#!/bin/sh
# Anlassmessung fuer die Pruefungen, die dieses Werkzeug bewusst NICHT hat.
#
#   sh projekte/icsdoktor/anlass.sh
#   echo "Exit-Code: $?"
#
# WOZU. Der ICS-Doktor baut eine Pruefung nur, wenn eine Messung den Anlass
# gibt. Wo er eine Pflicht der Norm absichtlich nicht prueft, steht der Grund
# im Docstring und in state/offen.md, und er endet regelmaessig mit dem Satz
# "keine der Beispieldateien und keine der elf fremden Eingaben loest den
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
#   betrachtet   wie viele Dinge der fraglichen Art ueberhaupt in den Eingaben
#                stehen. Ist diese Zahl 0, sagt das Ergebnis nichts ueber den
#                Fall aus, sondern nur etwas ueber den Korpus.
#   Treffer      wie viele davon die Pflicht wirklich verletzen.
#
# Erst beide zusammen tragen den Satz "kein Anlass". Eine 0 ohne die erste Zahl
# daneben ist genau die Auskunft, die 2026-08-17 in die Irre gefuehrt hat.
#
# WAS "betrachtet" ZAEHLT, haengt am Fall und steht deshalb neben ihm. Bei einer
# Pflicht, die eine Komponente als Ganzes trifft ("ein VALARM braucht ein
# TRIGGER"), sind es Komponenten. Bei einer Pflicht, die an einer einzelnen
# Eigenschaft haengt ("ein RRULE darf nicht beides tragen"), waeren Komponenten
# die falsche Zahl: Vierzig VEVENT ohne ein einziges RRULE ergaeben
# "betrachtet: 40, Treffer: 0" — dieselbe beruhigende Auskunft ueber nichts, vor
# der der Absatz darueber warnt. Gezaehlt wird dann die Eigenschaft.
#
# DIE EINGABEN sind dieselben wie ueberall in diesem Projekt:
#   - die Beispieldateien aus beispiele/ (meine eigenen);
#   - die sechs vollstaendigen Kalenderobjekte aus RFC 5545 §4, geholt vom
#     RFC-Editor, ausgeschnitten wie in rfc-beispiele.sh, aber OHNE die Errata
#     — gemessen wird der Text, wie er im RFC steht;
#   - die fuenf Fremddateien aus korpus.tsv, geholt und ausgeschnitten wie in
#     fremdprobe.sh.
# Die letzten elf zur Laufzeit. Fremde Kalenderdaten kommen nicht in dieses
# Repo (Regel 7); das temporaere Verzeichnis wird am Ende geloescht.
#
# GELESEN WIRD MIT DEM PARSER DES WERKZEUGS SELBST — zerlege_physisch,
# entfalte, pruefe_p04, pruefe_p05 aus icsdoktor.py. Die Frage lautet nicht
# "steht das irgendwo im Text", sondern "haette der ICS-Doktor hier einen
# Anlass". Wer mit einem zweiten Leser misst, misst den zweiten Leser mit.
#
# WAS DIESES SKRIPT NICHT IST. Kein Prueflauf des Werkzeugs — es meldet nichts
# ueber die fünfundzwanzig gebauten Pruefungen und ersetzt pruefe.sh nicht. Es
# beantwortet genau eine Frage: Gibt es einen Anlass, die 26. zu bauen?
#
# Beide Zahlen in diesem Absatz standen seit dem 2026-08-18 falsch — sie
# nannten den Stand vor P20. Seither rechnet zahlen.sh sie nach.
#
# NETZ. Vier der fuenf Fremddateien kommen ueber api.github.com; ohne
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

# --- Die fuenf Fremddateien aus korpus.tsv ----------------------------------
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

if [ "$fremd" -ne 5 ]; then
	echo "ABBRUCH: $fremd Fremddateien geholt, erwartet 5." >&2
	exit 2
fi

# --- Messen -----------------------------------------------------------------

python3 - "$werkzeug" "$arbeit" "$beispiele" <<'PY'
import os
import sys

werkzeug, arbeit, beispiele = sys.argv[1], sys.argv[2], sys.argv[3]
sys.path.insert(0, os.path.dirname(os.path.abspath(werkzeug)))
import icsdoktor as d


# Ein Fall je bewusst nicht gebauter Pruefung. Wer eine weitere Begruendung
# "im Repo unbelegt" aufschreibt, haengt sie hier an — sonst altert sie still.
#
#   name        wie der Fall in der Ausgabe heisst
#   abschnitt   die Stelle im Normtext
#   arten       welche Komponenten ueberhaupt betrachtet werden, oder None fuer
#               jede Komponente — dann entscheidet allein zaehlt, was zaehlt
#   pflicht     pflicht(komp, alle) -> ein fertiger Satzteil je betroffener
#               Einheit; "alle" sind die Komponenten derselben Datei, fuer
#               Faelle, die auf die Schachtelung schauen muessen. Ein Eintrag
#               ist eine Einheit, nicht eine verletzte Pflicht: Ein VALARM, dem
#               zwei Eigenschaften fehlen, ist ein Treffer und nicht zwei,
#               sonst zaehlen "betrachtet" und "Treffer" verschiedene Dinge.
#   wo          wo die Begruendung steht, die dieses Skript nachrechnet
#   einheit     wie das Ding heisst, das "betrachtet" zaehlt (Mehrzahl)
#   zaehlt      zaehlt(komp, alle) -> wie viele solche Dinge diese Komponente
#               beisteuert. Fuer Pflichten an der Komponente ist das 1.
#
# Warum die Meldungen in pflicht ausformuliert werden und nicht erst hier: Ein
# fehlendes DESCRIPTION und ein RRULE, das zwei einander ausschliessende
# Regelteile traegt, sind nicht dasselbe. Eine gemeinsame Schablone ("fehlt %s")
# muesste den zweiten Fall verbiegen, und verbogene Meldungen sind der Anfang
# von Meldungen, die nicht mehr stimmen.

def fehlt_satz(namen):
    """Ein Satzteil fuer alle fehlenden Eigenschaften einer Komponente.

    Eine Komponente ist eine Einheit, auch wenn ihr drei Eigenschaften fehlen.
    Deshalb steht hier ein Satzteil und nicht drei — die Liste ausserhalb
    zaehlt Einheiten.
    """
    if not namen:
        return []
    wort = "fehlt" if len(namen) == 1 else "fehlen"
    return ["%s %s" % (", ".join(namen), wort)]


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
    return fehlt_satz([e for e in noetig if not komp.hole(e)])


# HIER STANDEN fehlt_vtimezone und fehlt_zeitzonenteil — entfernt am
# 2026-09-01 (Zyklus 82), aus demselben Grund und nach demselben Muster wie
# untilcount_im_rrule weiter unten. Beide massen einen Anlass fuer eine
# Pruefung, die es nicht gab; seit Zyklus 82 gibt es sie. pruefe_p23 in
# icsdoktor.py meldet alle drei Pflichten aus §3.6.5 mit Zeile, Kennung und
# [RFC 5545 §3.6.5]. Der Code ist nicht verloren: Er steht in der
# Git-Historie und, in der Sache identisch, als pruefe_p23.
#
# Dass die Zahl der Faelle dabei von drei auf einen faellt, ist keine
# weichgeklopfte Messung, sondern genau das, was dieses Skript sagt: Ein
# Anlass verschwindet hier nicht, weil er erledigt waere, sondern weil er
# gebaut ist. Wer nachrechnen will, ob P23 den Fall wirklich trifft, liest
# nicht dieses Skript, sondern pruefe.sh und beispiele/70 bis 73.


# HIER STAND untilcount_im_rrule, dazu zaehlt_rrule — entfernt am 2026-08-24
# (Zyklus 58). Der Grund steht ausfuehrlich bei FAELLE weiter unten. In Kuerze:
# Dieses Skript misst Anlaesse fuer Pruefungen, die es NICHT gibt. Seit
# Zyklus 57 gibt es P21 (Commit bfec9cf), also gibt es diesen Fall hier nicht
# mehr. Der Code ist nicht verloren — er steht in der Git-Historie und, in der
# Sache identisch, als pruefe_p21 in icsdoktor.py.


def zaehlt_komponente(komp, alle):
    """Die Pflicht haengt an der Komponente selbst: sie zaehlt einmal."""
    return 1


FAELLE = (
    ("VALARM, aktionsabhaengige Pflichten", "3.6.6", ("VALARM",),
     fehlt_valarm,
     "pruefe_p19, Docstring; state/offen.md, Zyklus 29",
     "Komponenten", zaehlt_komponente),
)

# HIER STAND EIN VIERTER FALL: ("RRULE, UNTIL und COUNT zugleich", "3.3.10",
# None, untilcount_im_rrule, "pruefe_p17, Docstring; state/offen.md,
# Zyklus 36", "RRULE-Zeilen", zaehlt_rrule). Er ist am 2026-08-24 (Zyklus 58)
# entfernt worden. Warum, und warum das keine weichgeklopfte Messung ist:
#
# Dieser Fall hat gemessen, ob es einen Anlass gibt, eine Pruefung zu bauen,
# die es nicht gab. Seit Zyklus 57 gibt es sie: pruefe_p21 in icsdoktor.py
# meldet genau diesen Verstoss mit Zeile, Kennung und [RFC 5545 §3.3.10]
# (Commit bfec9cf). Damit ist der Fall nicht "erledigt", sondern
# gegenstandslos — der Kopf dieser Datei sagt "Ein Fall je bewusst nicht
# gebauter Pruefung", und bewusst nicht gebaut ist hier nichts mehr.
#
# WAS DAS BEHOBEN HAT, offen hingeschrieben statt uebergangen. Zyklus 57 hat
# P21 gebaut, aber diesen Fall stehen lassen und anlass.sh nicht gemessen
# (das Journal zu Zyklus 57 fuehrt anlass.sh ausdruecklich unter "nicht
# gemessen"). Das Skript war damit rot, ohne dass es jemand wusste: Gemessen am
# 2026-08-24 gegen 13:24 UTC meldete es "betrachtet: 14 RRULE-Zeilen,
# Treffer: 3" und Exit 1 — die drei Treffer waren die neuen Beispieldateien
# 57, 59 und 60, also die Belege von P21 selbst. Ein Skript, das die eigenen
# Belege als Anlass meldet, misst nichts mehr.
#
# WAS HIER NICHT PASSIERT IST: Kein Treffer wurde weggeschnitten, damit eine
# Zahl gruen wird. Die drei Treffer sind echt und stehen weiter da — sie werden
# jetzt von pruefe.sh und den erwartet/-Dateien gemessen, byte-genau, statt
# von einer Anlassfrage, die beantwortet ist.
#
# Der Absatz "WAS 'betrachtet' ZAEHLT" im Kopf benutzt weiter das RRULE als
# Beispiel fuer eine Pflicht, die an einer Eigenschaft haengt. Er bleibt
# stehen: Er erklaert die Bauart dieses Skripts und behauptet nicht, dass es
# diesen Fall noch fuehrt. Kommt je ein Fall dieser Bauart dazu, ist die
# Vorrichtung dafuer in der Historie und die Erklaerung im Kopf.

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
      "5 Fremddateien" % (len(eingaben) - 11))
print("Gelesen mit dem Parser von icsdoktor.py, nicht mit einem zweiten.")
print("")

anlaesse = 0
for name, abschnitt, arten, pflicht, wo, einheit, zaehlt in FAELLE:
    betrachtet = 0
    treffer = []
    for kurz, komponenten in gelesen:
        for komp in komponenten:
            if arten is not None and komp.name not in arten:
                continue
            betrachtet += zaehlt(komp, komponenten)
            verletzt = pflicht(komp, komponenten)
            if verletzt:
                treffer.append((kurz, komp.zeile, verletzt))
    # Gezaehlt werden betroffene Einheiten und nicht Komponenten mit einem
    # Befund. Sonst stuenden links RRULE-Zeilen und rechts Komponenten.
    getroffen = sum(len(verletzt) for _, _, verletzt in treffer)
    print("%s (§%s)" % (name, abschnitt))
    print("  betrachtet: %d %s   Treffer: %d" % (betrachtet, einheit, getroffen))
    if betrachtet == 0:
        print("  ACHTUNG: keine %s dieser Art in den Eingaben. Das Ergebnis"
              % einheit)
        print("  sagt nichts ueber den Fall, nur etwas ueber den Korpus —")
        print("  und traegt den Satz \"kein Anlass\" nicht.")
        anlaesse += 1
    for kurz, zeile, verletzt in treffer:
        print("  ANLASS %s, ab Zeile %d: %s"
              % (kurz, zeile, ", ".join(verletzt)))
    anlaesse += getroffen
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
