#!/bin/sh
# Herkunftspruefung der Fundstellen — jeder §-Verweis gegen den Normtext.
#
#   sh projekte/icsdoktor/fundstellen.sh
#   echo "Exit-Code: $?"
#
# Das Werkzeug verspricht in seiner ersten Zeile, fuer jeden Verstoss "Zeile,
# Regel und Abschnitt aus RFC 5545" zu nennen. Jede Fundzeile endet deshalb mit
# "[RFC 5545 §X]". Stimmt dieses X nicht, schickt das Werkzeug den Nutzer an
# eine falsche Stelle der Norm — und zwar leise: Die Ausgabe sieht genauso
# richtig aus wie vorher, und wer den Abschnitt nicht nachschlaegt, merkt
# nichts. Dasselbe gilt fuer die §-Verweise in README, GEGENPROBE und den
# Docstrings; sie sind die Begruendung dafuer, dass eine Pruefung ueberhaupt
# existiert.
#
# Geprueft wird gegen den Normtext selbst, zur Laufzeit geholt, nicht gegen
# eine Liste aus meiner Hand. Wie namensliste.sh und zahlen.sh beweist dieses
# Skript nicht, dass eine Pruefung richtig arbeitet — nur, dass die Stelle, die
# sie zitiert, im zitierten RFC existiert und wie sie dort heisst.
#
# ES IST KEINER DER PRUEFBEFEHLE EINER MISSION. Es braucht Netz; das Werkzeug
# selbst nicht.
#
# ---------------------------------------------------------------------------
# Vier Erhebungen, weil keine einzelne vollstaendig ist
#
#   (a) Prosa    — jedes "§N.N" in den Projektdateien: Docstrings, README,
#                  GEGENPROBE, LAGE, die Skripte. Exakt.
#   (b) Literale — das 5. Argument jedes Fund(...)-Aufrufs, sofern es eine
#                  Zeichenkette ist. Ueber den Syntaxbaum geholt (ast), nicht
#                  per Regex, damit ein Kommentar nichts vortaeuscht.
#   (c) Tabellen — Abschnittsnummern in den Modulkonstanten des Werkzeugs
#                  (_PFLICHT_JE_KOMPONENTE und Geschwister). Von dort kommen
#                  die Abschnitte, die (b) nur als Variablennamen sieht.
#   (d) Gemessen — was ueber allen Beispieldateien wirklich ausgegeben wird.
#
# (a) bis (c) sind statisch und decken auch Codewege ab, die kein Beispiel
# ausloest — am 2026-08-19 zehn Stueck. (d) ist die Gegenprobe dazu.
#
# DIE SELBSTPRUEFUNG, OHNE DIE DAS SKRIPT NICHTS WERT WAERE: Jeder in (d)
# gemessene Abschnitt muss in (a)+(b)+(c) vorkommen. Tut er es nicht, ist die
# statische Erhebung unvollstaendig — dann ist ein "alle Verweise stimmen" eine
# Aussage ueber einen Ausschnitt, der sich als Aussage ueber das Ganze liest.
# In dem Fall endet das Skript mit 2 und nennt den Abschnitt, den es nicht
# zuordnen konnte, statt mit 0 zu beruhigen.
#
# Genau das ist hier schon passiert: "3.7.3" steht als Zeichenkette in einem
# Tupel INNERHALB von pruefe_p06 und wird weder von (b) noch von (c) gesehen.
# Gedeckt ist es nur, weil der Docstring darueber §3.7.3 nennt. Ohne diesen
# Docstring haette die Erhebung ein Loch gehabt und es selbst gemeldet.
#
# ---------------------------------------------------------------------------
# Welcher RFC gemeint ist
#
# Fuer (b), (c) und (d) ist die Frage entschieden, bevor sie gestellt wird:
# Fund.__str__ schreibt "RFC 5545" fest in die Ausgabe. Was ueber diesen Weg
# hinausgeht, IST ein Verweis auf RFC 5545, ob es passt oder nicht.
#
# Fuer (a) nicht. Drei Verweise im Projekt zeigen absichtlich woandershin:
# RFC 5234 §2.3 (ABNF-Literale sind schreibweisenunabhaengig), RFC 2445 §4.6.2
# (die alte ABNF, in der UID optional war) und RFC 7986 §9.1 (die Nachtragungen
# von 2016). Die Regel dafuer ist eng gefasst und nicht geraten: Ein Verweis
# gehoert nur dann zu einem anderen RFC, wenn dessen Nummer unmittelbar davor
# in derselben Zeile steht ("RFC 2445 §4.6.2", auch mit Sternchen dazwischen).
# Sonst RFC 5545. Eine grosszuegigere Regel — irgendwo im Absatz — wuerde jeden
# §-Verweis in der Naehe einer RFC-Nummer entschuldigen und damit genau die
# Fehler durchlassen, wegen derer es dieses Skript gibt.
#
# ---------------------------------------------------------------------------
# Warum "Abschnitt nicht gefunden" hier ueberhaupt etwas bedeutet
#
# Die Abschnittsliste wird aus dem RFC-Text erhoben: eine Ueberschrift beginnt
# in Spalte 1 mit ihrer Nummer. Erhebt sie sich zu kurz, wird aus einem
# richtigen Verweis ein Fehlalarm — der teuerste Defekt, den ein Pruefwerkzeug
# haben kann, und in diesem Projekt schon zweimal der Anlass fuer eine
# Nacharbeit.
#
# Deshalb prueft das Skript die Erhebung, bevor es sie benutzt: Innerhalb jeder
# Ebene muss die Nummerierung lueckenlos bei 1 beginnen. Fehlt zwischen 3.8.2.1
# und 3.8.2.3 die 3.8.2.2, hat nicht der RFC ein Loch, sondern die Erhebung.
# Auch das endet mit 2 und nicht mit 1.
#
# ---------------------------------------------------------------------------
# NACHTRAG 2026-08-25 — was die Schlusszahl zaehlt, und was sie nicht sagt
#
# Die vorletzte Zeile der Ausgabe nennt eine Anzahl gepruefter Verweise. Sie
# ist die Anzahl VERSCHIEDENER Paare aus RFC-Nummer und Abschnittsnummer,
# vereinigt ueber (a), (b) und (c). Eine Fundstelle mehr erhoeht sie nicht:
# Nennen zwei Pruefungen denselben Abschnitt, ist es ein Paar; nennt eine
# Datei ihn fuenfmal, ist es ein Paar. Die Stellen stehen daneben — gezaehlt
# wird das Paar.
#
# Der Anlass, das hinzuschreiben, ist ein eigener Fehlgriff und keine Theorie.
# Eine Zieldefinition dieses Projekts hat aus "eine neue Pruefung kommt dazu"
# geschlossen, die Zahl steige um eins. Sie stieg nicht: Der Abschnitt, den die
# neue Pruefung zitiert, war laengst von einer aelteren genannt. Die Zusage war
# damit an eine Zahl geknuepft, die etwas anderes misst als das, wofuer sie
# stand — nachgerechnet am 2026-08-25 an dieser Datei, nicht vermutet.
#
# Wer diese Zahl in eine Zusage schreibt, sagt etwas ueber den BESTAND des
# Projekts an verschiedenen Abschnitten. Ob ein BESTIMMTER Verweis im Normtext
# steht, sagt sie nicht; dafuer ist die Zeile "ok RFC ..." zu genau diesem
# Abschnitt da, und dafuer die zweite Zahl "ohne Entsprechung".
#
# ---------------------------------------------------------------------------
# NACHTRAG 2026-08-25, zweiter des Tages — was (a) NICHT liest
#
# Die Schlusszeile lautete "Jeder §-Verweis dieses Projekts steht im zitierten
# RFC". Erhebung (a) liest aber eine feste Liste von Dateien, die weiter oben
# im Quelltext steht — nicht das Projekt. Die Liste ist seit ihrer Anlage nicht
# mitgewachsen: Gemessen am 2026-08-25 tragen mehrere versionierte
# Projektdateien einen §-Verweis, ohne darin vorzukommen, darunter die
# Erwartungsdateien unter erwartet/. Der Satz sagte damit ueber das Ganze, was
# ueber einen Ausschnitt gemessen war — dieselbe Sorte Fehlgriff wie im
# Nachtrag darueber, diesmal in der eigenen Schlusszeile.
#
# Geaendert wurde heute zweierlei, und bewusst nicht mehr:
#
#   - Die Schlusszeile nennt die Zahl der gelesenen Dateien und sagt, dass
#     sie ueber ungelesene nichts aussagt.
#   - Das Skript ZAEHLT den blinden Fleck selbst: versionierte Projektdateien
#     mit einem §-Verweis, die (a) nicht liest, stehen mit Namen in der
#     Ausgabe. Ein Kommentar veraltet, eine gemessene Zeile nicht.
#
# WARUM DIE LISTE HEUTE NICHT ERWEITERT WIRD, obwohl das die Reparatur waere:
# Zwei Gruende, beide gemessen, keiner davon Bequemlichkeit.
#
#   1. Eine naive Erweiterung erzeugt einen FEHLALARM. exitprobe.sh baut eine
#      erfundene Korpuszeile ("erfunden/probe#1") und setzt in deren
#      Abschnittsspalte einen Platzhalter, den es im Normtext nicht gibt. Er
#      ist als erfunden gekennzeichnet und ist kein Verweis auf die Norm; als
#      Verweis gelesen zeigte er ins Leere. Genau davor warnt der Absatz
#      "Warum 'Abschnitt nicht gefunden' hier ueberhaupt etwas bedeutet".
#   2. Die Erweiterung bewegt die Schlusszahl. An dieser Zahl haengt Punkt 4
#      einer laufenden Zieldefinition. Solange deren Frist laeuft, ist eine
#      Aenderung an der Erhebung von aussen nicht davon zu unterscheiden, dass
#      hier ein Pruefbefehl passend gemacht wird — und die Zieldefinition wird
#      nicht angefasst. Nach dem Abschluss der Mission ist die Reparatur faellig
#      und unverdaechtig; sie steht als Befund in state/offen.md.
#
# Der Exit-Code bleibt deshalb 0 und wird nicht zu 2. Die beiden bestehenden
# Selbstpruefungen enden mit 2, weil dort eine Aussage nachweislich FALSCH
# waere. Hier war sie nur zu WEIT gefasst; auf die gelesenen Dateien
# eingeschraenkt stimmt sie, und die Luecke steht gezaehlt daneben.
#
# ---------------------------------------------------------------------------
# Exit-Code: 0 alle Verweise stimmen, 1 mindestens einer zeigt ins Leere,
#            2 Quelle nicht erreichbar, Erhebung unvollstaendig oder
#              Umgebungsfehler.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"

if ! command -v python3 >/dev/null 2>&1; then
    echo "ABBRUCH: python3 ist nicht im PATH" >&2
    exit 2
fi
if [ ! -f "$werkzeug" ]; then
    echo "ABBRUCH: $werkzeug fehlt" >&2
    exit 2
fi

arbeit=$(mktemp -d) || exit 2
trap 'rm -rf "$arbeit"' EXIT INT TERM

lade() {
    if command -v curl >/dev/null 2>&1; then
        curl -sSf --max-time 60 "$1" > "$2" 2> "$arbeit/lade"
    elif command -v wget >/dev/null 2>&1; then
        wget -q -O "$2" "$1" 2> "$arbeit/lade"
    else
        echo "ABBRUCH: weder curl noch wget im PATH" >&2
        exit 2
    fi
    if [ $? -ne 0 ] || [ ! -s "$2" ]; then
        echo "ABBRUCH: $1 ist nicht erreichbar." >&2
        [ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
        echo "Kein Ergebnis ist kein gruenes Ergebnis." >&2
        exit 2
    fi
}

# Welche RFCs geholt werden muessen, steht nicht hier, sondern ergibt sich aus
# den Verweisen selbst. Kommt ein Verweis auf einen weiteren RFC dazu, wird der
# mitgeholt, statt stillschweigend als RFC 5545 durchzugehen.
python3 - "$verzeichnis" > "$arbeit/rfcs" <<'PYTHON' || exit 2
import os
import re
import sys

verzeichnis = sys.argv[1]
DATEIEN = ("icsdoktor.py", "README.md", "GEGENPROBE.md", "LAGE.md",
           "anlass.sh", "gegenprobe.sh", "rfc-beispiele.sh", "pruefe.sh",
           "namensliste.sh", "zahlen.sh", "fremdprobe.sh", "fundstellen.sh")
VOR = re.compile(r"RFC\s*\**\s*(\d{3,5})\s*\**\s*$")

nummern = {"5545"}
for name in DATEIEN:
    pfad = os.path.join(verzeichnis, name)
    if not os.path.exists(pfad):
        sys.stderr.write("ABBRUCH: %s fehlt — die Erhebung waere unvollstaendig,\n"
                         "  und ein gruenes Ergebnis ueber einen Ausschnitt liest\n"
                         "  sich wie eines ueber das Ganze.\n" % pfad)
        sys.exit(2)
    with open(pfad, encoding="utf-8", errors="replace") as fh:
        for zeile in fh:
            for treffer in re.finditer(r"§(\d+(?:\.\d+)*)", zeile):
                vor = VOR.search(zeile[:treffer.start()])
                if vor:
                    nummern.add(vor.group(1))
for n in sorted(nummern):
    print(n)
PYTHON

anzahl_rfc=0
for nr in $(cat "$arbeit/rfcs"); do
    lade "https://www.rfc-editor.org/rfc/rfc$nr.txt" "$arbeit/rfc$nr.txt"
    anzahl_rfc=$((anzahl_rfc + 1))
done
echo "Normtexte geholt: $anzahl_rfc ($(tr '\n' ' ' < "$arbeit/rfcs"))"

python3 - "$arbeit" "$verzeichnis" <<'PYTHON'
"""Jeden §-Verweis des Projekts gegen die Abschnittsliste seines RFC halten."""
import ast
import glob
import os
import re
import subprocess
import sys

arbeit, verzeichnis = sys.argv[1], sys.argv[2]
sys.path.insert(0, verzeichnis)
import icsdoktor

DATEIEN = ("icsdoktor.py", "README.md", "GEGENPROBE.md", "LAGE.md",
           "anlass.sh", "gegenprobe.sh", "rfc-beispiele.sh", "pruefe.sh",
           "namensliste.sh", "zahlen.sh", "fremdprobe.sh", "fundstellen.sh")
ABSCHNITT = re.compile(r"^\d+(\.\d+)*$")
VERWEIS = re.compile(r"§(\d+(?:\.\d+)*)")
VOR = re.compile(r"RFC\s*\**\s*(\d{3,5})\s*\**\s*$")
# Der feste Text aus Fund.__str__. Steht dort etwas anderes, stimmt die
# Annahme nicht mehr, dass jeder Code-Abschnitt ein RFC-5545-Abschnitt ist.
AUSGABE_RFC = "5545"


def sortier(nummer):
    return [int(teil) for teil in nummer.split(".")]


def abbruch(text):
    sys.stderr.write("ABBRUCH: %s\n" % text)
    sys.exit(2)


# --- Abschnittsliste je RFC, mit Selbstpruefung der Erhebung ---------------

def abschnitte(pfad):
    """Ueberschriften aus einem RFC-Text: Nummer in Spalte 1, dann der Titel.

    Im Fliesstext ist alles um drei Zeichen eingerueckt, im
    Inhaltsverzeichnis stehen Punktfuehrungen — beides faellt damit heraus.
    """
    gefunden = {}
    with open(pfad, encoding="utf-8", errors="replace") as fh:
        for zeile in fh:
            zeile = zeile.rstrip("\r\n")
            if not zeile or zeile.startswith(" ") or "..." in zeile:
                continue
            treffer = re.match(r"^(\d+(?:\.\d+)*)\.?\s+(\S.*?)\s*$", zeile)
            if treffer:
                gefunden.setdefault(treffer.group(1), treffer.group(2))
    return gefunden


def erhebung_pruefen(nummer, gefunden):
    """Lueckenlos ab 1 — sonst hat die Erhebung ein Loch, nicht der RFC.

    Ohne diesen Test waere jedes "Abschnitt existiert nicht" nur die Aussage,
    dass die Ueberschrift nicht erkannt wurde.
    """
    if not gefunden:
        abbruch("in rfc%s.txt keine einzige Ueberschrift erkannt" % nummer)
    kinder = {}
    for eintrag in gefunden:
        teile = eintrag.split(".")
        kinder.setdefault(".".join(teile[:-1]), set()).add(int(teile[-1]))
    for elter, gesehen in sorted(kinder.items()):
        erwartet = set(range(1, max(gesehen) + 1))
        fehlt = sorted(erwartet - gesehen)
        if fehlt:
            abbruch("Erhebung aus rfc%s.txt hat ein Loch: unter %s fehlt %s, "
                    "obwohl %s da ist.\n  Nicht der RFC ist unvollstaendig, "
                    "sondern die Ueberschriftenerkennung — ein 'Abschnitt "
                    "existiert nicht'\n  waere ab hier ein Fehlalarm."
                    % (nummer, "§" + elter if elter else "oberster Ebene",
                       ", ".join("%s.%d" % (elter, f) if elter else str(f)
                                 for f in fehlt),
                       "§%s.%d" % (elter, max(gesehen)) if elter
                       else "§%d" % max(gesehen)))
    return gefunden


liste = {}
for datei in sorted(glob.glob(os.path.join(arbeit, "rfc*.txt"))):
    nummer = re.search(r"rfc(\d+)\.txt$", datei).group(1)
    liste[nummer] = erhebung_pruefen(nummer, abschnitte(datei))
for nummer in sorted(liste, key=int):
    print("RFC %s: %d Abschnitte erhoben, lueckenlos"
          % (nummer, len(liste[nummer])))

# --- (a) Prosa: jedes § in den Projektdateien ------------------------------

prosa = {}
for name in DATEIEN:
    pfad = os.path.join(verzeichnis, name)
    if not os.path.exists(pfad):
        abbruch("%s fehlt" % pfad)
    with open(pfad, encoding="utf-8", errors="replace") as fh:
        for nr, zeile in enumerate(fh, 1):
            for treffer in VERWEIS.finditer(zeile):
                vor = VOR.search(zeile[:treffer.start()])
                rfc = vor.group(1) if vor else AUSGABE_RFC
                prosa.setdefault((rfc, treffer.group(1)), []).append(
                    "%s:%d" % (name, nr))

# --- (b) Das 5. Argument jedes Fund(...) ueber den Syntaxbaum --------------

literale = {}
quelle = open(os.path.join(verzeichnis, "icsdoktor.py"), encoding="utf-8").read()
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

# --- (c) Abschnittsnummern in den Modulkonstanten --------------------------

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

# --- (d) Gemessen: was ueber den Beispielen wirklich ausgegeben wird -------

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

aus_code = set(literale) | set(tabellen)
aus_prosa_5545 = {nr for rfc, nr in prosa if rfc == AUSGABE_RFC}

# --- Der blinde Fleck von (a), gezaehlt statt behauptet --------------------

def ungelesene():
    """Versionierte Projektdateien mit §-Verweis, die nicht in DATEIEN stehen.

    (a) liest eine feste Liste. Waechst das Projekt, waechst die Liste nicht
    mit — und die Schlusszeile spraeche weiter ueber "das Projekt", waehrend
    sie einen Ausschnitt meint. Was die Liste auslaesst, wird deshalb gemessen
    und beim Namen genannt, statt in einem Kommentar zu stehen, der veraltet.

    Rueckgabe None heisst NICHT "keine" — es heisst "nicht ermittelt", und die
    Ausgabe sagt das dann auch. Kein Ergebnis ist kein gruenes Ergebnis.
    """
    # Fehlt git ganz, wirft run() eine OSError, statt einen Code zu liefern —
    # am 2026-08-25 mit leerem PATH gemessen, nicht angenommen. Ohne diesen
    # Zweig endet das Skript an dieser Stelle mit einem Traceback auf stderr.
    try:
        lauf = subprocess.run(["git", "-C", verzeichnis, "ls-files", "-z"],
                              capture_output=True, text=True)
    except OSError:
        return None
    if lauf.returncode != 0:
        return None
    fehlend = []
    for name in lauf.stdout.split("\0"):
        if not name or name in DATEIEN:
            continue
        try:
            with open(os.path.join(verzeichnis, name),
                      encoding="utf-8", errors="replace") as fh:
                if VERWEIS.search(fh.read()):
                    fehlend.append(name)
        except OSError:
            continue
    return sorted(fehlend)


ungelesen = ungelesene()

print("")
print("Erhoben:")
print("  (a) Prosa     %3d Verweise in %d Datei(en), %d RFC(s)"
      % (len(prosa), len(DATEIEN), len({rfc for rfc, _ in prosa})))
print("  (b) Literale  %3d am 5. Argument von Fund(...)" % len(literale))
print("  (c) Tabellen  %3d in Modulkonstanten" % len(tabellen))
print("  (d) Gemessen  %3d ueber %d Beispieldatei(en)"
      % (len(gemessen), len(beispiele)))

if ungelesen is None:
    print("  Blinder Fleck: NICHT ERMITTELT — git lieferte keine Dateiliste.")
    print("    Ob (a) jede versionierte Projektdatei liest, ist damit offen.")
elif ungelesen:
    print("  Blinder Fleck: %d versionierte Projektdatei(en) mit §-Verweis "
          "liest (a) nicht" % len(ungelesen))
    for name in ungelesen[:6]:
        print("    ungelesen: %s" % name)
    if len(ungelesen) > 6:
        print("    ungelesen: ... und %d weitere" % (len(ungelesen) - 6))
else:
    print("  Blinder Fleck: keiner — (a) liest jede versionierte "
          "Projektdatei mit §-Verweis")

# Selbstpruefung: (d) muss in (a)+(b)+(c) aufgehen.
unzugeordnet = sorted(set(gemessen) - aus_code - aus_prosa_5545, key=sortier)
if unzugeordnet:
    abbruch("das Werkzeug gibt §%s aus, aber keine der statischen Erhebungen\n"
            "  kennt diesen Abschnitt. Damit ist (a)+(b)+(c) unvollstaendig, "
            "und ein\n  'alle Verweise stimmen' waere eine Aussage ueber einen "
            "Ausschnitt, die\n  sich wie eine ueber das Ganze liest."
            % ", §".join(unzugeordnet))
print("  Selbstpruefung: jeder gemessene Abschnitt kommt in (a)+(b)+(c) vor")

ungeprueft = sorted(aus_code - set(gemessen), key=sortier)
print("  Davon von keinem Beispiel ausgeloest: %d (§%s)"
      % (len(ungeprueft), ", §".join(ungeprueft)) if ungeprueft
      else "  Jeder Code-Abschnitt wird von mindestens einem Beispiel ausgeloest")

# --- Der eigentliche Vergleich --------------------------------------------

zu_pruefen = {}
for (rfc, nummer), stellen in prosa.items():
    zu_pruefen.setdefault((rfc, nummer), []).extend(stellen)
for nummer, stellen in literale.items():
    zu_pruefen.setdefault((AUSGABE_RFC, nummer), []).extend(stellen)
for nummer, namen in tabellen.items():
    zu_pruefen.setdefault((AUSGABE_RFC, nummer), []).extend(
        "icsdoktor.py:%s" % n for n in namen)

fehler = []
print("")
print("Verweise, einzeln:")
for rfc, nummer in sorted(zu_pruefen, key=lambda p: (int(p[0]), sortier(p[1]))):
    titel = liste.get(rfc, {}).get(nummer)
    stellen = sorted(set(zu_pruefen[(rfc, nummer)]))
    if titel is None:
        fehler.append((rfc, nummer, stellen))
        print("  FEHLT  RFC %s §%-9s zeigt ins Leere — %s"
              % (rfc, nummer, ", ".join(stellen[:4])))
    else:
        print("  ok     RFC %s §%-9s %s" % (rfc, nummer, titel))

print("")
print("%d Verweise geprueft, %d ohne Entsprechung im Normtext"
      % (len(zu_pruefen), len(fehler)))
# Was die Zahl links zaehlt, steht ab 2026-08-25 in der Ausgabe und nicht nur
# im Kopf dieser Datei: Wer sie in eine Zusage schreibt, liest sie hier.
print("Gezaehlt sind verschiedene Paare aus RFC und Abschnitt, nicht "
      "Fundstellen —")
print("ein Abschnitt, den schon eine andere Stelle nennt, erhoeht diese Zahl "
      "nicht.")
if fehler:
    print("Das Werkzeug schickt an eine Stelle, die es nicht gibt.")
    sys.exit(1)
print("Jeder §-Verweis der %d gelesenen Projektdateien steht im zitierten RFC —"
      % len(DATEIEN))
if ungelesen is None:
    print("nachgerechnet, nicht behauptet. Ob das alle sind, wurde nicht "
          "ermittelt.")
elif ungelesen:
    print("nachgerechnet, nicht behauptet. Ueber die %d ungelesenen oben sagt "
          "dieser Satz nichts." % len(ungelesen))
else:
    print("nachgerechnet, nicht behauptet — und das sind alle versionierten "
          "Projektdateien.")
PYTHON
