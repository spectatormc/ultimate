#!/bin/sh
# Pruefbefehl 1 und 2 der Mission "Die Gegenprobe"
# (state/missionen/2026-08-15-gegenprobe.md).
#
#   sh projekte/icsdoktor/gegenprobe.sh
#   sh projekte/icsdoktor/gegenprobe.sh --pruefe-abdeckung
#   echo "Exit-Code: $?"
#
# Es gibt ein fremdes Werkzeug, das dasselbe tut wie der ICS-Doktor:
# <https://github.com/WapplerSystems/rfc5545-validator>. Dieses Skript laesst
# beide ueber dieselben zwoelf fremden Eingaben laufen und stellt ihre Befunde
# nebeneinander. Es entscheidet nichts. Wer recht hat, wird am Normtext
# entschieden, einzeln, in GEGENPROBE.md.
#
# Keine der zwoelf Eingaben stammt von mir:
#   - die sechs vollstaendigen Kalenderobjekte aus RFC 5545 §4, geholt vom
#     RFC-Editor, ausgeschnitten wie in rfc-beispiele.sh;
#   - die sechs Fremddateien aus korpus.tsv, jede aus einem oeffentlichen
#     Fehlerbericht, geholt und ausgeschnitten wie in fremdprobe.sh.
# Beide zur Laufzeit. Fremde Kalenderdaten kommen nicht in dieses Repo
# (Regel 7); das temporaere Verzeichnis wird am Ende geloescht.
#
# WAS EINE ABWEICHUNG IST. Beide Werkzeuge melden je Befund eine Schwere, eine
# Zeile und einen RFC-Abschnitt, aber nach eigener Zaehlung und in eigenen
# Worten. Verglichen wird deshalb nicht der Wortlaut, sondern die Behauptung
# dahinter: Vergleichseinheit ist das Paar (Eingabe, RFC-Abschnitt). Je
# Abschnitt einer Eingabe gibt es fuenf moegliche Abweichungen:
#
#   nur-icsdoktor    nur der ICS-Doktor nennt diesen Abschnitt
#   nur-fremd        nur das fremde Werkzeug nennt ihn
#   schwere          beide nennen ihn, aber einer als Fehler und einer nicht
#   zeile            beide nennen ihn, aber ohne eine gemeinsame Zeile
#   abschnittstiefe  beide meinen dieselbe Stelle, aber einer nennt den
#                    Oberabschnitt des anderen (§3.3 statt §3.3.5)
#
# Die Zeile ist absichtlich das schwaechere Merkmal: Das fremde Werkzeug haengt
# einen Komponentenfehler an die BEGIN-Zeile, der ICS-Doktor an die Zeile der
# Eigenschaft, ueber die er klagt. Nach Zeilen zu paaren machte aus einem
# einzigen gemeinsamen Befund zwei Abweichungen und daraus einen Streit, den es
# nicht gibt.
#
# Aus demselben Grund gibt es "abschnittstiefe". Der erste Lauf dieses Skripts
# hat vier Faelle gezaehlt, in denen das fremde Werkzeug §3.3 nennt, wo der
# ICS-Doktor §3.3.5 nennt — dieselbe Zeile, dieselbe Klage, verschieden genau.
# Als "nur-icsdoktor" plus "nur-fremd" gebucht, waeren das acht Abweichungen
# gewesen statt vier, und keine davon haette gestimmt. Gepaart wird deshalb,
# wenn ein Abschnitt der Oberabschnitt des anderen ist UND beide sich eine
# Zeile teilen. Es bleibt eine Abweichung: Wer §3.3 sagt, schickt den Leser in
# ein Kapitel, wer §3.3.5 sagt, auf eine Seite. Die Kennung traegt dann den
# tieferen der beiden Abschnitte, und die Ausgabe zeigt beide.
#
# WAS DIESE MESSUNG NICHT SIEHT, damit es niemand hineinliest:
#   - Vielfachheit. Meldet ein Werkzeug denselben Abschnitt dreimal und das
#     andere einmal, ist das keine Abweichung. Die Zahl steht in der Ausgabe
#     (x3), sie zaehlt nur nicht mit.
#   - Wortlaut und Begruendung. Zwei Werkzeuge koennen denselben Abschnitt aus
#     verschiedenen Gruenden nennen; das faellt hier nicht auf.
#   - Alles ausserhalb der zwoelf Eingaben. Verglichen wird Verhalten auf zwoelf
#     Dateien, nicht die Guete zweier Projekte.
#
# Jede Abweichung bekommt eine Kennung aus Eingabe und Abschnitt, etwa
# "rfc4-1:§3.8.5.3". Sie ist stabil: Sie haengt nicht daran, in welcher
# Reihenfolge etwas gefunden wurde, und aendert sich nicht, wenn anderswo eine
# Abweichung dazukommt oder wegfaellt. --pruefe-abdeckung verlangt zu jeder
# dieser Kennungen einen eigenen Abschnitt in GEGENPROBE.md und macht damit
# Punkt 3 der Zieldefinition pruefbar, ohne mir zu glauben.
#
# Netz noetig: RFC-Editor, api.github.com, github.com. Ist eine Quelle nicht
# erreichbar, endet das Skript mit 2 und nicht mit 1 — eine tote Quelle ist ein
# Befund ueber das Netz, nicht ueber eines der beiden Werkzeuge.
#
# Exit-Code: 0 der Vergleich lief (auch mit Abweichungen; im Modus
#              --pruefe-abdeckung zusaetzlich: jede Abweichung ist aufgeloest),
#            1 nur mit --pruefe-abdeckung: mindestens eine Abweichung hat
#              keinen Abschnitt in GEGENPROBE.md,
#            2 Aufruf-, Umgebungs- oder Netzfehler, unvollstaendige Eingabemenge.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
korpus="$verzeichnis/korpus.tsv"
bericht="$verzeichnis/GEGENPROBE.md"

# Fester Stand. Ein beweglicher Zeiger machte den Vergleich unwiederholbar:
# Wer ihn morgen nachvollzieht, misst dann gegen etwas anderes als ich heute.
fremd_quelle="https://github.com/WapplerSystems/rfc5545-validator.git"
fremd_stand="e5554b99a08a5208949bb97c02eedf50d2b58ec4"
rfc_quelle="https://www.rfc-editor.org/rfc/rfc5545.txt"

erwartete_eingaben=12

modus=vergleich
case "${1:-}" in
	'')                 ;;
	--pruefe-abdeckung) modus=abdeckung ;;
	-h|--hilfe|--help)
		sed -n '2,/^set -u/p' "$0" | sed '$d;s/^# \{0,1\}//'
		exit 0 ;;
	*)  echo "FEHLER: unbekanntes Argument \"$1\"" >&2
	    echo "Aufruf: gegenprobe.sh [--pruefe-abdeckung]" >&2
	    exit 2 ;;
esac

[ -f "$werkzeug" ] || { echo "FEHLER: $werkzeug fehlt" >&2; exit 2; }
[ -f "$korpus" ]   || { echo "FEHLER: $korpus fehlt" >&2; exit 2; }

for befehl in curl git python3; do
	command -v "$befehl" >/dev/null 2>&1 || {
		echo "FEHLER: $befehl wurde nicht gefunden" >&2; exit 2; }
done

arbeit=$(mktemp -d) || exit 2
# shellcheck disable=SC2064
trap "rm -rf '$arbeit'" EXIT INT TERM

eingaben="$arbeit/eingaben.tsv"
: > "$eingaben"

# ---------------------------------------------------------------- fremdes Werkzeug

fremd="$arbeit/fremdwerkzeug"
mkdir -p "$fremd" || exit 2
(
	cd "$fremd" || exit 2
	git init -q . 2>/dev/null &&
	git remote add origin "$fremd_quelle" &&
	git fetch -q --depth 1 origin "$fremd_stand" 2>/dev/null &&
	git checkout -q FETCH_HEAD 2>/dev/null
) || {
	echo "NETZ  fremdes Werkzeug nicht holbar: $fremd_quelle @ $fremd_stand" >&2
	echo "Abbruch: ohne das fremde Werkzeug gibt es keinen Vergleich. Das ist" >&2
	echo "ein Befund ueber die Quelle, nicht ueber eines der Werkzeuge." >&2
	exit 2; }

geholt=$(git -C "$fremd" rev-parse HEAD 2>/dev/null || echo "")
[ "$geholt" = "$fremd_stand" ] || {
	echo "ABBRUCH: geholt wurde $geholt, verlangt ist $fremd_stand." >&2
	echo "Ein anderer Stand ist ein anderes Werkzeug." >&2
	exit 2; }

[ -f "$fremd/src/rfc5545_validator/cli.py" ] || {
	echo "ABBRUCH: $fremd_stand enthaelt src/rfc5545_validator/cli.py nicht." >&2
	exit 2; }

# ---------------------------------------------------------------- Eingaben 1-6: RFC 5545 §4
#
# Wortgleich zu rfc-beispiele.sh und absichtlich nicht mit ihm geteilt: Der
# gemeinsame Helfer waere ein Eingriff in einen Pruefbefehl, der gruen ist und
# nicht zu dieser Mission gehoert. Aendert sich hier etwas, ist dort nichts
# kaputt.

curl -sSf --max-time 60 "$rfc_quelle" > "$arbeit/rfc.txt" 2> "$arbeit/lade" || {
	echo "NETZ  RFC 5545 nicht erreichbar: $rfc_quelle" >&2
	[ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
	echo "Abbruch: kein Ergebnis ist kein gruenes Ergebnis." >&2
	exit 2; }
[ -s "$arbeit/rfc.txt" ] || { echo "NETZ  RFC 5545 kam leer an" >&2; exit 2; }

grep -q '^4\.  iCalendar Object Examples' "$arbeit/rfc.txt" || {
	echo "ABBRUCH: Abschnitt 4 im geladenen Text nicht gefunden." >&2
	echo "Geladen wurden $(wc -c < "$arbeit/rfc.txt") Oktette." >&2
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
		printf "%s\r\n", substr($0, 8) > (ziel "/rfc4-" n ".ics")
	}
	/^ +END:VCALENDAR[[:space:]]*$/ { drin = 0 }
	END {
		print n + 0 > (ziel "/anzahl")
		print schlecht + 0 > (ziel "/schlecht")
	}
' "$arbeit/abschnitt4.txt"

anzahl=$(cat "$arbeit/anzahl")
schlecht=$(cat "$arbeit/schlecht")

[ "$schlecht" = "0" ] || {
	echo "ABBRUCH: $schlecht Zeilen im Ausschnitt tragen nicht die erwartete" >&2
	echo "Grundeinrueckung von sieben Leerzeichen." >&2
	exit 2; }
[ "$anzahl" = "6" ] || {
	echo "ABBRUCH: $anzahl Kalenderobjekte gefunden, erwartet 6." >&2
	echo "RFC 5545 ist unveraenderlich; diese Zahl kann sich nicht aendern." >&2
	exit 2; }

nr=1
while [ "$nr" -le 6 ]; do
	printf 'rfc4-%s\t%s\t%s\n' \
		"$nr" "$arbeit/rfc4-$nr.ics" "RFC 5545 §4, Objekt $nr" >> "$eingaben"
	nr=$((nr + 1))
done

# ---------------------------------------------------------------- Eingaben 7-12: der Fremdkorpus
#
# Ausschneiden wortgleich zu fremdprobe.sh, aus demselben Grund wie oben. Was
# dort ueber die Zeilenenden steht, gilt hier genauso: Bei "bericht" und
# "block" sind sie meine, nicht die des Melders — eine Abweichung, die nur an
# P01 oder P02 haengt, ist deshalb ein Befund ueber meinen Zuschnitt und wird
# in GEGENPROBE.md als solcher aufgeloest, nicht gegen ein Werkzeug gebucht.

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

while IFS='	' read -r id typ fundstelle quelle kennung beleg abschnitt klage; do
	case "$id" in ''|'#'*) continue ;; esac
	datei="$arbeit/$id.ics"

	if [ "$typ" = anhang ]; then
		curl -sSLf -o "$datei" "$quelle" 2>/dev/null || {
			echo "NETZ  $id  Anhang nicht erreichbar: $quelle" >&2
			echo "Abbruch: eine Quelle ist weg." >&2
			exit 2; }
	else
		case "$typ" in
			bericht) rahmen=VCALENDAR ;;
			block)   rahmen= ;;
			*) echo "FEHLER: unbekannter Typ \"$typ\" in Zeile zu $id" >&2
			   exit 2 ;;
		esac
		curl -sSLf -o "$arbeit/$id.json" "$quelle" 2>/dev/null || {
			echo "NETZ  $id  Bericht nicht abrufbar: $quelle" >&2
			echo "Abbruch: eine Quelle ist weg oder die Ratenbegrenzung greift." >&2
			exit 2; }
		ausschneiden "$arbeit/$id.json" "$rahmen" > "$datei" || {
			echo "NETZ  $id  kein ${rahmen:-vollstaendiger} Block im Bericht $fundstelle" >&2
			echo "Abbruch: der Bericht wurde geaendert." >&2
			exit 2; }
	fi

	printf '%s\t%s\t%s\n' "$id" "$datei" "Fremddatei aus $fundstelle" >> "$eingaben"
done < "$korpus"

gefunden=$(grep -c . "$eingaben")
[ "$gefunden" -eq "$erwartete_eingaben" ] || {
	echo "ABBRUCH: $gefunden Eingaben zusammengekommen, verlangt sind $erwartete_eingaben." >&2
	echo "Ein Vergleich ueber eine geschrumpfte Eingabemenge ist kein Vergleich." >&2
	exit 2; }

# ---------------------------------------------------------------- Vergleich

cat > "$arbeit/vergleich.py" <<'PYTHON'
"""Laesst beide Werkzeuge ueber dieselben Eingaben laufen und vergleicht.

Aufruf: vergleich.py EINGABEN.tsv ICSDOKTOR.PY FREMDVERZEICHNIS [GEGENPROBE.md]

Liegt das vierte Argument an, wird zusaetzlich geprueft, ob GEGENPROBE.md zu
jeder Abweichung einen eigenen Abschnitt hat.
"""
import json
import os
import re
import subprocess
import sys

FUND = re.compile(
    r"^(FEHLER|HINWEIS) Zeile (\d+): (P\d\d) (.*) \[RFC 5545 §([0-9][0-9.]*)\]$")


def eigenes(werkzeug, datei):
    """Funde des ICS-Doktors, aus seiner Ausgabe gelesen — nicht aus seinem Code."""
    lauf = subprocess.run([sys.executable, werkzeug, datei],
                          capture_output=True, text=True)
    funde = []
    unlesbar = []
    for zeile in lauf.stdout.splitlines():
        if not zeile.strip():
            continue
        treffer = FUND.match(zeile)
        if not treffer:
            unlesbar.append(zeile)
            continue
        schwere, nr, code, _text, abschnitt = treffer.groups()
        funde.append({"fehler": schwere == "FEHLER", "zeile": int(nr),
                      "abschnitt": abschnitt, "marke": code})
    return funde, lauf.returncode, unlesbar, lauf.stderr


def fremdes(fremdverzeichnis, datei):
    umgebung = dict(os.environ)
    umgebung["PYTHONPATH"] = os.path.join(fremdverzeichnis, "src")
    lauf = subprocess.run(
        [sys.executable, "-m", "rfc5545_validator", "--format", "json",
         "--severity", "info", datei],
        capture_output=True, text=True, env=umgebung)
    try:
        roh = json.loads(lauf.stdout)
    except ValueError:
        return None, lauf.returncode, [], lauf.stdout + lauf.stderr
    if "error" in roh:
        return None, lauf.returncode, [], str(roh["error"])
    funde = []
    for stelle in roh.get("issues", []):
        abschnitt = (stelle.get("rfc_section") or "").strip()
        abschnitt = abschnitt.lstrip("§").strip() or "-"
        zeile = stelle.get("line")
        funde.append({"fehler": stelle.get("severity") == "error",
                      "zeile": int(zeile) if zeile else 0,
                      "abschnitt": abschnitt,
                      "marke": (stelle.get("property") or
                                stelle.get("component") or "")})
    return funde, lauf.returncode, [], lauf.stderr


def buendeln(funde):
    """Funde je Abschnitt zusammenfassen. Der Abschnitt ist die Behauptung."""
    nach_abschnitt = {}
    for f in funde:
        eintrag = nach_abschnitt.setdefault(
            f["abschnitt"], {"anzahl": 0, "zeilen": set(), "fehler": False,
                             "marken": []})
        eintrag["anzahl"] += 1
        eintrag["zeilen"].add(f["zeile"])
        eintrag["fehler"] = eintrag["fehler"] or f["fehler"]
        if f["marke"] and f["marke"] not in eintrag["marken"]:
            eintrag["marken"].append(f["marke"])
    return nach_abschnitt


def tiefer(a, b):
    """Ist b ein Unterabschnitt von a? §3.3 ist Oberabschnitt von §3.3.5."""
    return b.startswith(a + ".")


def paare(meine_b, ihre_b):
    """Abschnitte beider Werkzeuge einander zuordnen.

    Erst was gleich heisst, dann was dasselbe meint: ein Abschnitt und sein
    Oberabschnitt auf einer gemeinsamen Zeile. Rueckgabe je Zeile der Ausgabe:
    (Beschriftung, Kennabschnitt, mein Eintrag oder None, ihr Eintrag oder None).
    """
    zeilen = []
    offen_mein = set(meine_b)
    offen_ihr = set(ihre_b)

    for abschnitt in sorted(offen_mein & offen_ihr):
        zeilen.append((abschnitt, abschnitt, meine_b[abschnitt], ihre_b[abschnitt]))
        offen_mein.discard(abschnitt)
        offen_ihr.discard(abschnitt)

    for mein in sorted(offen_mein):
        passend = [ihr for ihr in sorted(offen_ihr)
                   if (tiefer(ihr, mein) or tiefer(mein, ihr))
                   and (meine_b[mein]["zeilen"] & ihre_b[ihr]["zeilen"])]
        if not passend:
            continue
        # Der genaueste der moeglichen Partner, damit §3.3.5 nicht an §3
        # haengenbleibt, wenn auch §3.3 dasteht.
        ihr = max(passend, key=lambda a: len(a.split(".")))
        kenn = mein if len(mein.split(".")) >= len(ihr.split(".")) else ihr
        zeilen.append(("%s ~ §%s" % (mein, ihr), kenn,
                       meine_b[mein], ihre_b[ihr]))
        offen_mein.discard(mein)
        offen_ihr.discard(ihr)

    for abschnitt in sorted(offen_mein):
        zeilen.append((abschnitt, abschnitt, meine_b[abschnitt], None))
    for abschnitt in sorted(offen_ihr):
        zeilen.append((abschnitt, abschnitt, None, ihre_b[abschnitt]))

    return sorted(zeilen, key=lambda z: [int(t) if t.isdigit() else 0
                                         for t in z[1].split(".")])


def zeige(eintrag):
    if eintrag is None:
        return "—"
    zeilen = sorted(eintrag["zeilen"])
    ort = ",".join("Z%d" % z if z else "Z?" for z in zeilen)
    text = "%s %s" % ("FEHLER " if eintrag["fehler"] else "HINWEIS", ort)
    if eintrag["anzahl"] > 1:
        text += " x%d" % eintrag["anzahl"]
    if eintrag["marken"]:
        text += " (%s)" % ",".join(eintrag["marken"][:3])
    return text


def main(argv):
    if len(argv) not in (4, 5):
        sys.stderr.write(__doc__)
        return 2
    eingabendatei, werkzeug, fremdverzeichnis = argv[1:4]
    berichtdatei = argv[4] if len(argv) == 5 else None

    eingaben = []
    with open(eingabendatei, encoding="utf-8") as fh:
        for zeile in fh:
            if not zeile.strip():
                continue
            kennung, pfad, herkunft = zeile.rstrip("\n").split("\t")
            eingaben.append((kennung, pfad, herkunft))

    abweichungen = []

    for kennung, pfad, herkunft in eingaben:
        meine, mein_code, unlesbar, mein_fehlerkanal = eigenes(werkzeug, pfad)
        ihre, ihr_code, _, ihr_fehlerkanal = fremdes(fremdverzeichnis, pfad)

        print("")
        print("--- %s  (%s)" % (kennung, herkunft))

        if unlesbar:
            # Eine Ausgabezeile, die das eigene Muster nicht trifft, waere ein
            # stiller Verlust. Lieber laut abbrechen als leise weniger messen.
            for zeile in unlesbar:
                print("    ABBRUCH: unlesbare Ausgabezeile des ICS-Doktors: %r"
                      % zeile)
            return 2
        if ihre is None:
            print("    ABBRUCH: das fremde Werkzeug lieferte keine Befundliste"
                  " (Exit %d): %s" % (ihr_code, ihr_fehlerkanal.strip()[:200]))
            return 2

        meine_b = buendeln(meine)
        ihre_b = buendeln(ihre)

        alle = paare(meine_b, ihre_b)
        if not alle:
            print("    beide fundfrei")

        for beschriftung, kennabschnitt, mein, ihr in alle:
            if mein and not ihr:
                arten = ["nur-icsdoktor"]
            elif ihr and not mein:
                arten = ["nur-fremd"]
            else:
                # Mehrere Arten koennen zugleich zutreffen. Sie werden alle
                # genannt, damit eine Auffaelligkeit nicht hinter der ersten
                # verschwindet; eine Abweichung bleibt es trotzdem nur einmal.
                arten = []
                if beschriftung != kennabschnitt:
                    arten.append("abschnittstiefe")
                if mein["fehler"] != ihr["fehler"]:
                    arten.append("schwere")
                if not (mein["zeilen"] & ihr["zeilen"]):
                    arten.append("zeile")
            art = "+".join(arten) if arten else None

            marke = "%s:§%s" % (kennung, kennabschnitt)
            print("    §%-13s icsdoktor: %-28s fremd: %-28s %s"
                  % (beschriftung, zeige(mein), zeige(ihr),
                     ("ABWEICHUNG %s (%s)" % (marke, art)) if art else "einig"))
            if art:
                abweichungen.append((marke, art, kennung, kennabschnitt))

        print("    Urteil: icsdoktor Exit %d, fremdes Werkzeug Exit %d%s"
              % (mein_code, ihr_code,
                 "" if (mein_code == 0) == (ihr_code == 0)
                 else "  — verschiedenes Urteil ueber dieselbe Datei"))

    print("")
    if abweichungen:
        print("Abweichungen, einzeln:")
        for marke, art, _kennung, _abschnitt in abweichungen:
            print("  %-26s %s" % (marke, art))
        print("")
    print("Gegenprobe: %d fremde Eingaben, %d Abweichungen"
          % (len(eingaben), len(abweichungen)))

    if berichtdatei is None:
        return 0

    # ---- Abdeckung
    print("")
    if not os.path.exists(berichtdatei):
        print("ABDECKUNG: %s gibt es noch nicht." % berichtdatei)
        print("Offen: %d von %d Abweichungen ohne Abschnitt."
              % (len(abweichungen), len(abweichungen)))
        return 1 if abweichungen else 0

    ueberschriften = []
    with open(berichtdatei, encoding="utf-8") as fh:
        for zeile in fh:
            if zeile.startswith("#"):
                ueberschriften.append(zeile.strip())

    def genannt(marke, ueberschrift):
        # Die Grenze hinten ist noetig: "x:§3.3" steht als Zeichenkette in
        # "x:§3.3.5". Ohne sie wuerde ein Abschnitt ueber den einen Befund den
        # anderen mit abdecken, und die Pruefung liesse genau die Luecke durch,
        # gegen die sie gebaut ist.
        return re.search(re.escape(marke) + r"(?![0-9.])", ueberschrift) is not None

    fehlend = [m for m, _a, _k, _s in abweichungen
               if not any(genannt(m, u) for u in ueberschriften)]
    kennungen = [m for m, _a, _k, _s in abweichungen]
    verwaist = [u for u in ueberschriften
                if re.search(r"\S+:§[0-9][0-9.]*", u)
                and not any(genannt(k, u) for k in kennungen)]

    for marke, art, _kennung, _abschnitt in abweichungen:
        stand = "fehlt" if marke in fehlend else "aufgeloest"
        print("ABDECKUNG %-12s %-26s %s" % (stand, marke, art))
    for u in verwaist:
        print("ABDECKUNG verwaist    %s" % u)
        print("          — dazu gibt es in diesem Lauf keine Abweichung mehr;"
              " das macht den Bericht nicht ungueltig, nur aelter.")

    print("")
    print("Abdeckung: %d von %d Abweichungen in %s aufgeloest"
          % (len(abweichungen) - len(fehlend), len(abweichungen),
             os.path.basename(berichtdatei)))
    return 1 if fehlend else 0


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", newline="\n")
    except AttributeError:
        pass
    sys.exit(main(sys.argv))
PYTHON

echo "Gegenprobe: ICS-Doktor gegen rfc5545-validator @ $fremd_stand"
echo "Eingaben: 6 Kalenderobjekte aus RFC 5545 §4, 6 Fremddateien aus korpus.tsv"
echo "Beide zur Laufzeit geholt, keine davon von mir geschrieben."

if [ "$modus" = abdeckung ]; then
	python3 "$arbeit/vergleich.py" "$eingaben" "$werkzeug" "$fremd" "$bericht"
else
	python3 "$arbeit/vergleich.py" "$eingaben" "$werkzeug" "$fremd"
fi
exit $?
