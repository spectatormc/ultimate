#!/bin/sh
# Pruefbefehl 1 der Mission "Die Fremdprobe".
#
#   bash projekte/icsdoktor/fremdprobe.sh
#   echo "Exit-Code: $?"
#
# Misst den ICS-Doktor an Dateien, die ich nicht geschrieben habe. Jede stammt
# aus einem oeffentlichen Fehlerbericht; was sie melden muss, steht nicht in
# meinem Kopf, sondern im Bericht. Die Zuordnung Datei -> erwartete Kennung
# liegt in korpus.tsv, eine Zeile je Datei, mit dem Zitat der Klage daneben.
#
# Regel 7: Fremde Kalenderdaten kommen nicht in dieses Repo. Jede Datei wird
# zur Laufzeit geholt und liegt nur in einem temporaeren Verzeichnis, das am
# Ende geloescht wird.
#
# Netz noetig. Ist eine Quelle nicht erreichbar, endet das Skript mit 2 und
# nicht mit 1: eine tote URL ist ein Befund ueber GitHub, nicht ueber das
# Werkzeug. Ohne Anmeldung erlaubt api.github.com 60 Anfragen pro Stunde und
# IP; der Korpus braucht eine Handvoll.
#
# Exit-Code: 0 alle Dateien wie erwartet, 1 mindestens eine Abweichung,
#            2 Aufruf-, Umgebungs- oder Netzfehler.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
korpus="$verzeichnis/korpus.tsv"

[ -f "$werkzeug" ] || { echo "FEHLER: $werkzeug fehlt" >&2; exit 2; }
[ -f "$korpus" ]   || { echo "FEHLER: $korpus fehlt" >&2; exit 2; }

for befehl in curl python3; do
	command -v "$befehl" >/dev/null 2>&1 || {
		echo "FEHLER: $befehl wurde nicht gefunden" >&2; exit 2; }
done

arbeit=$(mktemp -d) || exit 2
# shellcheck disable=SC2064
trap "rm -rf '$arbeit'" EXIT INT TERM

gesamt=0
gut=0

# Schneidet aus einem Bericht den ersten vollstaendigen VCALENDAR-Block heraus.
# Die Einrueckung, mit der Markdown ihn umgibt, faellt dabei weg — deshalb sind
# Zeilenenden auf diesen Dateien meine und nicht die des Melders, und deshalb
# darf keine Erwartung auf P01 oder P02 lauten (siehe Kopf von korpus.tsv).
ausschneiden() {
	python3 -c '
import json, sys
roh = json.load(open(sys.argv[1])).get("body") or ""
zeilen = [z.rstrip("\r").strip() for z in roh.splitlines()]
try:
    a = next(i for i, z in enumerate(zeilen) if z == "BEGIN:VCALENDAR")
    e = next(i for i, z in enumerate(zeilen) if i > a and z == "END:VCALENDAR")
except StopIteration:
    sys.exit(3)
sys.stdout.write("\r\n".join(zeilen[a:e + 1]) + "\r\n")
' "$1"
}

while IFS='	' read -r id typ fundstelle quelle kennung beleg abschnitt klage; do
	case "$id" in ''|'#'*) continue ;; esac
	gesamt=$((gesamt + 1))
	datei="$arbeit/$id.ics"

	if [ "$typ" = anhang ]; then
		curl -sSLf -o "$datei" "$quelle" 2>/dev/null || {
			echo "NETZ $id  Anhang nicht erreichbar: $quelle" >&2
			echo "Abbruch: eine Quelle ist weg. Das ist ein Befund ueber GitHub, nicht ueber das Werkzeug." >&2
			exit 2; }
	else
		curl -sSLf -o "$arbeit/$id.json" "$quelle" 2>/dev/null || {
			echo "NETZ $id  Bericht nicht abrufbar: $quelle" >&2
			echo "Abbruch: eine Quelle ist weg oder die Ratenbegrenzung greift." >&2
			exit 2; }
		ausschneiden "$arbeit/$id.json" > "$datei" || {
			echo "NETZ $id  kein VCALENDAR-Block im Bericht $fundstelle" >&2
			echo "Abbruch: der Bericht wurde geaendert. Das ist ein Befund ueber den Bericht, nicht ueber das Werkzeug." >&2
			exit 2; }
	fi

	ausgabe=$(python3 "$werkzeug" "$datei" 2>&1)

	# Die Kennung allein genuegt nicht: Sie muss auf der Eigenschaft stehen,
	# ueber die der Bericht klagt. Sonst besteht eine Datei den Vergleich,
	# weil dieselbe Kennung irgendwo anders ausgeloest hat.
	treffer=$(printf '%s\n' "$ausgabe" | grep "[ :]$kennung " | grep -c "$beleg")

	if [ "$treffer" -gt 0 ]; then
		zeile=$(printf '%s\n' "$ausgabe" | grep "[ :]$kennung " | grep "$beleg" | head -1)
		echo "OK         $id  $kennung auf $beleg, wie $fundstelle klagt (§$abschnitt)"
		echo "           $zeile"
		gut=$((gut + 1))
	else
		gefunden=$(printf '%s\n' "$ausgabe" | grep -oE '\bP[0-9]{2}\b' | sort -u | tr '\n' ' ')
		echo "ABWEICHEND $id  erwartet $kennung auf $beleg (§$abschnitt), gemeldet: ${gefunden:-nichts}"
		echo "           Bericht $fundstelle klagt: $klage"
	fi
done < "$korpus"

projekte=$(grep -v '^#' "$korpus" | grep -c . 2>/dev/null)
verschiedene=$(grep -v '^#' "$korpus" | cut -f3 | cut -d'#' -f1 | sort -u | grep -c .)

echo
echo "$gut von $gesamt Fremddateien wie erwartet"
echo "Korpus: $projekte Dateien aus $verschiedene Projekten (verlangt sind 5 aus 3)"

[ "$gut" -eq "$gesamt" ] || exit 1
exit 0
