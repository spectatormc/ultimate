#!/bin/sh
# Punkt 1 der Mission "Die gespaltene Sequenz": Stellt icsdoktor.py eine
# UTF-8-Sequenz, die eine Faltnaht nach §3.1 spaltet, wieder richtig her?
#
# Der Massstab ist NICHT mein Code. Er ist das Entfalten auf Byte-Ebene, wie
# §3.1 es beschreibt, in drei Zeilen, die jede dritte Person lesen kann:
#
#     b = open(datei,'rb').read()
#     re.sub(b'\r\n[ \t]', b'', b).decode('utf-8')
#
# Genau diese Ersetzung steht unten im Wortlaut. Waere sie aus icsdoktor.py
# geholt, pruefte das Skript den Code gegen sich selbst und bewiese nichts —
# derselbe Einwand, der gegen erwartet/ steht (siehe GEGENPROBE.md).
#
# Was das Skript NICHT misst: wie haeufig solche Faltungen draussen vorkommen.
# Es liest die Beispiele dieses Repos, nicht die Welt.
#
# Exit-Code: 0 alle verglichenen Zeilen stimmen ueberein, 1 mindestens eine
# Abweichung, 2 die Messung konnte nicht ausgefuehrt werden (nicht
# entschieden — nie "bestanden").

set -e
verzeichnis=$(dirname "$0")

python3 - "$verzeichnis" <<'PY'
import os
import re
import sys

verzeichnis = sys.argv[1]
sys.path.insert(0, verzeichnis)
try:
    import icsdoktor
except Exception as fehler:                                # pragma: no cover
    sys.stderr.write("icsdoktor.py nicht ladbar: %s\n" % fehler)
    raise SystemExit(2)

beispiele = os.path.join(verzeichnis, "beispiele")
if not os.path.isdir(beispiele):
    sys.stderr.write("Verzeichnis fehlt: %s\n" % beispiele)
    raise SystemExit(2)

namen = sorted(n for n in os.listdir(beispiele) if n.endswith(".ics"))
if not namen:
    sys.stderr.write("keine .ics-Datei in %s\n" % beispiele)
    raise SystemExit(2)


def naehte_spalten_sequenz(rohbytes):
    """Wie viele Faltnaehte eine UTF-8-Mehrbyte-Sequenz spalten.

    Unabhaengig von icsdoktor.py und von der Referenz: Steht direkt hinter dem
    WSP einer Naht ein Fortsetzungsbyte (0x80..0xBF), gehoert es zu einer
    Sequenz, die vor der Naht begonnen hat — ein Fortsetzungsbyte kann nie am
    Anfang eines Zeichens stehen.
    """
    anzahl = 0
    for treffer in re.finditer(b"\r\n[ \t]", rohbytes):
        naechstes = rohbytes[treffer.end():treffer.end() + 1]
        if naechstes and 0x80 <= naechstes[0] <= 0xBF:
            anzahl += 1
    return anzahl


verglichen = 0
gleich = 0
abweichungen = []
uebersprungen = []
dateien_mit_naht = 0
naehte_gesamt = 0

for name in namen:
    pfad = os.path.join(beispiele, name)
    rohbytes = open(pfad, "rb").read()

    naehte = naehte_spalten_sequenz(rohbytes)
    if naehte:
        dateien_mit_naht += 1
        naehte_gesamt += naehte

    # Die Referenz aus der Zieldefinition, im Wortlaut.
    try:
        referenztext = re.sub(b"\r\n[ \t]", b"", rohbytes).decode("utf-8")
    except UnicodeDecodeError:
        # Absichtlich kaputte Beispiele (P20, P05, ...) sind als Ganzes kein
        # UTF-8. Dann hat die Referenz kein Ergebnis, und ein Vergleich waere
        # geraten. Wird ausgewiesen, nicht verschwiegen.
        uebersprungen.append((name, "nach dem Entfalten kein gueltiges UTF-8"))
        continue

    # Die Referenz kennt nur CRLF. Beispiele mit LF oder einzelnem CR teilen
    # ihre Zeilen anders auf als das Werkzeug; der Vergleich verglich dann die
    # Zeilenaufteilung und nicht die Wiederherstellung.
    ohne_naht = re.sub(b"\r\n[ \t]", b"", rohbytes)
    if re.search(b"\r(?!\n)", ohne_naht) or re.search(b"(?<!\r)\n", ohne_naht):
        uebersprungen.append((name, "nicht durchgehend CRLF"))
        continue

    referenzzeilen = [z for z in referenztext.split("\r\n") if z != ""]
    meine = [lz.text for lz in
             icsdoktor.entfalte(icsdoktor.zerlege_physisch(rohbytes))]
    meine = [z for z in meine if z != ""]

    if len(referenzzeilen) != len(meine):
        abweichungen.append(
            (name, 0, "%d logische Zeilen laut Referenz, %d laut icsdoktor.py"
             % (len(referenzzeilen), len(meine))))
        verglichen += max(len(referenzzeilen), len(meine))
        continue

    for i, (soll, ist) in enumerate(zip(referenzzeilen, meine)):
        verglichen += 1
        if soll == ist:
            gleich += 1
        else:
            abweichungen.append((name, i + 1, "Referenz %r, icsdoktor.py %r"
                                 % (soll, ist)))

for name, grund in uebersprungen:
    print("uebersprungen %-38s %s" % (name, grund))
for name, nr, text in abweichungen:
    print("ABWEICHUNG    %-38s Zeile %d: %s" % (name, nr, text))

print("%d Beispiele gelesen, %d verglichen, %d uebersprungen"
      % (len(namen), len(namen) - len(uebersprungen), len(uebersprungen)))
print("%d Beispiele enthalten eine Faltnaht mitten in einer "
      "UTF-8-Mehrbyte-Sequenz, zusammen %d Naehte"
      % (dateien_mit_naht, naehte_gesamt))

if dateien_mit_naht == 0:
    sys.stderr.write("kein Beispiel mit gespaltener Sequenz — die Messung "
                     "traefe den Fall gar nicht\n")
    raise SystemExit(2)

print("%d von %d logischen Zeilen stimmen mit der Referenz überein"
      % (gleich, verglichen))
raise SystemExit(0 if gleich == verglichen else 1)
PY
