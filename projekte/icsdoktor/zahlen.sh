#!/bin/sh
# Rechnet die Zahlen nach, die dieses Projekt ueber seinen eigenen Bestand
# behauptet.
#
#   sh projekte/icsdoktor/zahlen.sh
#   echo "Exit-Code: $?"
#
# WOZU. "51 Kalenderdateien", "die zwanzig Pruefungen", "gibt es Anlass fuer
# eine 21. Pruefung" — das sind keine Meinungen, sondern Zahlen, die man
# nachsehen kann. Sie stehen im Text, waehrend der Bestand daneben waechst.
# Niemand zieht sie nach, weil niemand sie liest: Ein Absatz altert still.
#
# WARUM ES DIESES SKRIPT GIBT, mit Beleg statt als gute Absicht. Am 2026-08-18
# standen in diesem Projekt fuenf solche Zahlen falsch, in zwei Wellen:
#
#   - "drei falsche Ursachen" (README, es waren vier) und "beispiele/ 47
#     Kalenderdateien" (es waren 51) — gefunden und korrigiert in Zyklus 34,
#     state/journal/2026-08-18-zyklus-34.md. Gefunden wurden sie nebenbei.
#   - "gibt es Anlass fuer eine 20. Pruefung" (README), "die neunzehn gebauten
#     Pruefungen" und "eine zwanzigste zu bauen" (anlass.sh) — alle drei
#     nennen den Stand vor P20 und standen seit dem 2026-08-18 falsch, dem Tag,
#     an dem P20 gebaut wurde (Commit 9bab78d).
#
# anlass.sh rechnet seit Zyklus 32 die Saetze nach, mit denen dieses Werkzeug
# das Nichtbauen einer Pruefung begruendet. Zahlen ueber den eigenen Bestand
# fallen nicht darunter; genau das stand als Befund 4 in state/offen.md,
# Zyklus 34. Dieses Skript schliesst ihn.
#
# WAS GEPRUEFT WIRD. Eine Tabelle aus Faellen, jeder mit drei Dingen: der
# Datei, dem Satz mit einer Luecke an der Stelle der Zahl, und dem Weg, auf dem
# die Zahl aus dem Bestand nachgerechnet wird. Geprueft wird beides:
#
#   - Jede Stelle, die dem Satz entspricht, traegt die nachgerechnete Zahl.
#     Steht der Satz mehrfach da, muessen alle stimmen.
#   - Der Satz steht ueberhaupt noch da. Wer ihn umformuliert, macht ihn
#     unauffindbar — das ist hier ein Fehlschlag und kein stilles Bestehen.
#
# WAS DIESES SKRIPT NICHT IST. Keine Pruefung des Werkzeugs; es liest keine
# einzige Kalenderdatei und ersetzt pruefe.sh nicht. Und es ist kein
# Rechtschreibpruefer fuer Zahlen: Es kennt genau die Faelle, die unten in der
# Tabelle stehen. Eine neue Behauptung ueber den Bestand kommt nicht von selbst
# hinein — sie muss hier eingetragen werden. Das ist die bekannte Grenze, und
# sie steht hier, damit ein gruener Lauf nicht mehr verspricht, als er geprueft
# hat.
#
# NICHT GEPRUEFT werden Zahlen, die nicht aus dem Bestand kommen:
#
#   - Vorgaben aus den Missionsdateien ("mindestens 16 Beispiele") — sie stehen
#     fest, seit die Mission angelegt wurde, und duerfen sich gerade nicht mit
#     dem Bestand bewegen (Regel 3).
#   - Messprotokolle wie GEGENPROBE.md ("auf diesen zwoelf Eingaben") — sie
#     halten fest, was an einem Tag gemessen wurde. Sie nachzuziehen hiesse,
#     eine alte Messung zu faelschen.
#
# KEIN NETZ. Alles steht im Repo.
#
# Exit-Code: 0 alle Zahlen stimmen mit dem Bestand ueberein
#            1 mindestens eine Zahl ist veraltet oder ihr Satz fehlt
#            2 Aufruf- oder Umgebungsfehler

set -u

verzeichnis=$(dirname "$0")

command -v python3 >/dev/null 2>&1 || {
	echo "ABBRUCH: python3 ist nicht im PATH" >&2; exit 2; }

for datei in icsdoktor.py README.md anlass.sh; do
	[ -f "$verzeichnis/$datei" ] || {
		echo "ABBRUCH: $verzeichnis/$datei fehlt" >&2; exit 2; }
done
[ -d "$verzeichnis/beispiele" ] || {
	echo "ABBRUCH: $verzeichnis/beispiele fehlt" >&2; exit 2; }

python3 - "$verzeichnis" <<'PYTHON'
"""Die Zahlen aus dem Bestand erheben und gegen die Saetze im Text halten."""
import glob
import os
import re
import sys

verzeichnis = sys.argv[1]

# --- Der Bestand, gezaehlt und nicht erinnert -------------------------------

beispiele = sorted(glob.glob(os.path.join(verzeichnis, "beispiele", "*.ics")))

with open(os.path.join(verzeichnis, "icsdoktor.py"), encoding="utf-8") as fh:
    werkzeug = fh.read()
nummern = sorted(int(n) for n in re.findall(r"^def pruefe_p([0-9]+)\(",
                                            werkzeug, re.M))

if not nummern:
    sys.stderr.write("ABBRUCH: keine einzige Pruefung in icsdoktor.py "
                     "gefunden\n")
    sys.exit(2)

# Zwei der Saetze unten reden ueber "die zwanzig Pruefungen", zwei ueber "die
# 21.". Das eine ist die Anzahl, das andere die naechste freie Nummer. Beide
# meinen nur dann dasselbe, wenn die Nummern luckenlos bei 1 anfangen — sonst
# waere die naechste freie Nummer eine Luecke mittendrin und die Rechnung
# "hoechste + 1" falsch. Deshalb wird das gemessen und nicht angenommen.
if nummern != list(range(1, len(nummern) + 1)):
    print("ABWEICHUNG: die Pruefnummern in icsdoktor.py sind nicht "
          "lueckenlos P01..P%02d, sondern %s."
          % (len(nummern), ", ".join("P%02d" % n for n in nummern)))
    print("Solange das so ist, bedeutet \"die naechste Pruefung\" nicht mehr "
          "hoechste + 1, und dieses Skript rechnet nicht weiter.")
    sys.exit(1)

anzahl_pruefungen = len(nummern)
naechste_pruefung = nummern[-1] + 1

# --- Zahlwoerter ------------------------------------------------------------
#
# Nur so weit, wie die Saetze unten sie brauchen. Fehlt eins, sagt das Skript
# das und raet nicht.

_EINER = ("", "ein", "zwei", "drei", "vier", "fuenf", "sechs", "sieben",
          "acht", "neun")
_ZEHNER = ("", "", "zwanzig", "dreissig", "vierzig", "fuenfzig", "sechzig",
           "siebzig", "achtzig", "neunzig")
_BIS_ZWOELF = {1: "eine", 2: "zwei", 3: "drei", 4: "vier", 5: "fünf",
               6: "sechs", 7: "sieben", 8: "acht", 9: "neun", 10: "zehn",
               11: "elf", 12: "zwölf"}
_DREIZEHN_BIS_NEUNZEHN = {13: "dreizehn", 14: "vierzehn", 15: "fünfzehn",
                          16: "sechzehn", 17: "siebzehn", 18: "achtzehn",
                          19: "neunzehn"}


def als_wort(zahl):
    """Deutsches Zahlwort, klein geschrieben. Nur 1 bis 99."""
    if zahl in _BIS_ZWOELF:
        return _BIS_ZWOELF[zahl]
    if zahl in _DREIZEHN_BIS_NEUNZEHN:
        return _DREIZEHN_BIS_NEUNZEHN[zahl]
    if 20 <= zahl <= 99:
        zehner = _ZEHNER[zahl // 10].replace("fuenf", "fünf").replace(
            "dreissig", "dreißig")
        rest = zahl % 10
        if rest == 0:
            return zehner
        einer = _EINER[rest].replace("fuenf", "fünf")
        return "%sund%s" % (einer, zehner)
    return None


# --- Die Faelle -------------------------------------------------------------
#
# Je Fall: die Datei, der Satz mit {} an der Stelle der Zahl, die Zahl selbst,
# ihre Form ("ziffer" oder "wort") und der Weg, auf dem sie nachgerechnet ist.
# Der Weg wird mitgedruckt: Wer das Ergebnis liest, soll nicht glauben muessen,
# dass die Zahl von irgendwoher stimmt.

FAELLE = (
    ("README.md",
     "{} Kalenderdateien, byte-genau",
     len(beispiele), "ziffer",
     "Dateien beispiele/*.ics"),
    # Derselbe Bestand, zweite Stelle: der Absatz ueber dieses Skript zitiert
    # den Satz oben als Beispiel fuer eine Zahl, die still altert. Am
    # 2026-08-19 hat er es getan — beim Anlegen von zwei Beispieldateien blieb
    # das Zitat auf 51 stehen, waehrend die Zeile darueber nachgezogen wurde.
    # Ein Beispiel, das seinen eigenen Fall vorfuehrt, ist kein Beispiel mehr.
    ("README.md",
     "„{} Kalenderdateien\"",
     len(beispiele), "ziffer",
     "Dateien beispiele/*.ics"),
    ("README.md",
     "Es prüft genau die {} Prüfungen",
     anzahl_pruefungen, "wort",
     "Funktionen def pruefe_pNN in icsdoktor.py"),
    ("README.md",
     "gibt es Anlass für eine {}. Prüfung?",
     naechste_pruefung, "ziffer",
     "hoechste Pruefnummer in icsdoktor.py, plus 1"),
    ("icsdoktor.py",
     "Alle {} Pruefungen.",
     anzahl_pruefungen, "wort",
     "Funktionen def pruefe_pNN in icsdoktor.py"),
    ("anlass.sh",
     "ueber die {} gebauten Pruefungen",
     anzahl_pruefungen, "wort",
     "Funktionen def pruefe_pNN in icsdoktor.py"),
    ("anlass.sh",
     "Gibt es einen Anlass, die {}. zu bauen?",
     naechste_pruefung, "ziffer",
     "hoechste Pruefnummer in icsdoktor.py, plus 1"),
)

# In der Luecke steht entweder eine Ziffernfolge oder ein Wort aus Buchstaben.
# Beides wird eingefangen, damit eine falsche Zahl als falsche Zahl gemeldet
# wird und nicht als fehlender Satz.
_LUECKE = r"([0-9]+|[A-Za-zÄÖÜäöüß]+)"

inhalte = {}
for name in sorted({fall[0] for fall in FAELLE}):
    with open(os.path.join(verzeichnis, name), encoding="utf-8") as fh:
        inhalte[name] = fh.read().split("\n")

print("Bestand, gezaehlt:")
print("  Beispieldateien (beispiele/*.ics): %d" % len(beispiele))
print("  gebaute Pruefungen (P01..P%02d):    %d"
      % (nummern[-1], anzahl_pruefungen))
print("  naechste freie Pruefnummer:        %d" % naechste_pruefung)
print("")

fehler = 0
for datei, muster, zahl, form, weg in FAELLE:
    wort = als_wort(zahl)
    if form == "wort" and wort is None:
        print("ABBRUCH: fuer %d kennt dieses Skript kein Zahlwort." % zahl)
        sys.exit(2)
    soll = wort if form == "wort" else str(zahl)
    erwartet = muster.format(soll)
    suche = re.compile(re.escape(muster).replace(r"\{\}", _LUECKE))

    treffer = []
    for nr, zeile in enumerate(inhalte[datei], 1):
        for gefunden in suche.finditer(zeile):
            treffer.append((nr, gefunden.group(1), zeile.strip()))

    if not treffer:
        print("ABWEICHUNG %s: der Satz \"%s\" steht dort nicht mehr."
              % (datei, erwartet))
        print("  Wer ihn umformuliert hat, muss diese Tabelle mitziehen —")
        print("  ein Satz, den niemand findet, wird auch nicht nachgerechnet.")
        fehler += 1
        continue

    falsch = [t for t in treffer if t[1] != soll]
    if falsch:
        for nr, stand_da, zeile in falsch:
            print("ABWEICHUNG %s Zeile %d: dort steht \"%s\", "
                  "nachgerechnet sind es \"%s\"." % (datei, nr, stand_da, soll))
            print("  Zeile:        %s" % zeile)
            print("  nachgerechnet: %s" % weg)
        fehler += 1
        continue

    print("OK   %-13s %-38s (%s)"
          % (datei, "\"%s\"" % erwartet, weg))

print("")
if fehler:
    print("%d von %d Zahlen stimmen nicht mehr mit dem Bestand ueberein."
          % (fehler, len(FAELLE)))
    sys.exit(1)

print("Alle %d Zahlen stimmen mit dem Bestand ueberein — nachgerechnet, "
      "nicht behauptet." % len(FAELLE))
sys.exit(0)
PYTHON
