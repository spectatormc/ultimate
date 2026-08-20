#!/bin/sh
# Haelt das Werkzeug gegen Eingaben, die niemand von Hand ausgesucht hat.
#
#   sh projekte/icsdoktor/robustheit.sh
#   echo "Exit-Code: $?"
#
# WOZU. Jeder andere Pruefbefehl dieses Projekts fragt "sagt das Werkzeug das
# Richtige?" und braucht dafuer eine Erwartung. Fuer beispiele/ stammt die von
# mir, fuer die zwoelf fremden Eingaben aus fremden Fehlerberichten — in beiden
# Faellen gibt es genau so viele Eingaben, wie jemand hingelegt hat. Was
# passiert, wenn ein Nutzer eine Datei schickt, die niemand vorgesehen hat,
# sagt keiner von ihnen.
#
# Dieses Skript fragt deshalb etwas anderes und braucht dafuer keine Erwartung:
# Egal welche Bytes hereinkommen, sechs Zusagen muessen halten. Sie stehen
# nicht in meinem Kopf, sondern im README unter "Aufruf" — eine Zeile je Fund,
# die physische Zeile der Datei, drei Exit-Codes — und im Abschnitt "Kein
# Zeichen in einer Meldung, das in der Datei nicht steht".
#
#   (I1) Kein Absturz. untersuche() wirft keine Ausnahme.
#   (I2) Jede genannte Zeilennummer liegt zwischen 1 und der Zahl der
#        physischen Zeilen. Eine Meldung ueber Zeile 12 einer Datei mit acht
#        Zeilen schickt den Nutzer ins Leere.
#   (I3) Eine Meldung ist eine Zeile: kein CR, kein LF, kein Steuerzeichen.
#   (I4) Zweimal dieselbe Eingabe, zweimal dieselbe Ausgabe.
#   (I5) Ein U+FFFD steht in einer Meldung nur, wenn es auch im gelesenen Text
#        steht.
#   (I6) Eine Meldung ist hoechstens 400 Zeichen lang.
#
# DIE 400 IN (I6) IST EINE WAHL UND KEINE MESSUNG, und sie steht fest, bevor
# der erste verbogene Fall dagegen gehalten wurde — sonst waere sie an das
# Ergebnis angepasst, das sie beurteilen soll. Abgeleitet ist sie aus zwei
# Zahlen, die beide am Stand db3024c gemessen sind und nicht geschaetzt:
#
#   * Die laengste Meldung ueber die 55 unverbogenen Beispieldateien ist 254
#     Zeichen lang (erwartet/38-p18-trigger-ohne-value.txt). So gross ist der
#     feste Textanteil, den dieses Werkzeug ueberhaupt schreibt.
#   * Eine Meldung hat hoechstens ZWEI Stellen, an denen Text aus der Datei
#     hineinkommt (ueber den Syntaxbaum an allen 45 Fund-Stellen gezaehlt), und
#     das Werkzeug kuerzt jede davon mit _zeige_wort() bei 30 Zeichen plus
#     "...".
#
# 254 + 2 * 33 = 320. Die 400 liegen darueber, mit Luft, und weit unter dem,
# was gemessen wurde: Die laengste Meldung dieses Werkzeugs war 2878 Zeichen
# lang, also mehr als das Siebenfache. Wer die Grenze spaeter enger zieht,
# verschaerft; wer sie weiter zieht, muss den Grund danebenschreiben.
#
# (I6) ist nicht (I3) in gross. (I3) fragt, ob die Meldung EINE Zeile ist;
# (I6) fragt, ob diese eine Zeile noch lesbar ist. Eine Meldung von 2878
# Zeichen haelt (I3) und ist trotzdem keine Auskunft mehr, sondern die halbe
# Datei mit einem Satz davor.
#
# WARUM ES DIESES SKRIPT GIBT, mit Beleg statt als gute Absicht. Am 2026-08-19
# in Zyklus 39 zum ersten Mal gemessen, am Stand 200bb52: (I3) war an dreizehn
# Fundstellen in sieben Pruefungen verletzt — 1236 der 33498 Faelle. Ein Wert
# aus der Datei wandert woertlich in die Meldung, und stand ein Steuerzeichen
# darin, stand es danach in der Ausgabe:
#
#   FEHLER Zeile 2: P06 VERSION hat den Wert "2.0<CR>"; RFC 5545 verlangt 2.0
#
# Im Terminal setzt das CR den Cursor an den Zeilenanfang zurueck; der Rest der
# Meldung ueberschreibt ihren Anfang, und der Nutzer liest einen Satz, den so
# niemand geschrieben hat. Ein ESC aus der Datei wird zum Steuerbefehl an sein
# Terminal. Gemessene Zeichen: 0x00, 0x07, 0x09, 0x0D, 0x1B.
#
# Der Fall ist nicht ausgedacht. Ein Tabulator ist nach §3.1 (WSP) in einem
# Wert erlaubt und kommt in echten Dateien vor; ein CR bleibt stehen, wo eine
# Datei mit CR statt CRLF trennt oder das Herunterladen abgebrochen ist. Keine
# der 53 Beispieldateien von damals hat es ausgeloest — deshalb war jeder
# andere Pruefbefehl gruen, und deshalb steht dieses Skript daneben. Behoben
# ist es mit _zeigbar(); die beiden Beispiele 54 und 55 halten je einen der
# beiden Wege fest.
#
# WIE VERBOGEN WIRD, deterministisch und ohne Zufall. Ein Zufallsgenerator
# faende womoeglich mehr, aber ein roter Lauf waere dann nicht wiederholbar,
# und "bei mir ist es gruen" waere eine Frage des Wuerfels:
#
#   1. Abschneiden an jeder Bytegrenze der Datei (auch die leere Datei).
#   2. Jede physische Zeile einzeln entfernt.
#   3. Jedes Byte einzeln ersetzt, aus einer festen Liste, rotierend nach
#      Position: NUL CR LF ; : 0xE4 0xFF \ " , SP TAB BEL ESC.
#   4. Acht Umformungen der ganzen Datei: LF statt CRLF, CR statt CRLF, ohne
#      letztes Zeilenende, verdoppelt, mit BOM davor, rueckwaerts, nur
#      NUL-Bytes, Zeilen in umgekehrter Reihenfolge.
#
# Ausgangspunkt sind die Dateien in beispiele/, weil die im Repo liegen und
# sich nicht ohne mein Zutun aendern. Aus jeder entstehen so einige hundert
# Eingaben, die keiner Erwartung entsprechen und auch keiner entsprechen
# sollen.
#
# DIE MESSUNG PRUEFT SICH SELBST, sonst waere Stille ein Ergebnis: Ein Lauf,
# der keine Faelle bildet oder in dem keine einzige Meldung entsteht, misst
# nichts und endet mit 2 statt mit 0. Dazu wird an einer festen Auswahl
# zusaetzlich der echte Prozess aufgerufen — nicht nur untersuche() im selben
# Speicher —, weil ein Absturz sonst nicht von einem Fund zu unterscheiden
# waere: Python endet nach einer Ausnahme ebenfalls mit 1, und genau das
# bedeutet hier "mindestens ein FEHLER". Verlangt sind Exit 0 oder 1 und ein
# leerer Fehlerkanal.
#
# WAS DIESES SKRIPT NICHT IST. Es sagt kein Wort darueber, ob eine Meldung
# inhaltlich richtig ist — das tun pruefe.sh, rfc-beispiele.sh, fremdprobe.sh
# und gegenprobe.sh. Es ist auch kein Beweis, dass keine kaputte Datei das
# Werkzeug zu Fall bringt: Gemessen sind die Faelle, die aus beispiele/
# entstehen, und nicht alle Bytefolgen der Welt. Was es leistet, ist eine
# Untergrenze, die vorher gar nicht gemessen war.
#
# KEIN NETZ. Alles steht im Repo.
#
# Exit-Code: 0 alle sechs Zusagen halten in allen gebildeten Faellen
#            1 mindestens eine Zusage ist verletzt
#            2 Aufruf-, Umgebungs- oder Messfehler — kein Ergebnis ist kein
#              gruenes Ergebnis

set -u

verzeichnis=$(dirname "$0")

command -v python3 >/dev/null 2>&1 || {
	echo "ABBRUCH: python3 ist nicht im PATH" >&2; exit 2; }

[ -f "$verzeichnis/icsdoktor.py" ] || {
	echo "ABBRUCH: $verzeichnis/icsdoktor.py fehlt" >&2; exit 2; }
[ -d "$verzeichnis/beispiele" ] || {
	echo "ABBRUCH: $verzeichnis/beispiele fehlt" >&2; exit 2; }

python3 - "$verzeichnis" <<'PYTHON'
"""Sechs Zusagen gegen mechanisch verbogene Eingaben halten."""
import glob
import os
import subprocess
import sys
import tempfile
import unicodedata

verzeichnis = sys.argv[1]
sys.path.insert(0, os.path.abspath(verzeichnis))
try:
    import icsdoktor
except Exception as fehler:
    sys.stderr.write("ABBRUCH: icsdoktor.py laesst sich nicht laden (%s)\n"
                     % fehler)
    sys.exit(2)

werkzeug = os.path.abspath(icsdoktor.__file__)
if werkzeug.endswith(".pyc"):            # pragma: no cover
    werkzeug = werkzeug[:-1]

dateien = sorted(glob.glob(os.path.join(verzeichnis, "beispiele", "*.ics")))
if not dateien:
    sys.stderr.write("ABBRUCH: beispiele/ enthaelt keine .ics-Datei\n")
    sys.exit(2)

ERSATZ = [b"\x00", b"\r", b"\n", b";", b":", b"\xe4", b"\xff", b"\\",
          b'"', b",", b" ", b"\t", b"\x07", b"\x1b"]

# (I6). Die Herleitung steht im Kopf dieser Datei; sie stand fest, bevor der
# erste verbogene Fall dagegen gehalten wurde.
GRENZE_MELDUNG = 400


def faelle(roh):
    """Alle Verbiegungen einer Datei. Deterministisch, ohne Zufall."""
    for i in range(len(roh) + 1):
        yield "abgeschnitten nach %d Byte" % i, roh[:i]
    teile = roh.split(b"\n")
    for k in range(len(teile)):
        yield ("ohne physische Zeile %d" % (k + 1),
               b"\n".join(teile[:k] + teile[k + 1:]))
    for i in range(len(roh)):
        b = ERSATZ[i % len(ERSATZ)]
        yield ("Byte %d ersetzt durch %02X" % (i, b[0]),
               roh[:i] + b + roh[i + 1:])
    yield "LF statt CRLF", roh.replace(b"\r\n", b"\n")
    yield "CR statt CRLF", roh.replace(b"\r\n", b"\r")
    yield "ohne letztes Zeilenende", roh.rstrip(b"\r\n")
    yield "verdoppelt", roh + roh
    yield "mit BOM davor", b"\xef\xbb\xbf" + roh
    yield "rueckwaerts", roh[::-1]
    yield "nur NUL-Bytes", b"\x00" * len(roh)
    yield "Zeilen umgedreht", b"\r\n".join(roh.split(b"\r\n")[::-1])


def steuerzeichen(text):
    return sorted({z for z in text
                   if unicodedata.category(z) == "Cc" or ord(z) == 0x7F})


verletzungen = []                        # (Zusage, Herkunft, Belegtext)
n_faelle = 0
n_funde = 0
n_leer = 0
laengste = 0                             # laengste gesehene Meldung, in Zeichen

for pfad in dateien:
    name = os.path.basename(pfad)
    with open(pfad, "rb") as fh:
        roh = fh.read()
    for was, daten in faelle(roh):
        n_faelle += 1
        herkunft = "%s | %s" % (name, was)
        try:
            funde = icsdoktor.untersuche(daten)
        except Exception as fehler:
            verletzungen.append(("I1 Absturz", herkunft, "%s: %s"
                                 % (type(fehler).__name__, fehler)))
            continue
        if not funde:
            n_leer += 1
        n_funde += len(funde)

        # (I2) und (I3) an jeder einzelnen Meldung.
        zeilen = len(icsdoktor.zerlege_physisch(daten))
        text, _ = icsdoktor.dekodiere(daten)
        for fund in funde:
            try:
                gedruckt = str(fund)
            except Exception as fehler:
                verletzungen.append(("I3 nicht druckbar", herkunft,
                                     "%s: %s" % (type(fehler).__name__,
                                                 fehler)))
                continue
            if (not isinstance(fund.zeile, int)
                    or fund.zeile < 1 or fund.zeile > max(1, zeilen)):
                verletzungen.append(
                    ("I2 Zeilennummer", herkunft,
                     "Zeile %r bei %d physischen Zeilen: %s"
                     % (fund.zeile, zeilen, gedruckt)))
            if len(gedruckt) > laengste:
                laengste = len(gedruckt)
            if len(gedruckt) > GRENZE_MELDUNG:
                verletzungen.append(
                    ("I6 Meldung zu lang", herkunft,
                     "%d Zeichen, Anfang: %r" % (len(gedruckt),
                                                 gedruckt[:100])))
            gefunden = steuerzeichen(gedruckt)
            if gefunden:
                verletzungen.append(
                    ("I3 Steuerzeichen", herkunft,
                     "%s in %r" % (" ".join("0x%02X" % ord(z)
                                            for z in gefunden), gedruckt)))
            if "�" in gedruckt and "�" not in text:
                verletzungen.append(("I5 Ersatzzeichen", herkunft,
                                     repr(gedruckt)))

        # (I4) Determinismus.
        try:
            zweit = icsdoktor.untersuche(daten)
        except Exception as fehler:
            verletzungen.append(("I1 Absturz im Zweitlauf", herkunft,
                                 "%s: %s" % (type(fehler).__name__, fehler)))
            continue
        if [str(f) for f in funde] != [str(f) for f in zweit]:
            verletzungen.append(("I4 nicht deterministisch", herkunft, ""))

# Die Messung prueft sich selbst: Wer nichts bildet, misst nichts.
if n_faelle < 100:
    sys.stderr.write("ABBRUCH: nur %d Faelle gebildet; das misst nichts\n"
                     % n_faelle)
    sys.exit(2)
if n_funde == 0:
    sys.stderr.write("ABBRUCH: in keinem Fall ist eine Meldung entstanden; "
                     "gemessen wurde nichts\n")
    sys.exit(2)

# Der echte Prozess, an einer festen Auswahl. Im selben Speicher sieht man
# nicht, dass ein Absturz denselben Exit-Code traegt wie ein Fund.
prozessfehler = []
with tempfile.TemporaryDirectory() as ablage:
    ziel = os.path.join(ablage, "eingabe.ics")
    for pfad in dateien:
        with open(pfad, "rb") as fh:
            roh = fh.read()
        with open(ziel, "wb") as fh:
            fh.write(roh[::-1])          # rueckwaerts: garantiert kaputt
        lauf = subprocess.run([sys.executable, werkzeug, ziel],
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if lauf.returncode not in (0, 1):
            prozessfehler.append("%s rueckwaerts: Exit %d"
                                 % (os.path.basename(pfad), lauf.returncode))
        if lauf.stderr:
            prozessfehler.append(
                "%s rueckwaerts: Ausgabe auf stderr: %s"
                % (os.path.basename(pfad),
                   lauf.stderr.decode("utf-8", "replace").strip()[:120]))

print("Gemessen:")
print("  Beispieldateien:            %d" % len(dateien))
print("  daraus gebildete Faelle:    %d" % n_faelle)
print("  davon ohne jede Meldung:    %d" % n_leer)
print("  gepruefte Meldungen:        %d" % n_funde)
print("  laengste davon:             %d Zeichen (erlaubt: %d)"
      % (laengste, GRENZE_MELDUNG))
print("  Prozesslaeufe (rueckwaerts): %d" % len(dateien))
print("")

if prozessfehler:
    print("Der echte Prozess haelt die Zusage nicht:")
    for zeile in prozessfehler[:20]:
        print("  %s" % zeile)
    if len(prozessfehler) > 20:
        print("  ... und %d weitere" % (len(prozessfehler) - 20))

if verletzungen:
    nach_zusage = {}
    for zusage, herkunft, beleg in verletzungen:
        nach_zusage.setdefault(zusage, []).append((herkunft, beleg))
    print("Verletzte Zusagen:")
    for zusage in sorted(nach_zusage):
        eintraege = nach_zusage[zusage]
        print("  %s: %d Fall/Faelle" % (zusage, len(eintraege)))
        for herkunft, beleg in eintraege[:5]:
            print("    %s" % herkunft)
            if beleg:
                print("      %s" % beleg[:200])
        if len(eintraege) > 5:
            print("    ... und %d weitere" % (len(eintraege) - 5))
    print("")

if verletzungen or prozessfehler:
    print("%d Verletzung(en) in %d Faellen"
          % (len(verletzungen) + len(prozessfehler), n_faelle))
    sys.exit(1)

print("Alle sechs Zusagen halten in allen %d Faellen — gemessen an Eingaben,"
      % n_faelle)
print("zu denen es keine Erwartung gibt und die niemand ausgesucht hat.")
sys.exit(0)
PYTHON
