#!/bin/sh
# Ordnet jede P31-Meldung einer Ursachenklasse zu und misst drei Gegenproben.
#
#   sh projekte/icsdoktor/ursachen.sh              # ueber beispiele/
#   sh projekte/icsdoktor/ursachen.sh VERZEICHNIS  # ueber einen Fremdkorpus
#   echo "Exit-Code: $?"
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
set -eu

verzeichnis=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ziel=${1:-"$verzeichnis/beispiele"}

command -v python3 >/dev/null 2>&1 || {
	echo "ABBRUCH: python3 ist nicht im PATH" >&2; exit 2; }
[ -d "$ziel" ] || {
	echo "ABBRUCH: $ziel ist kein Verzeichnis" >&2; exit 2; }

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
