#!/bin/sh
# Pruefbefehl 1 der Mission ICS-Doktor.
#
#   sh projekte/icsdoktor/pruefe.sh
#   echo "Exit-Code: $?"
#
# Laesst icsdoktor.py auf jede Datei in beispiele/ los und vergleicht die
# Ausgabe Byte fuer Byte mit der Erwartung in erwartet/. Der erwartete
# Exit-Code wird nicht danebengeschrieben, sondern aus der Erwartung abgeleitet:
# 1, wenn dort mindestens eine FEHLER-Zeile steht, sonst 0. Damit prueft dieses
# Skript die Exit-Code-Regel des Werkzeugs mit, statt sie zu wiederholen.
#
# Am Ende Zusammenfassungszeilen, die die Vorgaben der Missionsdatei selbst
# nachrechnen: mindestens zwoelf Beispiele, jede Pruefung mindestens einmal
# ausgeloest, mindestens zwei fehlerfreie Dateien.
#
# Die laufende Mission Die Faltnaht verlangt mehr — mindestens 16 Beispiele und
# jede der zehn Pruefungen. Solange sie laeuft, wird dieser Abstand am Ende
# ausgedruckt, statt ihn erst am Missionsende nachzurechnen. Er laesst dieses
# Skript nicht rot werden: Exit 1 heisst Abweichung von erwartet/, nicht
# "Mission offen". Wer wissen will, ob die Mission erreicht ist, liest die
# Zeile "Faltnaht" und nicht den Exit-Code.
#
# Exit-Code: 0 alles wie erwartet, 1 mindestens eine Abweichung,
#            2 Aufruf- oder Umgebungsfehler.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
beispiele="$verzeichnis/beispiele"
erwartet="$verzeichnis/erwartet"

if ! command -v python3 >/dev/null 2>&1; then
    echo "ABBRUCH: python3 ist nicht im PATH" >&2
    exit 2
fi
for pfad in "$werkzeug" "$beispiele" "$erwartet"; do
    if [ ! -e "$pfad" ]; then
        echo "ABBRUCH: $pfad fehlt" >&2
        exit 2
    fi
done

arbeit=$(mktemp -d) || exit 2
trap 'rm -rf "$arbeit"' EXIT INT TERM

anzahl=0
gut=0
schlecht=0
leer=0

for datei in "$beispiele"/*.ics; do
    name=$(basename "$datei" .ics)
    soll="$erwartet/$name.txt"
    anzahl=$((anzahl + 1))

    if [ ! -f "$soll" ]; then
        printf 'ABWEICHUNG %s: keine Erwartung in erwartet/%s.txt\n' \
            "$name" "$name"
        schlecht=$((schlecht + 1))
        continue
    fi

    python3 "$werkzeug" "$datei" > "$arbeit/ist" 2> "$arbeit/fehlerkanal"
    ist_code=$?

    if grep -q '^FEHLER ' "$soll"; then
        soll_code=1
    else
        soll_code=0
    fi
    funde=$(wc -l < "$soll" | tr -d ' ')
    [ "$funde" = "0" ] && leer=$((leer + 1))

    abweichung=""
    if ! cmp -s "$arbeit/ist" "$soll"; then
        abweichung="Ausgabe"
    fi
    if [ "$ist_code" != "$soll_code" ]; then
        if [ -n "$abweichung" ]; then
            abweichung="$abweichung und Exit-Code"
        else
            abweichung="Exit-Code"
        fi
    fi
    if [ -s "$arbeit/fehlerkanal" ]; then
        abweichung="${abweichung:+$abweichung und }Ausgabe auf stderr"
    fi

    if [ -z "$abweichung" ]; then
        printf 'OK   %-34s %2d Funde, Exit %d\n' "$name" "$funde" "$ist_code"
        gut=$((gut + 1))
    else
        printf 'ABWEICHUNG %s: %s\n' "$name" "$abweichung"
        printf '  erwartet Exit %d, bekommen Exit %d\n' "$soll_code" "$ist_code"
        diff -u "$soll" "$arbeit/ist" | sed 's/^/  /'
        [ -s "$arbeit/fehlerkanal" ] && sed 's/^/  stderr: /' \
            "$arbeit/fehlerkanal"
        schlecht=$((schlecht + 1))
    fi
done

printf '%d Beispiele geprueft, %d OK, %d abweichend\n' \
    "$anzahl" "$gut" "$schlecht"

# Die Vorgaben der Missionsdatei nachrechnen, statt sie zu behaupten.
fehlt=""
ausgeloest=0
# Getrennt gezaehlt: Die Zusage der Mission Die Faltnaht lautet auf die zehn
# Pruefungen P01 bis P10. Eine elfte Pruefung darf diese Zahl nicht auffuellen,
# sonst waere eine abgeschlossene Zusage durch neue Arbeit billiger geworden.
# Dasselbe gilt ab P12 fuer jede weitere.
ausgeloest_faltnaht=0
# Die Liste nennt, was gebaut ist, und wurde mit jeder Pruefung erweitert. Seit
# dem 2026-08-15 steht P14 mit darin; damit nennt sie alle vier Pruefungen der
# Mission Die Beziehungsprobe. Ob die Mission damit erreicht ist, sagt ihre
# Missionsdatei und nicht der Exit-Code dieses Skripts.
for code in P01 P02 P03 P04 P05 P06 P07 P08 P09 P10 P11 P12 P13 P14 P15; do
    if ! grep -q " $code " "$erwartet"/*.txt; then
        fehlt="$fehlt $code"
    else
        ausgeloest=$((ausgeloest + 1))
        case "$code" in
            P11|P12|P13|P14|P15) ;;
            *) ausgeloest_faltnaht=$((ausgeloest_faltnaht + 1)) ;;
        esac
    fi
done
if [ -z "$fehlt" ]; then
    printf 'Abdeckung: alle %d Pruefungen bis P15 werden ausgeloest\n' \
        "$ausgeloest"
else
    printf 'Abdeckung unvollstaendig, nie ausgeloest:%s\n' "$fehlt"
    schlecht=$((schlecht + 1))
fi

printf 'Vorgaben: %d Beispiele (mindestens 12), %d davon fehlerfrei ' \
    "$anzahl" "$leer"
printf '(mindestens 2)\n'
if [ "$anzahl" -lt 12 ] || [ "$leer" -lt 2 ]; then
    printf 'Vorgabe der Missionsdatei verfehlt\n'
    schlecht=$((schlecht + 1))
fi

# Die abgeschlossene Mission Die Faltnaht, ohne Beschoenigung: 16 und 10. Die
# Zusage gilt weiter, sie wird hier nachgerechnet und nicht behauptet.
if [ "$anzahl" -ge 16 ] && [ "$ausgeloest_faltnaht" -ge 10 ]; then
    printf 'Faltnaht: %d Beispiele (16 verlangt), %d von 10 Pruefungen ' \
        "$anzahl" "$ausgeloest_faltnaht"
    printf '— Vorgabe erfuellt\n'
else
    printf 'Faltnaht: %d Beispiele (16 verlangt), %d von 10 Pruefungen ' \
        "$anzahl" "$ausgeloest_faltnaht"
    printf '— Vorgabe noch NICHT erfuellt\n'
fi

[ "$schlecht" -eq 0 ] || exit 1
exit 0
