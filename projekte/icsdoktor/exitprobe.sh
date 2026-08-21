#!/bin/sh
# Haelt die drei Exit-Codes von quellen.sh gegen erfundene Eingaben.
#
#   sh projekte/icsdoktor/exitprobe.sh
#   echo "Exit-Code: $?"
#
# WOZU. quellen.sh sagt seit dem 2026-08-21 (V10) ueber sich selbst: es liest
# den TITEL einer Fundstelle, es vergibt fuer ein Zitat, das an keiner Stelle
# steht, eine 1 statt einer 2 — und 1 SCHLAEGT 2, damit ein Befund nicht von
# einer unerreichbaren Quelle geschluckt wird.
#
# Am Tag dieser Zusage war davon genau ein Fall an echten Daten sichtbar: fuenf
# gefundene Zitate und eine tote Quelle, Exit 2. Der Exit-1-Pfad war NICHT
# ausgeloest — er stand da und war unbelegt. Genau das verbietet Regel 1: eine
# Behauptung ohne Beleg. Und Regel 3 verlangt eine Pruefung, die eine dritte
# Person ohne mich nachvollziehen kann, mit Befehl, Eingabe und erwarteter
# Ausgabe. Eine Messung, die ich einmal in einem Wegwerfverzeichnis gemacht
# habe, ist keine.
#
# WIE. Dieses Skript schneidet den Python-Teil aus quellen.sh heraus — nicht
# eine Kopie davon, den echten — und laesst ihn gegen erfundene Faelle laufen.
# Keine Fundstelle ist echt, es wird KEIN Abruf gemacht, kein Netz gebraucht
# und keine fremde Zeile in dieses Repo kopiert (Regel 7). Wie viele Faelle es
# sind, zaehlt das Skript beim Laufen; die Zahl steht deshalb nirgends im Text
# und kann nicht still altern.
#
# Aendert jemand die Exit-Logik von quellen.sh, wird dieses Skript rot. Das ist
# sein ganzer Zweck: Es haelt fest, was die Zusage versprochen hat, damit die
# Zusage nicht spaeter still ihre Bedeutung wechselt.
#
# WAS ES NICHT MISST: ob die Zitate in korpus.tsv stimmen. Das tut quellen.sh
# selbst, und dafuer braucht es das Netz. Dieses Skript prueft die Mechanik,
# nicht den Bestand.
#
# Exit-Code: 0 alle fuenf Faelle liefern den erwarteten Code
#            1 mindestens ein Fall weicht ab — die Exit-Logik hat sich
#              geaendert, ohne dass die Zusage nachgezogen wurde
#            2 Aufruf- oder Umgebungsfehler

set -u

verzeichnis=$(dirname "$0")
quelle="$verzeichnis/quellen.sh"

[ -f "$quelle" ] || { echo "FEHLER: $quelle fehlt" >&2; exit 2; }
command -v python3 >/dev/null 2>&1 || {
	echo "FEHLER: python3 wurde nicht gefunden" >&2; exit 2; }

arbeit=$(mktemp -d) || exit 2
# shellcheck disable=SC2064
trap "rm -rf '$arbeit'" EXIT INT TERM

python3 - "$quelle" "$arbeit" <<'PYTHON'
"""Den echten Python-Teil aus quellen.sh gegen erfundene Eingaben laufen."""
import json
import os
import subprocess
import sys

quelle, arbeit = sys.argv[1], sys.argv[2]

ANFANG = 'python3 - "$korpus" "$arbeit" <<\'PYTHON\''
ENDE = "PYTHON"

with open(quelle, encoding="utf-8") as fh:
    zeilen = fh.read().split("\n")
try:
    a = zeilen.index(ANFANG)
    b = zeilen.index(ENDE, a + 1)
except ValueError:
    sys.stderr.write("ABBRUCH: der Python-Teil von quellen.sh war nicht zu "
                     "finden; die Datei ist anders aufgebaut als erwartet\n")
    sys.exit(2)

kern = os.path.join(arbeit, "kern.py")
with open(kern, "w", encoding="utf-8") as fh:
    fh.write("\n".join(zeilen[a + 1:b]))


def zeile(id_, klage):
    """Eine Korpuszeile mit acht Spalten; nur id und klage werden gelesen."""
    return "\t".join([id_, "bericht", "erfunden/probe#1", "-", "-", "-",
                      "§0", klage])


def lauf(name, korpuszeilen, berichte, tot):
    ordner = os.path.join(arbeit, name)
    os.makedirs(ordner, exist_ok=True)
    korpus = os.path.join(ordner, "korpus.tsv")
    with open(korpus, "w", encoding="utf-8") as fh:
        fh.write("# erfundene Eingabe, keine echte Fundstelle\n")
        fh.write("\n".join(korpuszeilen) + "\n")
    for id_, (titel, text, koms) in berichte.items():
        with open(os.path.join(ordner, id_ + ".bericht.json"), "w",
                  encoding="utf-8") as fh:
            json.dump({"title": titel, "body": text}, fh)
        with open(os.path.join(ordner, id_ + ".kommentare.json"), "w",
                  encoding="utf-8") as fh:
            json.dump([{"body": t} for t in koms], fh)
    for id_, s1, s2 in tot:
        with open(os.path.join(ordner, "tot.tsv"), "a",
                  encoding="utf-8") as fh:
            fh.write("%s\t%s\t%s\n" % (id_, s1, s2))
    fertig = subprocess.run([sys.executable, kern, korpus, ordner],
                            capture_output=True, text=True)
    return fertig.returncode, fertig.stdout + fertig.stderr


# name, erwarteter Code, Korpuszeilen, Berichte {id: (titel, text, kommentare)},
# unerreichbar [(id, status_bericht, status_kommentare)]
FAELLE = [
    ("titel-zaehlt", 0,
     [zeile("a", "steht im Titel")],
     {"a": ("hier steht im Titel etwas", "im Text nicht", [])},
     []),
    ("text-zaehlt-weiter", 0,
     [zeile("a", "steht im Text")],
     {"a": ("Ueberschrift", "hier steht im Text etwas", [])},
     []),
    ("kein-treffer-ist-1", 1,
     [zeile("a", "steht an keiner Stelle")],
     {"a": ("Ueberschrift", "Text", ["ein Kommentar"])},
     []),
    ("nur-unerreichbar-ist-2", 2,
     [zeile("a", "egal, wird nie gelesen")],
     {},
     [("a", "404", "")]),
    ("eins-schlaegt-zwei", 1,
     [zeile("a", "steht an keiner Stelle"), zeile("b", "egal")],
     {"a": ("Ueberschrift", "Text", [])},
     [("b", "404", "")]),
]

abweichungen = 0
for name, erwartet, korpuszeilen, berichte, tot in FAELLE:
    code, ausgabe = lauf(name, korpuszeilen, berichte, tot)
    stimmt = code == erwartet
    print("%-24s erwartet %d, gemessen %d   %s"
          % (name, erwartet, code, "OK" if stimmt else "ABWEICHUNG"))
    if not stimmt:
        abweichungen += 1
        for z in ausgabe.rstrip("\n").split("\n"):
            print("    | %s" % z)

print("")
if abweichungen:
    print("%d von %d Faellen weichen ab. Die Exit-Logik von quellen.sh ist"
          % (abweichungen, len(FAELLE)))
    print("nicht mehr die, die (V10) am 2026-08-21 zugesagt hat.")
    sys.exit(1)

print("%d von %d Faellen wie zugesagt: der Titel zaehlt, ein Zitat ohne"
      % (len(FAELLE), len(FAELLE)))
print("Fundstelle ergibt 1, eine tote Quelle allein ergibt 2, und 1 schlaegt")
print("2 — nachgemessen, nicht behauptet.")
sys.exit(0)
PYTHON
