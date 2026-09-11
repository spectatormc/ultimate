#!/bin/sh
# Ordnet jede Meldung einer Ursachenklasse zu und misst Gegenproben.
#
#   sh projekte/icsdoktor/ursachen.sh              # P31 ueber beispiele/
#   sh projekte/icsdoktor/ursachen.sh VERZEICHNIS  # P31 ueber einen Fremdkorpus
#   sh projekte/icsdoktor/ursachen.sh --p32 [VERZEICHNIS]   # dasselbe fuer P32
#   echo "Exit-Code: $?"
#
# ZWEI PRUEFKENNUNGEN, EIN SKRIPT. Der Schalter --p32 kam am 2026-09-10 dazu,
# als die Mission "Der unzulaessige Regelteil" unter Punkt 3b dieselbe
# Zuordnung fuer P32 verlangte. Ohne Schalter bleibt alles, wie es war: P31.
# Was fuer P32 gilt, steht weiter unten im eigenen Kopf ab "DIE KLASSEN VON
# P32"; die Saetze bis dahin beschreiben P31.
#
# WOZU. Die Mission "Der unaufgeloeste Verweis" (state/missionen/, 2026-09-08)
# verlangt unter Punkt 3b, dass JEDE P31-Meldung ueber den Fremdkorpus einer
# maschinell reproduzierbaren Ursachenklasse zugeordnet wird und die Zuordnung
# als Skript im Repo liegt — nicht als Tabelle in einem Journaleintrag, die
# niemand nachrechnen kann. Das ist dieses Skript.
#
# WARUM DIE KLASSE NICHT AUS icsdoktor.py KOMMT. Wer die Meldung mit dem
# Werkzeug erklaert, das sie erzeugt hat, hat zweimal dasselbe hingeschrieben.
# Dieses Skript entfaltet die Datei deshalb selbst (§3.1, getrennt wird am LF,
# nie am blanken CR), trennt Name, Parameter und Wert selbst und sammelt die
# VTIMEZONE-Komponenten selbst ein. Aus icsdoktor.py kommt genau eines: die
# Liste der Meldungen, ueber die geurteilt wird.
#
# DIE VIER KLASSEN, festgelegt bevor die erste Meldung eingeordnet wurde:
#
#   K1  Die Datei enthaelt ueberhaupt keine VTIMEZONE-Komponente.
#   K2  VTIMEZONE-Komponenten sind da, keine traegt diesen TZID-Wert.
#   K3  Eine VTIMEZONE ist da, traegt aber gar keine TZID-Eigenschaft.
#       §3.6.5 nennt 'tzid' REQUIRED (Zeile 3466 des Normtexts) — eine solche
#       Komponente kann keinen Verweis aufloesen.
#   K4  Der Name steht als TZID-Eigenschaftszeile in der Datei, aber ausserhalb
#       jeder VTIMEZONE. Ein Verweis darauf ist unaufgeloest, denn der Normtext
#       verlangt die Komponente, nicht die Zeile.
#
# ALLE VIER LOESEN SICH AN DEMSELBEN SATZ AUF, der im Normtext zweimal
# woertlich steht — §3.2.19 Zeilen 1522-1525 und §3.6.5 Zeilen 3613-3615:
# "An individual "VTIMEZONE" calendar component MUST be specified for each
# unique "TZID" parameter value specified in the iCalendar object."
#
# WAS DIESES SKRIPT NICHT ENTSCHEIDET. Ob eine Meldung ein Fehlalarm ist, ist
# ein Urteil am Normtext und keine Zahl; dieses Skript liefert dafuer die drei
# Gegenproben, die ein Fehlalarm reissen muesste:
#
#   1. Keine Meldung ohne Klasse.
#   2. Keine Meldung an einem TZID mit SOLIDUS-Praefix. Zeilen 1533-1535:
#      der Praefix verweist in eine global definierte Registry, nicht in diese
#      Datei.
#   3. Keine Meldung in einer Datei, die eine passende VTIMEZONE enthaelt.
#
# Reisst eine davon, endet das Skript mit Exit 2. Dazu wird gerichtet gezaehlt,
# wie viele Kandidaten STUMM geblieben sind — "schlaegt nicht an, wo nichts
# ist" ist kein Ergebnis, und diese Zahl trennt den einen Fall vom anderen.
#
# RFC 7809 WIRD NICHT GEPRUEFT. Er lockert den Zwang fuer CalDAV-Server mit
# "time zones by reference"; am 2026-09-09 um 11:29:59 UTC geholt (HTTP 200,
# 28902 Bytes, 731 Zeilen) und gelesen: Zeile 9 sagt "Updates: 4791", er
# aendert CalDAV und nicht RFC 5545, und seine Lockerung haengt an einem
# Header der UEBERTRAGUNG (Zeilen 219-221, 246-247). Eine .ics auf der
# Festplatte traegt den nicht. Aus den Bytes einer Datei ist dieser Zweig
# weder zu bestaetigen noch auszuschliessen — er ist deshalb KEINE
# Ursachenklasse und wird auch nicht zu einer erklaert.
#
# OHNE ARGUMENT laeuft das Skript ueber beispiele/ — dort liegen die zehn
# Faelle aus Punkt 1 der Mission, fuenf gemeldete und fuenf stumme. Den
# Fremdkorpus holt man sich mit
#   git clone -q --depth 1 https://github.com/libical/libical.git
# (ebenso collective/icalendar, kewisch/ical.js, sabre-io/vobject) nach /tmp
# und uebergibt das Verzeichnis; im Arbeitsbaum hat er nichts zu suchen.
#
# ------------------------------------------------------------------------
# DIE KLASSEN VON P32, festgelegt bevor die erste Meldung eingeordnet wurde.
#
# P32 wirft zwei Schweregrade, und die Klassen folgen genau dieser Trennung:
#
#   G  Eine ABNF-Produktion aus §3.3.10 ist gebrochen        -> FEHLER
#   P  Die Produktion haelt, nur ein Prosasatz "Valid values are ..." ist
#      verletzt                                              -> HINWEIS
#
#   G1  Das Element ist leer — zwischen zwei Kommas oder hinter dem "="
#       steht nichts. Jede der zwoelf Produktionen verlangt mindestens ein
#       Zeichen.
#   G2  Das Element ist keine Ziffernfolge: nach dem optionalen Vorzeichen
#       steht etwas anderes als ASCII-Ziffern. Auch ein Vorzeichen dort, wo
#       die Produktion keines vorsieht, faellt hierher — "-1" ist fuer
#       monthnum = 1*2DIGIT (2209) schlicht keine Ziffernfolge.
#   G3  Die Ziffernfolge ist laenger, als die Produktion zulaesst: mehr als
#       zwei Stellen bei 1*2DIGIT, mehr als drei bei 1*3DIGIT (2201).
#   G4  BYDAY oder WKST: das Element endet nicht auf eines der sieben
#       weekday-Literale aus Zeile 2180.
#   G5  BYDAY: der Wochentag steht, aber der VORHANDENE Zahlteil davor ist
#       kein ordwk (2172, 2178). Der Zahlteil ist optional — die eckigen
#       Klammern in weekdaynum —, ein fehlender ist also kein Fund.
#   P1  Der Wert ist 0, wo der Prosasatz bei 1 beginnt.
#   P2  Der Betrag des Werts liegt ueber der oberen Prosagrenze.
#
# WO JEDE KLASSE SICH AUFLOEST. G1 bis G5 an der ABNF in den Zeilen
# 2138-2213; sie ist nach RFC 5234 die Sprache, in der RFC 5545 seine Syntax
# schreibt, und braucht kein MUST daneben. P1 und P2 an den zehn Prosazeilen
# 2247 (INTERVAL, "a positive integer") und 2277, 2279, 2280, 2319, 2325,
# 2332, 2347, 2370 ("Valid values are ..."). Fuer WKST nennt 2350 dieselben
# sieben Tage wie die Produktion; dort kann kein P-Fall entstehen.
#
# WIE DIE ZUORDNUNG UNABHAENGIG BLEIBT. Die Produktionen und die Prosagrenzen
# stehen unten ein zweites Mal, aus dem Normtext abgeschrieben und nicht aus
# icsdoktor.py geholt. Dieses Skript entscheidet fuer JEDES Element selbst, ob
# und mit welcher Klasse es zu melden waere, und legt das Ergebnis erst
# danach neben die Meldungsliste des Werkzeugs. Stimmen die beiden je Zeile
# und Regelteil nicht ueberein, endet das Skript mit Exit 2 — das ist die
# Gegenprobe, und sie ist schaerfer als "jede Meldung hat eine Klasse".
#
# EINE STELLE IST BEWUSST GLEICH: das ADRESSIEREN. Der Wert wird am Semikolon
# geteilt, der Name am ersten "=", der Rest getrimmt, je Regelteilname zaehlt
# der ERSTE Treffer, Listen werden am Komma geteilt. Das ist die Toleranz des
# Werkzeugs und nicht die ABNF; ohne sie zeigen beide Leser auf verschiedene
# Elemente und nichts liesse sich vergleichen. Unabhaengig ist das URTEIL
# ueber ein Element, nicht die Frage, welches Element gemeint ist.
#
# STUMM BLEIBT HIER, WAS AUCH IN P32 STUMM BLEIBT: FREQ, UNTIL, unbekannte
# Regelteilnamen, ein zweiter Regelteil desselben Namens, COUNT ohne
# Prosabereich (2272-2274) und der BEREICH des BYDAY-Zahlteils, der nur im
# ABNF-Kommentar von Zeile 2178 steht. Die sieben Vertraeglichkeitsfaelle der
# Missionsdatei werden gerichtet gegengemessen und nicht bloss ausgelassen.
#
# RSCALE, NACHGETRAGEN AM 2026-09-11. Steht der Regelteil RSCALE im Wert, dann
# schweigt auch dieser Zweitleser zu jedem Prosabereich und laesst BYMONTH auf
# ein "L" enden — RFC 7529 Zeile 293 ("When "RSCALE" is present, the other
# changes to "RRULE" are:"), 295-297 (Bereiche kommen vom RSCALE-Wert) und
# 324 (monthnum = 1*2DIGIT ["L"]). Der Normtext wurde dafuer am 2026-09-11 um
# 04:45:15 UTC geholt (HTTP 200, 43124 Bytes, 1179 Zeilen).
#
# Das ist die eine Stelle, an der ein Zweitleser einer Aenderung des Werkzeugs
# FOLGT statt sie zu pruefen, und sie ist die unangenehme Stelle dieses
# Schalters: Wo beide dieselbe Lockerung eingebaut bekommen, faellt ein
# gemeinsamer Irrtum in der Lockerung nicht mehr auf. Was weiterhin unabhaengig
# bleibt, ist alles andere — die Grammatik ueber dem "L", die Bereiche ohne
# RSCALE und jedes Schweigen an jeder anderen Stelle. Die Gegenprobe gegen die
# Lockerung selbst leisten die vier Beispieldateien 161 bis 164 und die
# Korpusmessung, nicht dieses Skript.
# ------------------------------------------------------------------------
set -eu

verzeichnis=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
kennung=P31
if [ $# -gt 0 ] && [ "$1" = "--p32" ]; then
	kennung=P32
	shift
elif [ $# -gt 0 ] && [ "$1" = "--p31" ]; then
	shift
fi
ziel=${1:-"$verzeichnis/beispiele"}

command -v python3 >/dev/null 2>&1 || {
	echo "ABBRUCH: python3 ist nicht im PATH" >&2; exit 2; }
[ -d "$ziel" ] || {
	echo "ABBRUCH: $ziel ist kein Verzeichnis" >&2; exit 2; }

if [ "$kennung" = P32 ]; then
	python3 - "$verzeichnis" "$ziel" <<'PYTHON32'
import os
import re
import sys

verzeichnis, ziel = sys.argv[1], sys.argv[2]
sys.path.insert(0, verzeichnis)
import icsdoktor as D


def entfalte(rohbytes):
    """Eigene Entfaltung, §3.1: getrennt wird am LF, nie am blanken CR."""
    text = rohbytes.decode("utf-8", "replace")
    if text[:1] == u"﻿":
        text = text[1:]
    logisch = []
    for i, zeile in enumerate(text.split("\n")):
        if zeile.endswith("\r"):
            zeile = zeile[:-1]
        if zeile[:1] in (" ", "\t") and logisch:
            logisch[-1][1] += zeile[1:]
        else:
            logisch.append([i + 1, zeile])
    return logisch


def name_und_wert(zeile):
    """(NAME, wert). Geteilt am ersten Doppelpunkt ausserhalb von "..."."""
    in_zitat, schnitt, name_ende = False, -1, None
    for i, zeichen in enumerate(zeile):
        if zeichen == '"':
            in_zitat = not in_zitat
        elif not in_zitat and zeichen == ";" and name_ende is None:
            name_ende = i
        elif not in_zitat and zeichen == ":":
            schnitt = i
            break
    if schnitt < 0:
        return None, None
    kopf = zeile[:name_ende if name_ende is not None else schnitt]
    return kopf.strip().upper(), zeile[schnitt + 1:]


# Die zwoelf Regelteile in der Reihenfolge der ABNF-Aufzaehlung 2138-2151.
# FREQ und UNTIL fehlen: P29 und P17/P18 pruefen sie.
ZWOELF = ("COUNT", "INTERVAL", "BYSECOND", "BYMINUTE", "BYHOUR", "BYDAY",
          "BYMONTHDAY", "BYYEARDAY", "BYWEEKNO", "BYMONTH", "BYSETPOS",
          "WKST")
LISTEN = {"BYSECOND", "BYMINUTE", "BYHOUR", "BYDAY", "BYMONTHDAY",
          "BYYEARDAY", "BYWEEKNO", "BYMONTH", "BYSETPOS"}
WEEKDAY = ("SU", "MO", "TU", "WE", "TH", "FR", "SA")

# Zweite, unabhaengige Abschrift aus dem Normtext.
#   stellen  hoechste Ziffernzahl der Produktion, 0 = 1*DIGIT ohne Schranke
#   vorz     laesst die Produktion [plus / minus] zu
#   unten/oben/negativ  der Prosabereich, None wo die Prosa keinen nennt
PRODUKTION = {
    "COUNT":      (0, False, None),               # 1*DIGIT, Zeile 2140
    "INTERVAL":   (0, False, (1, None, False)),   # 1*DIGIT 2141, Prosa 2247
    "BYSECOND":   (2, False, (0, 60, False)),     # seconds 2160, Prosa 2277
    "BYMINUTE":   (2, False, (0, 59, False)),     # minutes 2164, Prosa 2279
    "BYHOUR":     (2, False, (0, 23, False)),     # hour 2168, Prosa 2280
    "BYMONTHDAY": (2, True,  (1, 31, True)),      # ordmoday 2195, Prosa 2319
    "BYYEARDAY":  (3, True,  (1, 366, True)),     # ordyrday 2201, Prosa 2325
    "BYWEEKNO":   (2, True,  (1, 53, True)),      # ordwk 2178, Prosa 2332
    "BYMONTH":    (2, False, (1, 12, False)),     # monthnum 2209, Prosa 2347
    "BYSETPOS":   (3, True,  (1, 366, True)),     # setposday 2213, Prosa 2370
}


def teil(wert, gesucht):
    """Erster Wert des Regelteils, getrimmt. Ohne Treffer None."""
    for stueck in (wert or "").split(";"):
        name, gleich, rest = stueck.partition("=")
        if gleich and name.strip().upper() == gesucht:
            return rest.strip()
    return None


def elemente(wert, name):
    roh = teil(wert, name)
    if roh is None:
        return None
    return roh.split(",") if name in LISTEN else [roh]


def ziffern(text, stellen, vorz):
    """(wert, None) bei gueltiger Produktion, sonst (None, Klasse)."""
    rest = text
    if vorz and rest[:1] in ("+", "-"):
        rest = rest[1:]
    if not rest:
        return None, "G1"
    if not rest.isdigit() or not rest.isascii():
        return None, "G2"
    if stellen and len(rest) > stellen:
        return None, "G3"
    zahl = int(rest)
    return -zahl if text[:1] == "-" else zahl, None


def urteil(name, element, mit_rscale=False):
    """Was DIESES Skript zu einem Element sagt: Klasse oder None.

    `mit_rscale` heisst: im selben RRULE-Wert steht der Regelteil RSCALE.
    Dann gilt RFC 7529 — BYMONTH darf auf ein "L" enden (Zeile 324), und
    kein Prosabereich aus RFC 5545 wird mehr behauptet (Zeile 295-297).
    """
    if name == "WKST":
        return None if element.upper() in WEEKDAY else "G4"
    if name == "BYDAY":
        if element[-2:].upper() not in WEEKDAY:
            return "G4"
        if not element[:-2]:
            return None                      # Zahlteil ist optional (2172)
        _zahl, klasse = ziffern(element[:-2], 2, True)
        return "G5" if klasse else None      # Bereich steht nur in 2178
    stellen, vorz, prosa = PRODUKTION[name]
    if mit_rscale and name == "BYMONTH" and element[-1:].upper() == "L":
        element = element[:-1]               # monthnum, RFC 7529 Zeile 324
    zahl, klasse = ziffern(element, stellen, vorz)
    if klasse:
        return klasse
    if mit_rscale:
        return None                          # RFC 7529 Zeile 295-297
    if prosa is None:
        return None
    unten, oben, negativ = prosa
    betrag = abs(zahl) if negativ else zahl
    if zahl == 0 and unten > 0:
        return "P1"
    if oben is not None and betrag > oben:
        return "P2"
    if betrag < unten:
        return "P1"
    return None


KLASSENTEXT = {
    "G1": "G1 Element leer",
    "G2": "G2 keine Ziffernfolge",
    "G3": "G3 Ziffernfolge zu lang",
    "G4": "G4 kein Wochentag",
    "G5": "G5 Zahlteil kein ordwk",
    "P1": "P1 Null unter der Prosagrenze",
    "P2": "P2 ueber der oberen Prosagrenze",
}

# Die sieben Vertraeglichkeitsfaelle der Missionsdatei. Jeder nennt den
# Regelteil, den er ANGREIFT — gerichtet gemessen wird, dass P32 genau dieses
# Element nicht meldet, obwohl der Fall in der Datei steht.
VERTRAEGLICH = (
    ("V1 BYDAY mit Zahlteil, FREQ weder MONTHLY noch YEARLY (2312-2314)"),
    ("V2 BYDAY mit Zahlteil bei FREQ=YEARLY neben BYWEEKNO (2314-2316)"),
    ("V3 BYMONTHDAY neben FREQ=WEEKLY (2321-2322)"),
    ("V4 BYYEARDAY neben FREQ DAILY/WEEKLY/MONTHLY (2328-2329)"),
    ("V5 BYWEEKNO neben einem anderen FREQ als YEARLY (2338-2339)"),
    ("V6 BYSETPOS ohne einen zweiten BYxxx-Regelteil (2371-2372)"),
    ("V7 BYSECOND/BYMINUTE/BYHOUR an einem DTSTART vom Typ DATE (2281-2283)"),
)
BYXXX = ("BYSECOND", "BYMINUTE", "BYHOUR", "BYDAY", "BYMONTHDAY",
         "BYYEARDAY", "BYWEEKNO", "BYMONTH", "BYSETPOS")

MELDUNG = re.compile(u'^der Regelteil ([A-Z]+) trägt ')


dateien = []
for pfad, _unter, namen in os.walk(ziel):
    for name in sorted(namen):
        if name.endswith(".ics"):
            dateien.append(os.path.join(pfad, name))
dateien.sort()

klassen = {}
zeilen = []
ohne_klasse = []
vertraeglich_gemeldet = []
vertraeglich = {}
p04_grenze = []
kandidaten = gemeldet = 0
schweregrad_falsch = []

for pfad in dateien:
    rohbytes = open(pfad, "rb").read()
    rel = os.path.relpath(pfad, ziel)
    logisch = entfalte(rohbytes)

    # V7 braucht den Typ des DTSTART. Traegt die Datei irgendwo ein DTSTART
    # mit VALUE=DATE oder einem Wert aus genau acht Ziffern, ist der Fall
    # moeglich; genauer laesst er sich ohne Komponentenbaum nicht fassen, und
    # zu weit gefasst ist hier die sichere Richtung — die Gegenprobe wird
    # dadurch strenger und nie milder.
    datum_dtstart = False
    for _nr, zeile in logisch:
        name, wert = name_und_wert(zeile)
        if name != "DTSTART":
            continue
        kopf = zeile.split(":", 1)[0].upper()
        klar = (wert or "").strip()
        if "VALUE=DATE" in kopf and "VALUE=DATE-TIME" not in kopf:
            datum_dtstart = True
        elif len(klar) == 8 and klar.isdigit():
            datum_dtstart = True

    # Eigenes Urteil, Zeile fuer Zeile, Regelteil fuer Regelteil.
    eigen = {}
    still = {}
    for nr, zeile in logisch:
        name, wert = name_und_wert(zeile)
        if name != "RRULE":
            continue
        freq = (teil(wert, "FREQ") or "").upper()
        mit_rscale = teil(wert, "RSCALE") is not None
        hat = dict((n, elemente(wert, n)) for n in ZWOELF)
        for rteil in ZWOELF:
            liste = hat[rteil]
            if liste is None:
                continue
            for element in liste:
                kandidaten += 1
                klasse = urteil(rteil, element, mit_rscale)
                if klasse:
                    eigen.setdefault((nr, rteil), []).append((element, klasse))
        # Gerichtet: welche Elemente die sieben Faelle angreifen. Gezaehlt
        # wird ihr Vorkommen; verlangt ist, dass die nach dem EIGENEN Vorrat
        # gueltigen davon stumm bleiben. Ein Element, das zugleich einen
        # unzulaessigen Wert traegt (FREQ=DAILY;BYWEEKNO=54), wird wegen des
        # Werts gemeldet und nicht wegen der Vertraeglichkeit — P32 liest FREQ
        # nirgends. Es zaehlt deshalb getrennt und ist kein Fehlalarm.
        treffer = []
        if hat["BYDAY"]:
            mit_zahl = [e for e in hat["BYDAY"] if e[:-2]]
            if mit_zahl and freq not in ("MONTHLY", "YEARLY"):
                treffer.append((0, "BYDAY", mit_zahl))
            if mit_zahl and freq == "YEARLY" and hat["BYWEEKNO"]:
                treffer.append((1, "BYDAY", mit_zahl))
        if hat["BYMONTHDAY"] and freq == "WEEKLY":
            treffer.append((2, "BYMONTHDAY", hat["BYMONTHDAY"]))
        if hat["BYYEARDAY"] and freq in ("DAILY", "WEEKLY", "MONTHLY"):
            treffer.append((3, "BYYEARDAY", hat["BYYEARDAY"]))
        if hat["BYWEEKNO"] and freq and freq != "YEARLY":
            treffer.append((4, "BYWEEKNO", hat["BYWEEKNO"]))
        if hat["BYSETPOS"] and not any(hat[b] for b in BYXXX
                                       if b != "BYSETPOS"):
            treffer.append((5, "BYSETPOS", hat["BYSETPOS"]))
        if datum_dtstart:
            for rteil in ("BYSECOND", "BYMINUTE", "BYHOUR"):
                if hat[rteil]:
                    treffer.append((6, rteil, hat[rteil]))
        for nummer, rteil, liste in treffer:
            for element in liste:
                vertraeglich[nummer] = vertraeglich.get(nummer, [0, 0])
                if urteil(rteil, element, mit_rscale) is None:
                    vertraeglich[nummer][0] += 1
                    still.setdefault((nr, rteil), []).append(
                        (nummer, element))
                else:
                    vertraeglich[nummer][1] += 1

    # Erst jetzt die Meldungsliste des Werkzeugs daneben legen.
    werkzeug = {}
    p04_zeilen = set()
    for fund in D.untersuche(rohbytes):
        if fund.code == "P04" and fund.schwere == D.FEHLER:
            p04_zeilen.add(fund.zeile)
        if fund.code != "P32":
            continue
        gemeldet += 1
        treffer = MELDUNG.match(fund.text)
        if not treffer:
            ohne_klasse.append((rel, fund.zeile, fund.text))
            continue
        werkzeug.setdefault((fund.zeile, treffer.group(1)), []).append(
            fund.schwere)

    # Gerichtet, und ohne sich auf den Vergleich darunter zu verlassen: an
    # jeder Zeile, an der ein Vertraeglichkeitsfall steht, duerfen genau so
    # viele Meldungen stehen, wie dort Elemente einen unzulaessigen WERT
    # tragen. Jede weitere waere eine, die den Fall selbst meldet.
    for (nr, rteil), belegt in sorted(still.items()):
        seine = len(werkzeug.get((nr, rteil), []))
        meine = len(eigen.get((nr, rteil), []))
        if seine > meine:
            vertraeglich_gemeldet.append(
                (rel, nr, belegt[0][0], rteil, belegt[0][1]))

    for schluessel in sorted(set(list(eigen) + list(werkzeug))):
        meine = eigen.get(schluessel, [])
        seine = werkzeug.get(schluessel, [])
        if len(meine) != len(seine):
            # DIE P04-GRENZE, benannt statt weggelassen. Steht in derselben
            # Zeile ein P04-FEHLER, hat das Werkzeug die Zeile nie als RRULE
            # adressiert: lz.name wird erst gesetzt, wenn P04 durchlaeuft, und
            # ein Steuerzeichen im Wert bricht schon dort ab. Dann fehlt die
            # Meldung nicht still — an derselben Zeilennummer steht ein
            # FEHLER —, und es ist kein Urteil von P32, das hier abwiche.
            # Meldet das Werkzeug MEHR als dieses Skript, gilt die Ausnahme
            # nicht; das waere ein Fehlalarm und bleibt ein Abbruch.
            if len(seine) < len(meine) and schluessel[0] in p04_zeilen:
                p04_grenze.append((rel, schluessel[0], schluessel[1],
                                   len(meine)))
                continue
            ohne_klasse.append((rel, schluessel[0],
                                "%s: %d Meldungen, %d eigene Urteile"
                                % (schluessel[1], len(seine), len(meine))))
            continue
        for (element, klasse), schwere in zip(meine, seine):
            erwartet = D.FEHLER if klasse[0] == "G" else D.HINWEIS
            if schwere != erwartet:
                schweregrad_falsch.append(
                    (rel, schluessel[0], schluessel[1], element, klasse,
                     schwere))
            klassen[klasse] = klassen.get(klasse, 0) + 1
            zeilen.append("%s\tZeile %d\t%s=%s\t%s"
                          % (rel, schluessel[0], schluessel[1], element,
                             KLASSENTEXT[klasse]))

for zeile in zeilen:
    print(zeile)
if zeilen:
    print("")
print("%d Dateien gelesen, %d P32-Meldungen." % (len(dateien), gemeldet))
for klasse in sorted(klassen):
    print("  %-34s %d" % (KLASSENTEXT[klasse], klassen[klasse]))

print("")
print("%d Meldungen ohne Ursachenklasse" % len(ohne_klasse))
print("%d Meldungen mit falschem Schweregrad zur Klasse"
      % len(schweregrad_falsch))
print("%d Meldungen an einem der sieben Vertraeglichkeitsfaelle"
      % len(vertraeglich_gemeldet))
for eintrag in ohne_klasse:
    print("  OHNE   %s Zeile %d: %s" % eintrag)
for eintrag in schweregrad_falsch:
    print("  SCHWER %s Zeile %d: %s=%s ist %s, gemeldet als %s"
          % eintrag)
for eintrag in vertraeglich_gemeldet:
    print("  VERTR  %s Zeile %d: %s bei %s=%s"
          % (eintrag[0], eintrag[1], VERTRAEGLICH[eintrag[2]], eintrag[3],
             eintrag[4]))

print("")
print("%d Regelteile an der P04-Grenze: die Zeile traegt ein Steuerzeichen, "
      "das Werkzeug" % len(p04_grenze))
print("hat sie deshalb nie als RRULE adressiert und meldet an derselben "
      "Zeilennummer P04.")
for eintrag in p04_grenze:
    print("  P04    %s Zeile %d: %s, %d eigene Urteile ohne Meldung"
          % eintrag)

print("")
print("Gerichtet gezaehlt, damit Schweigen ein Ergebnis ist und kein "
      "Ausbleiben:")
print("  %d Elemente in den zwoelf Regelteilen, davon %d gemeldet und %d "
      "stumm" % (kandidaten, gemeldet, kandidaten - gemeldet))
print("")
print("Die sieben ausgeschlossenen Vertraeglichkeitsfaelle, einzeln:")
for nummer, text in enumerate(VERTRAEGLICH):
    stumm, wegen_wert = vertraeglich.get(nummer, [0, 0])
    print("  %-62s %4d stumm, %3d wegen des eigenen Werts gemeldet"
          % (text, stumm, wegen_wert))

if ohne_klasse or schweregrad_falsch or vertraeglich_gemeldet:
    print("")
    print("ABBRUCH: eine der drei Gegenproben ist gerissen.")
    sys.exit(2)
PYTHON32
	exit 0
fi

python3 - "$verzeichnis" "$ziel" <<'PYTHON'
import os
import sys

verzeichnis, ziel = sys.argv[1], sys.argv[2]
sys.path.insert(0, verzeichnis)
import icsdoktor as D


def entfalte(rohbytes):
    """Eigene Entfaltung. §3.1 nennt CRLF als Zeilenende; ein blankes CR ist
    ein Fehler IN der Zeile und keine Trennstelle. Zurueck kommen Paare aus
    physischer Anfangszeile und entfaltetem Text."""
    text = rohbytes.decode("utf-8", "replace")
    if text[:1] == u"﻿":
        text = text[1:]
    logisch = []
    for i, zeile in enumerate(text.split("\n")):
        if zeile.endswith("\r"):
            zeile = zeile[:-1]
        if zeile[:1] in (" ", "\t") and logisch:
            logisch[-1][1] += zeile[1:]
        else:
            logisch.append([i + 1, zeile])
    return logisch


def zerlege(zeile):
    """(NAME, [(PARAM, [werte])], wert). Getrennt wird am ersten Doppelpunkt
    ausserhalb von Anfuehrungszeichen, dann am Semikolon, dann am Komma."""
    in_zitat, schnitt = False, -1
    for i, zeichen in enumerate(zeile):
        if zeichen == '"':
            in_zitat = not in_zitat
        elif zeichen == ":" and not in_zitat:
            schnitt = i
            break
    if schnitt < 0:
        return None, [], None
    kopf, wert = zeile[:schnitt], zeile[schnitt + 1:]
    teile, akt, in_zitat = [], "", False
    for zeichen in kopf:
        if zeichen == '"':
            in_zitat = not in_zitat
            akt += zeichen
        elif zeichen == ";" and not in_zitat:
            teile.append(akt)
            akt = ""
        else:
            akt += zeichen
    teile.append(akt)
    params = []
    for teil in teile[1:]:
        if "=" not in teil:
            continue
        pname, roh = teil.split("=", 1)
        werte, akt, in_zitat = [], "", False
        for zeichen in roh:
            if zeichen == '"':
                in_zitat = not in_zitat
            elif zeichen == "," and not in_zitat:
                werte.append(akt)
                akt = ""
            else:
                akt += zeichen
        werte.append(akt)
        params.append((pname.strip().upper(), werte))
    return teile[0].strip().upper(), params, wert


def bestand(logisch):
    """Was die Datei an Zeitzonen wirklich hergibt: ob sie ueberhaupt eine
    VTIMEZONE oeffnet, welche TZID-Namen INNERHALB einer stehen, und welche
    TZID-Zeilen es sonst noch gibt."""
    tiefe, hat_begin = 0, False
    in_komponente, ueberall = set(), set()
    for _nr, zeile in logisch:
        name, _params, wert = zerlege(zeile)
        oben = (wert or "").strip().upper()
        if name == "BEGIN" and oben == "VTIMEZONE":
            tiefe += 1
            hat_begin = True
        elif name == "END" and oben == "VTIMEZONE":
            tiefe = max(0, tiefe - 1)
        elif name == "TZID":
            klar = (wert or "").strip()
            if klar:
                ueberall.add(klar.lower())
                if tiefe > 0:
                    in_komponente.add(klar.lower())
    return hat_begin, in_komponente, ueberall


def tzid_werte(logisch, nr):
    werte = []
    for anfang, zeile in logisch:
        if anfang != nr:
            continue
        _name, params, _wert = zerlege(zeile)
        for pname, pwerte in params:
            if pname == "TZID":
                werte.extend(pwerte)
    return werte


dateien = []
for pfad, _unter, namen in os.walk(ziel):
    for name in sorted(namen):
        if name.endswith(".ics"):
            dateien.append(os.path.join(pfad, name))
dateien.sort()

klassen = {}
ohne_klasse, solidus, passend = [], [], []
kandidaten = gemeldet = stumm_solidus = stumm_leer = 0
zeilen = []

for pfad in dateien:
    rohbytes = open(pfad, "rb").read()
    logisch = entfalte(rohbytes)
    hat_begin, in_komponente, ueberall = bestand(logisch)
    rel = os.path.relpath(pfad, ziel)

    # Gerichtet: alle TZID-Parameterwerte der Datei, aus der Bytefolge.
    for nr, zeile in logisch:
        _name, params, _wert = zerlege(zeile)
        for pname, pwerte in params:
            if pname != "TZID":
                continue
            for wert in pwerte:
                if not wert:
                    stumm_leer += 1
                elif wert.startswith("/"):
                    stumm_solidus += 1
                else:
                    kandidaten += 1

    for fund in D.untersuche(rohbytes):
        if fund.code != "P31":
            continue
        gemeldet += 1
        werte = tzid_werte(logisch, fund.zeile)
        if any(w.startswith("/") for w in werte if w):
            solidus.append((rel, fund.zeile, werte))
        getroffen = [w for w in werte
                     if w and not w.startswith("/") and w.lower() in in_komponente]
        if getroffen:
            passend.append((rel, fund.zeile, getroffen[0]))
        if not hat_begin:
            klasse = "K1 keine VTIMEZONE in der Datei"
        elif not in_komponente:
            klasse = "K3 VTIMEZONE ohne TZID-Eigenschaft"
        elif any(w and w.lower() in ueberall for w in werte):
            klasse = "K4 TZID-Zeile ausserhalb jeder VTIMEZONE"
        else:
            klasse = "K2 VTIMEZONE da, keine mit diesem Namen"
        klassen[klasse] = klassen.get(klasse, 0) + 1
        zeilen.append("%s\tZeile %d\t%s" % (rel, fund.zeile, klasse))

for zeile in zeilen:
    print(zeile)
if zeilen:
    print("")
print("%d Dateien gelesen, %d P31-Meldungen." % (len(dateien), gemeldet))
for klasse in sorted(klassen):
    print("  %-42s %d" % (klasse, klassen[klasse]))

print("")
print("%d Meldungen ohne Ursachenklasse" % len(ohne_klasse))
print("%d Meldungen an einem TZID mit SOLIDUS-Praefix" % len(solidus))
print("%d Meldungen in einer Datei mit passender VTIMEZONE" % len(passend))
for eintrag in solidus:
    print("  SOLIDUS %s Zeile %d: %s" % (eintrag[0], eintrag[1], eintrag[2]))
for eintrag in passend:
    print("  PASSEND %s Zeile %d: %s" % eintrag)

print("")
print("Gerichtet gezaehlt, damit Schweigen ein Ergebnis ist und kein "
      "Ausbleiben:")
print("  %d TZID-Parameterwerte ohne Praefix, davon %d gemeldet und %d stumm"
      % (kandidaten, gemeldet, kandidaten - gemeldet))
print("  %d mit SOLIDUS-Praefix und %d leere Werte, keiner davon gemeldet"
      % (stumm_solidus, stumm_leer))

if ohne_klasse or solidus or passend:
    print("")
    print("ABBRUCH: eine der drei Gegenproben ist gerissen.")
    sys.exit(2)
PYTHON
