#!/bin/sh
# Pruefbefehl 2 der Mission ICS-Doktor — der eigentliche.
#
#   sh projekte/icsdoktor/rfc-beispiele.sh
#   echo "Exit-Code: $?"
#
# Laedt RFC 5545 vom RFC-Editor, schneidet aus Abschnitt 4 ("iCalendar Object
# Examples") die sechs vollstaendigen Kalenderobjekte heraus und laesst
# icsdoktor.py auf jedes einzeln los. Die Eingabe stammt also nicht aus meiner
# Hand, sondern aus dem Normtext: Ein Kalender aus dem RFC verstoesst nicht
# gegen den RFC. Meldet das Werkzeug hier einen FEHLER, hat das Werkzeug
# unrecht.
#
# Beim Herausschneiden passiert genau dreierlei:
#   - Seitenumbruecke weg: Vorschubzeichen, Kopf- und Fusszeilen, Leerzeilen.
#   - Die einheitliche Grundeinrueckung von sieben Leerzeichen weg.
#     Fortsetzungszeilen sind im RFC tiefer eingerueckt und behalten dadurch
#     ihr zusaetzliches Leerzeichen — sonst zerstoert das Entfernen der
#     Einrueckung die Faltung nach §3.1.
#   - Zeilenenden auf CRLF.
# Traegt eine Zeile im Block nicht die erwartete Einrueckung, bricht das Skript
# mit Exit-Code 2 ab, statt stillschweigend etwas anderes zu pruefen.
#
# Exit-Code: 0 kein Fehler in den sechs Objekten, 1 mindestens einer,
#            2 RFC nicht erreichbar, Ausschnitt unerwartet, Umgebungsfehler.
#
# Das Netz braucht dieser Pruefbefehl, das Werkzeug selbst nicht.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
quelle="https://www.rfc-editor.org/rfc/rfc5545.txt"

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

if command -v curl >/dev/null 2>&1; then
    curl -sSf --max-time 60 "$quelle" > "$arbeit/rfc.txt" 2> "$arbeit/lade"
    geladen=$?
elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$arbeit/rfc.txt" "$quelle" 2> "$arbeit/lade"
    geladen=$?
else
    echo "ABBRUCH: weder curl noch wget im PATH" >&2
    exit 2
fi
if [ "$geladen" -ne 0 ] || [ ! -s "$arbeit/rfc.txt" ]; then
    echo "ABBRUCH: $quelle ist nicht erreichbar." >&2
    [ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
    echo "Dieser Pruefbefehl braucht Netz. Kein Ergebnis ist kein gruenes" >&2
    echo "Ergebnis." >&2
    exit 2
fi

if ! grep -q '^4\.  iCalendar Object Examples' "$arbeit/rfc.txt"; then
    echo "ABBRUCH: Abschnitt 4 im geladenen Text nicht gefunden." >&2
    echo "Geladen wurden $(wc -c < "$arbeit/rfc.txt") Oktette." >&2
    exit 2
fi

tr -d '\014' < "$arbeit/rfc.txt" > "$arbeit/ohne-vorschub.txt"
awk '/^4\.  iCalendar Object Examples/,/^5\.  Recommended Practices/' \
    "$arbeit/ohne-vorschub.txt" > "$arbeit/abschnitt4.txt"

awk -v ziel="$arbeit" '
    /^ +BEGIN:VCALENDAR[[:space:]]*$/ { n++; drin = 1 }
    drin {
        if ($0 ~ /^[[:space:]]*$/) next
        if ($0 ~ /^Desruisseaux/) next
        if ($0 ~ /^RFC 5545/) next
        if (substr($0, 1, 7) != "       ") { schlecht++; next }
        printf "%s\r\n", substr($0, 8) > (ziel "/objekt-" n ".ics")
    }
    /^ +END:VCALENDAR[[:space:]]*$/ { drin = 0 }
    END {
        print n + 0 > (ziel "/anzahl")
        print schlecht + 0 > (ziel "/schlecht")
    }
' "$arbeit/abschnitt4.txt"

anzahl=$(cat "$arbeit/anzahl")
schlecht=$(cat "$arbeit/schlecht")

if [ "$schlecht" != "0" ]; then
    echo "ABBRUCH: $schlecht Zeilen im Ausschnitt tragen nicht die erwartete" >&2
    echo "Grundeinrueckung von sieben Leerzeichen. Das Herausschneiden passt" >&2
    echo "nicht zum Text, und geprueft wuerde etwas anderes als gemeint." >&2
    exit 2
fi
if [ "$anzahl" != "6" ]; then
    echo "ABBRUCH: $anzahl vollstaendige Kalenderobjekte gefunden, erwartet 6." >&2
    echo "RFC 5545 ist unveraenderlich; diese Zahl kann sich nicht aendern." >&2
    exit 2
fi

fehler_gesamt=0
nr=1
while [ "$nr" -le "$anzahl" ]; do
    objekt="$arbeit/objekt-$nr.ics"
    zeilen=$(python3 -c 'import sys;print(open(sys.argv[1],"rb").read().count(b"\r\n"))' "$objekt")
    python3 "$werkzeug" "$objekt" > "$arbeit/ausgabe" 2>&1
    code=$?
    fehler=$(grep -c '^FEHLER ' "$arbeit/ausgabe" || true)
    hinweise=$(grep -c '^HINWEIS ' "$arbeit/ausgabe" || true)
    printf 'Objekt %d: %2d Zeilen, %d Fehler, %d Hinweise, Exit %d\n' \
        "$nr" "$zeilen" "$fehler" "$hinweise" "$code"
    [ -s "$arbeit/ausgabe" ] && sed 's/^/  /' "$arbeit/ausgabe"
    fehler_gesamt=$((fehler_gesamt + fehler))
    nr=$((nr + 1))
done

printf '%d Beispiele aus RFC 5545 §4 geprüft, %d Fehler\n' \
    "$anzahl" "$fehler_gesamt"

[ "$fehler_gesamt" -eq 0 ] || exit 1
exit 0
