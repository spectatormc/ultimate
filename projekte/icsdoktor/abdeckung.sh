#!/bin/sh
# Haelt jede Meldung, die dieses Werkzeug drucken kann, gegen die Beispiele.
#
#   sh projekte/icsdoktor/abdeckung.sh
#   echo "Exit-Code: $?"
#
# WOZU. pruefe.sh endet mit der Zeile "Abdeckung: alle 20 Pruefungen bis P20
# werden ausgeloest". Der Satz stimmt und er klingt nach mehr, als er misst:
# Eine Pruefung ist eine Funktion, und eine Funktion kann ein Dutzend
# verschiedener Meldungen drucken. pruefe_p04 allein hat neun Stellen, an denen
# ein Fund entsteht. Loest ein einziges Beispiel eine davon aus, gilt P04 als
# abgedeckt — und die anderen acht sind Code, den nie jemand hat laufen sehen.
#
# Genau dort sitzt der Fehler, den keiner der anderen Pruefbefehle finden kann.
# pruefe.sh vergleicht die Ausgabe byte-genau mit erwartet/; was nie gedruckt
# wird, steht in keiner Erwartung und wird von keinem Vergleich beruehrt. Ein
# Formatfehler, eine falsche Zeilennummer, ein Absturz in einem Zweig, den
# keine Datei betritt: alles gruen, bis zum ersten Anwender, der die Datei
# schickt, auf die es ankommt.
#
# WARUM ES DIESES SKRIPT GIBT, mit Beleg statt als gute Absicht. Am 2026-08-19
# gemessen, in Zyklus 38: Von den 45 Stellen, an denen icsdoktor.py einen Fund
# baut, hat keine der damals 51 Beispieldateien SECHS je erreicht — fuenf in
# pruefe_p04 (kein ':' in der Zeile; Zeile ohne Eigenschaftsnamen; Parametername
# fehlt nach ';'; kein ':' nach den Parametern; Steuerzeichen im Wert) und eine
# in pruefe_p05 (END ohne vorangehendes BEGIN). Ausgeloest verhalten sich alle
# sechs richtig — der Fehler, nach dem gesucht wurde, war nicht da. Der Befund
# ist, dass das bis dahin niemand sagen konnte. Beispiel 51 und 52 schliessen
# die Luecke; dieses Skript haelt sie zu.
#
# Es ist die dritte Messung dieser Art in diesem Projekt und dieselbe Frage wie
# in Zyklus 37: nicht "ist die Ausgabe wie erwartet", sondern "worueber sagt
# der gruene Lauf ueberhaupt etwas". fundstellen.sh stellt sie fuer die
# Paragraphenverweise, zahlen.sh fuer die Zahlen ueber den eigenen Bestand.
#
# WAS GEMESSEN WIRD, auf drei Wegen, weil ein einzelner sich nicht selbst
# widerlegen kann:
#
#   (A) statisch: jeder Aufruf von Fund(...) in icsdoktor.py, ueber den
#       Syntaxbaum geholt (ast), mit Zeile, Pruefcode und Abschnitt.
#   (B) gemessen, Zeilenspur: welche Zeilen von icsdoktor.py laufen, waehrend
#       jede Datei aus beispiele/ untersucht wird (sys.settrace).
#   (C) gemessen, Bauprotokoll: von welcher Zeile aus wirklich ein Fund-Objekt
#       gebaut wird (Frame des Aufrufers in Fund.__init__).
#
# (B) und (C) muessen dasselbe Ergebnis liefern. Eine Zeile, die laeuft, baut
# den Fund; ein gebauter Fund kommt von einer Zeile, die laeuft. Weichen sie
# voneinander ab, ist nicht das Werkzeug kaputt, sondern die Messung — und dann
# endet dieses Skript mit 2 und nicht mit 0. Ohne diesen Abgleich waere "alles
# abgedeckt" nur die Stille eines Messgeraets, das nichts sieht.
#
# (C) muss ausserdem ganz in (A) aufgehen. Baut das Werkzeug einen Fund an
# einer Zeile, die die statische Erhebung nicht kennt, hat die Erhebung ein
# Loch — dann ist "45 von 45 abgedeckt" eine Aussage ueber einen Ausschnitt,
# die sich wie eine ueber das Ganze liest. Auch das endet mit 2.
#
# JEDER GEBAUTE FUND WIRD GEDRUCKT. untersuche() sortiert die Liste und gibt
# sie zurueck, main() druckt jeden Eintrag; nichts wird unterwegs verworfen.
# Deshalb heisst "diese Stelle wurde ausgeloest" hier wirklich "diese Meldung
# steht byte-genau in erwartet/" und nicht nur "dieser Code lief".
#
# DIE ERHEBUNG (A) WIRD VOR GEBRAUCH GEPRUEFT, denn eine zu kurze Erhebung
# macht aus "45 von 45" eine Aussage ueber einen Ausschnitt. Der Syntaxbaum
# sieht nur, was "Fund(" heisst; ein zweiter Name fuer dieselbe Klasse waere
# unsichtbar. Deshalb wird zusaetzlich im Quelltext gezaehlt, und beide Zahlen
# muessen uebereinstimmen. Die bekannte Kehrseite: Ein "Fund(" in einem
# Kommentar laesst dieses Skript mit 2 enden, obwohl nichts kaputt ist. Das ist
# die gewollte Richtung — lieber einmal "ich kann es nicht sagen" als eine
# Erhebung, der man nicht ansieht, dass sie etwas uebersieht.
#
# WAS DIESES SKRIPT NICHT IST. Keine Pruefung des Werkzeugs an .ics-Dateien; es
# sagt kein Wort darueber, ob eine Meldung richtig ist, sondern nur, dass sie
# ueberhaupt einmal gedruckt wird. Es ersetzt pruefe.sh nicht, sondern misst,
# worueber pruefe.sh redet. Und es ist keine Zeilenabdeckung des ganzen Moduls:
# Hilfsfunktionen, Zweige ohne Fund und der Weg durch main() bleiben
# ungemessen. Gezaehlt wird die Meldung, nicht die Zeile.
#
# GEMESSEN WIRD NUR UEBER beispiele/, mit Absicht. Die elf fremden Eingaben
# aus korpus.tsv und RFC 5545 §4 werden zur Laufzeit geholt und aendern sich
# ohne mein Zutun; eine Abdeckung, die an ihnen haengt, waere morgen eine
# andere. beispiele/ liegt im Repo, und nur zu diesen Dateien gibt es eine
# byte-genaue Erwartung in erwartet/. Die Aussage lautet deshalb: Jede Meldung,
# die dieses Werkzeug drucken kann, ist in erwartet/ festgehalten.
#
# KEIN NETZ. Alles steht im Repo.
#
# Exit-Code: 0 jede Fundstelle wird von mindestens einem Beispiel ausgeloest
#            1 mindestens eine Fundstelle loest kein Beispiel aus
#            2 Aufruf-, Umgebungs- oder Messfehler — kein Ergebnis ist kein
#              gruenes Ergebnis

set -u

verzeichnis=$(dirname "$0")

command -v python3 >/dev/null 2>&1 || {
	echo "ABBRUCH: python3 ist nicht im PATH" >&2; exit 2; }

[ -f "$verzeichnis/icsdoktor.py" ] || {
	echo "ABBRUCH: $verzeichnis/icsdoktor.py fehlt" >&2; exit 2; }
[ -d "$verzeichnis/beispiele" ] || {
	echo "ABBRUCH: $verzeichnis/beispiele fehlt" >&2; exit 2; }

python3 - "$verzeichnis" <<'PYTHON'
"""Jede Fundstelle in icsdoktor.py gegen die Beispiele aus beispiele/ halten."""
import ast
import glob
import os
import sys

verzeichnis = sys.argv[1]
quelle = os.path.join(verzeichnis, "icsdoktor.py")

sys.path.insert(0, os.path.abspath(verzeichnis))
try:
    import icsdoktor
except Exception as fehler:                              # pragma: no cover
    sys.stderr.write("ABBRUCH: icsdoktor.py laesst sich nicht laden (%s)\n"
                     % fehler)
    sys.exit(2)

# Der Pfad, unter dem der Zeilenspur-Aufzeichner das Modul wiedererkennt. Ihn
# aus dem geladenen Modul zu nehmen statt aus dem Argument ist kein Detail:
# Waeren es zwei verschiedene Dateien, sieht die Spur nichts, und "0 von 45
# ausgeloest" waere ein Messfehler, der sich als Befund ausgibt.
modulpfad = os.path.abspath(icsdoktor.__file__)

# --- (A) statisch: jede Stelle, an der ein Fund gebaut wird -----------------

with open(quelle, encoding="utf-8") as fh:
    quelltext = fh.read()

try:
    baum = ast.parse(quelltext, filename=quelle)
except SyntaxError as fehler:
    sys.stderr.write("ABBRUCH: icsdoktor.py ist nicht lesbar (%s)\n" % fehler)
    sys.exit(2)


def _literal(knoten, stelle):
    """Das n-te Argument, wenn es eine Zeichenkette im Klartext ist."""
    if len(knoten.args) > stelle and isinstance(knoten.args[stelle],
                                                ast.Constant):
        wert = knoten.args[stelle].value
        if isinstance(wert, str):
            return wert
    return None


stellen = {}
for knoten in ast.walk(baum):
    if not isinstance(knoten, ast.Call):
        continue
    if getattr(knoten.func, "id", None) != "Fund":
        continue
    stellen[knoten.lineno] = {
        "bis": knoten.end_lineno or knoten.lineno,
        "code": _literal(knoten, 2),
        "abschnitt": _literal(knoten, 4),
    }

if not stellen:
    sys.stderr.write("ABBRUCH: kein einziger Aufruf von Fund(...) in "
                     "icsdoktor.py gefunden\n")
    sys.exit(2)

# Gegenprobe zur Erhebung selbst. Der Syntaxbaum sieht nur, was "Fund(" heisst;
# ein zweiter Name fuer dieselbe Klasse waere unsichtbar. Gezaehlt wird deshalb
# auch im Text — die Klassendefinition "class Fund(object)" abgezogen. Gehen
# die Zahlen auseinander, wird nicht weitergerechnet.
im_text = quelltext.count("Fund(") - quelltext.count("class Fund(")
if im_text != len(stellen):
    sys.stderr.write(
        "ABBRUCH: die Erhebung hat ein Loch — der Syntaxbaum kennt %d "
        "Aufrufe von Fund(...), im Quelltext stehen %d.\n"
        % (len(stellen), im_text))
    sys.exit(2)


def zustaendig(zeile):
    """Die Fundstelle, in deren Zeilenbereich diese Zeile faellt."""
    for anfang, daten in stellen.items():
        if anfang <= zeile <= daten["bis"]:
            return anfang
    return None


# --- (C) Bauprotokoll: Fund.__init__ merkt sich den Aufrufer ----------------

gebaut_an = set()
urspruenglich = icsdoktor.Fund.__init__


def protokollierend(self, *args, **kwargs):
    gebaut_an.add(sys._getframe(1).f_lineno)
    return urspruenglich(self, *args, **kwargs)


icsdoktor.Fund.__init__ = protokollierend

# --- (B) Zeilenspur ---------------------------------------------------------

gelaufen = set()


def spur(frame, ereignis, arg):
    if frame.f_code.co_filename != modulpfad:
        return None
    if ereignis == "line":
        gelaufen.add(frame.f_lineno)
    return spur


dateien = sorted(glob.glob(os.path.join(verzeichnis, "beispiele", "*.ics")))
if not dateien:
    sys.stderr.write("ABBRUCH: keine einzige Datei in beispiele/\n")
    sys.exit(2)

funde_gesamt = 0
sys.settrace(spur)
try:
    for pfad in dateien:
        with open(pfad, "rb") as fh:
            rohdaten = fh.read()
        try:
            funde_gesamt += len(icsdoktor.untersuche(rohdaten))
        except Exception as fehler:
            sys.settrace(None)
            sys.stderr.write("ABBRUCH: %s bringt das Werkzeug zum Absturz "
                             "(%s: %s)\n"
                             % (os.path.basename(pfad),
                                type(fehler).__name__, fehler))
            sys.exit(2)
finally:
    sys.settrace(None)
    icsdoktor.Fund.__init__ = urspruenglich

if not gelaufen:
    sys.stderr.write("ABBRUCH: die Zeilenspur hat keine einzige Zeile von "
                     "icsdoktor.py gesehen — gemessen wurde nichts\n")
    sys.exit(2)

# --- Die beiden Messungen gegeneinander -------------------------------------

# (C) ganz in (A): jeder gebaute Fund gehoert zu einer erhobenen Stelle.
fremd = sorted(z for z in gebaut_an if zustaendig(z) is None)
if fremd:
    sys.stderr.write(
        "ABBRUCH: an Zeile %s wird ein Fund gebaut, den die statische "
        "Erhebung nicht kennt. Solange das so ist, sagt eine Abdeckung ueber "
        "die erhobenen Stellen nichts ueber das Ganze.\n"
        % ", ".join(str(z) for z in fremd))
    sys.exit(2)

per_spur = set(a for a in stellen if any(z in gelaufen
                                         for z in range(a, stellen[a]["bis"] + 1)))
per_protokoll = set(zustaendig(z) for z in gebaut_an)

if per_spur != per_protokoll:
    nur_spur = sorted(per_spur - per_protokoll)
    nur_prot = sorted(per_protokoll - per_spur)
    sys.stderr.write(
        "ABBRUCH: die beiden Messungen widersprechen sich. Nur in der "
        "Zeilenspur: %s. Nur im Bauprotokoll: %s. Nicht das Werkzeug ist "
        "damit auffaellig, sondern die Messung.\n"
        % (nur_spur or "keine", nur_prot or "keine"))
    sys.exit(2)

# --- Ergebnis ---------------------------------------------------------------

ausgeloest = per_spur
offen = sorted(a for a in stellen if a not in ausgeloest)

print("%d Beispieldateien, %d Funde gedruckt" % (len(dateien), funde_gesamt))
print("%d Stellen bauen einen Fund, %d davon loest mindestens ein Beispiel aus"
      % (len(stellen), len(ausgeloest)))
print("")

if offen:
    for anfang in offen:
        daten = stellen[anfang]
        print("NIE AUSGELOEST  icsdoktor.py:%-5d %-6s %s"
              % (anfang,
                 daten["code"] or "?",
                 "§" + daten["abschnitt"] if daten["abschnitt"]
                 else "Abschnitt aus einer Variablen"))
    print("")
    print("%d von %d Fundstellen erreicht keine Beispieldatei. Was nie "
          "gedruckt wird, steht in keiner Erwartung — pruefe.sh kann darueber "
          "nichts sagen." % (len(offen), len(stellen)))
    sys.exit(1)

print("Jede Meldung, die dieses Werkzeug drucken kann, loest mindestens eine "
      "Beispieldatei aus")
print("und steht damit byte-genau in erwartet/ — gemessen, nicht behauptet.")
sys.exit(0)
PYTHON
