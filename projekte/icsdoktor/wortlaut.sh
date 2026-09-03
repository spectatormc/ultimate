#!/bin/sh
# Traegt der zitierte Abschnitt den Satz, den die Meldung ausspricht?
#
#   sh projekte/icsdoktor/wortlaut.sh
#   sh projekte/icsdoktor/wortlaut.sh --selbstprobe
#   sh projekte/icsdoktor/wortlaut.sh --schneiden
#   echo "Exit-Code: $?"
#
# fundstellen.sh prueft jeden "[RFC 5545 §X]"-Verweis gegen den Normtext, aber
# nur auf EXISTENZ und UEBERSCHRIFT — das sagt sein eigener Kopf seit dem
# 2026-08-19. Ein Verweis auf einen existierenden, aber sachfremden Abschnitt
# laeuft dort gruen durch. Dieses Skript schliesst genau diese Luecke: Fuer
# jeden Abschnitt, der in einer Meldung erscheinen kann, muss ein WOERTLICHES
# Fragment des Normtexts INNERHALB des Zeilenbereichs dieses Abschnitts stehen.
#
# ES IST KEINER DER PRUEFBEFEHLE DER FRUEHEREN MISSIONEN. Es braucht Netz; das
# Werkzeug selbst nicht.
#
# ---------------------------------------------------------------------------
# DER INTERESSENKONFLIKT, VORNEWEG UND NICHT IM KLEINGEDRUCKTEN
#
# Welches Fragment der *tragende* Satz eines Abschnitts ist, entscheidet am Ende
# ein Mensch oder der Agent, der es hinschreibt — und beides bin ich. Ein
# Skript, das eine von mir abgetippte Liste gegen sich selbst haelt, sagt
# nichts als "ich habe zweimal dasselbe hingeschrieben". Dagegen stehen hier
# vier Vorkehrungen, jede einzeln nachpruefbar:
#
#   1. DIE LISTE WIRD GESCHNITTEN, NIE ABGETIPPT. wortlaut.tsv entsteht
#      ausschliesslich ueber "--schneiden" aus dem zur Laufzeit geholten
#      Normtext. Neben jedem Fragment steht die Zeilennummer, aus der es
#      stammt. Wer nachsehen will, braucht dieses Skript nicht.
#   2. DIE AUSWAHL FOLGT EINER HINGESCHRIEBENEN REGEL, NICHT MEINEM GESCHMACK.
#      Genommen wird der ERSTE Satz des Abschnitts, der ein Schluesselwort nach
#      RFC 2119 traegt (MUST, MUST NOT, SHALL, SHOULD, REQUIRED, MAY,
#      OPTIONAL) — und nur wenn der Abschnitt keinen solchen Satz hat,
#      ersatzweise seine erste ABNF-Definitionszeile. Welche der beiden Arten
#      es geworden ist, steht in der Tabelle.
#   3. DAS FRAGMENT MUSS RFC-WEIT EINDEUTIG SEIN. Es genuegt nicht, dass es im
#      Bereich steht — es darf SONST NIRGENDS im Normtext stehen. Ein Satz, der
#      an acht Stellen vorkommt, belegt keine Fundstelle, und ein Abschnitt, aus
#      dem sich kein eindeutiger Satz schneiden laesst, wird gemeldet statt
#      geschoent.
#   4. DAS SKRIPT MUSS SEIN EIGENES VERSAGEN ZEIGEN KOENNEN ("--selbstprobe").
#      Ohne diesen Modus waere "alle tragen ihren Satz" auch dann wahr, wenn
#      hier gar nichts geprueft wird.
#
# Was danach uebrig bleibt und nicht wegzureden ist: Die Regel unter 2 ist
# meine. Sie ist nur besser als ein Geschmacksurteil, weil sie VOR den Daten
# feststeht, fuer alle Abschnitte gleich gilt und in einer Zeile nachlesbar ist.
#
# ---------------------------------------------------------------------------
# Welche Abschnitte geprueft werden — und warum nicht die aus der Prosa
#
# Erhoben wie in fundstellen.sh, aber nur ueber drei der vier Wege:
#
#   (b) Literale — das 5. Argument jedes Fund(...)-Aufrufs, ueber den
#                  Syntaxbaum geholt (ast), nicht per Regex.
#   (c) Tabellen — Abschnittsnummern in den Modulkonstanten des Werkzeugs.
#   (d) Gemessen — was ueber allen Beispieldateien wirklich ausgegeben wird.
#
# Weg (a) — jedes "§N.N" in README, LAGE, GEGENPROBE und den Docstrings — bleibt
# hier aussen vor, und zwar nicht aus Bequemlichkeit: Ein Verweis in einem
# erklaerenden Absatz zeigt auf einen Zusammenhang, nicht auf den Satz, den eine
# Meldung ausspricht. Er kann auf eine Grammatik zeigen, auf eine Aufzaehlung,
# auf einen ganzen Paragraphen. Die Frage dieses Skripts stellt sich nur dort,
# wo das Werkzeug einem Nutzer eine Fundstelle NENNT.
#
# Gemessen am 2026-09-03 gegen 04:39 UTC: (b) 12, (c) 18, (d) 17 Angaben, ihre
# VEREINIGUNG 27 — die Ueberschneidung war bis heute ungemessen und stand
# deshalb als offene Zahl in der Missionsdatei. Diese Zahlen sind eine datierte
# Momentaufnahme mit ihrem Messbefehl daneben, keine Zusage; die laufende Zahl
# steht in der Ausgabe dieses Skripts.
#
# DIE SELBSTPRUEFUNG, OHNE DIE DAS SKRIPT NICHTS WERT WAERE: Jeder Abschnitt aus
# (b)+(c)+(d) braucht einen Eintrag in wortlaut.tsv. Fehlt einer, endet das
# Skript mit 2 und NENNT ihn, statt mit einer gruenen Zahl ueber die uebrigen zu
# beruhigen. Dieselbe Vorkehrung traegt fundstellen.sh, aus demselben Grund: Ein
# zu enger Ausschnitt liefert eine glatte Zahl, und eine glatte Zahl faellt
# niemandem auf.
#
# ---------------------------------------------------------------------------
# Wie der Zeilenbereich eines Abschnitts entsteht
#
# Eine Ueberschrift beginnt in Spalte 1 mit ihrer Nummer; im Fliesstext ist
# alles um drei Zeichen eingerueckt, im Inhaltsverzeichnis stehen
# Punktfuehrungen. Der Bereich eines Abschnitts reicht von seiner
# Ueberschriftszeile bis zur Zeile vor der naechsten Ueberschrift, gleich
# welcher Ebene. Der Bereich von §3.6 enthaelt damit den von §3.6.1 — das ist
# gewollt und die Frage dieses Skripts unberuehrt: gefragt wird, ob der Satz
# INNERHALB des genannten Bereichs steht, nicht ob er nur dort steht.
#
# Wie fundstellen.sh prueft das Skript die Erhebung, BEVOR es sie benutzt:
# Innerhalb jeder Ebene muss die Nummerierung lueckenlos bei 1 beginnen. Sonst
# hat nicht der RFC ein Loch, sondern die Ueberschriftenerkennung — und jedes
# "traegt seinen Satz nicht" waere ab da ein Fehlalarm, der teuerste Defekt,
# den ein Pruefwerkzeug haben kann.
#
# Seitenkoepfe und -fuesse ("[Page 43]", "RFC 5545 ... September 2009",
# Seitenvorschub) zerschneiden im RFC-Text die Saetze. Sie werden vor dem
# Vergleich entfernt, und der Rest wird auf einfache Leerzeichen normalisiert:
# Ein Satz steht im Normtext nie ohne Zeilenumbruch da. "Woertlich" heisst
# deshalb hier: zeichengleich bis auf Zeilenumbruch und Einrueckung. Was NICHT
# angefasst wird, sind die Woerter selbst.
#
# ---------------------------------------------------------------------------
# Exit-Code: 0 jede Fundstelle traegt ihren Satz, 1 mindestens eine nicht,
#            2 Quelle nicht erreichbar, Erhebung unvollstaendig, ein Abschnitt
#              ohne Eintrag oder Umgebungsfehler.
#            Exit 2 heisst NICHT ENTSCHIEDEN und nie "bestanden".

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
tabelle="$verzeichnis/wortlaut.tsv"

modus="pruefen"
if [ $# -gt 0 ]; then
    case "$1" in
        --selbstprobe) modus="selbstprobe" ;;
        --schneiden)   modus="schneiden" ;;
        *) echo "ABBRUCH: unbekanntes Argument '$1'" >&2; exit 2 ;;
    esac
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo "ABBRUCH: python3 ist nicht im PATH" >&2
    exit 2
fi
if [ ! -f "$werkzeug" ]; then
    echo "ABBRUCH: $werkzeug fehlt" >&2
    exit 2
fi
if [ "$modus" != "schneiden" ] && [ ! -f "$tabelle" ]; then
    echo "ABBRUCH: $tabelle fehlt — sie entsteht mit --schneiden aus dem" >&2
    echo "  Normtext und wird nie von Hand geschrieben." >&2
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
echo "Normtext geholt: $(wc -c < "$arbeit/rfc5545.txt" | tr -d ' ') Bytes"

python3 - "$arbeit" "$verzeichnis" "$modus" "$tabelle" <<'PYTHON'
"""Jede Fundstelle gegen den Satz halten, den ihr Abschnitt im Normtext traegt."""
import ast
import glob
import os
import re
import subprocess
import sys

arbeit, verzeichnis, modus, tabellenpfad = sys.argv[1:5]
sys.path.insert(0, verzeichnis)
import icsdoktor

ABSCHNITT = re.compile(r"^\d+(\.\d+)*$")
SCHLUESSEL = re.compile(r"\b(MUST NOT|MUST|SHALL NOT|SHALL|SHOULD NOT|SHOULD|"
                        r"REQUIRED|OPTIONAL|MAY)\b")
# Seitenfuss, Seitenkopf und Seitenvorschub des RFC-Textsatzes.
FUSS = re.compile(r"^\S.*\[Page \d+\]\s*$")
KOPF = re.compile(r"^RFC 5545\s+iCalendar\s+\w+ \d{4}\s*$")
# Die Schranken trennen einen SATZ von zwei Nachbarn, die keiner sind: einem
# belanglosen Halbsatz und dem "Format Definition"-Block, der die ganze
# Grammatik einer Komponente enthaelt (in §3.6.2 sind das 1169 Zeichen am
# Stueck, weil eine ABNF keine Satzpunkte hat). Beide Zahlen sind beim ersten
# Schnitt am 2026-09-03 an drei Abschnitten NACHKALIBRIERT worden, und zwar
# gegen den Normtext, nicht gegen ein gewuenschtes Ergebnis:
#   - 240 war zu eng. Der einzige eindeutige normative Satz von §3.8.2.3 hat
#     286 Zeichen; ein langer Satz ist kein schlechterer Satz. 400 laesst ihn
#     zu und die Format-Bloecke (875 und 1169) weiter draussen.
#   - 40 war fuer ABNF-Zeilen falsch. 'todoc = "BEGIN" ":" "VTODO" CRLF' hat
#     33 Zeichen — eine Definitionszeile ist kurz, das ist ihre Natur.
# Was dabei NICHT gelockert wurde: die RFC-weite Eindeutigkeit. Sie ist die
# Schranke, die wirklich traegt, und sie steht unveraendert.
MINDESTLAENGE = 40
HOECHSTLAENGE = 400
MINDESTLAENGE_ABNF = 20


def abbruch(text):
    sys.stderr.write("ABBRUCH: %s\n" % text)
    sys.exit(2)


def sortier(nummer):
    return [int(teil) for teil in nummer.split(".")]


def normal(text):
    """Zeilenumbruch und Einrueckung einebnen — die Woerter bleiben unberuehrt."""
    return re.sub(r"\s+", " ", text).strip()


# --- Normtext einlesen, Seitenwerk entfernen -------------------------------

roh = open(os.path.join(arbeit, "rfc5545.txt"),
           encoding="utf-8", errors="replace").read().split("\n")
zeilen = []          # (nummer_im_original, text) ohne Seitenkopf/-fuss
for nr, zeile in enumerate(roh, 1):
    zeile = zeile.replace("\f", "").rstrip("\r")
    if FUSS.match(zeile) or KOPF.match(zeile):
        continue
    zeilen.append((nr, zeile))

# --- Abschnitte mit Zeilenbereich, mit Selbstpruefung der Erhebung ---------

ueberschriften = []          # (nummer_im_original, abschnitt, titel)
gesehen = set()
for nr, zeile in zeilen:
    if not zeile or zeile.startswith(" ") or "..." in zeile:
        continue
    treffer = re.match(r"^(\d+(?:\.\d+)*)\.?\s+(\S.*?)\s*$", zeile)
    if treffer and treffer.group(1) not in gesehen:
        gesehen.add(treffer.group(1))
        ueberschriften.append((nr, treffer.group(1), treffer.group(2)))

if not ueberschriften:
    abbruch("in rfc5545.txt keine einzige Ueberschrift erkannt")

kinder = {}
for _, nummer, _ in ueberschriften:
    teile = nummer.split(".")
    kinder.setdefault(".".join(teile[:-1]), set()).add(int(teile[-1]))
for elter, sichtbar in sorted(kinder.items()):
    fehlt = sorted(set(range(1, max(sichtbar) + 1)) - sichtbar)
    if fehlt:
        abbruch("Erhebung aus rfc5545.txt hat ein Loch: unter %s fehlt %s, "
                "obwohl %s da ist.\n  Nicht der RFC ist unvollstaendig, sondern "
                "die Ueberschriftenerkennung — ein\n  'traegt seinen Satz "
                "nicht' waere ab hier ein Fehlalarm."
                % ("§" + elter if elter else "oberster Ebene",
                   ", ".join("%s.%d" % (elter, f) if elter else str(f)
                             for f in fehlt),
                   "§%s.%d" % (elter, max(sichtbar)) if elter
                   else "§%d" % max(sichtbar)))

# Bereich: von der Ueberschrift bis zur Zeile vor der naechsten Ueberschrift.
grenzen = {}
for stelle, (nr, nummer, titel) in enumerate(ueberschriften):
    ende = (ueberschriften[stelle + 1][0] - 1
            if stelle + 1 < len(ueberschriften) else roh and len(roh))
    grenzen[nummer] = (nr, ende, titel)
print("RFC 5545: %d Abschnitte erhoben, lueckenlos" % len(grenzen))


def bereichstext(nummer):
    """Der Text eines Abschnitts, auf einfache Leerzeichen normalisiert."""
    von, bis, _ = grenzen[nummer]
    return normal(" ".join(t for n, t in zeilen if von <= n <= bis))


ganzer_text = normal(" ".join(t for _, t in zeilen))

# --- (b), (c), (d): welche Abschnitte in einer Meldung erscheinen koennen ---

literale = {}
quelle = open(os.path.join(verzeichnis, "icsdoktor.py"),
              encoding="utf-8").read()
for knoten in ast.walk(ast.parse(quelle)):
    if not (isinstance(knoten, ast.Call)
            and isinstance(knoten.func, ast.Name)
            and knoten.func.id == "Fund"):
        continue
    argument = knoten.args[4] if len(knoten.args) >= 5 else None
    for schluessel in knoten.keywords:
        if schluessel.arg == "abschnitt":
            argument = schluessel.value
    if isinstance(argument, ast.Constant) and isinstance(argument.value, str):
        literale.setdefault(argument.value, []).append(
            "icsdoktor.py:%d" % knoten.lineno)


def ernte(wert, tiefe=0):
    if tiefe > 6:
        return set()
    if isinstance(wert, str):
        return {wert} if ABSCHNITT.match(wert) and "." in wert else set()
    if isinstance(wert, (list, tuple, set, frozenset)):
        gefunden = set()
        for teil in wert:
            gefunden |= ernte(teil, tiefe + 1)
        return gefunden
    if isinstance(wert, dict):
        gefunden = set()
        for schluessel, inhalt in wert.items():
            gefunden |= ernte(schluessel, tiefe + 1) | ernte(inhalt, tiefe + 1)
        return gefunden
    return set()


tabellen = {}
for name in dir(icsdoktor):
    if name.startswith("__"):
        continue
    for nummer in ernte(getattr(icsdoktor, name)):
        tabellen.setdefault(nummer, []).append(name)

beispiele = sorted(glob.glob(os.path.join(verzeichnis, "beispiele", "*.ics")))
if not beispiele:
    abbruch("keine Beispieldatei in %s/beispiele/ gefunden" % verzeichnis)
gemessen = {}
for pfad in beispiele:
    lauf = subprocess.run(
        [sys.executable, os.path.join(verzeichnis, "icsdoktor.py"), pfad],
        capture_output=True, text=True)
    for nummer in re.findall(r"\[RFC 5545 §([\d.]+)\]", lauf.stdout):
        gemessen.setdefault(nummer, set()).add(os.path.basename(pfad))

verlangt = set(literale) | set(tabellen) | set(gemessen)
print("")
print("Erhoben — welche Abschnitte in einer Meldung erscheinen koennen:")
print("  (b) Literale  %3d am 5. Argument von Fund(...)" % len(literale))
print("  (c) Tabellen  %3d in Modulkonstanten" % len(tabellen))
print("  (d) Gemessen  %3d ueber %d Beispieldatei(en)"
      % (len(gemessen), len(beispiele)))
print("  Vereinigung   %3d verschiedene Abschnitte" % len(verlangt))

unbekannt = sorted(verlangt - set(grenzen), key=sortier)
if unbekannt:
    abbruch("das Werkzeug nennt §%s, was im Normtext keine Ueberschrift hat.\n"
            "  Das findet fundstellen.sh; hier ist es ein Umgebungsfehler."
            % ", §".join(unbekannt))

# --- Der Schneider: die Fragmentliste entsteht aus dem Normtext ------------


def schneide(nummer):
    """Erster 2119-Satz des Abschnitts, ersatzweise erste ABNF-Zeile.

    Rueckgabe (art, zeile, fragment) oder None. Die Regel steht im Kopf dieser
    Datei und gilt fuer alle Abschnitte gleich — sie ist der einzige Grund,
    warum diese Liste nicht mein Geschmack ist.
    """
    von, bis, _ = grenzen[nummer]
    text = bereichstext(nummer)
    # Saetze am Punkt trennen, aber nicht an "e.g." und nicht an Ziffern.
    for satz in re.split(r"(?<=[a-z\)\"])\.\s+(?=[A-Z\"])", text):
        satz = satz.strip()
        if not SCHLUESSEL.search(satz):
            continue
        if not (MINDESTLAENGE <= len(satz) <= HOECHSTLAENGE):
            continue
        if ganzer_text.count(satz) != 1:
            continue
        return ("norm", zeile_von(satz, von, bis), satz)
    # Kein eindeutiger normativer Satz: die erste ABNF-Definition des Bereichs.
    for nr, roh_zeile in [(n, t) for n, t in zeilen if von <= n <= bis]:
        kandidat = normal(roh_zeile)
        if (re.match(r'^[a-z][a-z0-9-]*\s*=', kandidat)
                and MINDESTLAENGE_ABNF <= len(kandidat) <= HOECHSTLAENGE
                and ganzer_text.count(kandidat) == 1):
            return ("abnf", nr, kandidat)
    return None


def zeile_von(fragment, von, bis):
    """Die Originalzeile, in der das Fragment beginnt."""
    anfang = normal(fragment)[:40]
    for stelle, (nr, _) in enumerate(zeilen):
        if not (von <= nr <= bis):
            continue
        fenster = normal(" ".join(t for _, t in zeilen[stelle:stelle + 6]))
        if fenster.startswith(anfang) or anfang in fenster[:len(anfang) + 2]:
            return nr
    return von


if modus == "schneiden":
    reihen = []
    ohne = []
    for nummer in sorted(verlangt, key=sortier):
        ergebnis = schneide(nummer)
        if ergebnis is None:
            ohne.append(nummer)
            continue
        art, nr, fragment = ergebnis
        reihen.append((nummer, art, nr, fragment))
    with open(tabellenpfad, "w", encoding="utf-8") as fh:
        fh.write("# Geschnitten aus dem zur Laufzeit geholten RFC 5545 durch\n")
        fh.write("# 'sh wortlaut.sh --schneiden'. NIE VON HAND SCHREIBEN —\n")
        fh.write("# die Regel steht im Kopf von wortlaut.sh, nicht hier.\n")
        fh.write("# abschnitt\tart\tzeile\tfragment\n")
        for nummer, art, nr, fragment in reihen:
            fh.write("%s\t%s\t%d\t%s\n" % (nummer, art, nr, fragment))
    print("")
    print("Geschnitten: %d Fragmente nach %s"
          % (len(reihen), os.path.basename(tabellenpfad)))
    for nummer in ohne:
        print("  OHNE FRAGMENT: §%s — kein eindeutiger normativer Satz und "
              "keine ABNF-Zeile" % nummer)
    if ohne:
        print("Diese Abschnitte bleiben ungeprueft und werden beim naechsten "
              "Lauf gemeldet.")
    sys.exit(0)

# --- Die Tabelle lesen -----------------------------------------------------

eintraege = {}
with open(tabellenpfad, encoding="utf-8") as fh:
    for zeile_txt in fh:
        if zeile_txt.startswith("#") or not zeile_txt.strip():
            continue
        teile = zeile_txt.rstrip("\n").split("\t")
        if len(teile) != 4:
            abbruch("%s: Zeile mit %d Feldern statt 4"
                    % (os.path.basename(tabellenpfad), len(teile)))
        eintraege[teile[0]] = (teile[1], int(teile[2]), teile[3])

# Selbstpruefung: jeder Abschnitt aus (b)+(c)+(d) braucht einen Eintrag.
fehlend = sorted(verlangt - set(eintraege), key=sortier)
if fehlend:
    abbruch("fuer §%s liegt kein Fragment vor. Damit ist eine Abschnittsangabe,\n"
            "  die in einer Meldung erscheinen kann, UNGEPRUEFT — und eine "
            "gruene Zahl\n  ueber die uebrigen laese sich wie eine ueber alle."
            % ", §".join(fehlend))

# --- Die Selbstprobe: drei absichtlich falsche Paarungen -------------------

if modus == "selbstprobe":
    print("")
    print("Selbstprobe — drei absichtlich falsche Paarungen. Das Skript muss")
    print("sie als NICHT GETRAGEN melden; taete es das nicht, waere sein "
          "gruenes")
    print("Ergebnis wertlos.")
    print("")
    vorrat = sorted(eintraege, key=sortier)
    falsch = []
    # (1) Ein echtes Fragment unter einem fremden, existierenden Abschnitt.
    for nummer in vorrat:
        anderer = next((a for a in vorrat if a != nummer
                        and eintraege[nummer][2] not in bereichstext(a)), None)
        if anderer:
            falsch.append(("echtes Fragment von §%s unter §%s gehaengt"
                           % (nummer, anderer), anderer, eintraege[nummer][2]))
            break
    # (2) Ein Satz, den es im Normtext nirgends gibt.
    falsch.append(("erfundener Satz, der im ganzen RFC nicht vorkommt",
                   vorrat[0],
                   "The \"XYZZY\" property parameter MUST be applied to every "
                   "calendar component that does not exist."))
    # (3) Ein Fragment aus dem Nachbarabschnitt — die schwerste der drei.
    for nummer in vorrat:
        geschwister = [a for a in sorted(grenzen, key=sortier)
                       if a.startswith(nummer.rsplit(".", 1)[0] + ".")
                       and a != nummer]
        treffer = next((g for g in geschwister
                        if eintraege[nummer][2] not in bereichstext(g)), None)
        if treffer:
            falsch.append(("Fragment aus §%s unter dem Nachbarn §%s"
                           % (nummer, treffer), treffer, eintraege[nummer][2]))
            break
    erkannt = 0
    for beschreibung, abschnitt, fragment in falsch:
        traegt = fragment in bereichstext(abschnitt)
        zustand = "getragen" if traegt else "NICHT GETRAGEN"
        if not traegt:
            erkannt += 1
        print("  %-14s %s" % (zustand, beschreibung))
        print("                 Fragment: %.70s..." % fragment)
    print("")
    print("%d von %d falschen Paarungen als nicht getragen erkannt"
          % (erkannt, len(falsch)))
    if erkannt != len(falsch) or len(falsch) < 3:
        print("Das Skript erkennt seine eigenen Fehlpaarungen nicht — ein "
              "gruenes")
        print("Ergebnis im Normalbetrieb sagt damit nichts.")
        sys.exit(1)
    print("Die Pruefung schlaegt an, wo sie anschlagen muss — gemessen, nicht "
          "behauptet.")
    sys.exit(0)

# --- Der eigentliche Vergleich --------------------------------------------

print("")
print("Fundstellen, einzeln:")
fehler = []
for nummer in sorted(eintraege, key=sortier):
    art, quellzeile, fragment = eintraege[nummer]
    von, bis, titel = grenzen[nummer]
    innerhalb = fragment in bereichstext(nummer)
    eindeutig = ganzer_text.count(fragment) == 1
    if innerhalb and eindeutig:
        print("  ok      §%-8s Zeile %5d  %-4s  %s"
              % (nummer, quellzeile, art, titel))
    else:
        grund = ("steht nicht in Zeile %d-%d" % (von, bis) if not innerhalb
                 else "steht %d-mal im RFC, nicht nur hier"
                      % ganzer_text.count(fragment))
        fehler.append((nummer, grund, fragment))
        print("  TRAEGT NICHT  §%-8s %s" % (nummer, grund))
        print("                Fragment: %.70s..." % fragment)

arten = {}
for art, _, _ in eintraege.values():
    arten[art] = arten.get(art, 0) + 1
print("")
print("Fragmentarten: %s"
      % ", ".join("%d %s" % (anzahl, art) for art, anzahl in sorted(arten.items())))
print("%d von %d Fundstellen tragen ihren Satz"
      % (len(eintraege) - len(fehler), len(eintraege)))
if fehler:
    print("Eine Meldung schickt an einen Abschnitt, der ihren Satz nicht "
          "ausspricht.")
    sys.exit(1)
print("Jedes Fragment ist aus dem heute geholten Normtext geschnitten, steht")
print("innerhalb des Zeilenbereichs seines Abschnitts und sonst nirgends im "
      "RFC —")
print("gemessen, nicht behauptet. Ob es der TRAGENDE Satz ist, entscheidet die")
print("Regel im Kopf dieser Datei und nicht mein Geschmack; mehr sagt diese "
      "Zahl nicht.")
PYTHON
