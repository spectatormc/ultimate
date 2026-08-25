#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""icsdoktor — nennt fuer jeden Verstoss in einer .ics-Datei Zeile, Regel und
Abschnitt aus RFC 5545.

Teil der Mission ICS-Doktor: state/missionen/2026-08-11-icsdoktor.md.
Die acht Pruefungen P01 bis P08 und das Ausgabeformat stehen dort und sind ab
Anlage der Mission unveraenderlich. Dieses Programm haelt sich daran und prueft
nichts darueber hinaus.

P09 und P10 kommen aus der Folgemission Die Faltnaht,
state/missionen/2026-08-12-faltnaht.md. Die acht alten Pruefungen bleiben dabei
unangetastet.

P11 kommt aus der Mission Die Fremdprobe,
state/missionen/2026-08-13-fremdprobe.md, und ist die erste Pruefung, die nicht
aus einem selbst ausgedachten Beispiel stammt, sondern aus einem fremden
Fehlerbericht (lfos/calcurse #323).

P12 kommt aus der Mission Die Beziehungsprobe,
state/missionen/2026-08-14-beziehungsprobe.md, und ist die erste Pruefung, die
zwei Eigenschaften zueinander in Beziehung setzt statt jede Zeile fuer sich zu
lesen. Wo der Vergleich ohne Zeitzonendatenbank nicht zu fuehren ist, meldet sie
nichts; die Grenze steht im README und in ihrem eigenen Docstring.

P15 stammt aus derselben Mission und meldet eine negative DURATION (§3.8.2.5).
Sie liest wieder eine einzelne Zeile — die Kennung folgt der Nummerierung der
Mission und nicht der Reihenfolge, in der gebaut wurde.

P13 kommt ebenfalls aus dieser Mission und prueft den ersten Halbsatz von
§3.8.2.2: Das Ende muss denselben Wertetyp tragen wie DTSTART. Sie schliesst
damit genau die Luecke, in der P12 schweigt, und braucht dafuer keine
Zeitzonendatenbank — der Typ steht in den Parametern und nicht im Wert.

P14 ist die letzte der vier und die einzige, bei der keine der beiden Zeilen
fuer sich falsch ist: Ende und Dauer duerfen nach §3.6.1 und §3.6.2 nicht
zugleich in derselben Komponente stehen.

P16 kommt aus der Mission Die vier Luecken,
state/missionen/2026-08-16-die-vier-luecken.md, und ist die erste Pruefung, die
nicht aus einem Fehlerbericht stammt, sondern aus einer Messung gegen ein
fremdes Werkzeug: DTSTAMP muss in UTC stehen (§3.8.7.2). Die Luecke ist am
2026-08-16 mit gegenprobe.sh gemessen worden.

P17 stammt aus derselben Mission und derselben Messung (Kennung
"simplecal-1983:§3.3.10"): Der UNTIL-Regelteil einer RRULE muss zum DTSTART
derselben Komponente passen — gleicher Wertetyp, und bei UTC oder
Zeitzonenbezug im DTSTART zwingend UTC im UNTIL (§3.3.10). Sie liest zwei
Zeilen zueinander wie P12 bis P14, holt den zweiten Wert aber aus einem
Regelteil innerhalb eines Eigenschaftswertes.

P18 stammt aus derselben Mission (Kennung "rfc4-4:§3.3"): TRIGGER traegt ohne
VALUE=DATE-TIME eine DURATION, mit diesem Parameter einen DATE-TIME in UTC
(§3.8.6.3). Sie ist die erste Pruefung, deren Beleg ein verifiziertes Erratum
des RFC-Editors ist (Errata-ID 2039) und nicht nur der Normtext selbst.

P19 stammt aus derselben Mission (Kennung "rfc4-6:§3.6") und ist die erste
Pruefung, die ausserhalb von VEVENT nach Pflichteigenschaften sieht: UID und
DTSTAMP in VTODO (§3.6.2), VJOURNAL (§3.6.3) und VFREEBUSY (§3.6.4), ACTION und
TRIGGER in VALARM (§3.6.6). Sie ist P07 nachgebaut, das dasselbe fuer VEVENT
tut, und ihr Beleg ist wieder ein verifiziertes Erratum (Errata-ID 4149).

P20 gehoert zu keiner Mission und stammt aus der Wartungslast (Regel 13): Eine
Datei, die mit einer UTF-8-Bytefolgemarkierung (BOM) beginnt, bekam bis zum
2026-08-18 fuenf Meldungen, von denen vier die Ursache falsch benannten. Sie ist
damit die erste Pruefung, die nicht eine Luecke schliesst, sondern eine falsche
Auskunft — und die einzige, die vor allen anderen laeuft, weil sie das Byte
entfernt, das die anderen in die Irre schickt.

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

# Alle bei der IANA registrierten iCalendar-Eigenschaften, Stand 2026-08-12.
# Diese Liste ist nicht aus dem Gedaechtnis geschrieben, sondern erhoben:
# `sh namensliste.sh` laedt die Registry und die beiden RFC-Tabellen, baut die
# Vereinigung und vergleicht sie mit dieser Liste. Weicht sie ab, endet das
# Skript mit 1 und nennt jeden Unterschied. Herkunft in HERKUNFT.md.
#
# Warum die Registry und nicht RFC 5545: Die Tabelle in §8.3.2 nennt 47 Namen,
# die Registry 72. Die 25 fehlenden waeren Fehlalarme von P09 gewesen — genau
# der Fehlgriff, den die Missionsdatei als Widerlegung 2 vorher benannt hat.
# EXRULE steht mit Status "Deprecated" darin und bleibt trotzdem in der Liste:
# eine veraltete Eigenschaft ist keine verlorene Faltung.
_REGISTRIERTE_EIGENSCHAFTEN = frozenset((
    "ACKNOWLEDGED", "ACTION", "ATTACH", "ATTENDEE", "BUSYTYPE",
    "CALENDAR-ADDRESS", "CALSCALE", "CATEGORIES", "CLASS", "COLOR", "COMMENT",
    "COMPLETED", "CONCEPT", "CONFERENCE", "CONTACT", "CREATED", "DESCRIPTION",
    "DTEND", "DTSTAMP", "DTSTART", "DUE", "DURATION", "ESTIMATED-DURATION",
    "EXDATE", "EXRULE", "FREEBUSY", "GEO", "IMAGE", "LAST-MODIFIED", "LINK",
    "LOCATION", "LOCATION-TYPE", "METHOD", "NAME", "ORGANIZER",
    "PARTICIPANT-TYPE", "PERCENT-COMPLETE", "PRIORITY", "PRODID", "PROXIMITY",
    "RDATE", "REASON", "RECURRENCE-ID", "REFID", "REFRESH-INTERVAL",
    "RELATED-TO", "REPEAT", "REQUEST-STATUS", "RESOURCE-TYPE", "RESOURCES",
    "RRULE", "SEQUENCE", "SOURCE", "STATUS", "STRUCTURED-DATA",
    "STYLED-DESCRIPTION", "SUBSTATE", "SUMMARY", "TASK-MODE", "TRANSP",
    "TRIGGER", "TZID", "TZID-ALIAS-OF", "TZNAME", "TZOFFSETFROM",
    "TZOFFSETTO", "TZUNTIL", "TZURL", "UID", "URL", "VERSION", "XML",
))

# BEGIN und END sind keine Eigenschaften und stehen deshalb in keiner Registry.
# Sie begrenzen Komponenten (§3.4) und werden von P05 geprueft; P09 darf sie
# nicht als unbekannte Eigenschaftsnamen melden.
_KOMPONENTENGRENZEN = frozenset(("BEGIN", "END"))


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


def dekodiere(rohbytes):
    """Wie decode("utf-8", errors="replace") — sagt aber, welches U+FFFD woher
    kommt.

    Der Ersatzhandler macht aus jedem Byte, das kein gueltiges UTF-8 ist, ein
    U+FFFD. Dieses Zeichen steht dann in *meinem* Text und nicht in der Datei
    des Nutzers. Zitiert eine Meldung es, nennt sie etwas, das er nirgends
    findet — derselbe Schaden wie vor P20, als eine Meldung das unsichtbare
    BOM-Zeichen zitierte.

    Deshalb wird hier zweites Wissen mitgefuehrt: eine Tabelle Textindex ->
    die Bytes, die an dieser Stelle standen. Wer daraus zitiert, kann die Bytes
    im Klartext nennen.

    Die Unterscheidung ist noetig und nicht Zierde: U+FFFD darf auch echt in
    der Datei stehen, korrekt als EF BF BD kodiert. Dann steht sein Index
    *nicht* in der Tabelle, und die Meldung zitiert es wie jedes andere
    Zeichen — richtig, denn dort ist es zu finden.

    Rueckgabe: (text, ungueltig). Der Text ist zeichengleich mit dem, den
    errors="replace" liefert; kein Index verschiebt sich.
    """
    text = ""
    ungueltig = {}
    rest = rohbytes
    while True:
        try:
            return text + rest.decode("utf-8"), ungueltig
        except UnicodeDecodeError as fehler:
            text += rest[:fehler.start].decode("utf-8")
            ungueltig[len(text)] = bytes(rest[fehler.start:fehler.end])
            text += "�"
            rest = rest[fehler.end:]


class Physisch(object):
    """Eine physische Zeile der Datei."""

    def __init__(self, nr, rohbytes, abschluss):
        self.nr = nr
        self.rohbytes = rohbytes          # ohne Zeilenende
        self.abschluss = abschluss        # b"\r\n", b"\n" oder b"" am Dateiende
        self.text, self.ungueltig = dekodiere(rohbytes)


class Logisch(object):
    """Eine logische (entfaltete) Zeile, mit der Zeile, in der sie beginnt."""

    def __init__(self, nr, text, ungueltig=None):
        self.nr = nr
        self.text = text
        # Textindex -> die Bytes, die dort standen, wenn sie kein gueltiges
        # UTF-8 waren. Beim Entfalten mitgezogen, siehe entfalte().
        self.ungueltig = dict(ungueltig or {})
        self.name = None                 # gesetzt, wenn P04 durchlaeuft
        self.rohname = None              # Name so, wie er in der Datei steht
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


def _zeilenliste(nummern, hoechstens=5):
    """'Zeilen 1, 2, 3, 4, 5 und 18 weitere'.

    Die Fundstellen bleiben lesbar, ohne dass eine Sammelzeile mit der
    Dateigroesse waechst. Wer alle Nummern braucht, hat mit der ersten den
    Einstieg und mit der Zahl das Ausmass.
    """
    gezeigt = nummern[:hoechstens]
    text = "Zeilen " + ", ".join(str(n) for n in gezeigt)
    rest = len(nummern) - len(gezeigt)
    if rest > 0:
        text += " und %d weitere" % rest
    return text


# Die drei Sorten von P01, je Sorte der Wortlaut fuer einen Einzelfall und der
# fuer eine Sammelmeldung. Zusammengefasst wird nur innerhalb einer Sorte:
# "durchgehend LF" und "ein CR mitten in einer Zeile" sind verschiedene
# Befunde, und der zweite darf nicht im ersten verschwinden.
_P01_SORTEN = (
    ("Zeile endet mit LF; RFC 5545 verlangt CRLF als Zeilenende",
     "%d Zeilen enden mit LF statt CRLF (%s); RFC 5545 verlangt CRLF als "
     "Zeilenende"),
    ("letzte Zeile endet ohne CRLF; jede Inhaltszeile wird mit CRLF "
     "abgeschlossen",
     "%d Zeilen enden ohne CRLF (%s); jede Inhaltszeile wird mit CRLF "
     "abgeschlossen"),
    ("Zeile enthält ein CR, dem kein LF folgt",
     "%d Zeilen enthalten ein CR, dem kein LF folgt (%s)"),
)


def pruefe_p01(zeilen, funde):
    """§3.1: Zeilen sind durch CRLF getrennt.

    Eine Meldung je Sorte, nicht je Zeile. Eine Datei, die durchgehend LF
    benutzt, ist ein Befund ueber die ganze Datei; als 23 gleichlautende Zeilen
    verdeckt er jeden anderen Fund und macht die Ausgabe unbrauchbar — so
    geschehen auf der ersten fremden Datei, die das Werkzeug gesehen hat
    (lfos/calcurse #323).

    Bei genau einer betroffenen Zeile bleibt der Wortlaut der Einzelmeldung
    unveraendert. Das ist keine Kosmetik, sondern die Bedingung, unter der
    Zusammenfassen erlaubt ist: Die Fundstelle darf es nicht kosten.
    """
    lf = []
    ohne_abschluss = []
    cr_innen = []
    for z in zeilen:
        if z.abschluss == b"\n":
            lf.append(z.nr)
        elif z.abschluss == b"":
            # Nur die letzte Zeile kann hier landen — hoechstens eine.
            ohne_abschluss.append(z.nr)
        if b"\r" in z.rohbytes:
            cr_innen.append(z.nr)

    for nummern, (einzeln, sammel) in zip(
            (lf, ohne_abschluss, cr_innen), _P01_SORTEN):
        if not nummern:
            continue
        if len(nummern) == 1:
            text = einzeln
        else:
            text = sammel % (len(nummern), _zeilenliste(nummern))
        funde.append(Fund(FEHLER, nummern[0], "P01", text, "3.1"))


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
            # Die Tabelle aus dekodiere() wandert mit dem Text. Verschoben wird
            # um die Laenge des bisherigen Stuecks, vermindert um das eine
            # WSP-Zeichen, das §3.1 hier entfernt. Bleibt das aus, zeigt eine
            # Meldung auf einer gefalteten Zeile auf das falsche Byte.
            versatz = len(logische[-1].text) - 1
            for stelle, rohbytes in z.ungueltig.items():
                logische[-1].ungueltig[versatz + stelle] = rohbytes
            logische[-1].text += z.text[1:]
        else:
            logische.append(Logisch(z.nr, z.text, z.ungueltig))
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
                    "'-', danach ';' oder ':'"
                    % _zeige(text[i], lz.ungueltig.get(i)),
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
        lz.rohname = name
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


def _zeige(zeichen, rohbytes=None):
    """Ein Zeichen so ausgeben, dass die Meldung einzeilig bleibt.

    `rohbytes` setzt der Aufrufer, wenn dieses Zeichen ein U+FFFD ist, das
    dekodiere() aus Bytes ohne gueltiges UTF-8 gemacht hat. Dann wird das
    Zeichen nicht zitiert, sondern es werden die Bytes genannt: Ein U+FFFD
    steht in der Datei des Nutzers nicht, und wer danach sucht, sucht nach
    nichts. Dieselbe Entscheidung wie bei P20, wo die drei BOM-Bytes im
    Klartext stehen statt des unsichtbaren Zeichens.
    """
    if rohbytes:
        gezeigt = " ".join("%02X" % b for b in rohbytes)
        if len(rohbytes) == 1:
            return "das Byte %s, das kein gültiges UTF-8 ist" % gezeigt
        return "die Bytes %s, die kein gültiges UTF-8 sind" % gezeigt
    if zeichen == " ":
        return "ein Leerzeichen"
    if zeichen == "\t":
        return "einen Tabulator"
    if ord(zeichen) < 0x20 or ord(zeichen) == 0x7F:
        return "0x%02X" % ord(zeichen)
    return "'%s'" % zeichen


def _zeigbar(text):
    """Steuerzeichen sichtbar machen, damit eine Meldung eine Meldung bleibt.

    Ein Wert aus der Datei wandert in Meldungen woertlich weiter. Steht ein
    Steuerzeichen darin, geht die Meldung im Terminal kaputt: Ein CR setzt den
    Cursor an den Zeilenanfang zurueck, und der Rest der Meldung ueberschreibt
    ihren Anfang — der Nutzer liest dann etwas, das so nie geschrieben wurde.
    Ein ESC laesst das Terminal den Dateiinhalt als Steuerbefehl ausfuehren,
    ein NUL schneidet die Zeile fuer manche Leser ab, ein BEL piept.

    Der Fall ist nicht ausgedacht: Ein Tabulator ist nach §3.1 (WSP) in einem
    Wert ausdruecklich erlaubt und kommt in echten Dateien vor; ein CR bleibt
    stehen, wo eine Datei mit CR statt CRLF trennt oder mitten im Herunterladen
    abbricht.

    Gezeigt wird <0x0D> statt des Zeichens. Die Kehrseite gehoert dazugesagt:
    Steht der Text "<0x0D>" so in der Datei, sieht die Meldung gleich aus. Der
    Tausch geht in die richtige Richtung — ein Zeichen, das sich nicht zeigen
    laesst, wird benannt statt ausgefuehrt.

    Gegenstueck zu _zeige(), das dasselbe fuer ein einzelnes beanstandetes
    Zeichen tut. Was hier durchlaeuft, ist nicht beanstandet, sondern zitiert.
    """
    if not any(ord(z) < 0x20 or ord(z) == 0x7F for z in text):
        return text                      # der Normalfall, unveraendert
    return "".join("<0x%02X>" % ord(z)
                   if ord(z) < 0x20 or ord(z) == 0x7F else z
                   for z in text)


def _kurz(text, grenze=30):
    """Ein Stueck Datei so weit kuerzen, dass die Meldung lesbar bleibt.

    Erst kuerzen, dann zeigen: Die Grenze zaehlt Zeichen der Datei, und ein
    <0x0D> aus _zeigbar() wird nie mittendrin abgeschnitten.

    WARUM ES DIESE FUNKTION GIBT, gemessen statt vermutet. Bis zum 2026-08-20
    kuerzte nur _zeige_wort(); sechs Stellen gaben Namen und TZID-Werte
    ungekuerzt weiter. Trennt eine Datei mit CR statt CRLF, ist sie fuer dieses
    Werkzeug eine einzige physische Zeile, und der "Komponentenname" hinter
    BEGIN: ist dann praktisch die ganze Datei. Gemessen an
    beispiele/02-sauber-gefaltet.ics: eine P05-Meldung von 2878 Zeichen. Sie
    war eine Zeile und sie war richtig — eine Auskunft war sie nicht.

    Die Grenze steht in EINER Funktion und nicht an sieben Stellen, damit
    "30 Zeichen plus ..." eine Regel dieses Werkzeugs ist und nicht eine
    Gewohnheit, die sechs Aufrufer nicht kannten.
    """
    if len(text) > grenze:
        text = text[:grenze] + "..."
    return _zeigbar(text)


def _zeige_wort(wort, grenze=30):
    return '"%s"' % _kurz(wort, grenze)


class Komponente(object):
    def __init__(self, name, zeile):
        self.name = name
        self.zeile = zeile
        self.eigenschaften = {}          # NAME -> [(zeile, wert)]
        # NAME -> [Logisch]. Dieselben Eigenschaften noch einmal, aber
        # vollstaendig statt auf (zeile, wert) verkuerzt. P12 braucht die
        # Parameter: VALUE=DATE und TZID entscheiden darueber, ob zwei
        # Zeitangaben ueberhaupt vergleichbar sind, und beide stehen nicht im
        # Wert, sondern davor. Die alte Form bleibt daneben stehen, damit P06,
        # P07 und P11 unveraendert weiterlaufen.
        self.zeitzeilen = {}
        # Die umgebende Komponente oder None auf der aeussersten Ebene. P11
        # braucht sie, weil DTSTART nur dann Pflicht ist, wenn das *umgebende*
        # VCALENDAR keine METHOD traegt — die Bedingung steht also nicht im
        # VEVENT selbst. P05 bis P10 lesen das Feld nicht.
        self.elternteil = None

    def merke(self, name, zeile, wert, logisch=None):
        self.eigenschaften.setdefault(name, []).append((zeile, wert))
        if logisch is not None:
            self.zeitzeilen.setdefault(name, []).append(logisch)

    def hole(self, name):
        return self.eigenschaften.get(name, [])

    def hole_zeile(self, name):
        """Die erste logische Zeile dieses Namens oder None.

        Steht die Eigenschaft mehrfach in der Komponente, nimmt P12 die erste
        und meldet die Wiederholung nicht. Bis zum 2026-08-15 stand hier, das
        sei die Sache von P07 — das stimmt nicht: P07 deckt UID und DTSTAMP ab
        und sonst nichts. Ein doppeltes DTSTART oder DTEND verbietet §3.6.1,
        und keine Pruefung dieses Werkzeugs meldet es.
        """
        treffer = self.zeitzeilen.get(name, [])
        return treffer[0] if treffer else None


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
            if stapel:
                komp.elternteil = stapel[-1]
            stapel.append(komp)
        elif lz.name == "END":
            ende = lz.wert.strip().upper()
            if not stapel:
                funde.append(Fund(
                    FEHLER, lz.nr, "P05",
                    "END:%s ohne vorangehendes BEGIN" % _kurz(ende),
                    "3.4"))
                continue
            oben = stapel.pop()
            if oben.name != ende:
                funde.append(Fund(
                    FEHLER, lz.nr, "P05",
                    "END:%s passt nicht zu BEGIN:%s aus Zeile %d"
                    % (_kurz(ende), _kurz(oben.name), oben.zeile),
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
                stapel[-1].merke(lz.name, lz.nr, lz.wert, lz)

    for offen in stapel:
        funde.append(Fund(
            FEHLER, offen.zeile, "P05",
            "BEGIN:%s hat kein END:%s" % (_kurz(offen.name),
                                          _kurz(offen.name)),
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
                "beides zusammen ist keine der drei Formen" % _kurz(tzid))
    return None


def pruefe_p09(logische, funde):
    """§3.1: Der Eigenschaftsname ist ein iana-token oder ein x-name.

    Steht ein Name in keiner Registry und beginnt er nicht mit "X-", ist die
    haeufigste Ursache keine erfundene Eigenschaft, sondern eine
    Fortsetzungszeile, die ihr fuehrendes Leerzeichen verloren hat: Aus
    " mailto:employee-A@example.com" wird die formal gueltige Eigenschaft
    "mailto". Deshalb HINWEIS und nicht FEHLER — der RFC verbietet unbekannte
    Namen nicht, und Hersteller-Eigenschaften ohne "X-" gibt es wirklich. Die
    Meldung nennt die verlorene Faltung als moeglichen Grund und behauptet sie
    nicht.
    """
    for lz in logische:
        if lz.name is None:
            continue
        if lz.name in _KOMPONENTENGRENZEN:
            continue
        if lz.name in _REGISTRIERTE_EIGENSCHAFTEN:
            continue
        if lz.name.startswith("X-"):
            continue
        funde.append(Fund(
            HINWEIS, lz.nr, "P09",
            "Eigenschaftsname %s ist nicht registriert und beginnt nicht mit "
            "'X-'; möglicherweise hat diese Zeile ihr führendes Leerzeichen "
            "verloren und ist die Fortsetzung der Zeile davor"
            % _zeige_wort(lz.rohname),
            "3.1"))


def pruefe_p10(zeilen, funde):
    """§3.1 zusammen mit §3.3.11: Die Faltung liegt mitten in einer Maskierung.

    Der Fall aus collective/icalendar #1501: Eine lange TEXT-Zeile wird genau
    zwischen dem "\\" und dem maskierten Zeichen gefaltet. Entfaltet ergibt das
    wieder die richtige Maskierung — wer die Zeile vor dem Auswerten
    zusammensetzt, sieht nichts. Wer sie Zeile fuer Zeile liest, sieht einen
    Rueckwaertsstrich am Zeilenende und ein loses Zeichen dahinter. Der
    Fehlerbericht nennt genau diesen Unterschied: ein Programm zeigt den Termin
    nicht an, ein anderes liest ihn ohne Klage.

    Deshalb HINWEIS und nicht FEHLER: §3.1 erlaubt die Faltung an nahezu jeder
    Stelle, dieses Dokument verstoesst also gegen kein MUST. Gemeldet wird eine
    Stelle, an der Programme messbar auseinandergehen, nicht ein Verstoss.

    Erkannt wird die Faltstelle, nicht der Text: Endet eine Zeile auf eine
    *ungerade* Zahl von Rueckwaertsstrichen und ist die naechste Zeile eine
    Fortsetzung, dann trennt die Naht ein "\\" von seinem maskierten Zeichen.
    Bei einer geraden Zahl steht am Zeilenende ein fertiges "\\\\" — eine
    maskierte Maskierung, die vollstaendig auf dieser Zeile liegt. Genau daran
    haengt Widerlegung 3 der Mission: Ohne diese Unterscheidung waere jede
    erlaubte Faltung mitgemeldet, und die Pruefung waere nicht baubar.
    """
    for i in range(len(zeilen) - 1):
        z = zeilen[i]
        naechste = zeilen[i + 1]
        if naechste.text[:1] not in (" ", "\t"):
            continue
        striche = len(z.text) - len(z.text.rstrip("\\"))
        if striche == 0 or striche % 2 == 0:
            continue
        maskiert = naechste.text[1:2]
        if maskiert == "":
            gezeigt = ('ein "\\" ohne maskiertes Zeichen; die Fortsetzung in '
                       'Zeile %d ist leer' % naechste.nr)
        else:
            gezeigt = ('die Maskierung %s, deren zweite Hälfte erst in '
                       'Zeile %d steht'
                       % (_zeige_wort("\\" + maskiert), naechste.nr))
        funde.append(Fund(
            HINWEIS, z.nr, "P10",
            "Faltung trennt %s (§3.3.11); erlaubt ist die Faltstelle, aber "
            "nicht jedes Programm setzt die Zeile vor dem Auswerten wieder "
            "zusammen" % gezeigt,
            "3.1"))


def _umgebendes_vcalendar(komp):
    """Das naechste VCALENDAR ueber dieser Komponente oder None."""
    oben = komp.elternteil
    while oben is not None:
        if oben.name == "VCALENDAR":
            return oben
        oben = oben.elternteil
    return None


def pruefe_p11(komponenten, funde):
    """§3.6.1: DTSTART ist im VEVENT Pflicht, solange das umgebende VCALENDAR
    keine METHOD traegt.

    Der Fall aus lfos/calcurse #323: Ein VEVENT ohne DTSTART wird von einem
    Programm abgewiesen, und der Melder sucht die Stelle von Hand. P07 prueft
    UID und DTSTAMP, mehr nicht — DTSTART fehlte dort, weil es die einzige der
    drei Pflichtangaben mit einer Bedingung ist.

    Die Bedingung steht woertlich in §3.6.1: DTSTART ist REQUIRED, "if the
    component appears in an iCalendar object that doesn't specify the METHOD
    property; otherwise, it is OPTIONAL". Ein Kalender mit METHOD — etwa eine
    Absage per METHOD:CANCEL, die nur UID und SEQUENCE braucht — loest diese
    Meldung deshalb nicht aus. Ohne diese Unterscheidung waere die Pruefung ein
    Fehlalarm auf jeder Einladung, die als iTIP-Nachricht verschickt wird.

    Ein VEVENT ganz ohne umgebendes VCALENDAR meldet P11 nicht. Der Bedingung
    fehlt dann ihr Bezugspunkt — §3.6.1 spricht vom Bauteil, das "appears in an
    iCalendar object"; erscheint es in keinem, ist das der Befund, und den
    meldet P05 an derselben Zeile bereits. Aufgefallen ist das nicht beim
    Entwurf, sondern an Beispiel 08, wo P11 als vierte Zeile zu drei
    P05-Meldungen ueber dasselbe Bruchstueck getreten ist.

    Nicht geprueft wird das mehrfache DTSTART: §3.6.1 verbietet auch das, aber
    Pruefbefehl 2 der Mission Die Fremdprobe verlangt den fehlenden Fall, und
    eine Pruefung, die mehr tut als der Prueftext sagt, ist von aussen nicht
    mehr an ihm zu messen.
    """
    for komp in komponenten:
        if komp.name != "VEVENT":
            continue
        if komp.hole("DTSTART"):
            continue
        kalender = _umgebendes_vcalendar(komp)
        if kalender is None or kalender.hole("METHOD"):
            continue
        funde.append(Fund(
            FEHLER, komp.zeile, "P11",
            "VEVENT ab Zeile %d hat kein DTSTART; die Eigenschaft ist "
            "Pflicht, denn das VCALENDAR ab Zeile %d trägt keine METHOD"
            % (komp.zeile, kalender.zeile),
            "3.6.1"))


# Welche Eigenschaft in welcher Komponente das Ende bezeichnet. VFREEBUSY steht
# mit dabei, weil §3.8.2.2 die Eigenschaft DTEND beschreibt und nicht die
# Komponente, in der sie steht.
_ENDE_EIGENSCHAFT = (
    ("VEVENT", "DTEND"),
    ("VTODO", "DUE"),
    ("VFREEBUSY", "DTEND"),
)

# Wo Ende und Dauer einander ausschliessen, mit dem Abschnitt, der es sagt. Hier
# steht VFREEBUSY nicht mit dabei: §3.6.4 kennt den Satz aus §3.6.1 und §3.6.2
# nicht, und in seiner Grammatik kommt DURATION gar nicht vor.
_ZUGLEICH_VERBOTEN = (
    ("VEVENT", "DTEND", "3.6.1"),
    ("VTODO", "DUE", "3.6.2"),
)


def _wertetyp(lz):
    """Der Wertetyp, den eine Zeit-Eigenschaft ausweist, in Grossbuchstaben.

    Fehlt der VALUE-Parameter, gilt die Vorgabe DATE-TIME — §3.8.2.2 fuer DTEND,
    §3.8.2.4 fuer DTSTART, §3.8.2.3 fuer DUE nennen sie jeweils als Default Value
    Type. Deshalb ist "DTSTART;VALUE=DATE-TIME:..." derselbe Typ wie ein DTSTART
    ohne Parameter, und P13 darf das nicht als Abweichung lesen.

    Steht VALUE mehrfach, gewinnt der letzte. Das ist keine Entscheidung mit
    Gewicht, sondern dieselbe Lesart, die _zeitpunkt seit P12 benutzt; ein
    doppelter Parameter kommt ohnehin nur in kaputten Dateien vor.
    """
    typ = None
    for pname, pwerte in lz.params:
        if pname == "VALUE" and pwerte:
            typ = pwerte[0].upper()
    if typ is None:
        return "DATE-TIME"
    return typ


def _zeitpunkt(lz):
    """Zerlegt DTSTART/DTEND/DUE in (typ, bezug, schluessel) oder None.

    `typ` ist "DATE" oder "DATE-TIME", `bezug` beschreibt, worauf sich die
    Angabe bezieht — ("utc",), ("lokal",) oder ("tzid", name) —, und
    `schluessel` ist die Ziffernfolge, die sich in gleichem Typ und gleichem
    Bezug vergleichen laesst.

    None heisst: nicht vergleichbar, also schweigen. Das betrifft jeden Wert,
    der die Form aus §3.3.4/§3.3.5 nicht erfuellt; den meldet P08 an derselben
    Zeile bereits, und eine zweite Meldung ueber dieselbe kaputte Zeile hilft
    niemandem beim Suchen.
    """
    tzid = None
    for pname, pwerte in lz.params:
        if pname == "TZID" and pwerte:
            tzid = pwerte[0]
    wert = lz.wert or ""
    typ = _wertetyp(lz)                  # Vorgabe nach §3.8.2.4 und §3.8.2.2
    if typ == "DATE":
        if not re.match(r"^[0-9]{8}$", wert):
            return None
        return ("DATE", ("lokal",), wert + "000000")
    if typ != "DATE-TIME":
        return None                      # PERIOD und alles Weitere: nicht hier
    if not re.match(r"^[0-9]{8}T[0-9]{6}Z?$", wert):
        return None
    if wert.endswith("Z"):
        # Ein Z-Wert mit TZID ist keine der drei Formen; das meldet P08.
        if tzid is not None:
            return None
        return ("DATE-TIME", ("utc",), wert[:8] + wert[9:15])
    bezug = ("tzid", tzid) if tzid is not None else ("lokal",)
    return ("DATE-TIME", bezug, wert[:8] + wert[9:15])


def pruefe_p12(komponenten, funde):
    """§3.8.2.2: Das Ende liegt spaeter als der Anfang.

    Woertlich: der Wert von DTEND "MUST be later in time than the value of the
    'DTSTART' property". Fuer VTODO sagt §3.6.2 dasselbe ueber DUE. Gleichstand
    ist damit ebenfalls ein Verstoss — "later" und nicht "not earlier".

    Die erste Pruefung dieses Werkzeugs, die zwei Zeilen zueinander in Beziehung
    setzt statt jede fuer sich zu lesen. Sie kommt aus der Mission Die
    Beziehungsprobe, state/missionen/2026-08-14-beziehungsprobe.md, und dort aus
    fuenf fremden Fehlerberichten ueber dreizehn Jahre — bitfireAT/synctools#156
    ist der, dessen Aufbau Beispiel 21 nachbildet.

    **Wo geschwiegen wird, und warum das kein Versaeumnis ist.** Verglichen wird
    nur, was ohne Zeitzonendatenbank vergleichbar ist: gleicher Wertetyp und
    gleicher Zeitbezug. Zwei verschiedene TZID, TZID gegen UTC, DATE gegen
    DATE-TIME — in all diesen Faellen meldet P12 nichts. Der Grund steht in der
    Missionsdatei und war vor dem ersten Commit festgelegt: Ein Anfang um 23:30
    in Europe/Berlin und ein Ende um 18:00 in America/New_York laufen oertlich
    rueckwaerts und tatsaechlich vorwaerts. Wer das ohne Zonendaten vergleicht,
    raet — und ein geratener Fehlalarm ist schlimmer als eine Luecke, die
    dokumentiert ist. Beispiel 22 haelt genau diesen Fall fest.

    Die abweichenden Wertetypen sind keine Luecke, sondern die Zustaendigkeit
    von P13 aus derselben Mission. Bis die steht, bleibt der Fall unbemerkt;
    das ist im README als Grenze benannt und nicht hier stillschweigend
    aufgefangen.

    Eine Grenze, die auch mit gleicher TZID bleibt: Faellt der Zeitraum in die
    doppelte Stunde der Rueckstellung, kann die oertliche Uhrzeit rueckwaerts
    laufen, waehrend die tatsaechliche Zeit vorwaerts laeuft. P12 vergleicht
    dort die Ortszeit und kann in dieser einen Stunde falsch liegen. Das steht
    im README, statt hier durch Raten geschlossen zu werden.
    """
    for komp in komponenten:
        for name, ende_name in _ENDE_EIGENSCHAFT:
            if komp.name != name:
                continue
            anfang = komp.hole_zeile("DTSTART")
            ende = komp.hole_zeile(ende_name)
            if anfang is None or ende is None:
                continue
            a = _zeitpunkt(anfang)
            e = _zeitpunkt(ende)
            if a is None or e is None:
                continue
            if a[0] != e[0] or a[1] != e[1]:
                continue                 # nicht vergleichbar: schweigen
            if e[2] > a[2]:
                continue                 # in Ordnung
            funde.append(Fund(
                FEHLER, ende.nr, "P12",
                "%s liegt nicht später als das DTSTART aus Zeile %d "
                "(%s gegen %s)"
                % (ende_name, anfang.nr,
                   _zeige_wort(ende.wert or ""), _zeige_wort(anfang.wert or "")),
                "3.8.2.2"))


def pruefe_p13(komponenten, funde):
    """§3.8.2.2: Das Ende traegt denselben Wertetyp wie der Anfang.

    Woertlich, und es ist der erste Halbsatz des Abschnitts: "The value type of
    this property MUST be the same as the 'DTSTART' property". Fuer VTODO sagt
    §3.8.2.3 dasselbe ueber DUE. Ein Termin, der am 14. als ganzer Tag beginnt
    und am 15. um 12:00 Uhr UTC endet, mischt DATE und DATE-TIME und ist damit
    kein gueltiges VEVENT — auch dann nicht, wenn beide Werte fuer sich gelesen
    tadellos aussehen.

    Aus der Mission Die Beziehungsprobe,
    state/missionen/2026-08-14-beziehungsprobe.md. Der Fall wurde vor der Wahl
    gemessen und nicht vermutet: DTSTART;VALUE=DATE:20260814 gegen
    DTEND:20260815T120000Z lief durch dieses Werkzeug mit Exit 0 und ohne eine
    einzige Meldung.

    **Diese Pruefung schliesst die Luecke, in der P12 schweigt.** P12 vergleicht
    nur, was ohne Zeitzonendatenbank vergleichbar ist, und ueberspringt deshalb
    unter anderem die abweichenden Wertetypen. Genau die meldet P13, und zwar
    ohne den Vergleich der Zeitpunkte ueberhaupt zu versuchen: Was die beiden
    Zeilen bedeuten, ist nicht die Frage — dass sie verschiedene Typen
    ausweisen, steht in den Parametern und ist ohne jede Zonendatenbank lesbar.
    Beide koennen daher nie zugleich anschlagen.

    **Geprueft wird der ausgewiesene Typ, nicht der geschriebene Wert.** Ob der
    Wert zu seinem Typ passt, ist die Sache von P08; ob eine Zeitzone dazu passt,
    die von niemandem. Eine Zeile mit VALUE=DATE und einem unlesbaren Wert
    bekommt daher zwei Meldungen: P08 zum Wert und P13 zum Typ. Das ist Absicht
    — es sind zwei verschiedene Fehler an derselben Zeile, und wer nur den einen
    behebt, hat den anderen noch.

    **Was ausdruecklich nicht gemeldet wird:**

    - **Der zweite Satz von §3.8.2.2.** "This property MUST be specified as a
      date with local time if and only if the 'DTSTART' property is also
      specified as a date with local time" — ein Ende in UTC neben einem Anfang
      ohne Zeitzone verletzt das, traegt aber denselben Wertetyp DATE-TIME und
      geht hier durch. Die Missionsdatei sagt "Wertetyp weicht ab", und das ist
      etwas anderes. Die Luecke steht im README, statt hier durch eine eigene
      Auslegung geschlossen zu werden.
    - **Ein Typ, den es nicht gibt.** DTEND;VALUE=PERIOD neben einem DTSTART in
      DATE-TIME wird als Abweichung gemeldet, weil die Typen abweichen — nicht
      weil PERIOD an dieser Stelle unzulaessig waere. Dass §3.8.2.2 nur DATE und
      DATE-TIME zulaesst, prueft dieses Werkzeug nirgends.
    - **Ein fehlendes DTSTART.** Ohne Anfang gibt es nichts zu vergleichen; die
      Stelle meldet P11, soweit sie in ihre Bedingung faellt.
    """
    for komp in komponenten:
        for name, ende_name in _ENDE_EIGENSCHAFT:
            if komp.name != name:
                continue
            anfang = komp.hole_zeile("DTSTART")
            ende = komp.hole_zeile(ende_name)
            if anfang is None or ende is None:
                continue
            typ_anfang = _wertetyp(anfang)
            typ_ende = _wertetyp(ende)
            if typ_anfang == typ_ende:
                continue
            funde.append(Fund(
                FEHLER, ende.nr, "P13",
                "%s weist den Wertetyp %s aus, das DTSTART aus Zeile %d aber "
                "%s; beide müssen denselben Typ tragen"
                % (ende_name, _zeige_wort(typ_ende), anfang.nr,
                   _zeige_wort(typ_anfang)),
                "3.8.2.2"))


def pruefe_p14(komponenten, funde):
    """§3.6.1 / §3.6.2: Ende und Dauer schliessen einander aus.

    Woertlich aus der Grammatik von §3.6.1: "Either 'dtend' or 'duration' MAY
    appear in a 'eventprop', but 'dtend' and 'duration' MUST NOT occur in the
    same 'eventprop'." §3.6.2 sagt denselben Satz fuer 'due' und 'duration' im
    VTODO. Beide zugleich heisst: Zwei Zeilen behaupten das Ende desselben
    Termins, und wer die Datei liest, muss raten, welche gilt.

    Die letzte der vier Pruefungen aus der Mission Die Beziehungsprobe,
    state/missionen/2026-08-14-beziehungsprobe.md. Der Fall wurde vor der Wahl
    gemessen und nicht vermutet: DTEND und DURATION im selben VEVENT liefen
    durch dieses Werkzeug mit Exit 0 und ohne eine einzige Meldung.

    **Gemeldet wird an der spaeteren der beiden Zeilen**, und die fruehere steht
    im Text. Anders als bei P12 und P13 ist keine der beiden Zeilen fuer sich
    falsch — falsch ist, dass sie zusammen dastehen. Eine Meldung je Komponente
    statt zwei, weil es ein Fehler ist und nicht zwei.

    **Nur VEVENT und VTODO.** Das VFREEBUSY steht in _ENDE_EIGENSCHAFT, weil
    §3.8.2.2 dort ueber DTEND dasselbe sagt; diesen Satz sagt §3.6.4 aber nicht.
    In der Grammatik des VFREEBUSY kommt DURATION ueberhaupt nicht vor — welche
    Eigenschaften eine Komponente tragen darf, prueft dieses Werkzeug nirgends,
    und P14 faengt damit nicht nebenbei an.

    **Was ausdruecklich nicht gemeldet wird:**

    - **Eine DURATION in einer eingebetteten VALARM.** Sie gehoert zu ihrer
      eigenen Komponente und nicht zu dem Termin darum herum; §3.6.6 sieht sie
      dort neben REPEAT ausdruecklich vor. Ein Wecker, der zweimal klingelt,
      ist der Normalfall und kein Verstoss. Beispiel 31 haelt ihn fest und muss
      stumm bleiben.
    - **Ob die Dauer taugt.** Ob der Wert der DURATION positiv ist, fragt P15;
      ob er ueberhaupt die Form nach §3.3.6 hat, fragt niemand. Ein VEVENT mit
      DTEND und DURATION:-PT1H bekommt beide Meldungen — es sind zwei
      verschiedene Fehler, und wer nur die Dauer umdreht, hat den anderen noch.
    - **Die Wiederholung derselben Eigenschaft.** Stehen zwei DTEND in einer
      Komponente, nimmt P14 das erste und meldet die Wiederholung nicht. Dass
      §3.6.1 auch die verbietet, prueft dieses Werkzeug fuer DTEND, DURATION
      und DTSTART nirgends — P07 deckt nur UID und DTSTAMP ab.
    """
    for komp in komponenten:
        for name, ende_name, abschnitt in _ZUGLEICH_VERBOTEN:
            if komp.name != name:
                continue
            ende = komp.hole(ende_name)
            dauer = komp.hole("DURATION")
            if not ende or not dauer:
                continue
            paar = sorted(((ende[0][0], ende_name), (dauer[0][0], "DURATION")))
            (zuerst_nr, zuerst_name), (danach_nr, danach_name) = paar
            funde.append(Fund(
                FEHLER, danach_nr, "P14",
                "%s steht neben dem %s aus Zeile %d in demselben %s ab "
                "Zeile %d; höchstens eines von beiden darf dort stehen"
                % (danach_name, zuerst_name, zuerst_nr, komp.name, komp.zeile),
                abschnitt))


def _dauer_negativ(wert):
    """Rueckgabe: None, "vorne" oder "innen".

    "vorne" ist die Form, die §3.3.6 fuer ein Vorzeichen vorsieht — das Minus
    steht vor dem "P", etwa -PT1H. "innen" ist die Form aus dem Absturzbericht
    bitfireAT/davx5-ose#1850: P-1W. Die kennt §3.3.6 gar nicht; sie meint aber
    dasselbe und kommt in echten Dateien vor, sonst gaebe es den Bericht nicht.

    None heisst: kein Minuszeichen. Ob der Rest ueberhaupt eine gueltige Dauer
    nach §3.3.6 ist, prueft hier niemand — dafuer gibt es keine Pruefung in
    diesem Werkzeug, und eine nebenbei zu erfinden ist nicht Aufgabe dieser
    Mission. P15 beantwortet genau eine Frage: negativ oder nicht.

    Gross- und Kleinschreibung: In ABNF sind Literale wie "P" unabhaengig von
    der Schreibweise (RFC 5234 §2.3), deshalb wird hier nicht auf Grossbuchstabe
    bestanden.
    """
    rest = wert
    vorzeichen = ""
    if rest[:1] in ("+", "-"):
        vorzeichen = rest[0]
        rest = rest[1:]
    if rest[:1].upper() != "P":
        return None                      # sieht nicht nach einer Dauer aus
    if vorzeichen == "-":
        return "vorne"
    if "-" in rest[1:]:
        return "innen"
    return None


def pruefe_p15(logische, funde):
    """§3.8.2.5: DURATION nennt eine positive Dauer.

    Woertlich: "This property specifies a positive duration of time", und in
    der Grammatik ";consisting of a positive duration of time". Eine negative
    Dauer ist damit ein Verstoss, auch wenn §3.3.6 das Vorzeichen syntaktisch
    zulaesst — der Wertetyp kann es, diese Eigenschaft darf es nicht.

    Aus der Mission Die Beziehungsprobe,
    state/missionen/2026-08-14-beziehungsprobe.md. Der Anlass ist fremd und
    nicht ausgedacht: bitfireAT/synctools#147 nennt die negative Dauer neben
    dem Ende vor dem Anfang und stellt selbst fest, dass der Standard beide
    verbietet; davx5-ose#1850 ist der ausgeloeste Absturz, mit dem Wert P-1W
    im Klartext der Meldung.

    **Geprueft wird die Eigenschaft, nicht die Komponente.** §3.8.2.5
    beschreibt DURATION und nicht den Ort, an dem sie steht; in VEVENT, VTODO
    und VALARM gilt derselbe Satz. Deshalb laeuft diese Pruefung ueber die
    logischen Zeilen und nicht ueber die Komponentenliste.

    **Was ausdruecklich nicht gemeldet wird:**

    - **TRIGGER mit negativer Dauer.** Das ist eine andere Eigenschaft, und
      §3.8.6.3 erlaubt ihr das Vorzeichen ausdruecklich: Ein Wecker, der
      fuenfzehn Minuten vor dem Termin klingelt, traegt TRIGGER:-PT15M. Wer
      das meldet, meldet den Normalfall. Beispiel 25 haelt ihn fest und muss
      stumm bleiben.
    - **Die Dauer null**, etwa PT0S. "Positive" schliesst sie dem Wortsinn
      nach aus, aber die Missionsdatei sagt "DURATION ist negativ", und das
      ist etwas anderes als "nicht positiv". Die Luecke steht im README,
      statt hier durch eine eigene Auslegung geschlossen zu werden.
    - **Eine Dauer, die keine ist.** DURATION:morgen traegt kein Minus und
      geht hier durch. Die Form nach §3.3.6 prueft dieses Werkzeug nirgends.
    """
    for lz in logische:
        if lz.name != "DURATION":
            continue
        richtung = _dauer_negativ(lz.wert or "")
        if richtung is None:
            continue
        if richtung == "vorne":
            zusatz = ""
        else:
            zusatz = ("; das Minuszeichen steht hinter dem \"P\", "
                      "§3.3.6 sieht es davor vor")
        funde.append(Fund(
            FEHLER, lz.nr, "P15",
            "DURATION nennt mit %s eine negative Dauer, zulässig ist nur "
            "eine positive%s" % (_zeige_wort(lz.wert or ""), zusatz),
            "3.8.2.5"))


def pruefe_p16(logische, funde):
    """§3.8.7.2: DTSTAMP steht in der UTC-Form.

    Woertlich, unter "Description": "The value MUST be specified in the UTC
    time format." Das ist ein MUST und keine Empfehlung. Errata-ID 3038
    (gemeldet 2011-11-30, Status "Held for Document Update") will diese
    Anforderung aus der Beschreibung in die Werttyp-Zeile hochziehen, weil sie
    dort leichter zu uebersehen ist — ein Beleg dafuer, dass sie als
    verbindlich gelesen wird, und keiner fuer ein SHOULD.

    Erste der vier Pruefungen aus der Mission Die vier Luecken,
    state/missionen/2026-08-16-die-vier-luecken.md. Der Anlass ist eine
    Messung und kein Einfall: gegenprobe.sh hat am 2026-08-16 unter der
    Kennung "vagov-23608:§3.8.7" gezeigt, dass ein fremdes Werkzeug hier
    meldet und der ICS-Doktor schweigt. Dass es zu mild meldet — Warnung
    statt Fehler, mit einem SHOULD im Text —, aendert daran nichts: zu mild
    ist mehr als gar nicht. Dass der Fall real vorkommt, steht in deni-zen/qcal
    Nr. 19, offen seit 2014.

    **Genau eine Frage.** Steht der Wert in der UTC-Form? Ob er ueberhaupt ein
    DATE-TIME ist, fragt P08 und nicht diese Pruefung. Eine Zeile kann deshalb
    zwei Meldungen bekommen — P08 zur Form des Wertes, P16 zur fehlenden
    UTC-Angabe. Das ist dieselbe Aufteilung wie bei P08 und P13 auf Beispiel 12
    und Absicht: Zwei Saetze der Norm, zwei Befunde, jeder fuer sich richtig.
    Wer nur "kein DATE-TIME" liest, weiss nicht, dass ihm ausserdem die
    Zeitzone fehlt.

    **Auf einem Wert, der schon kein DATE-TIME ist, wird trotzdem gemeldet —
    nur anders formuliert.** Bis zum 2026-08-17 stand hier der Satz "verlangt
    ist ein 'Z' am Ende", auch auf einem Wert wie "NaNNaNNaNTNaNNaNNaN", den
    ein angehaengtes 'Z' nicht rettet. Der Rat trug nicht; die Klage schon.
    §3.8.7.2 verlangt die UTC-Form, und wer sie verfehlt, verfehlt sie auch
    dann, wenn er zusaetzlich §3.3.5 verfehlt. Geaendert wurde deshalb der
    Wortlaut und nicht der Befund. Die Begruendung im Absatz darueber traegt
    genau bis hierhin: Wer "kein DATE-TIME" liest und repariert, schreibt sonst
    Ortszeit hin und erfaehrt den zweiten Satz erst beim naechsten Lauf.

    **Warum die zweite Meldung P08 nicht beim Namen nennt.** Naheliegend waere
    "siehe P08". Bei "DTSTAMP;VALUE=DATE:20260901" schweigt P08 aber (ein
    anderer Wertetyp ist nicht seine Frage), waehrend diese Pruefung meldet —
    der Verweis waere dann ein Zeiger ins Leere. Der Satz steht deshalb fuer
    sich.

    **Was ausdruecklich nicht gemeldet wird:**

    - **Ortszeit in DTSTART, DTEND, DUE.** Dort ist sie erlaubt (§3.3.5,
      Form 2 und 3). Der UTC-Zwang steht in §3.8.7.2 und gilt fuer DTSTAMP;
      CREATED und LAST-MODIFIED tragen denselben Satz und bekommen ihn
      trotzdem nicht von dieser Pruefung — sie stehen in keiner der vier
      gemessenen Luecken, und eine Pruefung ohne Messung dahinter ist genau
      das, was diese Mission nicht baut. Die Grenze steht im README.
    - **Ein DTSTAMP, das ganz fehlt oder doppelt steht.** Das meldet P07.
    """
    for lz in logische:
        if lz.name != "DTSTAMP":
            continue
        tzid = None
        for pname, pwerte in lz.params:
            if pname == "TZID" and pwerte:
                tzid = pwerte[0]
        wert = lz.wert or ""
        if tzid is not None:
            funde.append(Fund(
                FEHLER, lz.nr, "P16",
                "DTSTAMP trägt den Parameter TZID=%s und steht damit in "
                "Ortszeit; verlangt ist die UTC-Form mit 'Z' am Ende"
                % _kurz(tzid),
                "3.8.7.2"))
            continue
        if _pruefe_datetime(wert, None) is not None:
            funde.append(Fund(
                FEHLER, lz.nr, "P16",
                "DTSTAMP steht mit %s nicht in der UTC-Form; der Wert ist "
                "schon kein DATE-TIME, ein angehängtes 'Z' genügt hier also "
                "nicht" % _zeige_wort(wert),
                "3.8.7.2"))
            continue
        if not wert.endswith("Z"):
            funde.append(Fund(
                FEHLER, lz.nr, "P16",
                "DTSTAMP steht mit %s nicht in der UTC-Form; verlangt ist ein "
                "'Z' am Ende" % _zeige_wort(wert),
                "3.8.7.2"))


# Die drei Formen, die ein UNTIL-Wert nach §3.3.10 haben kann, jeweils mit dem
# Wertetyp und dem Zeitbezug, den sie ausweist. Die Reihenfolge ist bedeutungslos,
# die Ausdruecke sind ueberschneidungsfrei.
_UNTIL_FORMEN = (
    (re.compile(r"^[0-9]{8}$"), ("DATE", "lokal")),
    (re.compile(r"^[0-9]{8}T[0-9]{6}Z$"), ("DATE-TIME", "utc")),
    (re.compile(r"^[0-9]{8}T[0-9]{6}$"), ("DATE-TIME", "lokal")),
)


def _until_wert(wert):
    """Der Wert des UNTIL-Regelteils aus einem RRULE-Wert, oder None.

    Der Wertetyp RECUR ist nach §3.3.10 eine Liste aus "teil=wert", getrennt
    durch Semikolon; die Namen der Regelteile sind gross geschrieben, werden
    hier aber tolerant gelesen. Steht UNTIL mehrfach, gewinnt der erste — das
    ist dieselbe Lesart wie bei hole_zeile und betrifft ohnehin nur Werte, die
    die Grammatik schon verletzen ("The rule parts are not ordered and MUST NOT
    occur more than once").
    """
    for teil in (wert or "").split(";"):
        name, gleich, rest = teil.partition("=")
        if gleich and name.strip().upper() == "UNTIL":
            return rest.strip()
    return None


def _until_form(wert):
    """(typ, bezug) eines UNTIL-Wertes oder None, wenn er keine Form trifft."""
    for muster, form in _UNTIL_FORMEN:
        if muster.match(wert):
            return form
    return None


def pruefe_p17(komponenten, funde):
    """§3.3.10: UNTIL passt zum DTSTART derselben Komponente.

    Woertlich, unter "Description": "The value of the UNTIL rule part MUST have
    the same value type as the 'DTSTART' property. Furthermore, if the
    'DTSTART' property is specified as a date with local time, then the UNTIL
    rule part MUST also be specified as a date with local time. If the
    'DTSTART' property is specified as a date with UTC time or a date with
    local time and time zone reference, then the UNTIL rule part MUST be
    specified as a date with UTC time."

    Zwei Saetze, zwei Meldungen: der Wertetyp und der Zeitbezug. Sie schliessen
    einander aus — wo der Typ schon abweicht, ist der Bezug keine zweite Frage,
    sondern dieselbe.

    Vierte und letzte Pruefung aus der Mission Die vier Luecken,
    state/missionen/2026-08-16-die-vier-luecken.md, und die einzige der vier,
    die schon einmal fallengelassen wurde: Am 2026-08-15 stand sie auf einer
    Mission und wurde gestrichen, weil das fremde Werkzeug sie hat. Zurueck ist
    sie nicht, weil ich sie schoen finde, sondern weil gegenprobe.sh sie am
    2026-08-16 unter der Kennung "simplecal-1983:§3.3.10" an einer echten
    Fremddatei als Luecke ausgewiesen hat. Dass der Fall in echter Software
    vorkommt, steht in jkbrzt/rrule Nr. 440, offen seit 2020.

    **Die Pruefung liest zwei Zeilen zueinander**, wie P12 bis P14, aber ueber
    eine Grenze hinweg, die es dort nicht gibt: Der zu vergleichende Wert steckt
    nicht in einer eigenen Eigenschaft, sondern in einem Regelteil innerhalb des
    RRULE-Wertes.

    **Wo geschwiegen wird, und warum das kein Versaeumnis ist:**

    - **Kein DTSTART in der Komponente.** Dann gibt es nichts zu vergleichen.
      Ob es fehlen darf, fragt P11 fuer VEVENT; hier waere jede Meldung geraten.
    - **Ein DTSTART, das keine der drei Formen aus §3.3.4/§3.3.5 trifft.** Das
      meldet P08 an seiner eigenen Zeile. Eine kaputte Anfangszeit macht jeden
      Vergleich mit ihr wertlos, nicht falsch.
    - **Ein UNTIL, das keine der drei Formen trifft** — etwa UNTIL=morgen oder
      UNTIL=20201220T14. Die Grammatik von RECUR prueft dieses Werkzeug
      nirgends, und diese Pruefung faengt sie nicht nebenbei auf: Sie
      beantwortet, ob UNTIL zum DTSTART passt, und nicht, ob der Wert
      wohlgeformt ist. Die Luecke steht im README.
    - **Ein RRULE ohne UNTIL.** Auch der Satz "The UNTIL or COUNT rule parts
      are OPTIONAL, but they MUST NOT occur in the same 'recur'" steht in
      §3.3.10, in der ABNF des RECUR-Wertes, und wird hier nicht geprueft — er
      ist eine andere Frage.

      Bis zum 2026-08-19 endete dieser Absatz mit "und nicht gemessen worden".
      Das stimmt seither nicht mehr: anlass.sh rechnet den Fall mit nach, ueber
      dieselben Eingaben wie die uebrigen. Gemessen am 2026-08-19: 8
      RRULE-Zeilen, kein einziger Treffer. Gebaut wird die Pruefung, wenn diese
      Messung einen Anlass zeigt, und nicht vorher.

      **Nachtrag vom 2026-08-24.** Die Pruefung ist gebaut, und der Absatz
      darueber bleibt stehen, wie er geschrieben wurde. Was er sagte, ist
      eingetreten und was er verlangte, ist es nicht: anlass.sh zaehlt ueber
      den Fremdkorpus weiter null Treffer. Der Anlass kam aus einer offenen
      Fremdklage gegen eine fremde Bibliothek statt aus der eigenen Zaehlung —
      ggaabe/rrule-temporal Nr. 128, zitiert in
      state/missionen/2026-08-24-die-doppelte-grenze.md. Wer "und nicht vorher"
      streng liest, findet hier eine Abweichung von der eigenen Ansage; sie
      wird benannt und nicht wegformuliert. Die neue Pruefung heisst P21, ihr
      Satz aus §3.3.10 ist ein anderer als der hier gepruefte, und sie liegt
      unter pruefe_p21.
    """
    for komp in komponenten:
        anfang = komp.hole_zeile("DTSTART")
        if anfang is None:
            continue
        start = _zeitpunkt(anfang)
        if start is None:
            continue                     # nicht vergleichbar: schweigen
        start_typ = start[0]
        start_bezug = start[1][0]        # "utc", "tzid" oder "lokal"
        for rrule in komp.zeitzeilen.get("RRULE", []):
            roh = _until_wert(rrule.wert)
            if roh is None:
                continue
            form = _until_form(roh)
            if form is None:
                continue                 # keine der drei Formen: schweigen
            until_typ, until_bezug = form
            if until_typ != start_typ:
                funde.append(Fund(
                    FEHLER, rrule.nr, "P17",
                    "UNTIL nennt mit %s einen Wert vom Typ %s, das DTSTART aus "
                    "Zeile %d ist vom Typ %s; verlangt ist derselbe Wertetyp"
                    % (_zeige_wort(roh), until_typ, anfang.nr, start_typ),
                    "3.3.10"))
                continue
            if until_typ != "DATE-TIME":
                continue                 # DATE gegen DATE: kein Zeitbezug
            if start_bezug in ("utc", "tzid") and until_bezug != "utc":
                wie = ("in UTC" if start_bezug == "utc"
                       else "mit Zeitzonenbezug")
                funde.append(Fund(
                    FEHLER, rrule.nr, "P17",
                    "UNTIL steht mit %s in Ortszeit, das DTSTART aus Zeile %d "
                    "steht %s; dann muss UNTIL in UTC stehen, mit 'Z' am Ende"
                    % (_zeige_wort(roh), anfang.nr, wie),
                    "3.3.10"))
            elif start_bezug == "lokal" and until_bezug != "lokal":
                funde.append(Fund(
                    FEHLER, rrule.nr, "P17",
                    "UNTIL steht mit %s in UTC, das DTSTART aus Zeile %d steht "
                    "in Ortszeit; dann muss UNTIL ebenfalls in Ortszeit stehen"
                    % (_zeige_wort(roh), anfang.nr),
                    "3.3.10"))


def _sieht_aus_wie_zeitpunkt(wert):
    """True, wenn der Wert die Gestalt eines DATE oder DATE-TIME hat.

    Nur fuer den Zusatzsatz von P18 gedacht: Wer einen absoluten Zeitpunkt
    hinschreibt, wo eine Dauer stehen muss, braucht einen anderen Hinweis als
    wer sich vertippt hat. Ob der Zeitpunkt gueltig ist, entscheidet diese
    Funktion nicht — das ist die Frage von P08.
    """
    return re.match(r"^[0-9]{8}(T[0-9]{6}Z?)?$", wert or "") is not None


def pruefe_p18(logische, funde):
    """§3.8.6.3: TRIGGER traegt eine DURATION, oder mit VALUE=DATE-TIME UTC.

    Woertlich, unter "Value Type": "The default value type is DURATION. The
    value type can be set to a DATE-TIME value type, in which case the value
    MUST specify a UTC-formatted DATE-TIME value." Die Beschreibung sagt es
    ein zweites Mal: "If a value type of DATE-TIME is specified, then the
    property value MUST be specified in the UTC time format."

    Zwei Saetze, zwei Zweige — und sie schliessen einander aus, weil der
    VALUE-Parameter entscheidet, welcher gilt.

    Dritte Pruefung aus der Mission Die vier Luecken,
    state/missionen/2026-08-16-die-vier-luecken.md, Luecke 1. Der Anlass ist
    eine Messung: gegenprobe.sh hat am 2026-08-16 unter der Kennung
    "rfc4-4:§3.3" gezeigt, dass ein fremdes Werkzeug hier meldet und der
    ICS-Doktor schweigt. Der Beleg kommt weder von ihm noch von mir, sondern
    vom RFC-Editor — Errata-ID 2039, Status Verified, gemeldet 2010-02-10,
    bestaetigt 2010-02-15. Es korrigiert genau die Zeile
    "TRIGGER:19980403T120000Z" im vierten Kalenderobjekt aus §4 zu
    "TRIGGER;VALUE=DATE-TIME:19980403T120000Z". Dass der Fall in echter
    Software vorkommt, steht in derekantrican/GAS-ICS-Sync Nr. 475, offen seit
    2025: Ein Erzeuger schreibt den absoluten Zeitpunkt ohne Parameter, und
    der Verbraucher zerbricht daran, weil er nach der Norm eine DURATION lesen
    muss.

    **Der erste Zweig ist bewusst nur halb scharf, und das ist keine
    Nachlaessigkeit.** Geprueft wird, ob der Wert ueberhaupt eine Dauer sein
    *kann*: Jede dur-value nach §3.3.6 beginnt nach einem optionalen Vorzeichen
    mit "P". Fehlt dieses "P", ist der Wert sicher keine Dauer — diese Richtung
    ist wasserdicht, ein Fehlalarm ist ausgeschlossen. Was hinter dem "P" steht,
    prueft niemand: "TRIGGER:PXYZ" geht stumm durch. Die Grammatik von §3.3.6
    prueft dieses Werkzeug an keiner Stelle, auch nicht bei DURATION selbst
    (siehe pruefe_p15), und sie hier fuer eine einzige Eigenschaft nebenbei zu
    erfinden waere eine Pruefung ohne Messung dahinter. Die Grenze steht im
    README.

    **Was ausdruecklich nicht gemeldet wird:**

    - **Ein VALUE-Parameter, der weder DURATION noch DATE-TIME nennt.** Die
      ABNF laesst nur diese beiden zu; welche Werte der VALUE-Parameter tragen
      darf, prueft dieses Werkzeug aber nirgends. Bei "TRIGGER;VALUE=DATE:..."
      schweigt P18 deshalb ganz, statt den Wert an einem Typ zu messen, den die
      Zeile gar nicht behauptet.
    - **Der RELATED-Parameter am absoluten Trigger.** §3.8.6.3 verbietet ihn
      dort ("The trigger relationship property parameter MUST only be
      specified when the value type is DURATION"). Das ist ein dritter Satz und
      steht in keiner gemessenen Abweichung; die Mission baut ihn nicht.
    - **Ein TRIGGER ausserhalb von VALARM.** Die Conformance-Zeile verlangt ihn
      dort; welche Eigenschaft in welche Komponente gehoert, prueft dieses
      Werkzeug nur fuer die Pflichtfaelle P06, P07 und P11.

    **Ein Wert, der schon kein DATE-TIME ist, wird seit dem 2026-08-17
    gemeldet.** Vorher schwieg P18 dort mit der Begruendung, ein angehaengtes
    'Z' rette "TRIGGER;VALUE=DATE-TIME:20260901T1000" nicht und ein Rat, der
    nicht traegt, sei schlechter als keiner. Der zweite Halbsatz stimmt, der
    Schluss daraus nicht: Nicht der Befund traegt nicht, sondern der Rat. Wer
    VALUE=DATE-TIME schreibt, hat sich nach §3.8.6.3 auf die UTC-Form
    festgelegt, und die verfehlt dieser Wert. Gemeldet wird deshalb mit
    geaendertem Wortlaut statt geschwiegen — dieselbe Regel wie bei P16.

    **Die Grenze zu P17 verlaeuft nicht zwischen diesen beiden Pruefungen,
    sondern zwischen Einzelwert und Beziehung.** P17 vergleicht UNTIL mit
    DTSTART; ist eine der beiden Seiten unlesbar, gibt es nichts zu
    vergleichen, und jede Meldung waere geraten. P16 und P18 messen einen Wert
    an einem Satz der Norm, den er allein verletzt — dafuer braucht es keine
    zweite Zeile. Bis zum 2026-08-17 stand die Grenze falsch, naemlich zwischen
    P16 und P18, und stand als Ungereimtheit in state/offen.md.
    """
    for lz in logische:
        if lz.name != "TRIGGER":
            continue
        typ = None
        tzid = None
        for pname, pwerte in lz.params:
            if pname == "VALUE" and pwerte:
                typ = pwerte[0].upper()
            elif pname == "TZID" and pwerte:
                tzid = pwerte[0]
        wert = lz.wert or ""

        if typ is None or typ == "DURATION":
            rest = wert[1:] if wert[:1] in ("+", "-") else wert
            if rest[:1].upper() == "P":
                continue                 # kann eine Dauer sein: schweigen
            if _sieht_aus_wie_zeitpunkt(wert):
                zusatz = ("; als absoluter Zeitpunkt braucht die Zeile den "
                          "Parameter VALUE=DATE-TIME")
            else:
                zusatz = ""
            funde.append(Fund(
                FEHLER, lz.nr, "P18",
                "TRIGGER nennt mit %s keine Dauer; ohne VALUE=DATE-TIME ist "
                "der Standardwerttyp DURATION, und die beginnt nach §3.3.6 "
                "mit \"P\"%s" % (_zeige_wort(wert), zusatz),
                "3.8.6.3"))
            continue

        if typ != "DATE-TIME":
            continue                     # anderer Typ: nicht diese Pruefung
        if tzid is not None:
            funde.append(Fund(
                FEHLER, lz.nr, "P18",
                "TRIGGER trägt den Parameter TZID=%s und steht damit in "
                "Ortszeit; mit VALUE=DATE-TIME verlangt §3.8.6.3 die UTC-Form "
                "mit \"Z\" am Ende" % _kurz(tzid),
                "3.8.6.3"))
            continue
        if _pruefe_datetime(wert, None) is not None:
            funde.append(Fund(
                FEHLER, lz.nr, "P18",
                "TRIGGER steht mit %s nicht in der UTC-Form; der Wert ist "
                "schon kein DATE-TIME, ein angehängtes \"Z\" genügt hier also "
                "nicht" % _zeige_wort(wert),
                "3.8.6.3"))
            continue
        if not wert.endswith("Z"):
            funde.append(Fund(
                FEHLER, lz.nr, "P18",
                "TRIGGER steht mit %s nicht in der UTC-Form; mit "
                "VALUE=DATE-TIME ist ein \"Z\" am Ende verlangt"
                % _zeige_wort(wert),
                "3.8.6.3"))


# Welche Komponente ausserhalb von VEVENT welche Pflichteigenschaften hat, mit
# dem Abschnitt, der die Pflicht ausspricht, und dem Abschnitt der Eigenschaft
# selbst. Die Angaben stehen woertlich in der ABNF der jeweiligen Komponente;
# der Wortlaut ist im Docstring von pruefe_p19 zitiert.
#
# VEVENT fehlt hier, weil P07 und P11 es abdecken — dieselbe Pflicht zweimal zu
# melden waere schlechter als sie einmal zu melden.
_PFLICHT_JE_KOMPONENTE = (
    ("VTODO", "3.6.2", (("UID", "3.8.4.7"), ("DTSTAMP", "3.8.7.2"))),
    ("VJOURNAL", "3.6.3", (("UID", "3.8.4.7"), ("DTSTAMP", "3.8.7.2"))),
    ("VFREEBUSY", "3.6.4", (("UID", "3.8.4.7"), ("DTSTAMP", "3.8.7.2"))),
    ("VALARM", "3.6.6", (("ACTION", "3.8.6.1"), ("TRIGGER", "3.8.6.3"))),
)


def pruefe_p19(komponenten, funde):
    """§3.6.2, §3.6.3, §3.6.4, §3.6.6: Pflichteigenschaften ausserhalb VEVENT.

    Woertlich, je Komponente aus ihrer eigenen Format Definition:

    - todoprop (§3.6.2), jourprop (§3.6.3) und fbprop (§3.6.4) fuehren
      "dtstamp / uid" unter "The following are REQUIRED, but MUST NOT occur
      more than once."
    - alarmc (§3.6.6) fuehrt "action / trigger" unter "'action' and 'trigger'
      are both REQUIRED, but MUST NOT occur more than once." Dieser Satz steht
      in allen drei Varianten — audioprop, dispprop und emailprop — gleich, und
      deshalb braucht diese Pruefung den Wert des ACTION nicht zu kennen.

    Vierte Pruefung aus der Mission Die vier Luecken,
    state/missionen/2026-08-16-die-vier-luecken.md, Luecke 2. Der Anlass ist
    eine Messung: gegenprobe.sh hat am 2026-08-16 unter der Kennung
    "rfc4-6:§3.6" gezeigt, dass ein fremdes Werkzeug das VFREEBUSY im sechsten
    Kalenderobjekt aus §4 beanstandet und der ICS-Doktor dazu schweigt. Der
    Beleg kommt auch hier nicht von ihm und nicht von mir, sondern vom
    RFC-Editor: Errata-ID 4149, Status Verified, gemeldet 2014-10-29,
    bestaetigt 2014-10-30. Es ergaenzt in genau diesem Objekt das fehlende UID
    und DTSTAMP und nennt als Begruendung die ABNF aus §3.6.4.

    Dass die Familie in echter Software vorkommt, steht in owncloud/tasks
    Nr. 272, offen seit 2015: Ein Programm meldet "Every VTODO component must
    have an UID", und der Melder haelt das fuer einen Fehler, weil UID in der
    ABNF von RFC 2445 §4.6.2 unter den optionalen Eigenschaften steht. In
    RFC 5545 §3.6.2 ist es REQUIRED. Der Bericht ist damit kein Beleg gegen die
    Pflicht, sondern dafuer, dass sie schwer zu finden ist.

    P07 macht dasselbe fuer VEVENT (§3.6.1), und diese Pruefung ist ihm
    absichtlich bis in den Wortlaut der Meldung nachgebaut: Wer beide Ausgaben
    nebeneinander liest, soll nicht zwei Werkzeuge zu hoeren glauben. VEVENT
    selbst bleibt bei P07 und P11 — eine zweite Meldung derselben Pflicht waere
    kein zweiter Befund.

    **Was ausdruecklich nicht geprueft wird:**

    - **Die aktionsabhaengigen Pflichten des VALARM.** dispprop verlangt
      zusaetzlich description, emailprop zusaetzlich description, summary und
      attendee. Welche der drei Varianten gilt, haengt am Wert des ACTION — und
      §3.8.6.1 laesst dort auch iana-token und x-name zu. Bei
      "ACTION:X-MEIN-WECKER" ist keine der drei Varianten anwendbar, und eine
      Pruefung, die dann die naechstliegende nimmt, meldet einen Verstoss gegen
      eine Regel, die es fuer diesen Wert nicht gibt. Keine gemessene
      Abweichung verlangt sie; sie steht als Befund in state/offen.md statt
      hier nebenbei gebaut zu werden. Dass keine Eingabe den Fall ausloest, ist
      seit dem 2026-08-18 kein Satz mehr, sondern eine Messung: anlass.sh
      rechnet ihn nach und endet mit 1, sobald er nicht mehr stimmt.
    - **VTIMEZONE (§3.6.5) und seine Unterkomponenten.** Auch dort steht eine
      Pflicht (tzid; in standardc und daylightc dtstart, tzoffsetto,
      tzoffsetfrom). Die Missionsdatei nennt unter Luecke 2 vier Komponenten,
      und diese ist keine davon: Die Messung, die den Anlass gibt, betrifft
      VFREEBUSY. Eine fuenfte Komponente ohne Messung dahinter waere eine
      Prueferweiterung, die sich hinterher als Teil der Aufgabe erzaehlen
      liesse. Ebenfalls in state/offen.md benannt und ebenfalls seit dem
      2026-08-18 von anlass.sh nachgerechnet.
    - **Die uebrigen Saetze der vier ABNFs.** Dass in todoprop 'due' und
      'duration' nicht zusammen stehen duerfen, meldet P14; dass zu 'repeat'
      ein 'duration' gehoert, meldet niemand. Diese Pruefung liest genau die
      Zeile "The following are REQUIRED" und keine andere.
    - **Eine dieser Komponenten am falschen Ort.** Ein VALARM ausserhalb von
      VEVENT und VTODO oder ein VFREEBUSY in einem VEVENT verstoesst gegen die
      Schachtelung aus §3.6; welche Komponente wohin gehoert, prueft dieses
      Werkzeug nirgends. P19 nimmt jede Komponente dieses Namens, wo sie steht.
    """
    for komp in komponenten:
        for name, abschnitt, pflichten in _PFLICHT_JE_KOMPONENTE:
            if komp.name != name:
                continue
            for eigenschaft, eigen_abschnitt in pflichten:
                treffer = komp.hole(eigenschaft)
                if not treffer:
                    funde.append(Fund(
                        FEHLER, komp.zeile, "P19",
                        "%s ab Zeile %d hat kein %s (§%s); die Eigenschaft ist "
                        "Pflicht und darf nur einmal vorkommen"
                        % (name, komp.zeile, eigenschaft, eigen_abschnitt),
                        abschnitt))
                for zeile, _ in treffer[1:]:
                    funde.append(Fund(
                        FEHLER, zeile, "P19",
                        "%s (§%s) steht zum wiederholten Mal im %s ab Zeile "
                        "%d; zuerst in Zeile %d"
                        % (eigenschaft, eigen_abschnitt, name, komp.zeile,
                           treffer[0][0]),
                        abschnitt))


def _recur_teil(wert, gesucht):
    """(erster Wert, Anzahl) eines Regelteils in einem RECUR-Wert.

    Liest denselben Wert wie _until_wert, nur fuer einen beliebigen Regelteil
    und mit der Anzahl daneben: "teil=wert", getrennt durch Semikolon, Namen
    tolerant gelesen. Ohne Treffer (None, 0).
    """
    erster = None
    anzahl = 0
    for teil in (wert or "").split(";"):
        name, gleich, rest = teil.partition("=")
        if gleich and name.strip().upper() == gesucht:
            anzahl += 1
            if erster is None:
                erster = rest.strip()
    return erster, anzahl


def pruefe_p21(logische, funde):
    """§3.3.10: COUNT und UNTIL stehen nicht in derselben RRULE.

    DER NORMTEXT, woertlich aus der ABNF des RECUR-Wertes in §3.3.10:

        ; The UNTIL or COUNT rule parts are OPTIONAL,
        ; but they MUST NOT occur in the same 'recur'.

    Am 2026-08-24 am Normtext an seiner Fundstelle nachgewiesen (HTTP 200):
    Der Satz steht genau einmal im ganzen RFC 5545, und zwar im Abschnitt
    3.3.10 "Recurrence Rule". Er steht dort als Kommentarzeile IN der ABNF und
    nicht in der Prosa unter "Description" — das ist kein schwaecherer Ort,
    sondern der normative Teil der Wertdefinition, aber es gehoert
    hingeschrieben, weil P17 seinen Satz aus der Prosa desselben Abschnitts
    nimmt.

    **Was diese Pruefung von P17 trennt.** Beide zitieren §3.3.10 und beide
    lesen den RECUR-Wert einer RRULE. P17 vergleicht den UNTIL-Wert mit dem
    DTSTART und braucht dafuer zwei Zeilen; P21 braucht nur die eine, denn der
    Verstoss steckt ganz in ihr. Eine RRULE kann beide Meldungen zugleich
    bekommen: COUNT und UNTIL zusammen (P21) und ein UNTIL, das nicht zum
    DTSTART passt (P17). Das ist kein doppelter Befund, sondern sind zwei
    Saetze derselben Norm.

    **Warum ueber die logischen Zeilen und nicht ueber die Komponenten.**
    P17 laeuft ueber komponenten, weil es das DTSTART daneben braucht. Hier
    gibt es nichts daneben: Eine RRULE mit COUNT und UNTIL ist falsch, wo immer
    sie steht — auch in STANDARD und DAYLIGHT innerhalb einer VTIMEZONE, wo
    §3.6.5 sie ausdruecklich erlaubt, und auch in einer Zeile, die ausserhalb
    jeder Komponente steht. Ueber die Komponentenliste waeren die letzten
    beiden Faelle stumm, ohne dass irgendwo stuende, warum.

    **Wo geschwiegen wird, und warum das kein Versaeumnis ist:**

    - **Nur COUNT oder nur UNTIL.** Beide Regelteile sind OPTIONAL; einzeln
      sind sie richtig. Genau das ist der haeufige Fall, und ein Fehlalarm
      dort waere teurer als die ganze Pruefung wert ist.
    - **Eine Zeile, die P04 nicht lesen konnte.** Sie traegt keinen Namen und
      wird hier nicht angefasst — dieselbe Grenze wie ueberall im Werkzeug.
    - **Ein doppeltes COUNT oder ein doppeltes UNTIL fuer sich.** "The rule
      parts are not ordered and MUST NOT occur more than once" steht im selben
      Abschnitt und ist eine andere Frage; dieses Werkzeug prueft die Grammatik
      des RECUR-Wertes nirgends. Die Anzahl wird hier trotzdem gelesen, aber
      nur, um im Meldungstext nicht die zweite Nennung zu unterschlagen.
    - **Ob COUNT oder UNTIL wohlgeformt sind.** Ein "COUNT=viele" ist nach
      dieser Pruefung derselbe Verstoss wie ein "COUNT=2": Verboten ist das
      Zusammentreffen der Regelteile, nicht ein bestimmter Wert.

    ANLASS. Bis zum 2026-08-24 stand im Docstring von pruefe_p17, gebaut werde
    diese Pruefung, "wenn diese Messung einen Anlass zeigt, und nicht vorher" —
    gemeint war die Zaehlung von anlass.sh ueber den Fremdkorpus, die am
    2026-08-19 und am 2026-08-24 null Treffer hatte und weiter null Treffer
    hat. Der Anlass kommt von woanders her: aus einer offenen Fremdklage gegen
    eine fremde Bibliothek, ggaabe/rrule-temporal Nr. 128, eroeffnet am
    2026-08-02, am 2026-08-24 als offen abgerufen. Sie ist im Wortlaut in
    state/missionen/2026-08-24-die-doppelte-grenze.md zitiert. Das ist eine
    Klage und nicht fuenf, und der Fremdkorpus stuetzt sie nicht mit — beides
    steht so in der Missionsdatei und wird hier nicht dicker geschrieben.

    NACHTRAG 2026-08-24, Zyklus 59 — eine fuenfte Stelle, an der geschwiegen
    wird. Sie stand oben nicht, und sie ist die einzige der fuenf, an der die
    Datei trotz des Schweigens fehlerhaft ist. Zwei GETRENNTE RRULE-Zeilen in
    derselben Komponente,

        RRULE:FREQ=DAILY;COUNT=5
        RRULE:FREQ=WEEKLY;UNTIL=20260901T090000Z

    in einem sonst gueltigen VEVENT, ergeben Exit 0 und keine einzige Meldung.
    Gemessen an diesem Tag gegen 19:06 UTC, stderr leer.

    Fuer P21 ist dieses Schweigen richtig: Der Satz aus §3.3.10 verbietet das
    Zusammentreffen im selben 'recur', und hier sind es zwei. Die Datei ist
    trotzdem falsch, nur nach einer anderen Norm. §3.6.1 fuehrt "rrule" in der
    ABNF von eventprop unter

        ; The following is OPTIONAL,
        ; but SHOULD NOT occur more than once.

    und Anhang A.1 Nummer 2 von RFC 5545 nennt dieselbe Einschraenkung als
    Neuerung gegenueber RFC 2445. Beides am 2026-08-24 am Normtext an seiner
    Fundstelle nachgesehen (HTTP 200), nicht erinnert.

    Gebaut wird das hier nicht, und zwar nicht aus Zeitmangel: Es ist ein
    SHOULD NOT statt eines MUST NOT, es liegt keine fremde Klage dafuer vor,
    und anlass.sh kennt den Fall nicht. Eine Pruefung entsteht in diesem
    Projekt erst, wenn ein Anlass da ist. Der Befund steht in state/offen.md
    und ist nicht dadurch erledigt, dass er hier benannt ist.

    NACHTRAG 2026-08-25, Zyklus 63 — eine SECHSTE Stelle, an der geschwiegen
    wird, und wie die fuenfte eine, an der die Datei trotzdem fehlerhaft ist.
    Ein Regelteil, dessen Name auf COUNT oder UNTIL endet, ohne einer zu sein:

        RRULE:FREQ=DAILY;X-COUNT=2;UNTIL=20260901T090000Z
        RRULE:FREQ=DAILY;COUNT=2;X-UNTIL=20260901T090000Z

    Beide ergeben Exit 0 und keine Meldung, gemessen am 2026-08-25 gegen
    19:02 UTC, stderr leer. Das ist richtig: _recur_teil vergleicht den
    ganzen Namen links vom ersten "=" und nicht ein Stueck davon. Eine
    Umsetzung, die stattdessen "COUNT=" im Wert SUCHT, alarmiert hier falsch —
    dieselbe Falle wie beim Muster im Parameterwert (Beispiel 61), nur eine
    Ebene tiefer. Beide Zeilen liegen als beispiele/63-p21-regelteil-mit-x-
    praefix.ics im Repo, mit leerer Erwartung.

    Fehlerhaft sind sie dennoch: Die ABNF von §3.3.10 fuehrt unter
    recur-rule-part genau VIERZEHN Alternativen, von FREQ bis WKST, und
    KEINEN x-name-Zweig — nachgesehen am Normtext an seiner Fundstelle am
    2026-08-25 (HTTP 200), nicht erinnert. Ein X-COUNT ist dort also kein
    erlaubter Regelteil, sondern gar keiner. Gemeldet wird das hier nicht,
    weil dieses Werkzeug die Grammatik des RECUR-Wertes nirgends prueft (siehe
    oben, dritter Spiegelstrich) — der Befund steht in state/offen.md.
    """
    for lz in logische:
        if lz.name != "RRULE":
            continue
        count, count_n = _recur_teil(lz.wert, "COUNT")
        until, until_n = _recur_teil(lz.wert, "UNTIL")
        if count is None or until is None:
            continue
        funde.append(Fund(
            FEHLER, lz.nr, "P21",
            "die Wiederholungsregel nennt COUNT (%s) und UNTIL (%s) "
            "zugleich%s; beide Regelteile sind einzeln erlaubt, aber nicht in "
            "derselben RRULE"
            % (_zeige_wort(count), _zeige_wort(until),
               "" if count_n == 1 and until_n == 1 else ", mehrfach"),
            "3.3.10"))


_BOM_UTF8 = b"\xef\xbb\xbf"


def pruefe_p20(rohdaten, funde):
    """§3.4: Vor BEGIN:VCALENDAR steht nichts, auch keine BOM.

    Rueckgabe: (rohdaten ohne BOM, hatte_bom).

    DER NORMTEXT. §3.4 gibt die Grammatik des Stroms an:

        icalstream = 1*icalobject
        icalobject = "BEGIN" ":" "VCALENDAR" CRLF icalbody
                     "END" ":" "VCALENDAR" CRLF

    und davor im selben Abschnitt: "The first line and last line of the
    iCalendar object MUST contain a pair of iCalendar object delimiter
    strings." Ein U+FEFF vor dem Literal "BEGIN" ist von dieser Grammatik nicht
    gedeckt. RFC 5545 erwaehnt die BOM an keiner Stelle; sie ist deshalb nicht
    ausdruecklich verboten, sondern schlicht nicht vorgesehen — der Befund
    steht auf der Grammatik und auf nichts sonst.

    WARUM DIESE PRUEFUNG DAS BYTE ENTFERNT, STATT NUR ZU MELDEN. Ohne das
    Entfernen meldete das Werkzeug am Stand 0bbd7d8 auf beispiele/47-p20-bom.ics
    — einer bis auf die BOM tadellosen Datei — fuenf Zeilen:

        FEHLER Zeile  1: P04 Eigenschaftsname enthält '<unsichtbar>'; ...
        FEHLER Zeile  2: P05 Eigenschaft "VERSION" steht außerhalb jeder Komponente
        FEHLER Zeile  3: P05 Eigenschaft "PRODID" steht außerhalb jeder Komponente
        FEHLER Zeile  4: P05 äußerste Komponente ist "VEVENT"; ...
        FEHLER Zeile 11: P05 END:VCALENDAR ohne vorangehendes BEGIN

    Die erste Zeile war richtig, aber unlesbar: Sie zitiert ein Zeichen, das
    keine Breite hat, und der Leser sucht in seiner Datei nach nichts. Die
    anderen vier waren schlicht falsch — VERSION und PRODID stehen sehr wohl in
    einer Komponente, die aeusserste ist VCALENDAR, und das END:VCALENDAR hat
    sehr wohl ein BEGIN. Ein Werkzeug, dessen Zweck es ist, Zeile, Regel und
    Abschnitt zu nennen, darf nicht viermal die falsche Ursache nennen, davon
    einmal zehn Zeilen weiter unten. Deshalb faellt das Byte weg, bevor
    irgendeine andere Pruefung es sieht, und der Befund steht genau einmal da.

    Statt das Zeichen zu zitieren, nennt die Meldung die drei Bytes im
    Klartext: EF BB BF. Wer sie sucht, findet sie damit auch in einem
    Editor, der U+FEFF nicht anzeigt.

    ZU P03. Die Laenge in Oktetten wird nach dem Entfernen gemessen, Zeile 1
    ist also drei Oktette kuerzer als in der Datei. Das ist Absicht und keine
    Ungenauigkeit: §3.1 empfiehlt die 75 Oktette fuer Inhaltszeilen, und die
    BOM ist keine — sie steht vor dem Objekt, nicht darin.

    NICHT GEPRUEFT wird die Bytefolgemarkierung fuer UTF-16 (FF FE, FE FF).
    Eine Datei in UTF-16 verletzt §6 ("Applications MUST generate iCalendar
    streams in the UTF-8 charset"), aber im Repo gibt es dafuer keinen Beleg
    und in der Suche vom 2026-08-18 keinen oeffentlichen Fehlerbericht. Der
    Befund steht ohne Frist in state/offen.md; gebaut wird er, wenn eine
    Messung einen Anlass zeigt, und nicht vorher.

    DER ANLASS AUS DER WELT. mampfes/hacs_waste_collection_schedule #541,
    geschlossen, vom 2023-01-01: Ein Abfallkalender einer Stadt liefert .ics
    mit BOM, und der Verbraucher bricht ab mit
    "ValueError: Content line could not be parsed into parts:
    '<BOM>BEGIN:VCALENDAR'". Genau dieser Nutzer bekam vom ICS-Doktor bis
    heute drei falsche Ursachen genannt.
    """
    if not rohdaten.startswith(_BOM_UTF8):
        return rohdaten, False
    funde.append(Fund(
        FEHLER, 1, "P20",
        "die Datei beginnt mit einer UTF-8-Bytefolgemarkierung "
        "(BOM, die drei Bytes EF BB BF) vor BEGIN:VCALENDAR; ein "
        "iCalendar-Objekt beginnt mit BEGIN",
        "3.4"))
    return rohdaten[len(_BOM_UTF8):], True


def untersuche(rohdaten):
    """Alle einundzwanzig Pruefungen. Rueckgabe: sortierte Liste der Funde."""
    funde = []
    rohdaten, hatte_bom = pruefe_p20(rohdaten, funde)
    zeilen = zerlege_physisch(rohdaten)
    if not zeilen:
        # Ohne BOM heisst "keine Zeile" eine leere Datei. Mit BOM waere dieser
        # Satz falsch: Die Datei hat drei Bytes, sie sind nur keine Zeile.
        if hatte_bom:
            text = ("die Datei enthält außer der Bytefolgemarkierung nichts; "
                    "ein iCalendar-Objekt beginnt mit BEGIN:VCALENDAR")
        else:
            text = ("die Datei ist leer; ein iCalendar-Objekt beginnt mit "
                    "BEGIN:VCALENDAR")
        funde.append(Fund(FEHLER, 1, "P05", text, "3.4"))
        # Auch dieser Zweig sortiert. Bis zum 2026-08-18 stand hier ein
        # blankes "return funde" — richtig, solange genau ein Fund entstehen
        # konnte, und ab P20 nicht mehr.
        funde.sort(key=lambda f: (f.zeile, f.code))
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
    pruefe_p09(logische, funde)
    pruefe_p10(zeilen, funde)
    pruefe_p11(komponenten, funde)
    pruefe_p12(komponenten, funde)
    pruefe_p13(komponenten, funde)
    pruefe_p14(komponenten, funde)
    pruefe_p15(logische, funde)
    pruefe_p16(logische, funde)
    pruefe_p17(komponenten, funde)
    pruefe_p18(logische, funde)
    pruefe_p19(komponenten, funde)
    pruefe_p21(logische, funde)
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
