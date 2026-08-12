#!/bin/sh
# Herkunftspruefung der Namensliste in icsdoktor.py.
#
#   sh projekte/icsdoktor/namensliste.sh
#   echo "Exit-Code: $?"
#
# P09 meldet Eigenschaftsnamen, die weder registriert sind noch mit "X-"
# beginnen. Diese Pruefung ist nur so gut wie die Liste, gegen die sie
# vergleicht — eine zu kurze Liste macht aus gueltigen Kalendern Fehlalarme.
# Deshalb steht die Liste nicht aus dem Gedaechtnis in icsdoktor.py, sondern
# wird hier aus drei Quellen erhoben und dagegen verglichen:
#
#   1. IANA, Registry "iCalendar Properties" — die vollstaendige Liste.
#   2. RFC 5545 §8.3.2 — die Tabelle, mit der die Registry angelegt wurde.
#   3. RFC 7986 §9.1 — die Nachtragungen von 2016.
#
# Quelle 2 und 3 sind nicht redundant: Sie zeigen, wie weit die Registry ueber
# den Normtext hinausgewachsen ist, den das Werkzeug zitiert. Genau diese
# Differenz war der wahrscheinlichste Fehlgriff der Mission Die Faltnaht
# (Widerlegung 2 in state/missionen/2026-08-12-faltnaht.md).
#
# Dieses Skript ist keiner der drei Pruefbefehle der Mission. Es beweist nicht,
# dass P09 richtig arbeitet, sondern nur, dass seine Liste aus einer fremden
# Quelle stammt und nicht aus meiner. Es braucht Netz; das Werkzeug selbst nicht.
#
# Exit-Code: 0 Liste stimmt mit den Quellen ueberein, 1 sie weicht ab,
#            2 Quelle nicht erreichbar oder Umgebungsfehler.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"

iana="https://www.iana.org/assignments/icalendar/properties.csv"
rfc5545="https://www.rfc-editor.org/rfc/rfc5545.txt"
rfc7986="https://www.rfc-editor.org/rfc/rfc7986.txt"

if ! command -v python3 >/dev/null 2>&1; then
    echo "ABBRUCH: python3 ist nicht im PATH" >&2
    exit 2
fi
if [ ! -f "$werkzeug" ]; then
    echo "ABBRUCH: $werkzeug fehlt" >&2
    exit 2
fi

arbeit=$(mktemp -d) || exit 2
trap 'rm -rf "$arbeit"' EXIT INT TERM

lade() {
    if command -v curl >/dev/null 2>&1; then
        curl -sSf --max-time 60 "$1" > "$2" 2> "$arbeit/lade"
    elif command -v wget >/dev/null 2>&1; then
        wget -q -O "$2" "$1" 2> "$arbeit/lade"
    else
        echo "ABBRUCH: weder curl noch wget im PATH" >&2
        exit 2
    fi
    if [ $? -ne 0 ] || [ ! -s "$2" ]; then
        echo "ABBRUCH: $1 ist nicht erreichbar." >&2
        [ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
        echo "Kein Ergebnis ist kein gruenes Ergebnis." >&2
        exit 2
    fi
}

lade "$iana" "$arbeit/iana.csv"
lade "$rfc5545" "$arbeit/rfc5545.txt"
lade "$rfc7986" "$arbeit/rfc7986.txt"

python3 - "$arbeit" "$verzeichnis" <<'PYTHON'
"""Die drei Quellen auswerten und mit der Liste im Werkzeug vergleichen."""
import csv
import re
import sys

arbeit, verzeichnis = sys.argv[1], sys.argv[2]
sys.path.insert(0, verzeichnis)
import icsdoktor

# Zeile einer RFC-Tabelle: "      | NAME  | Current | RFC ...  |"
TABELLENZEILE = re.compile(r"^\s*\|\s*([A-Z][A-Z0-9-]*)\s*\|\s*([A-Za-z]+)\s*\|")


def aus_rfc_tabelle(pfad, von, bis):
    """Namen aus der Tabelle zwischen zwei Abschnittsueberschriften lesen.

    Die Ueberschriften stehen am Zeilenanfang; im Inhaltsverzeichnis sind
    dieselben Nummern eingerueckt und werden dadurch nicht getroffen.
    """
    namen = set()
    drin = False
    with open(pfad, encoding="utf-8", errors="replace") as fh:
        for zeile in fh:
            if zeile.startswith(von):
                drin = True
                continue
            if drin and zeile.startswith(bis):
                break
            if drin:
                treffer = TABELLENZEILE.match(zeile)
                if treffer and treffer.group(1) != "Property":
                    namen.add(treffer.group(1))
    if not drin:
        sys.stderr.write("ABBRUCH: Abschnitt %s in %s nicht gefunden\n"
                         % (von.strip(), pfad))
        sys.exit(2)
    return namen


def aus_iana_csv(pfad):
    namen = set()
    with open(pfad, newline="", encoding="utf-8", errors="replace") as fh:
        leser = csv.DictReader(fh)
        if leser.fieldnames is None or "Property" not in leser.fieldnames:
            sys.stderr.write("ABBRUCH: %s hat keine Spalte 'Property'\n" % pfad)
            sys.exit(2)
        for satz in leser:
            name = (satz.get("Property") or "").strip()
            if re.match(r"^[A-Z][A-Z0-9-]*$", name):
                namen.add(name)
    if not namen:
        sys.stderr.write("ABBRUCH: kein Name in %s gefunden\n" % pfad)
        sys.exit(2)
    return namen


registry = aus_iana_csv(arbeit + "/iana.csv")
tabelle5545 = aus_rfc_tabelle(arbeit + "/rfc5545.txt", "8.3.2.", "8.3.3.")
tabelle7986 = aus_rfc_tabelle(arbeit + "/rfc7986.txt", "9.1.", "9.2.")

quelle = registry | tabelle5545 | tabelle7986
liste = set(icsdoktor._REGISTRIERTE_EIGENSCHAFTEN)

print("IANA-Registry: %d Namen" % len(registry))
print("RFC 5545 §8.3.2: %d Namen" % len(tabelle5545))
print("RFC 7986 §9.1: %d Namen" % len(tabelle7986))
print("Vereinigung der drei Quellen: %d Namen" % len(quelle))
print("Liste in icsdoktor.py: %d Namen" % len(liste))

nur_registry = sorted(registry - tabelle5545)
print("Nur in der Registry, nicht in RFC 5545 §8.3.2: %d — %s"
      % (len(nur_registry), ", ".join(nur_registry)))
nur_norm = sorted(tabelle5545 - registry)
if nur_norm:
    print("Nur in RFC 5545 §8.3.2, nicht in der Registry: %s"
          % ", ".join(nur_norm))

fehlt = sorted(quelle - liste)
zuviel = sorted(liste - quelle)
if fehlt:
    print("ABWEICHUNG: in den Quellen, aber nicht in der Liste: %s"
          % ", ".join(fehlt))
if zuviel:
    print("ABWEICHUNG: in der Liste, aber in keiner Quelle: %s"
          % ", ".join(zuviel))
if fehlt or zuviel:
    print("Die Liste in icsdoktor.py passt nicht mehr zu ihren Quellen.")
    sys.exit(1)

print("Die Liste in icsdoktor.py ist genau die Vereinigung der drei Quellen.")
sys.exit(0)
PYTHON
