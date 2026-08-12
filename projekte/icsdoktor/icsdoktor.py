#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""icsdoktor — nennt fuer jeden Verstoss in einer .ics-Datei Zeile, Regel und
Abschnitt aus RFC 5545.

Teil der Mission ICS-Doktor: state/missionen/2026-08-11-icsdoktor.md.
Die acht Pruefungen und das Ausgabeformat stehen dort und sind ab Anlage der
Mission unveraenderlich. Dieses Programm haelt sich daran und prueft nichts
darueber hinaus.

Nur Python 3 aus der Standardbibliothek. Kein Netz zur Laufzeit.

Aufruf:
    python3 icsdoktor.py DATEI.ics

Ausgabe, eine Zeile je Fund:
    <SCHWERE> Zeile <n>: <code> <klartext> [RFC 5545 §<abschnitt>]

<n> ist die physische Zeile der Eingabedatei, gezaehlt ab 1. Bei entfalteten
Zeilen ist es die Zeile, in der die logische Zeile beginnt.

Exit-Code:
    0  kein FEHLER (HINWEIS aendert ihn nicht)
    1  mindestens ein FEHLER
    2  Aufruf- oder Lesefehler
"""

import calendar
import re
import sys

FEHLER = "FEHLER"
HINWEIS = "HINWEIS"

# Zeichenklassen aus RFC 5545 §3.1.
# CTL = %x00-08 / %x0A-1F / %x7F. TAB (%x09) ist WSP und damit erlaubt.
# Ein CR im Zeileninhalt meldet P01, nicht P04 — sonst steht derselbe Befund
# zweimal da.
_STEUERZEICHEN = set(range(0x00, 0x09)) | set(range(0x0A, 0x20)) | {0x7F}
_STEUERZEICHEN.discard(0x0D)

# iana-token / x-name: 1*(ALPHA / DIGIT / "-")
_NAME_ERLAUBT = re.compile(r"[A-Za-z0-9-]")

# Eigenschaften, deren Wert nach RFC 5545 vom Typ DATE-TIME ist, solange kein
# abweichender VALUE-Parameter dabeisteht. TRIGGER fehlt hier absichtlich: sein
# Standardtyp ist DURATION (§3.8.6.3), DATE-TIME nur mit VALUE=DATE-TIME.
_DATETIME_EIGENSCHAFTEN = {
    "DTSTAMP": "3.8.7.2",
    "DTSTART": "3.8.2.4",
    "DTEND": "3.8.2.2",
    "DUE": "3.8.2.3",
    "CREATED": "3.8.7.1",
    "LAST-MODIFIED": "3.8.7.3",
    "COMPLETED": "3.8.2.1",
    "RECURRENCE-ID": "3.8.4.4",
    "EXDATE": "3.8.5.1",
    "RDATE": "3.8.5.2",
}
# Mehrwertige unter ihnen: Werte durch Komma getrennt.
_MEHRWERTIG = {"EXDATE", "RDATE"}

# Eigenschaften, die nur mit ausdruecklichem VALUE=DATE-TIME ein DATE-TIME
# sind. TRIGGER ist ohne diesen Parameter eine DURATION und wird dann von P08
# nicht angefasst.
_DATETIME_NUR_MIT_VALUE = {"TRIGGER": "3.8.6.3"}


class Fund(object):
    """Ein einzelner Befund. Eine Ausgabezeile."""

    def __init__(self, schwere, zeile, code, text, abschnitt):
        self.schwere = schwere
        self.zeile = zeile
        self.code = code
        self.text = text
        self.abschnitt = abschnitt

    def __str__(self):
        return "%s Zeile %d: %s %s [RFC 5545 §%s]" % (
            self.schwere, self.zeile, self.code, self.text, self.abschnitt)


class Physisch(object):
    """Eine physische Zeile der Datei."""

    def __init__(self, nr, rohbytes, abschluss):
        self.nr = nr
        self.rohbytes = rohbytes          # ohne Zeilenende
        self.abschluss = abschluss        # b"\r\n", b"\n" oder b"" am Dateiende
        self.text = rohbytes.decode("utf-8", errors="replace")


class Logisch(object):
    """Eine logische (entfaltete) Zeile, mit der Zeile, in der sie beginnt."""

    def __init__(self, nr, text):
        self.nr = nr
        self.text = text
        self.name = None                 # gesetzt, wenn P04 durchlaeuft
        self.params = []                 # Liste (NAME, [werte])
        self.wert = None


def zerlege_physisch(rohdaten):
    """Datei in physische Zeilen zerlegen, Zeilenenden behalten."""
    zeilen = []
    start = 0
    nr = 0
    for i, byte in enumerate(rohdaten):
        if byte == 0x0A:
            nr += 1
            inhalt = rohdaten[start:i]
            if inhalt.endswith(b"\r"):
                zeilen.append(Physisch(nr, inhalt[:-1], b"\r\n"))
            else:
                zeilen.append(Physisch(nr, inhalt, b"\n"))
            start = i + 1
    if start < len(rohdaten):
        nr += 1
        zeilen.append(Physisch(nr, rohdaten[start:], b""))
    return zeilen


def pruefe_p01(zeilen, funde):
    """§3.1: Zeilen sind durch CRLF getrennt."""
    for z in zeilen:
        if z.abschluss == b"\n":
            funde.append(Fund(
                FEHLER, z.nr, "P01",
                "Zeile endet mit LF; RFC 5545 verlangt CRLF als Zeilenende",
                "3.1"))
        elif z.abschluss == b"":
            funde.append(Fund(
                FEHLER, z.nr, "P01",
                "letzte Zeile endet ohne CRLF; jede Inhaltszeile wird mit CRLF "
                "abgeschlossen",
                "3.1"))
        if b"\r" in z.rohbytes:
            funde.append(Fund(
                FEHLER, z.nr, "P01",
                "Zeile enthält ein CR, dem kein LF folgt",
                "3.1"))


def pruefe_p02(zeilen, funde):
    """§3.1: Die erste Zeile darf nichts fortsetzen."""
    if not zeilen:
        return
    erste = zeilen[0]
    if not erste.text[:1] in (" ", "\t"):
        return
    text = ("erste Zeile beginnt mit Leerzeichen oder Tabulator und kann "
            "deshalb keine Fortsetzung sein")
    if len(zeilen) > 1 and zeilen[1].text[:1] in (" ", "\t"):
        text += ("; alle folgenden eingerückten Zeilen gelten als ihre "
                 "Fortsetzung")
    funde.append(Fund(FEHLER, erste.nr, "P02", text, "3.1"))


def pruefe_p03(zeilen, funde):
    """§3.1: nicht laenger als 75 Oktette. Im RFC ein SHOULD NOT — HINWEIS."""
    for z in zeilen:
        laenge = len(z.rohbytes)
        if laenge > 75:
            funde.append(Fund(
                HINWEIS, z.nr, "P03",
                "Zeile ist %d Oktette lang; empfohlen sind höchstens 75, "
                "längere Zeilen werden gefaltet" % laenge,
                "3.1"))


def entfalte(zeilen):
    """Fortsetzungszeilen anhaengen, je ein WSP-Zeichen entfernen (§3.1)."""
    logische = []
    for i, z in enumerate(zeilen):
        ist_fortsetzung = i > 0 and z.text[:1] in (" ", "\t")
        if ist_fortsetzung and logische:
            logische[-1].text += z.text[1:]
        else:
            logische.append(Logisch(z.nr, z.text))
    return logische


def pruefe_p04(logische, funde):
    """§3.1: name *(";" param) ":" value.

    Setzt bei Erfolg name/params/wert auf der logischen Zeile. Zeilen, die hier
    scheitern, gehen nicht in die Struktur- und Wertpruefungen ein — an einer
    Zeile, deren Form unklar ist, waere jede weitere Aussage geraten.
    """
    for lz in logische:
        text = lz.text
        if text.strip() == "":
            funde.append(Fund(
                FEHLER, lz.nr, "P04",
                "leere Zeile; zwischen Inhaltszeilen stehen keine Leerzeilen",
                "3.1"))
            continue

        i = 0
        namensfehler = False
        while i < len(text) and text[i] not in (";", ":"):
            if not _NAME_ERLAUBT.match(text[i]):
                funde.append(Fund(
                    FEHLER, lz.nr, "P04",
                    "Eigenschaftsname enthält %s; erlaubt sind A-Z, 0-9 und "
                    "'-', danach ';' oder ':'" % _zeige(text[i]),
                    "3.1"))
                namensfehler = True
                break
            i += 1
        if namensfehler:
            continue
        if i >= len(text):
            funde.append(Fund(
                FEHLER, lz.nr, "P04",
                "kein ':' in der Zeile; nach dem Eigenschaftsnamen fehlt der "
                "Wert (%s)" % _zeige_wort(text),
                "3.1"))
            continue
        if i == 0:
            funde.append(Fund(
                FEHLER, lz.nr, "P04",
                "Zeile beginnt mit %s; davor fehlt der Eigenschaftsname"
                % _zeige(text[i]),
                "3.1"))
            continue
        name = text[:i]

        params = []
        fehler = False
        while i < len(text) and text[i] == ";":
            i += 1
            pname_start = i
            while i < len(text) and _NAME_ERLAUBT.match(text[i]):
                i += 1
            if i == pname_start:
                funde.append(Fund(
                    FEHLER, lz.nr, "P04",
                    "Parametername fehlt nach ';' in %s" % _zeige_wort(name),
                    "3.1"))
                fehler = True
                break
            pname = text[pname_start:i]
            if i >= len(text) or text[i] != "=":
                funde.append(Fund(
                    FEHLER, lz.nr, "P04",
                    "Parameter %s hat kein '='; die Form ist "
                    "NAME=WERT" % _zeige_wort(pname),
                    "3.1"))
                fehler = True
                break
            i += 1
            werte, i, meldung = _lies_parameterwerte(text, i)
            if meldung is not None:
                funde.append(Fund(
                    FEHLER, lz.nr, "P04",
                    "Parameter %s: %s" % (_zeige_wort(pname), meldung),
                    "3.1"))
                fehler = True
                break
            params.append((pname.upper(), werte))
        if fehler:
            continue

        if i >= len(text) or text[i] != ":":
            funde.append(Fund(
                FEHLER, lz.nr, "P04",
                "kein ':' nach den Parametern von %s" % _zeige_wort(name),
                "3.1"))
            continue
        wert = text[i + 1:]

        schlimmes = [c for c in wert if ord(c) in _STEUERZEICHEN]
        if schlimmes:
            funde.append(Fund(
                FEHLER, lz.nr, "P04",
                "Wert enthält das Steuerzeichen %s" % _zeige(schlimmes[0]),
                "3.1"))
            continue

        lz.name = name.upper()
        lz.params = params
        lz.wert = wert


def _lies_parameterwerte(text, i):
    """param-value *("," param-value) lesen. Rueckgabe (werte, i, meldung)."""
    werte = []
    while True:
        if i < len(text) and text[i] == '"':
            i += 1
            start = i
            while i < len(text) and text[i] != '"':
                i += 1
            if i >= len(text):
                return None, i, "Anführungszeichen wird nicht geschlossen"
            werte.append(text[start:i])
            i += 1
        else:
            start = i
            while i < len(text) and text[i] not in (";", ":", ",", '"'):
                i += 1
            if i < len(text) and text[i] == '"':
                return None, i, ("Anführungszeichen mitten im Wert; ein "
                                 "Parameterwert wird ganz oder nicht "
                                 "gequotet")
            werte.append(text[start:i])
        if i < len(text) and text[i] == ",":
            i += 1
            continue
        return werte, i, None


def _zeige(zeichen):
    """Ein Zeichen so ausgeben, dass die Meldung einzeilig bleibt."""
    if zeichen == " ":
        return "ein Leerzeichen"
    if zeichen == "\t":
        return "einen Tabulator"
    if ord(zeichen) < 0x20 or ord(zeichen) == 0x7F:
        return "0x%02X" % ord(zeichen)
    return "'%s'" % zeichen


def _zeige_wort(wort, grenze=30):
    wort = wort.replace("\t", " ")
    if len(wort) > grenze:
        wort = wort[:grenze] + "..."
    return '"%s"' % wort


class Komponente(object):
    def __init__(self, name, zeile):
        self.name = name
        self.zeile = zeile
        self.eigenschaften = {}          # NAME -> [(zeile, wert)]

    def merke(self, name, zeile, wert):
        self.eigenschaften.setdefault(name, []).append((zeile, wert))

    def hole(self, name):
        return self.eigenschaften.get(name, [])


def pruefe_p05(logische, funde):
    """§3.4: BEGIN/END paarig geschachtelt, aussen VCALENDAR.

    Rueckgabe: alle Komponenten, damit P06 und P07 darauf aufsetzen.
    """
    stapel = []
    komponenten = []
    hat_komponente = False

    for lz in logische:
        if lz.name is None:
            continue
        if lz.name == "BEGIN":
            komp = Komponente(lz.wert.strip().upper(), lz.nr)
            hat_komponente = True
            # Jede Komponente auf der äußersten Ebene, nicht nur die erste:
            # eine Datei darf mehrere iCalendar-Objekte enthalten, aber jedes
            # beginnt mit VCALENDAR.
            if not stapel and komp.name != "VCALENDAR":
                funde.append(Fund(
                    FEHLER, lz.nr, "P05",
                    "äußerste Komponente ist %s; ein iCalendar-Objekt "
                    "beginnt mit BEGIN:VCALENDAR" % _zeige_wort(komp.name),
                    "3.4"))
            stapel.append(komp)
        elif lz.name == "END":
            ende = lz.wert.strip().upper()
            if not stapel:
                funde.append(Fund(
                    FEHLER, lz.nr, "P05",
                    "END:%s ohne vorangehendes BEGIN" % ende,
                    "3.4"))
                continue
            oben = stapel.pop()
            if oben.name != ende:
                funde.append(Fund(
                    FEHLER, lz.nr, "P05",
                    "END:%s passt nicht zu BEGIN:%s aus Zeile %d"
                    % (ende, oben.name, oben.zeile),
                    "3.4"))
            komponenten.append(oben)
        else:
            if not stapel:
                funde.append(Fund(
                    FEHLER, lz.nr, "P05",
                    "Eigenschaft %s steht außerhalb jeder Komponente"
                    % _zeige_wort(lz.name),
                    "3.4"))
            else:
                stapel[-1].merke(lz.name, lz.nr, lz.wert)

    for offen in stapel:
        funde.append(Fund(
            FEHLER, offen.zeile, "P05",
            "BEGIN:%s hat kein END:%s" % (offen.name, offen.name),
            "3.4"))
        komponenten.append(offen)

    if not hat_komponente:
        nr = logische[0].nr if logische else 1
        funde.append(Fund(
            FEHLER, nr, "P05",
            "keine Komponente gefunden; ein iCalendar-Objekt beginnt mit "
            "BEGIN:VCALENDAR",
            "3.4"))
    return komponenten


def pruefe_p06(komponenten, funde):
    """§3.7.4 / §3.7.3: VERSION und PRODID je genau einmal, VERSION = 2.0."""
    for komp in komponenten:
        if komp.name != "VCALENDAR":
            continue
        for name, abschnitt in (("VERSION", "3.7.4"), ("PRODID", "3.7.3")):
            treffer = komp.hole(name)
            if not treffer:
                funde.append(Fund(
                    FEHLER, komp.zeile, "P06",
                    "VCALENDAR ab Zeile %d hat kein %s; die Eigenschaft ist "
                    "Pflicht und steht genau einmal im Kalender"
                    % (komp.zeile, name),
                    abschnitt))
            for zeile, _ in treffer[1:]:
                funde.append(Fund(
                    FEHLER, zeile, "P06",
                    "%s steht zum wiederholten Mal in VCALENDAR ab Zeile %d; "
                    "zuerst in Zeile %d" % (name, komp.zeile, treffer[0][0]),
                    abschnitt))
        for zeile, wert in komp.hole("VERSION"):
            if wert != "2.0":
                funde.append(Fund(
                    FEHLER, zeile, "P06",
                    "VERSION hat den Wert %s; RFC 5545 verlangt 2.0"
                    % _zeige_wort(wert),
                    "3.7.4"))


def pruefe_p07(komponenten, funde):
    """§3.6.1: VEVENT enthält UID und DTSTAMP genau einmal."""
    for komp in komponenten:
        if komp.name != "VEVENT":
            continue
        for name, abschnitt in (("UID", "3.8.4.7"), ("DTSTAMP", "3.8.7.2")):
            treffer = komp.hole(name)
            if not treffer:
                funde.append(Fund(
                    FEHLER, komp.zeile, "P07",
                    "VEVENT ab Zeile %d hat kein %s (§%s); die Eigenschaft ist "
                    "Pflicht und darf nur einmal vorkommen"
                    % (komp.zeile, name, abschnitt),
                    "3.6.1"))
            for zeile, _ in treffer[1:]:
                funde.append(Fund(
                    FEHLER, zeile, "P07",
                    "%s (§%s) steht zum wiederholten Mal im VEVENT ab Zeile "
                    "%d; zuerst in Zeile %d"
                    % (name, abschnitt, komp.zeile, treffer[0][0]),
                    "3.6.1"))


def pruefe_p08(logische, funde):
    """§3.3.5: Werte vom Typ DATE-TIME haben eine der drei dort genannten
    Formen."""
    for lz in logische:
        if lz.name is None:
            continue
        typ = None
        tzid = None
        for pname, pwerte in lz.params:
            if pname == "VALUE" and pwerte:
                typ = pwerte[0].upper()
            elif pname == "TZID" and pwerte:
                tzid = pwerte[0]
        if lz.name in _DATETIME_EIGENSCHAFTEN:
            if typ is not None and typ != "DATE-TIME":
                continue                  # anderer Wertetyp, nicht P08
        elif lz.name in _DATETIME_NUR_MIT_VALUE:
            if typ != "DATE-TIME":
                continue                  # ohne VALUE=DATE-TIME kein DATE-TIME
        else:
            continue
        werte = lz.wert.split(",") if lz.name in _MEHRWERTIG else [lz.wert]
        for wert in werte:
            meldung = _pruefe_datetime(wert, tzid)
            if meldung is not None:
                funde.append(Fund(
                    FEHLER, lz.nr, "P08",
                    "%s: %s" % (lz.name, meldung),
                    "3.3.5"))


def _pruefe_datetime(wert, tzid):
    """Rueckgabe: Meldung oder None, wenn der Wert eine der drei Formen hat."""
    if not re.match(r"^[0-9]{8}T[0-9]{6}Z?$", wert):
        return ("Wert %s ist kein DATE-TIME; erwartet wird JJJJMMTT, ein 'T' "
                "und HHMMSS, wahlweise mit 'Z' am Ende" % _zeige_wort(wert))
    utc = wert.endswith("Z")
    jahr = int(wert[0:4])
    monat = int(wert[4:6])
    tag = int(wert[6:8])
    stunde = int(wert[9:11])
    minute = int(wert[11:13])
    sekunde = int(wert[13:15])
    if not 1 <= monat <= 12:
        return "Monat %02d gibt es nicht" % monat
    letzter = calendar.monthrange(jahr, monat)[1]
    if not 1 <= tag <= letzter:
        return "den %d. gibt es im Monat %02d des Jahres %d nicht" % (
            tag, monat, jahr)
    if stunde > 23:
        return "Stunde %02d liegt außerhalb von 00 bis 23" % stunde
    if minute > 59:
        return "Minute %02d liegt außerhalb von 00 bis 59" % minute
    if sekunde > 60:
        return "Sekunde %02d liegt außerhalb von 00 bis 60" % sekunde
    if utc and tzid is not None:
        return ("Wert endet auf 'Z' und trägt zugleich den Parameter TZID=%s; "
                "beides zusammen ist keine der drei Formen" % tzid)
    return None


def untersuche(rohdaten):
    """Alle acht Pruefungen. Rueckgabe: sortierte Liste der Funde."""
    funde = []
    zeilen = zerlege_physisch(rohdaten)
    if not zeilen:
        funde.append(Fund(
            FEHLER, 1, "P05",
            "die Datei ist leer; ein iCalendar-Objekt beginnt mit "
            "BEGIN:VCALENDAR",
            "3.4"))
        return funde
    pruefe_p01(zeilen, funde)
    pruefe_p02(zeilen, funde)
    pruefe_p03(zeilen, funde)
    logische = entfalte(zeilen)
    pruefe_p04(logische, funde)
    komponenten = pruefe_p05(logische, funde)
    pruefe_p06(komponenten, funde)
    pruefe_p07(komponenten, funde)
    pruefe_p08(logische, funde)
    # Nach Zeile, dann nach Code — bei gleicher Zeile steht P01 vor P08.
    # Innerhalb desselben Codes bleibt die Fundreihenfolge erhalten.
    funde.sort(key=lambda f: (f.zeile, f.code))
    return funde


def main(argv):
    if len(argv) == 2 and argv[1] in ("-h", "--hilfe", "--help"):
        sys.stdout.write(__doc__)
        return 0
    if len(argv) != 2:
        sys.stderr.write("Aufruf: icsdoktor.py DATEI.ics\n")
        return 2
    pfad = argv[1]
    try:
        with open(pfad, "rb") as fh:
            rohdaten = fh.read()
    except OSError as fehler:
        sys.stderr.write("%s: nicht lesbar (%s)\n" % (pfad, fehler.strerror))
        return 2

    funde = untersuche(rohdaten)
    for fund in funde:
        print(str(fund))
    return 1 if any(f.schwere == FEHLER for f in funde) else 0


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", newline="\n")
    except AttributeError:               # Python < 3.7
        pass
    sys.exit(main(sys.argv))
