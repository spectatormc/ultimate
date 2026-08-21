#!/bin/sh
# Rechnet den Ermessensdeckel aus Regel 12 an den Dateien in state/posts/ nach.
#
#   sh projekte/zustandspruefer/deckel.sh                       # jetzt
#   sh projekte/zustandspruefer/deckel.sh 2026-08-21T07:09:00Z  # zu einem Stichtag
#   echo "Exit-Code: $?"
#
# WOZU. Regel 12 laesst hoechstens vier Beitraege je rollender Woche nach
# meinem Ermessen zu; die Pflicht-Ausloeser aus Regel 2 zaehlen nicht dagegen.
# An dieser Zahl haengt in jedem Zyklus eine Entscheidung: Zaehle ich zu hoch,
# unterbleibt ein Beitrag, den der Kodex erlaubt. Zaehle ich zu tief, geht einer
# hinaus, den er nicht erlaubt.
#
# WARUM ES DIESES SKRIPT GIBT, mit Beleg statt als gute Absicht. Bis heute habe
# ich diese Zahl in jedem Zyklus von Hand an den Dateien gezaehlt. Am
# 2026-08-21 stand in state/stand.md eine andere Zahl ueber den eigenen Bestand
# falsch — der Rueckstand, aus einer vier Tage alten Zeile abgeschrieben statt
# gemessen. Das war ein Verstoss gegen Regel 1 und ist als
# state/posts/2026-08-21-01-verstoss-rueckstandszahl.md gepostet. Der Befund
# dazu steht in state/offen.md, Zyklus 45: Kein Werkzeug rechnet Zahlen in
# state/ nach. Dieses Skript schliesst davon genau ein Stueck.
#
# WAS ES NICHT IST, und das gehoert an dieselbe Stelle wie das Wozu:
#
#   - Es schliesst den Befund NICHT. Der Rueckstand — die Zahl, an der Zyklus 45
#     gescheitert ist — bleibt unmaschinell. Er ist keine Eigenschaft dieser
#     Dateien, sondern eine Buchung darueber, welche Pflicht-Meldung noch
#     aussteht, und die steht als Prosa in state/offen.md.
#   - Es prueft NICHT, ob ein angegebener Auslooeser zutrifft. Ob ein Beitrag
#     wirklich einen Fehlschlag meldet, entscheidet das Repo und nicht ein
#     Feldwert. Eine falsche Angabe waere ein Verstoss gegen Regel 1 und stuende
#     als Behauptung neben ihrem Gegenbeweis.
#   - Es sendet nichts und aendert keine Datei. Es liest.
#
# DIE ZAEHLREGEL STAMMT NICHT VON MIR. Sie steht in tools/senden.js in der
# Funktion ermessenInWoche(), und der Sender ist die Stelle, die sie durchsetzt.
# Dieses Skript bildet sie nach; damit die beiden nicht auseinanderlaufen, liest
# es die drei Vorgaben — Deckel, Fenster und die sechs Auslooeser-Namen —
# ebenfalls aus tools/senden.js, statt sie hier zu wiederholen. Findet es sie
# dort nicht in der erwarteten Form, sagt es 2 und nicht etwa einen alten Wert.
#
# ZWEI EXIT-CODES BEDEUTEN VERSCHIEDENES, wie in quellen.sh:
#
#   0  gezaehlt, Deckel nicht ueberschritten, Buchfuehrung heil
#   1  ein echter Befund gegen meine Buchfuehrung
#   2  ich kann es nicht sagen
#
# 1 schlaegt 2: Ein Befund darf nicht davon geschluckt werden, dass an einer
# anderen Stelle etwas unlesbar war.
#
# Keine Abhaengigkeiten ausser git, date und POSIX-Shell.

set -u

wurzel=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "UNKLAR kein Git-Repo — von wo aus soll ich lesen?"
    exit 2
}
cd "$wurzel" || exit 2

POSTS=state/posts
SENDER=tools/senden.js

befund=0    # -> Exit 1
unklar=0    # -> Exit 2

melde_befund() { echo "BEFUND $1"; befund=1; }
melde_unklar() { echo "UNKLAR $1"; unklar=1; }

# --- Die drei Vorgaben aus dem Sender lesen, nicht wiederholen ---------------

if [ ! -f "$SENDER" ]; then
    echo "UNKLAR $SENDER fehlt — die Zaehlregel steht dort und nirgends sonst."
    exit 2
fi

deckel=$(sed -n 's/^const WOCHE = \([0-9][0-9]*\);.*/\1/p' "$SENDER" | head -n 1)
tage=$(sed -n 's/^const TAGE = \([0-9][0-9]*\);.*/\1/p' "$SENDER" | head -n 1)
pflicht=$(sed -n 's/^const PFLICHT = \[\(.*\)\];.*/\1/p' "$SENDER" | head -n 1 |
          tr -d ' "' | tr ',' ' ')

if [ -z "$deckel" ] || [ -z "$tage" ] || [ -z "$pflicht" ]; then
    echo "UNKLAR $SENDER nennt WOCHE, TAGE oder PFLICHT nicht in der erwarteten Form."
    echo "      Lieber keine Zahl als eine aus einer veralteten Kopie."
    exit 2
fi

anzahl_pflicht=$(echo "$pflicht" | wc -w | tr -d ' ')

# --- Bezugszeitpunkt --------------------------------------------------------
# Ohne Argument: jetzt. Mit Argument: ein fester Stichtag, damit eine dritte
# Person dieselbe Zahl noch in einem Jahr bekommt.

if [ "$#" -gt 0 ] && [ -n "$1" ]; then
    bezug_text=$1
    bezug=$(date -u -d "$bezug_text" +%s 2>/dev/null) || bezug=
    if [ -z "$bezug" ]; then
        echo "UNKLAR \"$bezug_text\" ist kein Zeitpunkt, den ich lesen kann."
        exit 2
    fi
else
    bezug=$(date -u +%s 2>/dev/null) || bezug=
    if [ -z "$bezug" ]; then
        echo "UNKLAR kein brauchbares date — ohne Uhr kein rollendes Fenster."
        exit 2
    fi
    bezug_text=$(date -u -d "@$bezug" +%Y-%m-%dT%H:%M:%SZ)
fi

grenze=$((bezug - tage * 86400))
grenze_text=$(date -u -d "@$grenze" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null) || grenze_text="?"

echo "Bezugszeitpunkt: $bezug_text"
echo "Fenster:         ab $grenze_text ($tage Tage, rollend)"
echo "Pflicht-Namen:   $anzahl_pflicht — $(echo "$pflicht" | tr ' ' ',' | sed 's/,/, /g')"
echo ""

if [ ! -d "$POSTS" ]; then
    echo "UNKLAR $POSTS fehlt — nichts zu zaehlen und nichts zu behaupten."
    exit 2
fi

# --- Ein Feld aus dem Kopf lesen --------------------------------------------
# Der Kopf ist der Block zwischen der ersten und der zweiten Zeile "---".
# Nur dort wird gesucht: Ein Wort im Beitragstext ist kein Feld.

kopf_feld() {
    # $1 = Datei, $2 = Feldname
    awk -v feld="$2" '
        NR == 1 && $0 == "---" { imkopf = 1; next }
        imkopf && $0 == "---"  { exit }
        imkopf {
            trenn = index($0, ":")
            if (trenn > 0 && substr($0, 1, trenn - 1) == feld) {
                wert = substr($0, trenn + 1)
                sub(/^[ \t]+/, "", wert)
                sub(/[ \t\r]+$/, "", wert)
                print wert
                exit
            }
        }
    ' "$1"
}

ist_pflicht() {
    # $1 = Feldwert. Wie im Sender: kleingeschrieben woertlich einer der Namen.
    # Die eigenen Variablen heissen bewusst _klein und _name: eine Funktion in
    # POSIX-sh hat keine lokalen Variablen, und ein "name" haette hier den
    # Dateinamen der aufrufenden Schleife ueberschrieben.
    _klein=$(printf '%s' "$1" | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz')
    for _name in $pflicht; do
        [ "$_klein" = "$_name" ] && return 0
    done
    return 1
}

# --- Jede Datei einzeln ------------------------------------------------------

gezaehlt=0
gesendet_gesamt=0
geplant=0
verworfen=0
dateien=0

for datei in "$POSTS"/*.md; do
    [ -f "$datei" ] || continue
    name=$(basename "$datei")

    # Ohne Kopf ist es keine Beitragsdatei. state/posts/README.md faellt so
    # heraus, ohne dass der Name irgendwo als Ausnahme stehen muss.
    [ "$(head -n 1 "$datei")" = "---" ] || continue

    dateien=$((dateien + 1))
    status=$(kopf_feld "$datei" status)
    ausloeser=$(kopf_feld "$datei" ausloeser)
    gesendet_am=$(kopf_feld "$datei" gesendet_am)

    case "$status" in
        gesendet)  gesendet_gesamt=$((gesendet_gesamt + 1)) ;;
        geplant)   geplant=$((geplant + 1)) ;;
        verworfen) verworfen=$((verworfen + 1)) ;;
        "")        melde_befund "$name: kein Feld status im Kopf."; continue ;;
        *)         melde_befund "$name: status \"$status\" ist keiner von geplant, gesendet, verworfen."
                   continue ;;
    esac

    # Ein angegebener Auslooeser, den der Sender nicht kennt, bricht dort den
    # Lauf ab. Das soll man hier sehen und nicht erst beim Senden.
    if [ -n "$ausloeser" ] && ! ist_pflicht "$ausloeser"; then
        if [ "$status" = geplant ]; then
            melde_befund "$name: ausloeser \"$ausloeser\" ist keiner der $anzahl_pflicht Namen — der Sender bricht daran ab."
        else
            # Bereits gesendet: der Sender hat ihn als Ermessen verbucht, und
            # dabei bleibt es. Rueckwirkend umdeuten waere das Herstellen einer
            # Zahl statt einer Messung.
            echo "HINWEIS $name: ausloeser \"$ausloeser\" ist keiner der $anzahl_pflicht Namen — zaehlt als Ermessen."
        fi
    fi

    [ "$status" = gesendet ] || continue

    # Ein gesendeter Eintrag ohne Beleg macht die Zahl unpruefbar.
    for feld in gesendet_am uri url; do
        [ -n "$(kopf_feld "$datei" "$feld")" ] || melde_befund "$name: status gesendet, aber kein Feld $feld."
    done

    [ -n "$gesendet_am" ] || continue

    ts=$(date -u -d "$gesendet_am" +%s 2>/dev/null) || ts=
    if [ -z "$ts" ]; then
        melde_unklar "$name: gesendet_am \"$gesendet_am\" ist kein lesbarer Zeitpunkt."
        continue
    fi

    # Genau die Bedingung aus ermessenInWoche(): >= grenze, ohne obere Schranke.
    [ "$ts" -ge "$grenze" ] || continue

    if ist_pflicht "$ausloeser"; then
        art="Pflicht  ($ausloeser)"
    else
        art="ERMESSEN"
        gezaehlt=$((gezaehlt + 1))
    fi
    printf '  %-8s %s  %s\n' "$art" "$gesendet_am" "$name"
done

echo ""
echo "$dateien Beitragsdatei(en): $gesendet_gesamt gesendet, $geplant geplant, $verworfen verworfen."

if [ "$gezaehlt" -gt "$deckel" ]; then
    melde_befund "Ermessen im Fenster: $gezaehlt von $deckel — der Deckel aus Regel 12 ist ueberschritten."
else
    echo "Ermessen im Fenster: $gezaehlt von $deckel."
fi

echo ""
if [ "$befund" -eq 1 ]; then
    echo "Mindestens ein Befund gegen die Buchfuehrung. Exit 1."
    exit 1
fi
if [ "$unklar" -eq 1 ]; then
    echo "Gezaehlt, aber nicht vollstaendig — mindestens ein Eintrag war unlesbar. Exit 2."
    exit 2
fi
echo "Nachgerechnet an $dateien Datei(en), nicht erinnert."
exit 0
