#!/bin/sh
# Woran haengt der Wertebereich eines RRULE-Regelteils — an der Grammatik oder
# an einem Satz Prosa?
#
# Aufruf:
#   sh projekte/icsdoktor/regelteile.sh
#   echo "Exit-Code: $?"
#
# WOZU. RFC 5545 §3.3.10 zaehlt vierzehn Regelteile auf. Fuer jeden steht
# irgendwo, welche Werte er tragen darf — aber nicht fuer jeden an derselben
# Art von Stelle. Bei FREQ ist der Vorrat eine geschlossene Aufzaehlung IN DER
# GRAMMATIK; wer FREQ=BLA schreibt, verletzt eine Produktion. Bei BYMONTH ist
# der Bereich ein Satz im Fliesstext ("Valid values are 1 to 12."), waehrend
# die Grammatik mit "monthnum = 1*2DIGIT" die 13 anstandslos zulaesst. Das ist
# kein Detail, sondern der Unterschied zwischen FEHLER und HINWEIS.
#
# DER ANLASS, woertlich und von aussen. dateutil/dateutil #523, eroeffnet
# 2017-11-14, am 2026-09-10 um 04:49 UTC als offen abgerufen. Der Melder fragt
# ausdruecklich den Normtext:
#
#     This can be fixed one of two ways, depending on what the RFC has to say
#     about it: 1. We raise a ValueError when there are out-of-range value
#     components if the RFC restricts all components to be valid values.
#
# Ein Kommentator hat ein halbes Jahr spaeter gesucht und nichts gefunden
# (absreim, 2018-05-24):
#
#     I've looked through RFC 5545 and could not find any comments either way
#     as to how invalid values should be handled. The most relevant statements
#     in the RFC in section 3.3.10 describe "valid" ranges for various byxxx
#     rule parts, but does not go into detail about how invalid values should
#     be handled.
#
# Er hat recht in dem, was er sagt. Dieses Skript sagt das Uebrige: WO die
# Bereiche stehen, mit Zeilennummer, und WORAN sie haengen. Es beantwortet
# nicht, was ein Programm tun soll — das steht im RFC wirklich nicht.
#
# WAS GEPRUEFT WIRD. Der Normtext wird bei jedem Lauf frisch von rfc-editor.org
# geholt; es liegt keine Kopie im Repo, die altern koennte. Zu jedem Eintrag
# der Tabelle unten gehoert eine Zeilennummer und ein Bruchstueck, das auf
# dieser Zeile stehen MUSS. Gedruckt wird die Zeile, wie sie wirklich dasteht,
# nicht das Bruchstueck — wer das Ergebnis nachlesen will, liest den Normtext
# und nicht diese Datei.
#
# Zusaetzlich wird jede Belegzeile auf ein Schluesselwort nach RFC 2119
# abgesucht (MUST, MUST NOT, SHALL, SHOULD, REQUIRED, MAY ...). Das ist die
# eigentliche Messung: Sie zeigt, dass hinter keiner der neun Bereichsangaben
# ein solches Wort steht.
#
# WAS DIESES SKRIPT NICHT IST. Keine Pruefung von Kalenderdateien; es liest
# keine einzige und ersetzt pruefe.sh nicht. Es faellt auch keine Entscheidung
# ueber die Schwere einer Meldung — es legt die Belege nebeneinander, damit die
# Entscheidung an ihnen gemessen werden kann statt an einer Erinnerung.
#
# NICHT ERFASST ist die Vertraeglichkeit ZWISCHEN Regelteilen (BYMONTHDAY
# neben FREQ=WEEKLY und die sechs weiteren Faelle). Sie liest zwei Werte
# gegeneinander, waehrend es hier um einen einzelnen Wert gegen einen Vorrat
# geht, und sie steht — anders als die Bereiche — mehrfach mit MUST NOT da.
#
# ---------------------------------------------------------------------------
# Exit-Code: 0 jede Belegzeile steht, wo sie steht,
#            1 mindestens eine nicht,
#            2 Quelle nicht erreichbar oder Umgebungsfehler.
#            Exit 2 heisst NICHT ENTSCHIEDEN und nie "bestanden".

set -u

if ! command -v python3 >/dev/null 2>&1; then
    echo "ABBRUCH: python3 ist nicht im PATH" >&2
    exit 2
fi

arbeit=$(mktemp -d) || exit 2
trap 'rm -rf "$arbeit"' EXIT INT TERM

if command -v curl >/dev/null 2>&1; then
    curl -sSf --max-time 60 "https://www.rfc-editor.org/rfc/rfc5545.txt" \
        > "$arbeit/rfc5545.txt" 2> "$arbeit/lade"
elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$arbeit/rfc5545.txt" \
        "https://www.rfc-editor.org/rfc/rfc5545.txt" 2> "$arbeit/lade"
else
    echo "ABBRUCH: weder curl noch wget im PATH" >&2
    exit 2
fi
if [ ! -s "$arbeit/rfc5545.txt" ]; then
    echo "ABBRUCH: rfc-editor.org ist nicht erreichbar." >&2
    [ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
    echo "Kein Ergebnis ist kein gruenes Ergebnis." >&2
    exit 2
fi
echo "Normtext geholt: $(wc -c < "$arbeit/rfc5545.txt" | tr -d ' ') Bytes, \
$(wc -l < "$arbeit/rfc5545.txt" | tr -d ' ') Zeilen"
echo

python3 - "$arbeit/rfc5545.txt" <<'PYTHON'
"""Fuer jeden Regelteil aus §3.3.10: woran haengt sein Wertebereich?"""
import re
import sys

pfad = sys.argv[1]

# RFC 2119 §1-8, dazu die Kleinschreibung ausdruecklich NICHT: RFC 5545 nennt
# die Woerter in Grossbuchstaben, wo es sie normativ meint (§1.1 verweist auf
# RFC 2119). "may" in einem gewoehnlichen Satz ist kein Schluesselwort.
SCHLUESSEL = re.compile(r"\b(MUST NOT|MUST|SHALL NOT|SHALL|SHOULD NOT|SHOULD|"
                        r"RECOMMENDED|NOT RECOMMENDED|REQUIRED|OPTIONAL|MAY)\b")

GRAMMATIK = "Grammatik"
PROSA = "Prosa"
KOMMENTAR = "ABNF-Kommentar"

# Regelteil, was gebunden wird, Art der Bindung, Zeile, Bruchstueck das auf
# dieser Zeile stehen muss. Die Zeilennummern sind am 2026-09-10 gemessen,
# nicht erinnert; steht der Normtext eines Tages anders, wird dieses Skript rot
# und nicht still falsch.
TABELLE = [
    ("FREQ",       "Wertevorrat",  GRAMMATIK, 2153,
     'freq        = "SECONDLY" / "MINUTELY" / "HOURLY" / "DAILY"'),
    ("UNTIL",      "Wertetyp",     GRAMMATIK, 2156,
     "enddate     = date / date-time"),
    ("COUNT",      "Wertform",     GRAMMATIK, 2140,
     '/ ( "COUNT" "=" 1*DIGIT )'),
    ("INTERVAL",   "Wertform",     GRAMMATIK, 2141,
     '/ ( "INTERVAL" "=" 1*DIGIT )'),
    ("INTERVAL",   "Wertebereich", PROSA,     2247,
     "The INTERVAL rule part contains a positive integer"),
    ("BYSECOND",   "Stellenzahl",  GRAMMATIK, 2160,
     "seconds     = 1*2DIGIT"),
    ("BYSECOND",   "Wertebereich", PROSA,     2277,
     "Valid values are 0 to 60."),
    ("BYMINUTE",   "Stellenzahl",  GRAMMATIK, 2164,
     "minutes     = 1*2DIGIT"),
    ("BYMINUTE",   "Wertebereich", PROSA,     2279,
     "Valid values are 0 to 59."),
    ("BYHOUR",     "Stellenzahl",  GRAMMATIK, 2168,
     "hour        = 1*2DIGIT"),
    ("BYHOUR",     "Wertebereich", PROSA,     2280,
     "Valid values are 0 to 23."),
    ("BYDAY",      "Wochentag",    GRAMMATIK, 2180,
     'weekday     = "SU" / "MO" / "TU" / "WE" / "TH" / "FR" / "SA"'),
    ("BYDAY",      "Aufbau",       GRAMMATIK, 2172,
     "weekdaynum  = [[plus / minus] ordwk] weekday"),
    ("BYDAY",      "Wertebereich", KOMMENTAR, 2178,
     "ordwk       = 1*2DIGIT       ;1 to 53"),
    ("BYMONTHDAY", "Stellenzahl",  GRAMMATIK, 2195,
     "ordmoday    = 1*2DIGIT"),
    ("BYMONTHDAY", "Wertebereich", PROSA,     2319,
     "Valid values are 1 to 31 or -31 to -1."),
    ("BYYEARDAY",  "Stellenzahl",  GRAMMATIK, 2201,
     "ordyrday    = 1*3DIGIT"),
    ("BYYEARDAY",  "Wertebereich", PROSA,     2325,
     "Valid values are 1 to 366 or -366 to -1."),
    ("BYWEEKNO",   "Stellenzahl",  GRAMMATIK, 2205,
     "weeknum     = [plus / minus] ordwk"),
    ("BYWEEKNO",   "Wertebereich", PROSA,     2332,
     "Valid values are 1 to 53"),
    ("BYMONTH",    "Stellenzahl",  GRAMMATIK, 2209,
     "monthnum    = 1*2DIGIT"),
    ("BYMONTH",    "Wertebereich", PROSA,     2347,
     "Valid values are 1 to 12."),
    ("BYSETPOS",   "Stellenzahl",  GRAMMATIK, 2213,
     "setposday   = yeardaynum"),
    ("BYSETPOS",   "Wertebereich", PROSA,     2370,
     "Valid values are 1 to 366"),
    ("WKST",       "Wertevorrat",  GRAMMATIK, 2151,
     '/ ( "WKST" "=" weekday )'),
    ("WKST",       "Wertevorrat",  PROSA,     2350,
     "Valid values are MO, TU, WE, TH, FR, SA, and SU."),
]

# Die vierzehn Regelteile aus recur-rule-part, Zeilen 2138-2151. Sie stehen
# hier, damit ein fehlender Eintrag auffaellt und nicht als Vollstaendigkeit
# durchgeht.
REGELTEILE = ("FREQ", "UNTIL", "COUNT", "INTERVAL", "BYSECOND", "BYMINUTE",
              "BYHOUR", "BYDAY", "BYMONTHDAY", "BYYEARDAY", "BYWEEKNO",
              "BYMONTH", "BYSETPOS", "WKST")

with open(pfad, "r", encoding="utf-8", errors="replace") as fh:
    zeilen = fh.read().split("\n")

fehlend = []
gedeckt = set()
zaehler = {GRAMMATIK: 0, PROSA: 0, KOMMENTAR: 0}
mit_schluesselwort = 0

breite = max(len(e[0]) for e in TABELLE)
for name, was, art, nr, bruch in TABELLE:
    gedeckt.add(name)
    if nr < 1 or nr > len(zeilen):
        fehlend.append((name, was, nr, "Zeile liegt ausserhalb des Textes"))
        continue
    zeile = zeilen[nr - 1].strip()
    if bruch not in zeile:
        fehlend.append((name, was, nr, zeile))
        continue
    zaehler[art] += 1
    treffer = SCHLUESSEL.search(zeile)
    if treffer:
        mit_schluesselwort += 1
        wort = treffer.group(0)
    else:
        wort = "-"
    print("%-*s  %-12s  %-14s  Zeile %4d  RFC-2119: %s"
          % (breite, name, was, art, nr, wort))
    print("%*s      %s" % (breite, "", zeile))

print()
offen = [r for r in REGELTEILE if r not in gedeckt]
if offen:
    print("OHNE EINTRAG: %s" % ", ".join(offen))

for name, was, nr, gefunden in fehlend:
    print("NICHT BELEGT: %s (%s), Zeile %d traegt statt dessen: %s"
          % (name, was, nr, gefunden))

belegt = len(TABELLE) - len(fehlend)
print("%d von %d Belegzeilen stehen, wo sie stehen" % (belegt, len(TABELLE)))
print("davon %d in der Grammatik, %d in der Prosa, %d nur im ABNF-Kommentar"
      % (zaehler[GRAMMATIK], zaehler[PROSA], zaehler[KOMMENTAR]))
print("%d von %d Belegzeilen tragen ein Schluesselwort nach RFC 2119"
      % (mit_schluesselwort, belegt))

sys.exit(1 if (fehlend or offen) else 0)
PYTHON
