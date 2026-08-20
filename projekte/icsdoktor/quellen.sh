#!/bin/sh
# Haelt die fremden Zitate dieses Projekts gegen die Quellen, aus denen sie
# stammen sollen.
#
#   sh projekte/icsdoktor/quellen.sh
#   echo "Exit-Code: $?"
#
# WOZU. korpus.tsv traegt in der Spalte "klage" je Zeile ein woertliches Zitat
# aus einem fremden Fehlerbericht. Diese sechs Zitate sind der Maßstab dieses
# Projekts, der nicht aus meiner Hand stammt: Sie sagen, worueber jemand
# geklagt hat, und fremdprobe.sh misst daran, ob der ICS-Doktor die Klage
# meldet.
#
# Geprueft hat sie bisher niemand. fremdprobe.sh DRUCKT die Spalte, wenn eine
# Datei abweicht; gegenprobe.sh und anlass.sh lesen sie ein und vergleichen
# sie mit nichts. Ein Zitat, das ich einmal abgeschrieben habe, steht seither
# unbelegt im Repo — es koennte falsch abgeschrieben sein, der Bericht koennte
# geaendert worden sein, die Quelle koennte weg sein.
#
# WARUM DAS KEINE VORSICHTSMASSNAHME IST, sondern eine Reaktion auf eine
# Messung: Am 2026-08-20 gegen 19:05 UTC war das Repository
# department-of-veterans-affairs/va.gov-team nicht mehr abrufbar — HTTP 404
# auf die Fundstelle, auf das Repository und auf die HTML-Seite, waehrend die
# Organisation darueber mit 200 antwortete und 55 von 60 Abrufen frei waren.
# Keine Ratenbegrenzung; eine Quelle war weg. Sechs Stunden vorher, in
# Zyklus 42, war derselbe Abruf gruen. Belege verschwinden, und zwar
# stillschweigend.
#
# Regel 1 verlangt fuer jede Behauptung einen Beleg. Ein Beleg, der
# verschwindet, macht die Behauptung nicht falsch — er macht sie unbelegt, und
# das gehoert gesagt statt bemerkt.
#
# DIE VERGLEICHSREGEL, festgelegt bevor der erste Vergleich lief:
#
#   1. Das Zitat wird an "[...]" (U+2026 in eckigen Klammern) in Teile
#      zerlegt. JEDER Teil muss woertlich vorkommen, in der Reihenfolge des
#      Zitats. Eine Auslassung im Zitat ist eine Auslassung, kein Freibrief.
#   2. Gesucht wird im Text der Fundstelle UND in ihren Kommentaren. Wer
#      seinen Fall im ersten Kommentar praezisiert, hat ihn dort geschrieben;
#      ein Zitat von dort ist zitiert und nicht erfunden.
#   3. Normalisiert wird genau zweierlei: typografische Anfuehrungszeichen und
#      Apostrophe auf ihre geraden Formen, und jede Folge aus Leerraum
#      einschliesslich Zeilenumbruch auf ein Leerzeichen. Ein Bericht ist
#      umbrochener Markdown; ein Zitat ueber einen Zeilenumbruch ist dasselbe
#      Zitat. ALLES ANDERE BLEIBT WOERTLICH — keine Kleinschreibung, keine
#      entfernte Zeichensetzung, keine Aehnlichkeit.
#
# Was hier NICHT gemessen wird: ob die Klage berechtigt ist, ob der Normtext
# sie stuetzt, ob der ICS-Doktor sie meldet. Das tun gegenprobe.sh,
# fundstellen.sh und fremdprobe.sh. Dieses Skript fragt genau eine Sache —
# steht das Zitat noch dort, wo ich behaupte, dass es steht?
#
# NETZ NOETIG, und der Verbrauch ist vorhersagbar: zwei Abrufe je Korpuszeile,
# macht 12 Abrufe je Lauf. Ohne Anmeldung erlaubt api.github.com 60 Abrufe pro
# Stunde und IP; fremdprobe.sh, gegenprobe.sh und anlass.sh brauchen je fuenf.
# Die Zahl steht in der Tabelle von zahlen.sh und altert deshalb nicht still
# mit, wenn korpus.tsv eine Zeile dazubekommt.
#
# Eine unerreichbare Quelle ist KEIN Befund gegen das Zitat. Sie ist ein
# Befund darueber, dass ich es nicht mehr pruefen kann, und die beiden
# auseinanderzuhalten ist der ganze Wert der drei Exit-Codes.
#
# WAS DIESEM SKRIPT AM TAG SEINER ENTSTEHUNG FEHLT, und das steht hier oben
# statt in einer Fussnote: Es liest den Text einer Fundstelle und ihre
# Kommentare — NICHT ihren Titel. Am 2026-08-20 gemessen und nicht vermutet:
# Zwei Zitate (icaljs-620, fossify-1102) stehen woertlich im Titel
# ihrer Fundstelle und in keinem Text. Beide Zitate sind richtig; die Luecke
# liegt in diesem Skript.
#
# Der Titel wird trotzdem NICHT in diesem Zyklus nachgetragen, und der Grund
# ist derselbe wie bei der zwoelften Verbiegung in robustheit.sh: Die
# Vergleichsregel stand vor der Messung fest, zusammen mit der Vorhersage
# "fuenf von fuenf". Gemessen sind drei von fuenf. Eine Regel, die man
# aufmacht, sobald ihr Ergebnis unbequem wird, hat nie eine Regel sein
# koennen — und die Erweiterung geht hier in die verbotene Richtung: Sie
# macht einen roten Lauf gruen. Sie gehoert an den ANFANG des naechsten
# Zyklus, mit ihrer eigenen Zusage davor. Der Befund steht in state/offen.md.
#
# DESHALB VERGIBT DIESES SKRIPT HEUTE KEINE 1. Solange es nicht jede Stelle
# einer Fundstelle liest, kann es Abwesenheit nicht beweisen: "nicht im Text
# und in keinem Kommentar" ist kein "steht dort nicht mehr". Was es in diesem
# Fall sagt, ist 2 — nicht pruefbar ist nicht dasselbe wie in Ordnung, und es
# ist auch nicht dasselbe wie widerlegt.
#
# Exit-Code: 0 jedes Zitat steht an seiner Fundstelle
#            1 reserviert: ein Zitat steht nachweislich nicht mehr dort. Das
#              kann dieses Skript erst behaupten, wenn es alle Stellen einer
#              Fundstelle liest, den Titel eingeschlossen. Bis dahin sagt es
#              in diesem Fall 2 und nie 1.
#            2 mindestens ein Zitat ist nicht abrufbar oder an den gelesenen
#              Stellen nicht zu finden, oder Aufruf- und Umgebungsfehler.
#              Kein Ergebnis ist kein gruenes Ergebnis.

set -u

verzeichnis=$(dirname "$0")
korpus="$verzeichnis/korpus.tsv"

[ -f "$korpus" ] || { echo "FEHLER: $korpus fehlt" >&2; exit 2; }

for befehl in curl python3; do
	command -v "$befehl" >/dev/null 2>&1 || {
		echo "FEHLER: $befehl wurde nicht gefunden" >&2; exit 2; }
done

arbeit=$(mktemp -d) || exit 2
# shellcheck disable=SC2064
trap "rm -rf '$arbeit'" EXIT INT TERM

# Die Fundstelle steht als "eigner/repo#nummer" in korpus.tsv. Die Quell-URL
# daneben zeigt bei typ "anhang" auf die angehaengte Datei und nicht auf den
# Bericht — geholt wird deshalb die Fundstelle und nie die Quelle.
holen() {
	ziel="$1"
	url="$2"
	status=$(curl -sSL -o "$ziel" -w '%{http_code}' "$url" 2>/dev/null) || status=000
	echo "$status"
}

zeilen=0
while IFS='	' read -r id typ fundstelle quelle kennung beleg abschnitt klage; do
	case "$id" in ''|'#'*) continue ;; esac
	zeilen=$((zeilen + 1))

	eigner_repo=${fundstelle%%#*}
	nummer=${fundstelle##*#}
	case "$eigner_repo/$nummer" in
		*/*/*) ;;
		*) echo "FEHLER: Fundstelle \"$fundstelle\" ist nicht eigner/repo#nummer" >&2
		   exit 2 ;;
	esac
	basis="https://api.github.com/repos/$eigner_repo/issues/$nummer"

	s1=$(holen "$arbeit/$id.bericht.json" "$basis")
	if [ "$s1" != 200 ]; then
		printf '%s\t%s\t%s\n' "$id" "$s1" "" >> "$arbeit/tot.tsv"
		continue
	fi
	s2=$(holen "$arbeit/$id.kommentare.json" "$basis/comments")
	if [ "$s2" != 200 ]; then
		printf '%s\t%s\t%s\n' "$id" "200" "$s2" >> "$arbeit/tot.tsv"
		continue
	fi
done < "$korpus"

if [ "$zeilen" -eq 0 ]; then
	echo "ABBRUCH: keine Korpuszeile gelesen; das misst nichts" >&2
	exit 2
fi

python3 - "$korpus" "$arbeit" <<'PYTHON'
"""Jedes Zitat gegen den Text seiner Fundstelle halten."""
import json
import os
import re
import sys

korpus, arbeit = sys.argv[1], sys.argv[2]

# Regel 3 der Vergleichsregel im Kopf dieser Datei. Genau diese Paare und
# sonst nichts.
GERADE = {
    "“": '"', "”": '"', "„": '"', "‟": '"', "″": '"',
    "«": '"', "»": '"',
    "‘": "'", "’": "'", "‚": "'", "‛": "'", "′": "'",
}
TEILER = "[…]"                      # [...] mit Auslassungspunkt


def normal(text):
    text = "".join(GERADE.get(z, z) for z in text)
    return re.sub(r"\s+", " ", text).strip()


def steht_darin(zitat, heuhaufen):
    """Alle Teile des Zitats, woertlich und in der Reihenfolge des Zitats."""
    ab = 0
    for teil in [t for t in zitat.split(TEILER) if t.strip()]:
        i = heuhaufen.find(teil.strip(), ab)
        if i < 0:
            return False
        ab = i + len(teil.strip())
    return True


tot = {}
pfad_tot = os.path.join(arbeit, "tot.tsv")
if os.path.exists(pfad_tot):
    with open(pfad_tot, encoding="utf-8") as fh:
        for zeile in fh:
            id_, s1, s2 = (zeile.rstrip("\n").split("\t") + ["", ""])[:3]
            tot[id_] = (s1, s2)

gut = []
ungefunden = []
unerreichbar = []

with open(korpus, encoding="utf-8") as fh:
    for zeile in fh:
        if zeile.startswith("#") or not zeile.strip():
            continue
        spalten = zeile.rstrip("\n").split("\t")
        if len(spalten) < 8:
            sys.stderr.write("ABBRUCH: Korpuszeile mit %d Spalten statt 8\n"
                             % len(spalten))
            sys.exit(2)
        id_, fundstelle, klage = spalten[0], spalten[2], spalten[7]

        if id_ in tot:
            s1, s2 = tot[id_]
            wo = "Bericht" if s1 != "200" else "Kommentare"
            status = s1 if s1 != "200" else s2
            unerreichbar.append((id_, fundstelle, wo, status))
            continue

        mit = os.path.join(arbeit, id_ + ".bericht.json")
        mkom = os.path.join(arbeit, id_ + ".kommentare.json")
        try:
            with open(mit, encoding="utf-8") as f:
                bericht = json.load(f)
            with open(mkom, encoding="utf-8") as f:
                kommentare = json.load(f)
        except Exception as fehler:
            sys.stderr.write("ABBRUCH: %s liess sich nicht lesen (%s)\n"
                             % (id_, fehler))
            sys.exit(2)

        zitat = normal(klage)
        if not zitat:
            sys.stderr.write("ABBRUCH: leeres Zitat in Zeile zu %s\n" % id_)
            sys.exit(2)

        stellen = [("Text", normal(bericht.get("body") or ""))]
        for n, k in enumerate(kommentare, 1):
            stellen.append(("Kommentar %d" % n, normal(k.get("body") or "")))

        for wo, heuhaufen in stellen:
            if steht_darin(zitat, heuhaufen):
                gut.append((id_, fundstelle, wo))
                break
        else:
            ungefunden.append((id_, fundstelle, len(stellen) - 1, zitat))

for id_, fundstelle, wo in gut:
    print("GEFUNDEN      %-15s Zitat steht in %s (%s)"
          % (id_, fundstelle, wo))
for id_, fundstelle, wo, status in unerreichbar:
    print("UNERREICHBAR  %-15s %s — %s: HTTP %s"
          % (id_, fundstelle, wo, status))
for id_, fundstelle, n, zitat in ungefunden:
    print("NICHT GELESEN %-15s %s — nicht im Text und in keinem der %d "
          "Kommentare" % (id_, fundstelle, n))
    print("              gesucht: %s" % zitat)

abrufbar = len(gut) + len(ungefunden)
gesamt = abrufbar + len(unerreichbar)
print("")
print("%d Korpuszeilen, davon %d abrufbar" % (gesamt, abrufbar))
print("%d von %d abrufbaren Zitaten stehen im Text oder in einem Kommentar"
      % (len(gut), abrufbar))

if ungefunden:
    print("")
    print("%d Zitat(e) stehen an keiner Stelle, die dieses Skript liest."
          % len(ungefunden))
    print("Das heisst NICHT, dass sie nicht mehr an ihrer Fundstelle stehen:")
    print("den Titel liest dieses Skript nicht (siehe Kopf der Datei und")
    print("state/offen.md). Was hier fehlt, ist die Auskunft, nicht der Beleg.")

if ungefunden or unerreichbar:
    if unerreichbar:
        print("")
        print("%d Quelle(n) nicht abrufbar. Ueber deren Zitate sage ich"
              % len(unerreichbar))
        print("nichts: nicht pruefbar ist nicht dasselbe wie in Ordnung.")
    sys.exit(2)

print("")
print("Jedes Zitat dieses Korpus steht noch an seiner Fundstelle —")
print("nachgesehen, nicht behauptet.")
sys.exit(0)
PYTHON
