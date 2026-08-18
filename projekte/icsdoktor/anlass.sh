#!/bin/sh
# Anlassmessung fuer die Pruefungen, die dieses Werkzeug bewusst NICHT hat.
#
#   sh projekte/icsdoktor/anlass.sh
#   echo "Exit-Code: $?"
#
# WOZU. Der ICS-Doktor baut eine Pruefung nur, wenn eine Messung den Anlass
# gibt. Wo er eine Pflicht der Norm absichtlich nicht prueft, steht der Grund
# im Docstring und in state/offen.md, und er endet regelmaessig mit dem Satz
# "keine der Beispieldateien und keine der zwoelf fremden Eingaben loest den
# Fall heute aus". Dieses Skript rechnet diesen Satz nach.
#
# WARUM ES DIESES SKRIPT GIBT, und zwar mit Beleg statt als gute Absicht.
# Genau so ein Satz stand am 2026-08-17 zweimal im Repo und war falsch: Zu
# P16/P18 hiess es "kein Beispiel und keine der zwoelf Eingaben loest den Fall
# heute aus", waehrend beispiele/12-p08-datumszeit.ics ihn in Zeile 14 ausloest
# und die Fremddatei vagov-23608 ebenfalls. Zwei Zyklen lang hat dieser Satz
# die Arbeit aufgehalten, weil ihn niemand nachgesehen hat (Commit b2fb773,
# state/journal/2026-08-17-zyklus-31.md). Eine Behauptung ueber den Zustand des
# Repos gehoert in einen Befehl und nicht in einen Absatz: Ein Absatz altert
# still, ein Befehl wird rot.
#
# WAS GEMESSEN WIRD. Je Fall zwei Zahlen statt einer:
#
#   betrachtet   wie viele Komponenten der fraglichen Art ueberhaupt in den
#                Eingaben stehen. Ist diese Zahl 0, sagt das Ergebnis nichts
#                ueber den Fall aus, sondern nur etwas ueber den Korpus.
#   Treffer      wie viele davon die Pflicht wirklich verletzen.
#
# Erst beide zusammen tragen den Satz "kein Anlass". Eine 0 ohne die erste Zahl
# daneben ist genau die Auskunft, die 2026-08-17 in die Irre gefuehrt hat.
#
# DIE EINGABEN sind dieselben wie ueberall in diesem Projekt:
#   - die Beispieldateien aus beispiele/ (meine eigenen);
#   - die sechs vollstaendigen Kalenderobjekte aus RFC 5545 §4, geholt vom
#     RFC-Editor, ausgeschnitten wie in rfc-beispiele.sh, aber OHNE die Errata
#     — gemessen wird der Text, wie er im RFC steht;
#   - die sechs Fremddateien aus korpus.tsv, geholt und ausgeschnitten wie in
#     fremdprobe.sh.
# Die letzten zwoelf zur Laufzeit. Fremde Kalenderdaten kommen nicht in dieses
# Repo (Regel 7); das temporaere Verzeichnis wird am Ende geloescht.
#
# GELESEN WIRD MIT DEM PARSER DES WERKZEUGS SELBST — zerlege_physisch,
# entfalte, pruefe_p04, pruefe_p05 aus icsdoktor.py. Die Frage lautet nicht
# "steht das irgendwo im Text", sondern "haette der ICS-Doktor hier einen
# Anlass". Wer mit einem zweiten Leser misst, misst den zweiten Leser mit.
#
# WAS DIESES SKRIPT NICHT IST. Kein Prueflauf des Werkzeugs — es meldet nichts
# ueber die zwanzig gebauten Pruefungen und ersetzt pruefe.sh nicht. Es
# beantwortet genau eine Frage: Gibt es einen Anlass, die 21. zu bauen?
#
# Beide Zahlen in diesem Absatz standen seit dem 2026-08-18 falsch — sie
# nannten den Stand vor P20. Seither rechnet zahlen.sh sie nach.
#
# NETZ. Fuenf der sechs Fremddateien kommen ueber api.github.com; ohne
# Anmeldung erlaubt GitHub dort 60 Anfragen pro Stunde und IP. Ein Lauf dieses
# Skripts verbraucht davon fuenf, genau wie ein Lauf von fremdprobe.sh oder
# gegenprobe.sh. Wer die drei hintereinander mehrmals laufen laesst, laeuft in
# die Grenze — dann endet dieses Skript mit 2 und nicht mit 0. Kein Ergebnis
# ist kein gruenes Ergebnis.
#
# Exit-Code: 0 kein Anlass, die Begruendungen im Repo stimmen weiter
#            1 mindestens ein Anlass — dann ist eine Begruendung veraltet
#            2 Aufruf-, Umgebungs- oder Netzfehler

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
korpus="$verzeichnis/korpus.tsv"
beispiele="$verzeichnis/beispiele"

[ -f "$werkzeug" ] || { echo "FEHLER: $werkzeug fehlt" >&2; exit 2; }
[ -f "$korpus" ]   || { echo "FEHLER: $korpus fehlt" >&2; exit 2; }
[ -d "$beispiele" ] || { echo "FEHLER: $beispiele fehlt" >&2; exit 2; }

for befehl in curl python3 awk; do
	command -v "$befehl" >/dev/null 2>&1 || {
		echo "FEHLER: $befehl wurde nicht gefunden" >&2; exit 2; }
done

arbeit=$(mktemp -d) || exit 2
# shellcheck disable=SC2064
trap "rm -rf '$arbeit'" EXIT INT TERM

# --- Die sechs Kalenderobjekte aus RFC 5545 §4 ------------------------------
#
# Wortgleich zu rfc-beispiele.sh, bis auf die Errata: Die werden hier nicht
# angewandt. Errata 2039 und 4149 ergaenzen VALUE=DATE-TIME, UID und DTSTAMP
# und beruehren weder die aktionsabhaengigen Pflichten des VALARM noch das
# VTIMEZONE; welche Fassung gemessen wird, aendert am Ergebnis nichts und wird
# trotzdem hingeschrieben.

quelle="https://www.rfc-editor.org/rfc/rfc5545.txt"
curl -sSf --max-time 60 "$quelle" > "$arbeit/rfc.txt" 2> "$arbeit/lade" || {
	echo "ABBRUCH: $quelle ist nicht erreichbar." >&2
	[ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
	echo "Dieses Skript braucht Netz. Kein Ergebnis ist kein gruenes" >&2
	echo "Ergebnis." >&2
	exit 2; }

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
        printf "%s\r\n", substr($0, 8) > (ziel "/rfc-objekt-" n ".ics")
    }
    /^ +END:VCALENDAR[[:space:]]*$/ { drin = 0 }
    END {
        print n + 0 > (ziel "/anzahl")
        print schlecht + 0 > (ziel "/schlecht")
    }
' "$arbeit/abschnitt4.txt"

if [ "$(cat "$arbeit/schlecht")" != "0" ]; then
	echo "ABBRUCH: Zeilen im Ausschnitt tragen nicht die erwartete" >&2
	echo "Grundeinrueckung von sieben Leerzeichen." >&2
	exit 2
fi
if [ "$(cat "$arbeit/anzahl")" != "6" ]; then
	echo "ABBRUCH: $(cat "$arbeit/anzahl") Kalenderobjekte gefunden, erwartet 6." >&2
	exit 2
fi

# --- Die sechs Fremddateien aus korpus.tsv ----------------------------------
#
# Wortgleich zu fremdprobe.sh. Der Kommentar dort erklaert die drei
# Quellsorten und warum bei "bericht" und "block" die Zeilenenden meine sind.

ausschneiden() {
	python3 -c '
import json, re, sys
roh = json.load(open(sys.argv[1])).get("body") or ""
rahmen = sys.argv[2]
zeilen = [z.rstrip("\r").strip() for z in roh.splitlines()]

if rahmen:
    name = rahmen
else:
    treffer = [z[len("BEGIN:"):] for z in zeilen
               if re.fullmatch(r"BEGIN:[A-Z][A-Z0-9-]*", z)]
    if not treffer:
        sys.exit(3)
    name = treffer[0]

try:
    a = next(i for i, z in enumerate(zeilen) if z == "BEGIN:" + name)
except StopIteration:
    sys.exit(3)

tiefe = 0
for e in range(a, len(zeilen)):
    if zeilen[e] == "BEGIN:" + name:
        tiefe += 1
    elif zeilen[e] == "END:" + name:
        tiefe -= 1
        if tiefe == 0:
            sys.stdout.write("\r\n".join(zeilen[a:e + 1]) + "\r\n")
            sys.exit(0)
sys.exit(3)
' "$1" "$2"
}

fremd=0
while IFS='	' read -r id typ fundstelle quelle kennung beleg abschnitt klage; do
	case "$id" in ''|'#'*) continue ;; esac
	datei="$arbeit/fremd-$id.ics"
	if [ "$typ" = anhang ]; then
		curl -sSLf -o "$datei" "$quelle" 2>/dev/null || {
			echo "ABBRUCH: Anhang zu $id nicht erreichbar: $quelle" >&2
			echo "Eine tote Quelle ist ein Befund ueber GitHub, nicht ueber" >&2
			echo "den Anlass. Kein Ergebnis ist kein gruenes Ergebnis." >&2
			exit 2; }
	else
		case "$typ" in
			bericht) rahmen=VCALENDAR ;;
			block)   rahmen= ;;
			*) echo "FEHLER: unbekannter Typ \"$typ\" in Zeile zu $id" >&2
			   exit 2 ;;
		esac
		curl -sSLf -o "$arbeit/$id.json" "$quelle" 2>/dev/null || {
			echo "ABBRUCH: Bericht $fundstelle nicht abrufbar." >&2
			exit 2; }
		ausschneiden "$arbeit/$id.json" "$rahmen" > "$datei" || {
			echo "ABBRUCH: kein Block im Bericht $fundstelle." >&2
			exit 2; }
	fi
	fremd=$((fremd + 1))
done < "$korpus"

if [ "$fremd" -ne 6 ]; then
	echo "ABBRUCH: $fremd Fremddateien geholt, erwartet 6." >&2
	exit 2
fi

# --- Messen -----------------------------------------------------------------

python3 - "$werkzeug" "$arbeit" "$beispiele" <<'PY'
import os
import sys

werkzeug, arbeit, beispiele = sys.argv[1], sys.argv[2], sys.argv[3]
sys.path.insert(0, os.path.dirname(os.path.abspath(werkzeug)))
import icsdoktor as d


# Ein Fall je bewusst nicht gebauter Pruefung. Wer eine dritte Begruendung
# "im Repo unbelegt" aufschreibt, haengt sie hier an — sonst altert sie still.
#
#   name        wie der Fall in der Ausgabe heisst
#   abschnitt   die Stelle im Normtext
#   arten       welche Komponenten ueberhaupt betrachtet werden
#   pflicht     fehlt(komp, alle) -> Liste der verletzten Pflichten; "alle"
#               sind die Komponenten derselben Datei, fuer Faelle, die auf die
#               Schachtelung schauen muessen
#   wo          wo die Begruendung steht, die dieses Skript nachrechnet

def fehlt_valarm(komp, alle):
    """§3.6.6: die aktionsabhaengigen Pflichten von dispprop und emailprop.

    Woertlich: dispprop fuehrt "action / description / trigger" unter "The
    following are REQUIRED, but MUST NOT occur more than once."; emailprop
    fuehrt "action / description / trigger / summary" ebenso und "attendee"
    unter "The following is REQUIRED, and MAY occur more than once."

    audioprop verlangt nur action und trigger — die prueft P19 schon, und sie
    zaehlen hier deshalb nicht mit. Traegt ACTION einen anderen Wert, ist keine
    der drei Varianten anwendbar: §3.8.6.1 laesst dort iana-token und x-name
    zu, und eine Pflicht, die es fuer diesen Wert nicht gibt, ist keine.
    """
    treffer = komp.hole("ACTION")
    if not treffer:
        return []                        # das meldet P19
    wert = (treffer[0][1] or "").strip().upper()
    if wert == "DISPLAY":
        noetig = ("DESCRIPTION",)
    elif wert == "EMAIL":
        noetig = ("DESCRIPTION", "SUMMARY", "ATTENDEE")
    else:
        return []                        # audio, iana-token, x-name
    return [e for e in noetig if not komp.hole(e)]


def fehlt_vtimezone(komp, alle):
    """§3.6.5: "'tzid' is REQUIRED, but MUST NOT occur more than once."

    Dass eine der beiden Unterkomponenten vorkommen muss ("One of 'standardc'
    or 'daylightc' MUST occur"), steht hier mit, weil es dieselbe Zeile der
    ABNF ist. Gezaehlt wird nur das Fehlen; die Obergrenze "MUST NOT occur
    more than once" prueft dieser Fall nicht, weil die Begruendung in
    state/offen.md sie nicht nennt.
    """
    fehlt = [] if komp.hole("TZID") else ["TZID"]
    kinder = [k for k in alle
              if k.elternteil is komp and k.name in ("STANDARD", "DAYLIGHT")]
    if not kinder:
        fehlt.append("STANDARD oder DAYLIGHT")
    return fehlt


def fehlt_zeitzonenteil(komp, alle):
    """§3.6.5, standardc und daylightc: "The following are REQUIRED, but MUST
    NOT occur more than once: dtstart / tzoffsetto / tzoffsetfrom"."""
    return [e for e in ("DTSTART", "TZOFFSETTO", "TZOFFSETFROM")
            if not komp.hole(e)]


FAELLE = (
    ("VALARM, aktionsabhaengige Pflichten", "3.6.6", ("VALARM",),
     fehlt_valarm,
     "pruefe_p19, Docstring; state/offen.md, Zyklus 29"),
    ("VTIMEZONE, Pflichteigenschaften", "3.6.5", ("VTIMEZONE",),
     fehlt_vtimezone,
     "pruefe_p19, Docstring; state/offen.md, Zyklus 29"),
    ("STANDARD/DAYLIGHT, Pflichteigenschaften", "3.6.5",
     ("STANDARD", "DAYLIGHT"), fehlt_zeitzonenteil,
     "pruefe_p19, Docstring; state/offen.md, Zyklus 29"),
)

def lies(pfad):
    """Die Komponenten einer Datei, gelesen wie der ICS-Doktor sie liest."""
    with open(pfad, "rb") as f:
        roh = f.read()
    zeilen = d.zerlege_physisch(roh)
    if not zeilen:
        return []
    logische = d.entfalte(zeilen)
    d.pruefe_p04(logische, [])           # setzt name, params, wert
    return d.pruefe_p05(logische, [])    # setzt elternteil


eingaben = []
for datei in sorted(os.listdir(beispiele)):
    if datei.endswith(".ics"):
        eingaben.append((os.path.join(beispiele, datei), "beispiel " + datei))
for datei in sorted(os.listdir(arbeit)):
    if datei.startswith("rfc-objekt-") and datei.endswith(".ics"):
        eingaben.append((os.path.join(arbeit, datei), "RFC §4 " + datei))
for datei in sorted(os.listdir(arbeit)):
    if datei.startswith("fremd-") and datei.endswith(".ics"):
        eingaben.append((os.path.join(arbeit, datei), "fremd " + datei))

gelesen = []
for pfad, kurz in eingaben:
    try:
        gelesen.append((kurz, lies(pfad)))
    except Exception as fehler:          # eine unlesbare Eingabe ist ein Befund
        sys.stderr.write("ABBRUCH: %s ist nicht lesbar: %s\n" % (kurz, fehler))
        raise SystemExit(2)

print("Eingaben: %d Beispieldateien, 6 Kalenderobjekte aus RFC 5545 §4, "
      "6 Fremddateien" % (len(eingaben) - 12))
print("Gelesen mit dem Parser von icsdoktor.py, nicht mit einem zweiten.")
print("")

anlaesse = 0
for name, abschnitt, arten, pflicht, wo in FAELLE:
    betrachtet = 0
    treffer = []
    for kurz, komponenten in gelesen:
        for komp in komponenten:
            if komp.name not in arten:
                continue
            betrachtet += 1
            fehlt = pflicht(komp, komponenten)
            if fehlt:
                treffer.append((kurz, komp.zeile, fehlt))
    print("%s (§%s)" % (name, abschnitt))
    print("  betrachtet: %d Komponenten   Treffer: %d"
          % (betrachtet, len(treffer)))
    if betrachtet == 0:
        print("  ACHTUNG: keine Komponente dieser Art in den Eingaben. Das")
        print("  Ergebnis sagt nichts ueber den Fall, nur etwas ueber den")
        print("  Korpus — und traegt den Satz \"kein Anlass\" nicht.")
        anlaesse += 1
    for kurz, zeile, fehlt in treffer:
        print("  ANLASS %s, ab Zeile %d: fehlt %s"
              % (kurz, zeile, ", ".join(fehlt)))
    anlaesse += len(treffer)
    print("  Begruendung, die das nachrechnet: %s" % wo)
    print("")

if anlaesse:
    print("%d Anlass/Anlaesse. Mindestens eine Begruendung im Repo ist "
          "veraltet." % anlaesse)
    raise SystemExit(1)

print("Kein Anlass. Die Begruendungen im Repo stimmen weiter — gemessen, "
      "nicht behauptet.")
raise SystemExit(0)
PY
