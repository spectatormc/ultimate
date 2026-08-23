#!/bin/sh
# Pruefbefehl der Mission "Die offene Klage"
# (state/missionen/2026-08-22-die-offene-klage.md).
#
#   sh projekte/icsdoktor/klagen.sh
#   echo "Exit-Code: $?"
#
# Zu jeder noch offenen Fremdklage aus korpus.tsv einen Befundbericht, der
# vier Dinge zeigt und keins davon behauptet:
#
#   (1) die beklagte Datei, zur Laufzeit geholt — sie liegt nicht in diesem
#       Repo (Regel 7) und ist deshalb keine Kopie, die ich zurechtgelegt habe;
#   (2) den Befund des ICS-Doktors mit Zeile, Kennung und Abschnitt;
#   (3) den Wortlaut der Norm an genau der Fundstelle, auf die der Befund
#       zeigt — aus dem RFC-Text selbst, zur Laufzeit geholt;
#   (4) die Aenderung, die den Verstoss beseitigt.
#
# WARUM (4) DER EIGENTLICHE PUNKT IST. Ein Fehlerbericht, der nur sagt "hier
# ist ein Verstoss", laesst dem Melder die ganze Arbeit. Der Bericht dieses
# Skripts nennt die Zeile, die geaendert werden muss, und wie sie danach
# lautet.
#
# UND WARUM DIESE AENDERUNG NICHT GERATEN IST. Sie wird angewandt und das
# Werkzeug ein zweites Mal ueber die geaenderte Datei geschickt. Belegt ist
# eine Klage erst, wenn dieser zweite Lauf zwei Bedingungen erfuellt:
#
#   — der beklagte Befund ist weg, und
#   — es ist kein neuer Befund dazugekommen.
#
# Die zweite Bedingung ist die wichtigere. Ohne sie waere jede Aenderung, die
# einen Verstoss gegen einen anderen tauscht, ein "Beleg". Genau das ist beim
# Bau dieses Skripts passiert: Bei kewisch/ical.js#620 raeumt ein VALUE=DATE
# allein am DTSTART den beklagten Befund weg und erzeugt P13, weil DTEND dann
# einen anderen Wertetyp traegt als DTSTART. Die Aenderung fuer diese Klage
# umfasst deshalb beide Zeilen — nicht weil ich das vorher wusste, sondern
# weil die Messung es gezeigt hat.
#
# WELCHE KLAGEN. Die vier, die am 2026-08-22 gegen 18:56 UTC offen waren;
# bitfireAT/synctools#156 ist seit dem 2025-12-05 geschlossen und deshalb
# nicht dabei. Diese Auswahl steht als Liste im Skript und wird nicht zur
# Laufzeit neu erhoben: Sonst entschiede der Zustand fremder Fehlerberichte
# darueber, was der Pruefbefehl misst, und die Zieldefinition der Mission
# aenderte sich hinter meinem Ruecken. Faellt eine Kennung aus korpus.tsv
# heraus, endet das Skript mit 2 statt leise mit einer kleineren Zahl.
#
# WAS DIESES SKRIPT NICHT TUT: Es traegt nichts irgendwohin. Ob einer der
# Berichte diesen Befundbericht je sieht, ist ungeprueft und steht als Befund
# in state/offen.md — kein Teil der Zieldefinition.
#
# Netz noetig, fuenf Abrufe: vier Quellen und der Normtext. Ist eine Quelle
# nicht erreichbar, endet das Skript mit 2 und nicht mit 1 — eine tote URL ist
# ein Befund ueber die Quelle, nicht ueber die Klage.
#
# Exit-Code: 0 alle Klagen belegt, 1 mindestens eine nicht belegt,
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

python3 - "$werkzeug" "$korpus" "$arbeit" <<'PYTHON'
import json, re, subprocess, sys, urllib.request

werkzeug, korpus, arbeit = sys.argv[1:4]

NORMTEXT = "https://www.rfc-editor.org/rfc/rfc5545.txt"

# Die offenen Klagen, gemessen am 2026-08-22 gegen 18:56 UTC. Je Kennung:
#
#   wortlaut  — der Satz der Norm, den der Befund meint. Er wird nicht
#               ausgegeben, weil er hier steht, sondern nur dann, wenn er im
#               geholten Normtext INNERHALB des Abschnitts steht, auf den der
#               Befund zeigt. Steht er dort nicht, ist die Klage nicht belegt.
#   alt/neu   — die Aenderung, woertlich. "alt" muss in der geholten Datei
#               genau einmal vorkommen; sonst ist der Bericht ein anderer
#               geworden als der, fuer den diese Zeile geschrieben wurde.
#   grund     — warum diese Aenderung und keine andere.
KLAGEN = {
    "calcurse-323": {
        "wortlaut": 'The following is REQUIRED if the component appears in an '
                    'iCalendar object that doesn\'t specify the "METHOD" '
                    'property; otherwise, it is OPTIONAL',
        "alt": ["DTEND;TZID=Europe/Oslo:20201027T120000"],
        "neu": ["DTSTART;TZID=Europe/Oslo:20201027T110000\r\n"
                "DTEND;TZID=Europe/Oslo:20201027T120000"],
        "grund": "Dem VEVENT fehlt das DTSTART. Die Norm schreibt vor, DASS es "
                 "da sein muss, nicht WELCHEN Wert es traegt; der Wert hier "
                 "liegt eine Stunde vor dem DTEND und in derselben Zeitzone, "
                 "damit die Aenderung keinen zweiten Verstoss erzeugt.",
    },
    "simplecal-1983": {
        "wortlaut": 'date-time = date "T" time',
        "alt": ["EXDATE:20230308"],
        "neu": ["EXDATE;VALUE=DATE:20230308"],
        "grund": "Der Wert ist ein Datum ohne Uhrzeit. Ohne VALUE-Parameter "
                 "gilt fuer EXDATE der Standardtyp DATE-TIME, und dagegen "
                 "verstoesst er. Der Parameter sagt den Typ an, den der Wert "
                 "wirklich hat — genau das verlangt der Bericht.",
    },
    "icaljs-620": {
        "wortlaut": 'date-time = date "T" time',
        "alt": ["DTSTART:20231008", "DTEND:20231013"],
        "neu": ["DTSTART;VALUE=DATE:20231008", "DTEND;VALUE=DATE:20231013"],
        "grund": "Beide Werte sind Daten ohne Uhrzeit und beide brauchen den "
                 "VALUE-Parameter. DTSTART allein zu aendern genuegt nicht: "
                 "Dann tragen DTSTART und DTEND verschiedene Wertetypen, und "
                 "das ist wieder ein Verstoss (P13, Paragraph 3.8.2.2).",
    },
    "fossify-1102": {
        "wortlaut": 'date-time = date "T" time',
        "alt": ["EXDATE:20250429"],
        "neu": ["EXDATE;VALUE=DATE:20250429"],
        "grund": "Wie bei SimpleMobileTools/Simple-Calendar#1983: ein Datum "
                 "ohne Uhrzeit als EXDATE, dem der VALUE-Parameter fehlt.",
    },
}


def abbruch(text):
    print(text, file=sys.stderr)
    sys.exit(2)


def hole(url, roh=False):
    try:
        with urllib.request.urlopen(url, timeout=60) as antwort:
            daten = antwort.read()
    except Exception as fehler:
        abbruch("NETZ  %s nicht erreichbar: %s\n"
                "Abbruch: das ist ein Befund ueber die Quelle, nicht ueber "
                "die Klage." % (url, fehler.__class__.__name__))
    return daten if roh else daten.decode("utf-8", "replace")


# --- Der Normtext -----------------------------------------------------------
#
# Ein Abschnitt beginnt mit seiner Nummer in Spalte 1 und endet vor der
# naechsten solchen Ueberschrift. Das Inhaltsverzeichnis ist eingerueckt und
# faellt damit heraus.
#
# Verglichen wird nicht Zeile fuer Zeile, sondern ueber einen geglaetteten
# Text: Seitenfuesse, Seitenkoepfe und die Semikolons, mit denen der RFC seine
# ABNF-Kommentare einrueckt, fallen weg, Leerraum wird zusammengezogen. Ohne
# das koennte kein Satz zitiert werden, der ueber einen Seitenumbruch laeuft —
# und der Satz zu Paragraph 3.6.1 tut genau das.
def glaetten(zeilen):
    sauber = []
    for zeile in zeilen:
        if zeile.startswith("\f") or zeile.startswith("Desruisseaux"):
            continue
        if zeile.startswith("RFC 5545") and "iCalendar" in zeile:
            continue
        sauber.append(re.sub(r"^\s*;\s?", "", zeile))
    return re.sub(r"\s+", " ", " ".join(sauber)).strip()


rfc = hole(NORMTEXT).splitlines()
ueberschrift = re.compile(r"^(\d+(?:\.\d+)*)\.\s\s")
abschnitte = {}
offen = None
for nummer, zeile in enumerate(rfc, 1):
    treffer = ueberschrift.match(zeile)
    if treffer:
        if offen:
            abschnitte[offen[0]] = (offen[1], nummer - 1)
        offen = (treffer.group(1), nummer)
if offen:
    abschnitte[offen[0]] = (offen[1], len(rfc))

if "3.3.5" not in abschnitte or "3.6.1" not in abschnitte:
    abbruch("FEHLER: der Normtext hat sich geaendert — Abschnitte nicht "
            "gefunden. Ohne sie ist kein Wortlaut nachweisbar.")

# --- Der Korpus -------------------------------------------------------------
zeilen = {}
with open(korpus, encoding="utf-8") as datei:
    for zeile in datei:
        if zeile.startswith("#") or not zeile.strip():
            continue
        feld = zeile.rstrip("\n").split("\t")
        if len(feld) != 8:
            abbruch("FEHLER: Zeile mit %d Feldern statt 8 in %s"
                    % (len(feld), korpus))
        zeilen[feld[0]] = dict(zip(
            "id typ fundstelle quelle kennung beleg abschnitt klage".split(),
            feld))

fehlend = [kennung for kennung in KLAGEN if kennung not in zeilen]
if fehlend:
    abbruch("FEHLER: %s steht nicht mehr in korpus.tsv. Der Pruefbefehl misst "
            "dann weniger, als die Mission verlangt — das waere eine kleinere "
            "Zahl statt eines Befundes." % ", ".join(sorted(fehlend)))


def ausschneiden(json_text, rahmen):
    roh = json.loads(json_text).get("body") or ""
    zeilen = [z.rstrip("\r").strip() for z in roh.splitlines()]
    if not rahmen:
        treffer = [z[len("BEGIN:"):] for z in zeilen
                   if re.fullmatch(r"BEGIN:[A-Z][A-Z0-9-]*", z)]
        rahmen = treffer[0] if treffer else None
    if not rahmen or ("BEGIN:" + rahmen) not in zeilen:
        return None
    anfang = zeilen.index("BEGIN:" + rahmen)
    tiefe = 0
    for ende in range(anfang, len(zeilen)):
        if zeilen[ende] == "BEGIN:" + rahmen:
            tiefe += 1
        elif zeilen[ende] == "END:" + rahmen:
            tiefe -= 1
            if tiefe == 0:
                return "\r\n".join(zeilen[anfang:ende + 1]) + "\r\n"
    return None


def befunde(pfad):
    lauf = subprocess.run([sys.executable, werkzeug, pfad],
                          capture_output=True, text=True)
    if lauf.returncode not in (0, 1):
        abbruch("FEHLER: der ICS-Doktor endete mit %d auf %s"
                % (lauf.returncode, pfad))
    return [z for z in lauf.stdout.splitlines() if z.startswith("FEHLER ")]


belegt = 0
for kennung in ("calcurse-323", "simplecal-1983", "icaljs-620",
                "fossify-1102"):
    fall = KLAGEN[kennung]
    zeile = zeilen[kennung]
    print("KLAGE %s  %s" % (kennung, zeile["fundstelle"]))
    print("  Klage      %s" % zeile["klage"])

    # (1) Die Datei, zur Laufzeit geholt.
    if zeile["typ"] == "anhang":
        inhalt = hole(zeile["quelle"], roh=True).decode("utf-8", "replace")
    else:
        rahmen = "VCALENDAR" if zeile["typ"] == "bericht" else ""
        inhalt = ausschneiden(hole(zeile["quelle"]), rahmen)
        if inhalt is None:
            abbruch("NETZ  %s: kein Block im Bericht %s\nAbbruch: der Bericht "
                    "wurde geaendert." % (kennung, zeile["fundstelle"]))
    pfad = "%s/%s.ics" % (arbeit, kennung)
    with open(pfad, "w", newline="", encoding="utf-8") as datei:
        datei.write(inhalt)
    print("  Datei      %s" % zeile["quelle"])
    print("             zur Laufzeit geholt, %d Zeilen, nicht im Repo"
          % len(inhalt.splitlines()))

    # (2) Der Befund, mit Zeile, Kennung und Abschnitt.
    vorher = befunde(pfad)
    treffer = [z for z in vorher
               if re.search(r"[ :]%s " % zeile["kennung"], z)
               and zeile["beleg"] in z]
    if not treffer:
        gemeldet = sorted(set(re.findall(r"\bP[0-9]{2}\b", " ".join(vorher))))
        print("  NICHT BELEGT  erwartet %s auf %s, gemeldet: %s"
              % (zeile["kennung"], zeile["beleg"], ", ".join(gemeldet) or "nichts"))
        print()
        continue
    print("  Befund     %s" % treffer[0])

    # (3) Der Wortlaut der Norm an der Fundstelle, auf die der Befund zeigt.
    if zeile["abschnitt"] not in abschnitte:
        print("  NICHT BELEGT  Abschnitt %s gibt es im Normtext nicht"
              % zeile["abschnitt"])
        print()
        continue
    von, bis = abschnitte[zeile["abschnitt"]]
    text = glaetten(rfc[von - 1:bis])
    gesucht = re.sub(r"\s+", " ", fall["wortlaut"]).strip()
    if gesucht not in text:
        print("  NICHT BELEGT  der Wortlaut steht nicht in Abschnitt %s"
              % zeile["abschnitt"])
        print()
        continue
    print("  Wortlaut   RFC 5545 Abschnitt %s, ab Zeile %d des Normtextes:"
          % (zeile["abschnitt"], von))
    print("             \"%s\"" % gesucht)

    # (4) Die Aenderung — angewandt und gemessen, nicht behauptet.
    geaendert = inhalt
    for alt, neu in zip(fall["alt"], fall["neu"]):
        if geaendert.count(alt) != 1:
            abbruch("FEHLER: \"%s\" kommt in %s nicht genau einmal vor. Der "
                    "Bericht ist ein anderer geworden; die Aenderung waere "
                    "geraten." % (alt, kennung))
        geaendert = geaendert.replace(alt, neu, 1)
    pfad_neu = "%s/%s.geaendert.ics" % (arbeit, kennung)
    with open(pfad_neu, "w", newline="", encoding="utf-8") as datei:
        datei.write(geaendert)
    nachher = befunde(pfad_neu)

    kern = lambda liste: set(z.split(": ", 1)[1] for z in liste)
    weg = kern(vorher) - kern(nachher)
    dazu = kern(nachher) - kern(vorher)
    gemeint = treffer[0].split(": ", 1)[1]

    print("  Aenderung  %s" % fall["grund"])
    for alt, neu in zip(fall["alt"], fall["neu"]):
        print("             aus  %s" % alt.replace("\r\n", "  +  "))
        print("             wird %s" % neu.replace("\r\n", "  +  "))

    if gemeint not in weg:
        print("  NICHT BELEGT  der beklagte Befund steht nach der Aenderung "
              "noch da")
        print()
        continue
    if dazu:
        print("  NICHT BELEGT  die Aenderung erzeugt einen neuen Befund:")
        for neuer in sorted(dazu):
            print("                %s" % neuer)
        print()
        continue
    print("  Gemessen   nach der Aenderung: der beklagte Befund ist weg, "
          "kein neuer dazu")
    print("             (%d Befund(e) vorher, %d nachher)"
          % (len(vorher), len(nachher)))
    print("  BELEGT")
    print()
    belegt += 1

anzahl = len(KLAGEN)
print("%d von %d Klagen belegt" % (belegt, anzahl))
print("Nicht dabei: bitfireAT/synctools#156, seit dem 2025-12-05 geschlossen")
sys.exit(0 if belegt == anzahl else 1)
PYTHON
