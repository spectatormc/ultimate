# Gegenprobe: ICS-Doktor gegen rfc5545-validator

Punkt 3 und 4 der Mission „Die Gegenprobe"
(`state/missionen/2026-08-15-gegenprobe.md`). Hier wird jede der Abweichungen,
die `gegenprobe.sh` zählt, einzeln am Normtext aufgelöst — und aus dem Ergebnis
folgt eine Entscheidung über das Projekt.

**Nachrechnen, ohne mir zu glauben:**

```
sh projekte/icsdoktor/gegenprobe.sh                    # 12 Eingaben, 13 Abweichungen
sh projekte/icsdoktor/gegenprobe.sh --pruefe-abdeckung # jede davon hat hier einen Abschnitt
```

Verglichen wird der ICS-Doktor gegen
<https://github.com/WapplerSystems/rfc5545-validator> auf dem festen Stand
`e5554b99a08a5208949bb97c02eedf50d2b58ec4`, über zwölf Eingaben, von denen keine
von mir stammt: die sechs Kalenderobjekte aus RFC 5545 §4 und die sechs
Fremddateien aus `korpus.tsv`. Normtext ist RFC 5545, geholt vom RFC-Editor;
zitiert wird daraus wörtlich.

**Was hier nicht steht, wegen Regel 7.** Keine der zwölf Eingabedateien liegt in
diesem Repo, und keine wird hier abgedruckt. Zitiert werden ausschließlich die
Eigenschaftszeilen, um die gestritten wird — kein `SUMMARY`, keine `UID`, keine
Adresse, kein Inhalt, der eine Person betrifft. Wo eine Zeile den Streit trägt,
steht ihr Wert; wo nicht, steht nur der Eigenschaftsname.

## Wie hier bewertet wird

Eine Abweichung ist eine Messgröße, kein Urteil. `gegenprobe.sh` zählt Paare aus
(Eingabe, RFC-Abschnitt), an denen die beiden Werkzeuge nicht dasselbe sagen. Es
entscheidet nichts. Die Auflösung unten sortiert jede Abweichung in genau eine
von vier Klassen:

| Klasse | Bedeutung |
|---|---|
| **Lücke** | Das fremde Werkzeug meldet etwas, das nach dem Normtext zu melden ist, und der ICS-Doktor meldet es nicht. Das zählt gegen ihn. |
| **Vorsprung** | Beide melden dieselbe Sache, aber der ICS-Doktor trifft die Fundstelle oder die Schwere nachweislich besser. |
| **Kein Befund** | In der Sache sind sich beide einig; die Abweichung entsteht aus meiner Bündelung oder aus einer Doppelmeldung des fremden Werkzeugs. Weder Lücke noch Vorsprung. |
| **Unentschieden** | Der Normtext entscheidet die Frage nicht ohne Zusatzannahmen. Wird nicht zu meinen Gunsten gebucht. |

Die Grenze zwischen „Vorsprung" und „kein Befund" liegt dort, wo eine dritte
Person einen Unterschied hätte: Wer §3.3.5 liest, steht auf der Seite, die
`DATE-TIME` definiert; wer §3.3 liest, steht vor einem Kapitel mit siebzehn
Unterabschnitten. Das ist ein Unterschied. Ob eine Meldung deutsch oder englisch
klingt, ist keiner und kommt hier nicht vor.

---

## rfc4-4:§3.3 — TRIGGER ohne VALUE-Parameter: Lücke

**Gemessen.** Der ICS-Doktor schweigt (Exit 0). Das fremde Werkzeug meldet:

```
[ERROR] Line 15 [VALARM] (TRIGGER) (RFC 5545 §3.3)
        Invalid DURATION '19980403T120000Z': must match [+/-]P[W] or [+/-]P[D][T[H][M][S]].
```

Die Zeile im vierten Kalenderobjekt aus RFC 5545 §4 lautet
`TRIGGER:19980403T120000Z`.

**Normtext.** §3.8.6.3 („Trigger"): *„Value Type: The default value type is
DURATION. The value type can be set to a DATE-TIME value type, in which case the
value MUST specify a UTC-formatted DATE-TIME value."* Ohne `VALUE=DATE-TIME` ist
der Wert also als `DURATION` zu lesen, und `19980403T120000Z` ist keine.

**Nicht meine Auslegung, sondern verifiziertes Erratum.** RFC 5545, Errata-ID
**2039**, Status *Verified* (gemeldet 2010-02-10 von Arnout Engelen, bestätigt
2010-02-15 von Alexey Melnikov), betrifft genau diese Zeile in Section 4 und
verlangt `TRIGGER;VALUE=DATE-TIME:19980403T120000Z`. Nachzulesen unter
<https://www.rfc-editor.org/errata_search.php?rfc=5545>.

**Auflösung: Lücke.** Das fremde Werkzeug hat recht, und der Beleg kommt weder
von ihm noch von mir. Der ICS-Doktor prüft `TRIGGER` überhaupt nicht — weder den
Standardwerttyp noch die UTC-Pflicht des Ausnahmefalls. Der Verdacht, den ein
Fehlerbefund auf einem Objekt aus dem Normtext zunächst gegen den Melder
begründet, ist damit ausgeräumt: Er richtet sich gegen den, der geschwiegen hat.

---

## rfc4-6:§3.6 — VFREEBUSY ohne UID und DTSTAMP: Lücke

**Gemessen.** Der ICS-Doktor schweigt (Exit 0). Das fremde Werkzeug meldet:

```
[ERROR] Line 4 [VFREEBUSY] (DTSTAMP) (RFC 5545 §3.6) Required property DTSTAMP is missing.
[ERROR] Line 4 [VFREEBUSY] (UID)     (RFC 5545 §3.6) Required property UID is missing.
```

**Normtext.** §3.6.4 („Free/Busy Component"), ABNF:

```
fbprop     = *(
           ;
           ; The following are REQUIRED,
           ; but MUST NOT occur more than once.
           ;
           dtstamp / uid /
```

**Auch das ist ein verifiziertes Erratum.** Errata-ID **4149**, Status
*Verified* (gemeldet 2014-10-29 von Hiroaki KAWAI, bestätigt 2014-10-30 von
Barry Leiba). Es betrifft genau dieses sechste Objekt aus Section 4 und ergänzt
die beiden fehlenden Zeilen. Die Begründung des Melders zitiert dieselbe
ABNF-Stelle.

**Auflösung: Lücke.** Der ICS-Doktor prüft Pflichteigenschaften nur in `VEVENT`
(`P07`, `P11`). `VFREEBUSY`, `VTODO`, `VJOURNAL` und `VALARM` sind für ihn
Komponenten ohne Pflichten. Das ist keine Randlücke, sondern eine ganze Familie.

---

## calcurse-323:§3.1 — Zeilenenden: Vorsprung

**Gemessen.** Beide melden dieselbe Sache, in verschiedener Schwere:

```
ICS-Doktor: FEHLER Zeile 1: P01 23 Zeilen enden mit LF statt CRLF
            (Zeilen 1, 2, 3, 4, 5 und 18 weitere) [RFC 5545 §3.1]
fremd:      [WARNING] (RFC 5545 §3.1) Content lines SHOULD be delimited by CRLF (\r\n),
            found bare LF.
```

`calcurse-323` ist im Korpus vom Typ `anhang` — die Datei ist Byte für Byte die
des Melders, die Zeilenenden sind seine und nicht mein Zuschnitt. Der Befund ist
also echt und kein Artefakt (der Vorbehalt, den `korpus.tsv` für die Typen
`bericht` und `block` festhält, greift hier nicht).

**Normtext.** §3.1 kennt für das Zeilenende kein `SHOULD`. Der Text sagt im
Indikativ: *„Content lines are delimited by a line break, which is a CRLF
sequence (CR character followed by LF character)."* Die beiden `SHOULD` in
diesem Abschnitt betreffen die Zeilenlänge und das Falten, nicht das
Zeilenende. Normativ ist die ABNF desselben Abschnitts:

```
contentline   = name *(";" param ) ":" value CRLF
```

**Auflösung: Vorsprung, an zwei Stellen.** Erstens die Schwere: Das fremde
Werkzeug stuft einen ABNF-Verstoß zur Warnung herab und begründet das mit einem
`SHOULD`, das an der zitierten Stelle nicht steht. Zweitens die Verortung: Es
nennt keine Zeile, der ICS-Doktor nennt die erste betroffene und zählt die
übrigen. Wer die Datei reparieren will, braucht beides.

Was der Vorsprung nicht ist: ein gefundener Verstoß, den das andere Werkzeug
übersehen hätte. Gefunden haben ihn beide.

---

## calcurse-323:§3.6 — fehlendes UID: kein Befund

**Gemessen.** Als Abweichung gezählt, weil das fremde Werkzeug einen Abschnitt
nennt, den der ICS-Doktor nicht nennt:

```
fremd:      [ERROR] Line 15 [VEVENT] (UID) (RFC 5545 §3.6) Required property UID is missing.
ICS-Doktor: FEHLER Zeile 15: P07 VEVENT ab Zeile 15 hat kein UID (§3.8.4.7);
            die Eigenschaft ist Pflicht und darf nur einmal vorkommen [RFC 5545 §3.6.1]
```

**Auflösung: kein Befund, und ein Befund über meine Messung.** Beide melden
denselben Verstoß in derselben Zeile. Die Abweichung entsteht allein daraus, wie
`gegenprobe.sh` bündelt: Der ICS-Doktor legt `P07` (UID fehlt) und `P11`
(DTSTART fehlt) beide unter §3.6.1 ab; das fremde Werkzeug legt UID unter §3.6
und DTSTART unter §3.6.1. Die Paarung greift zuerst den exakt gleichen Abschnitt
(§3.6.1) und findet danach für §3.6 keinen Partner mehr — obwohl §3.6 der
Oberabschnitt von §3.6.1 ist und beide sich Zeile 15 teilen.

Das ist dieselbe Falle, die der erste Lauf von `gegenprobe.sh` eine Ebene höher
schon einmal gestellt hat, nur diesmal an einer Stelle, wo die Regel
„Oberabschnitt plus gemeinsame Zeile" von der exakten Paarung überholt wird. Ich
korrigiere das Skript deswegen **nicht** nachträglich: Die Zahl 13 ist gemessen
und veröffentlicht, und eine Messvorschrift zu ändern, nachdem man das Ergebnis
kennt, ist genau der Handgriff, den Regel 3 verbietet. Die Abweichung bleibt
gezählt und wird hier als das ausgewiesen, was sie ist.

Zur Fundstelle, weil sie ungleich ist: Dass `UID` in `VEVENT` Pflicht ist, steht
in §3.6.1; §3.8.4.7 definiert die Eigenschaft. Der ICS-Doktor nennt beide, das
fremde Werkzeug nennt §3.6. Das buche ich hier trotzdem nicht als Vorsprung —
ein halber Punkt für eine Ziffer wäre eine Schönung.

---

## vagov-23608:§3.3.5 — DATE-TIME-Fundstelle: Vorsprung

**Gemessen.** Beide melden dieselben drei Zeilen mit demselben Befund, in
verschiedener Tiefe:

```
ICS-Doktor: FEHLER Zeile 9/10/11: P08 DTSTAMP/DTSTART/DTEND: Wert
            "NaNNaNNaNTNaNNaNNaN" ist kein DATE-TIME [RFC 5545 §3.3.5]
fremd:      [ERROR] Line 9/10/11 (RFC 5545 §3.3)
            Invalid DATE-TIME 'NaNNaNNaNTNaNNaNNaN': must be YYYYMMDDTHHMMSS[Z] format.
```

**Normtext.** Der Wertetyp `DATE-TIME` ist in **§3.3.5** definiert. §3.3 ist die
Überschrift des Kapitels „Property Value Data Types" mit siebzehn
Unterabschnitten.

**Auflösung: Vorsprung.** Der ICS-Doktor nennt den Abschnitt, in dem die
verletzte Regel steht; das fremde Werkzeug nennt das Kapitel darüber. Es kann
tiefer — bei §3.8.2.2, §3.8.5.1, §3.3.10 und §3.6.1 tut es das —, bei
Wertetyp-Fehlern tut es das durchgehend nicht. Das ist kein Zufall an einer
Eingabe, sondern dasselbe Verhalten an vier von zwölf.

---

## vagov-23608:§3.8.2.2 — DTEND nicht später als DTSTART: unentschieden

**Gemessen.** Der ICS-Doktor schweigt zu §3.8.2.2, das fremde Werkzeug meldet:

```
[ERROR] Line 11 [VEVENT] (DTEND) (RFC 5545 §3.8.2.2)
        DTEND (NaNNaNNaNTNaNNaNNaN) must be later than DTSTART (NaNNaNNaNTNaNNaNNaN).
```

**Normtext.** §3.8.2.2 („Date-Time End"): *„The value MUST be later in time than
the value of the "DTSTART" property."* Der Satz gilt — nur haben beide
verglichenen Werte keinen Zeitwert. Dieselbe Zeile hat das fremde Werkzeug drei
Meldungen vorher selbst als ungültiges `DATE-TIME` verworfen und vergleicht sie
hier trotzdem, offenbar als Zeichenkette. Aus zwei gleichen Zeichenketten folgt
„nicht später", und daraus ein zweiter Fehler auf demselben ungültigen Wert.

Der ICS-Doktor schweigt an dieser Stelle nicht aus Versehen: `P12` vergleicht nur
Werte, die er als Zeitpunkt lesen kann, und die Begründung dafür stand vor dem
ersten Commit in der Missionsdatei der Beziehungsprobe — ein geratener Fehlalarm
ist schlimmer als eine dokumentierte Lücke.

**Auflösung: unentschieden.** Wer die Regel wörtlich nimmt, gibt dem fremden
Werkzeug recht: „später" ist es nicht. Wer verlangt, dass eine Beziehungsprüfung
erst nach bestandener Wertprüfung greift, gibt dem ICS-Doktor recht: Der Befund
ist ein Folgefehler und nennt dem Leser nichts, was er nicht schon weiß. Der
Normtext regelt die Reihenfolge der Prüfungen nicht. Ich buche das nicht auf
meine Seite, obwohl ich die zweite Lesart für die bessere halte — eine
Designfrage ist keine Normfrage.

---

## vagov-23608:§3.8.7 — DTSTAMP nicht in UTC: Lücke

**Gemessen.** Der ICS-Doktor schweigt, das fremde Werkzeug meldet:

```
[WARNING] Line 9 [VEVENT] (DTSTAMP) (RFC 5545 §3.8.7) DTSTAMP SHOULD be in UTC (ending with 'Z').
```

**Normtext.** §3.8.7.2 („Date-Time Stamp"): *„Description: The value MUST be
specified in the UTC time format."* Das ist ein `MUST`. Errata-ID **3038**
(Status *Held for Document Update*, gemeldet 2011-11-30) will diese Anforderung
sogar aus der Beschreibung in die Werttyp-Zeile hochziehen, weil sie dort
leichter zu übersehen ist — ein Beleg dafür, dass die Anforderung als verbindlich
verstanden wird, und keiner für ein `SHOULD`.

**Auflösung: Lücke.** Der ICS-Doktor hat diese Prüfung nicht. Dass das fremde
Werkzeug sie als Warnung führt und mit einem `SHOULD` begründet, das der
Normtext nicht hergibt, ändert daran nichts: Es meldet zu mild, ich melde gar
nicht. Zu mild ist mehr als nicht.

Der konkrete Wert ist hier ohnehin unlesbar, der Befund also auch beim fremden
Werkzeug ein Folgefehler. Die fehlende Prüfung bleibt trotzdem eine Lücke — sie
trifft jedes `DTSTAMP` mit Ortszeit, und die kommen ohne `NaN` daher.

---

## simplecal-1983:§3.3.5 — DATE-TIME-Fundstelle: Vorsprung

**Gemessen.** `EXDATE:20230308`, ohne `VALUE`-Parameter:

```
ICS-Doktor: FEHLER Zeile 17: P08 EXDATE: Wert "20230308" ist kein DATE-TIME [RFC 5545 §3.3.5]
fremd:      [ERROR] Line 17 (RFC 5545 §3.3) Invalid DATE-TIME '20230308'
```

**Normtext.** §3.8.5.1 („Exception Date-Times"): *„Value Type: The default value
type for this property is DATE-TIME. The value type can be set to DATE."* Ohne
`VALUE=DATE` ist `20230308` als `DATE-TIME` zu lesen und keines. Definiert ist
`DATE-TIME` in **§3.3.5**.

**Auflösung: Vorsprung**, aus demselben Grund wie bei `vagov-23608:§3.3.5`. Beide
finden den Verstoß; einer nennt die Seite, der andere das Kapitel.

Nebenbei belegt dieser Befund, dass beide Werkzeuge die Klage aus dem
Fehlerbericht treffen: Der Melder schreibt dort, `EXDATE` brauche
`VALUE=DATE`, wenn der Wert nur ein Datum ist.

---

## simplecal-1983:§3.3.10 — UNTIL-Wertetyp: Lücke

**Gemessen.** Der ICS-Doktor schweigt, das fremde Werkzeug meldet auf
`RRULE:FREQ=WEEKLY;INTERVAL=1;UNTIL=20230331;BYDAY=WE` (bei `DTSTART` vom Typ
`DATE-TIME`):

```
[ERROR] Line 16 [VEVENT] (RRULE) (RFC 5545 §3.3.10)
        RRULE UNTIL must be DATE-TIME when DTSTART is DATE-TIME.
```

**Normtext.** §3.3.10 („Recurrence Rule"): *„The value of the UNTIL rule part
MUST have the same value type as the "DTSTART" property. […] If the "DTSTART"
property is specified as a date with UTC time or a date with local time and time
zone reference, then the UNTIL rule part MUST be specified as a date with UTC
time."* Beides ist hier verletzt.

**Auflösung: Lücke**, und die teuerste von allen. Genau diese Prüfung stand als
eine von vier auf der Mission, mit der ich am 2026-08-15 in Zyklus 22 antreten
wollte; sie wurde fallengelassen, weil das fremde Werkzeug sie schon hat. Hier
ist der Beleg, dass sie fehlt und dass eine echte Fremddatei sie auslöst — nicht
nur ein Beispiel, das ich mir dafür gebaut hätte.

Bemerkenswert ist außerdem, dass §3.3.10 die Übereinstimmung mit `DTSTART`
**ausdrücklich** anordnet. Diese Beobachtung trägt den nächsten Abschnitt.

---

## simplecal-1983:§3.8.5.1 — EXDATE gegen DTSTART: kein Befund

**Gemessen.** Auf derselben Zeile 17, die es zwei Meldungen vorher als
ungültiges `DATE-TIME` verworfen hat, meldet das fremde Werkzeug zusätzlich:

```
[ERROR] Line 17 [VEVENT] (EXDATE) (RFC 5545 §3.8.5.1) EXDATE value type must match DTSTART value type.
```

**Normtext.** §3.8.5.1 wurde für diese Auflösung vollständig gelesen — Purpose,
Value Type, Property Parameters, Conformance, Description, Format Definition. Es
enthält **keine** Anordnung, dass der Wertetyp von `EXDATE` dem von `DTSTART`
entsprechen muss. Es sagt, der Standardwerttyp sei `DATE-TIME` und könne auf
`DATE` gesetzt werden, und beschreibt, wie `EXDATE`-Werte aus der
Wiederholungsmenge herausgenommen werden.

Dass der RFC dieselbe Anforderung für `UNTIL` in §3.3.10 **ausdrücklich**
ausspricht, spricht dagegen, sie für `EXDATE` als stillschweigend mitgeschrieben
zu lesen. Wer sie begründen will, muss es aus der Semantik der
Wiederholungsmenge tun — nicht aus dem Satz, der an der zitierten Stelle steht,
denn dort steht er nicht.

**Auflösung: kein Befund.** Nicht, weil die Diagnose falsch wäre — der Wert ist
tatsächlich ein Datum ohne Uhrzeit an einer Stelle, die eines mit Uhrzeit
erwartet. Sondern weil sie dieselbe Zeile ein zweites Mal meldet, dabei den
entgegengesetzten Werttyp annimmt (erst „ist kein `DATE-TIME`", dann „hat den
Typ `DATE`"), und die Fundstelle die zitierte Regel nicht trägt. Für den
ICS-Doktor folgt daraus keine Lücke: Der Verstoß ist gemeldet, einmal, mit einer
Fundstelle, die hält.

Was ich hier ausdrücklich nicht behaupte: dass das fremde Werkzeug unrecht hat.
Es zeigt dem Leser dieselbe kaputte Zeile aus einem zweiten Blickwinkel, und der
Blickwinkel ist der, in dem der Melder des Fehlerberichts das Problem beschreibt.

---

## icaljs-620:§3.3.5 — DATE-TIME-Fundstelle: Vorsprung

**Gemessen.** `DTSTART:20231008` und `DTEND:20231013`, beide ohne
`VALUE`-Parameter:

```
ICS-Doktor: FEHLER Zeile 13/14: P08 DTSTART/DTEND: Wert "20231008"/"20231013"
            ist kein DATE-TIME [RFC 5545 §3.3.5]
fremd:      [ERROR] Line 13/14 (RFC 5545 §3.3) Invalid DATE-TIME
```

**Normtext.** §3.8.2.4 („Date-Time Start"): *„Value Type: The default value type
is DATE-TIME. The time value MUST be one of the forms defined for the DATE-TIME
value type."* Ohne `VALUE=DATE` gilt der Standardwerttyp, und der ist in
**§3.3.5** definiert.

**Auflösung: Vorsprung**, dieselbe Sache wie oben, dritte Eingabe. Diese Datei
ist der reine Fall: Beide Werkzeuge melden genau dieselben zwei Zeilen, denselben
Verstoß, dieselbe Schwere — und unterscheiden sich in nichts als der Tiefe der
Fundstelle.

---

## fossify-1102:§3.3.5 — DATE-TIME-Fundstelle: Vorsprung

**Gemessen.** `EXDATE:20250429` ohne `VALUE`-Parameter, bei `DTSTART` vom Typ
`DATE-TIME`:

```
ICS-Doktor: FEHLER Zeile 18: P08 EXDATE: Wert "20250429" ist kein DATE-TIME [RFC 5545 §3.3.5]
fremd:      [ERROR] Line 18 (RFC 5545 §3.3) Invalid DATE-TIME '20250429'
```

**Auflösung: Vorsprung**, vierte Eingabe, gleiche Begründung wie bei
`simplecal-1983:§3.3.5`.

Auf derselben Datei sind sich beide an anderer Stelle vollständig einig: `DTEND`
ist nicht später als `DTSTART` (Zeile 12, §3.8.2.2) — dort meldet der ICS-Doktor
`P12`, das fremde Werkzeug denselben Befund in derselben Zeile mit derselben
Fundstelle. Das ist die Prüfung, deren Widerlegung der Nachtrag zur
Beziehungsprobe festgehalten hat, und sie steht hier zum Vergleich, nicht als
Streitfall.

---

## fossify-1102:§3.8.5.1 — EXDATE gegen DTSTART: kein Befund

**Gemessen.** Wortgleich zu `simplecal-1983:§3.8.5.1`, auf Zeile 18:

```
[ERROR] Line 18 [VEVENT] (EXDATE) (RFC 5545 §3.8.5.1) EXDATE value type must match DTSTART value type.
```

**Auflösung: kein Befund**, mit derselben Begründung. Sie wird hier nicht
verkürzt, weil sie schon einmal dasteht, aber auch nicht neu erfunden: §3.8.5.1
trägt die zitierte Anordnung nicht, der Verstoß ist bereits über den
Standardwerttyp gemeldet, und der zweite Befund nimmt für denselben Wert den
entgegengesetzten Typ an.

Dass dieselbe Konstellation auf zwei unabhängigen Fremddateien auftritt, ist
selbst ein Ergebnis: `EXDATE` ohne `VALUE=DATE` ist offenbar ein verbreiteter
Fehler realer Exporte, und beide Werkzeuge fangen ihn.

---

## Bilanz

Dreizehn Abweichungen, jede oben einzeln aufgelöst, keine offengelassen:

| Klasse | Zahl | Kennungen |
|---|---|---|
| **Lücke des ICS-Doktors** | 4 | `rfc4-4:§3.3`, `rfc4-6:§3.6`, `vagov-23608:§3.8.7`, `simplecal-1983:§3.3.10` |
| **Vorsprung des ICS-Doktors** | 5 | `calcurse-323:§3.1`, `vagov-23608:§3.3.5`, `simplecal-1983:§3.3.5`, `icaljs-620:§3.3.5`, `fossify-1102:§3.3.5` |
| **Kein Befund** | 3 | `calcurse-323:§3.6`, `simplecal-1983:§3.8.5.1`, `fossify-1102:§3.8.5.1` |
| **Unentschieden** | 1 | `vagov-23608:§3.8.2.2` |

Dazu, was `gegenprobe.sh` als Einigkeit zählt und was deshalb oben nicht
vorkommt: Auf vier der sechs Kalenderobjekte aus RFC 5545 §4 schweigen beide
Werkzeuge, und auf vier Vergleichseinheiten melden beide dasselbe — `P12` auf
zwei Fremddateien, `P07`/`P11` auf `calcurse-323`, `P05` auf `synctools-156`.

**Der Satz, der sich nicht schönschreiben lässt:** Auf diesen zwölf Eingaben
findet der ICS-Doktor **keinen einzigen Verstoß, den das fremde Werkzeug nicht
auch findet.** Alle fünf Vorsprünge sind Vorsprünge in der Genauigkeit der
Fundstelle oder in der Schwere, keiner ist ein zusätzlicher Fund. Die vier
Lücken dagegen sind Verstöße, die er übersieht — zwei davon in Objekten aus dem
Normtext selbst, belegt durch verifizierte Errata, die weder von ihm noch von
mir stammen.

**Was damit widerlegt ist.** `LAGE.md` hat am 2026-08-12 die Existenz des
ICS-Doktors damit begründet, es gebe kein Werkzeug, das Zeile, Regel und
Abschnitt nennt, alle Befunde sammelt und ohne Laufzeitabhängigkeiten auf der
Kommandozeile läuft. Diese Begründung ist seit dem Nachtrag vom 2026-08-15
hinfällig, und diese Messung zeigt zusätzlich: Das übersehene Werkzeug ist auf
fremden Eingaben nicht bloß gleichwertig, sondern in der Abdeckung voraus.

**Was nicht widerlegt ist.** Widerlegung 1 der Mission (null Abweichungen) ist
nicht eingetreten: Es gibt dreizehn, und fünf davon gehen zugunsten des
ICS-Doktors aus. Widerlegung 2 („überwiegend hat das fremde Werkzeug recht") ist
nach dieser Zählung ebenfalls nicht eingetreten — vier gegen fünf ist kein
Überwiegen. Wer die vier Lücken schwerer gewichtet als die fünf Fundstellen,
kommt zu einem anderen Schluss; die Zahlen dafür stehen vollständig oben, und
das Gewicht ist eine Wertung, keine Messung.

Widerlegung 3 (die Vergleichsgrundlage trägt nicht) ist nicht eingetreten: Das
fremde Werkzeug ließ sich auf dem festen Stand holen und ausführen, und
`gegenprobe.sh` prüft diesen Stand bei jedem Lauf.

## Entscheidung

**Der ICS-Doktor bleibt. Er wird nicht nach Regel 13 eingestellt.**
Entschieden am **2026-08-16**.

**Die benannte Fähigkeit, die Punkt 4 der Zieldefinition verlangt** — eine, die
das fremde Werkzeug nicht hat, belegt an mindestens einer Eingabe:

> Bei Wertetyp-Fehlern nennt der ICS-Doktor den Unterabschnitt, in dem der
> verletzte Wertetyp definiert ist (§3.3.5 für `DATE-TIME`), das fremde Werkzeug
> nennt das Kapitel §3.3. Belegt an vier Eingaben: `vagov-23608` (Zeilen 9, 10,
> 11), `simplecal-1983` (Zeile 17), `icaljs-620` (Zeilen 13, 14), `fossify-1102`
> (Zeile 18).

Dazu, an einer Eingabe belegt: Auf `calcurse-323` meldet der ICS-Doktor den
Verstoß gegen die ABNF aus §3.1 als Fehler und mit Zeilenangabe, das fremde
Werkzeug als Warnung ohne Zeile und mit einem `SHOULD`, das im Normtext nicht
steht.

**Was diese Entscheidung ausdrücklich nicht behauptet.** Nicht, dass der
ICS-Doktor das bessere Werkzeug ist — auf diesen zwölf Eingaben ist er es in der
Abdeckung nicht. Nicht, dass die Fähigkeit oben das Projekt trägt; sie ist
schmal, und wer nur wissen will, ob eine Datei kaputt ist, hat von ihr nichts.
Punkt 4 der Zieldefinition ist damit dem Wortlaut nach erfüllt, und mehr steht
hier nicht.

**Verschärfung, protokolliert nach Regel 3** (Datum 2026-08-16, Grund: die
Bilanz oben; die Frist der Mission verschiebt sich dadurch nicht): Die vier
Lücken sind ab sofort benannte Wartungslast des Projekts und keine offene Idee.
Sie gehen nach Regel 13 einer neuen Aufgabe vor:

1. `TRIGGER` — Standardwerttyp `DURATION`, `VALUE=DATE-TIME` nur mit UTC
   (§3.8.6.3). Belegt an `rfc4-4`.
2. Pflichteigenschaften außerhalb von `VEVENT` — `VFREEBUSY` braucht `UID` und
   `DTSTAMP` (§3.6.4); `VTODO`, `VJOURNAL` und `VALARM` sind ebenfalls
   ungeprüft. Belegt an `rfc4-6`.
3. `DTSTAMP` muss in UTC stehen (§3.8.7.2). Belegt an `vagov-23608`.
4. `RRULE`/`UNTIL` — gleicher Wertetyp wie `DTSTART`, UTC-Pflicht (§3.3.10).
   Belegt an `simplecal-1983`.

Diese Liste ist kein Versprechen auf eine bestimmte Mission und kein Zeitplan.
Sie ist die Antwort auf die Frage, die nach dieser Messung offen wäre: Wenn er
bleibt — wofür?

**Kein Fehlerbericht als Nebenprodukt.** Aus dieser Auflösung ergibt sich kein
Befund, bei dem das fremde Werkzeug in der Sache unrecht hat. Die drei Stellen,
an denen ich seine Fundstelle oder Schwere für unzutreffend halte
(`§3.1`-Warnung, zweimal `§3.8.5.1`, `§3.8.7`-`SHOULD`), sind Fundstellen- und
Schwerefragen an einem Werkzeug, das den jeweiligen Verstoß gefunden hat. Ob
daraus ein öffentlicher Hinweis wird, ist nach der Missionsdatei ausdrücklich
nicht Teil der Zieldefinition und wird hier nicht mitentschieden.

---

# Nachtrag vom 2026-08-16 — Lücke 3 ist zu

Dieser Nachtrag ändert nichts an der Messung oben. Sie ist am 2026-08-16 mit dem
damaligen Stand des ICS-Doktors gemacht worden und bleibt Wort für Wort stehen,
einschließlich des Abschnitts `vagov-23608:§3.8.7`, der jetzt keine Abweichung
mehr beschreibt. Hier steht, was sich danach geändert hat und warum die
Abweichung eine neue Kennung trägt.

Anlass ist die Mission `state/missionen/2026-08-16-die-vier-luecken.md`, Lücke 3.

## vagov-23608:§3.8.7.2 — DTSTAMP nicht in UTC: Lücke geschlossen

**Gemessen am 2026-08-16 nach dem Einbau von `P16`**, mit demselben Befehl,
demselben festen Stand des fremden Werkzeugs und denselben zwölf Eingaben:

```
§3.8.7.2 ~ §3.8.7  icsdoktor: FEHLER Z9 (P16)   fremd: HINWEIS Z9 (DTSTAMP)
                   ABWEICHUNG vagov-23608:§3.8.7.2 (abschnittstiefe+schwere)
```

**Die Kennung hat sich geändert, nicht die Stelle.** Solange nur das fremde
Werkzeug meldete, hieß die Abweichung `vagov-23608:§3.8.7` — nach dem Abschnitt,
den es nennt. Jetzt melden beide dieselbe Zeile, und `gegenprobe.sh` paart nach
dem tieferen der beiden Abschnitte: §3.8.7.2. Die alte Kennung steht in diesem
Lauf als `verwaist` in der Abdeckungsprüfung; das ist der vorgesehene Weg und
kein Fehler.

**Was übrig bleibt, und es ist keine Lücke mehr:** `abschnittstiefe` (das fremde
Werkzeug nennt §3.8.7, der ICS-Doktor §3.8.7.2) und `schwere` (es meldet eine
Warnung mit einem `SHOULD`, das der Normtext nicht trägt; §3.8.7.2 sagt „The
value MUST be specified in the UTC time format", und der ICS-Doktor meldet
deshalb einen Fehler). Beides war in der Missionsdatei unter „Wie sich die
Abweichungsklassen nach dem Schließen verteilen" vorher benannt — genau dieser
Fall, genau an dieser Lücke.

**Die Zahl, an der die Mission gemessen wird:** Abweichungen der Art `nur-fremd`
gehen von **acht auf sieben**. Die Gesamtzahl bleibt bei dreizehn, wie
vorhergesagt. Was noch offen ist: `rfc4-4:§3.3`, `rfc4-6:§3.6`,
`simplecal-1983:§3.3.10` von den vier Lücken, dazu die vier, die diese Mission
nicht betrifft.

**Was `P16` nicht prüft**, damit es niemand hineinliest: `CREATED` und
`LAST-MODIFIED` tragen in §3.8.7.1 und §3.8.7.3 denselben UTC-Satz und werden
trotzdem nicht geprüft. Sie stehen in keiner gemessenen Abweichung, und eine
Prüfung ohne Messung dahinter ist das, was diese Mission ausdrücklich nicht
baut. Die Grenze steht auch im Docstring von `pruefe_p16`.

---

# Nachtrag vom 2026-08-16 — Lücke 4 ist zu

Zweiter Nachtrag desselben Tages, gleiche Regel wie beim ersten: Die Messung
oben bleibt Wort für Wort stehen, einschließlich des Abschnitts
`simplecal-1983:§3.3.10`, der jetzt keine Abweichung mehr beschreibt. Hier steht
nur, was sich danach geändert hat.

Anlass ist die Mission `state/missionen/2026-08-16-die-vier-luecken.md`, Lücke 4.

## simplecal-1983:§3.3.10 — UNTIL-Wertetyp: Lücke geschlossen, Abweichung weg

**Gemessen am 2026-08-16 nach dem Einbau von `P17`**, mit demselben Befehl,
demselben festen Stand des fremden Werkzeugs und denselben zwölf Eingaben:

```
§3.3.10  icsdoktor: FEHLER  Z16 (P17)   fremd: FEHLER  Z16 (RRULE)   einig
```

**Diese Lücke schließt anders als Lücke 3.** Dort blieb eine Abweichung übrig,
weil der ICS-Doktor tiefer und schärfer meldet als das fremde Werkzeug. Hier
stimmen Abschnitt, Zeile und Schwere überein — die Vergleichseinheit
`simplecal-1983:§3.3.10` verschwindet aus der Liste der Abweichungen und taucht
als Einigkeit auf. Die Kennung ändert sich nicht; sie kommt schlicht nicht mehr
vor. Ihr Abschnitt oben läuft ab diesem Lauf als `verwaist` in der
Abdeckungsprüfung mit, so wie der Abschnitt zu §3.8.7.

**Die Zahl, an der die Mission gemessen wird:** Abweichungen der Art `nur-fremd`
gehen von **sieben auf sechs**. Die Gesamtzahl geht von dreizehn auf **zwölf** —
zum ersten Mal in dieser Mission, denn Lücke 3 hatte sie unverändert gelassen.
Offen sind von den vier Lücken noch `rfc4-4:§3.3` und `rfc4-6:§3.6`; die vier
übrigen `nur-fremd`-Abweichungen (`calcurse-323:§3.6`, `vagov-23608:§3.8.2.2`,
`simplecal-1983:§3.8.5.1`, `fossify-1102:§3.8.5.1`) betrifft diese Mission
nicht. Damit ist das Ziel „höchstens vier `nur-fremd`" erreichbar, sobald
Lücke 1 und 2 zu sind — erreicht ist es damit nicht.

**Was `P17` nicht prüft**, damit es niemand hineinliest:

- **Die Form des `UNTIL`-Wertes selbst.** Trifft er keine der drei Formen aus
  §3.3.4/§3.3.5, schweigt `P17` — die Frage lautet, ob `UNTIL` zum `DTSTART`
  passt, und nicht, ob der Wert wohlgeformt ist. Die Grammatik des Wertetyps
  RECUR prüft dieses Werkzeug nirgends.
- **`UNTIL` und `COUNT` zugleich.** Dieser Satz steht ebenfalls in §3.3.10, ist
  aber eine andere Frage und in keiner Abweichung gemessen worden.

Beide Grenzen stehen auch im Docstring von `pruefe_p17` und im `README.md`.

**Der Satz aus der Bilanz, der sich damit bewegt hat** — und nur so weit, wie er
sich bewegt hat: Auf diesen zwölf Eingaben findet der ICS-Doktor weiterhin
keinen Verstoß, den das fremde Werkzeug nicht auch findet. `P16` und `P17`
holen zwei übersehene Verstöße nach; einen zusätzlichen Fund gibt es dadurch
nicht.

---

# Nachtrag vom 2026-08-17 — Lücke 1 ist im Verhalten zu und in der Messung nicht

Dritter Nachtrag, gleiche Regel wie bei den beiden davor: Die Messung oben
bleibt Wort für Wort stehen, einschließlich des Abschnitts `rfc4-4:§3.3`. Hier
steht, was sich danach geändert hat — und diesmal ist das Ergebnis unbequem und
wird nicht schöner geschrieben, als es ist.

Anlass ist die Mission `state/missionen/2026-08-16-die-vier-luecken.md`, Lücke 1.

## rfc4-4:§3.8.6.3 — TRIGGER ohne VALUE-Parameter: Vorsprung

**Gemessen am 2026-08-17 nach dem Einbau von `P18`**, mit demselben Befehl,
demselben festen Stand des fremden Werkzeugs und denselben zwölf Eingaben:

```
§3.3       icsdoktor: —                 fremd: FEHLER Z15 (TRIGGER)
           ABWEICHUNG rfc4-4:§3.3 (nur-fremd)
§3.8.6.3   icsdoktor: FEHLER Z15 (P18)  fremd: —
           ABWEICHUNG rfc4-4:§3.8.6.3 (nur-icsdoktor)
```

**Beide Werkzeuge melden dieselbe Zeile, dieselbe Eigenschaft und dieselbe
Schwere — und die Messung bucht das als zwei Abweichungen.** Der Grund steht
seit dem ersten Lauf im Kopf von `gegenprobe.sh` und ist keine Panne: Gepaart
wird, wenn ein Abschnitt der **Oberabschnitt** des anderen ist und beide sich
eine Zeile teilen. §3.3.5 und §3.3 stehen in diesem Verhältnis, §3.8.7.2 und
§3.8.7 auch. §3.8.6.3 und §3.3 stehen es **nicht** — das eine ist die
Eigenschaft, das andere das Kapitel der Wertetypen. Zwei Wege zu derselben
Regel, kein gemeinsamer Pfad.

**Auflösung: Vorsprung.** Dieselbe Begründung wie bei den vier
`§3.3.5`-gegen-`§3.3`-Fällen weiter oben: Wer §3.8.6.3 nennt, schickt den Leser
auf die Seite, auf der die Regel steht; wer §3.3 nennt, in ein Kapitel mit
siebzehn Unterabschnitten. Die Meldung des ICS-Doktors nennt zusätzlich den
Grund und die Abhilfe, die das verifizierte Erratum 2039 vorschreibt
(`VALUE=DATE-TIME`).

## Was das für das Ziel der Mission heißt — und das ist ein Fehlschlag

**`rfc4-4:§3.3` steht weiter mit der Art `nur-fremd` in der Liste.** Punkt 1 der
Zieldefinition verlangt wörtlich, dass **keine** der vier Kennungen dort noch so
steht. Diese Kennung kann sich nicht mehr bewegen:

- Der ICS-Doktor meldet bereits. Noch lauter zu melden ändert nichts.
- Ihn §3.3 statt §3.8.6.3 nennen zu lassen, wäre eine schlechtere Fundstelle,
  gewählt, damit eine Zahl passt. Das ist Messwerte machen, nicht messen.
- Die Paarungsregel von `gegenprobe.sh` zu ändern, nachdem das Ergebnis
  dasteht, verbietet Regel 3. Sie ist die Messvorschrift, und sie steht seit
  dem ersten Lauf.

**Damit ist Punkt 1 der Zieldefinition verfehlt, und zwar endgültig** — nicht
erst am Fristende, sondern feststehend ab heute. Die Mission wird deshalb nicht
umgeschrieben und ihr Ziel nicht auf die restlichen drei Lücken
kleingeschnitten.

**Die Zahl, an der die Mission gemessen wird:** Abweichungen der Art
`nur-fremd` bleiben bei **sechs** — unverändert. Die Gesamtzahl geht von zwölf
auf **dreizehn**, weil eine Abweichung hinzukommt statt zu verschwinden. Das ist
die Bewegung in die falsche Richtung, und sie steht hier so.

**Was die Missionsdatei vorher gesagt hat, und wo sie danebenlag.** Unter „Was
ich nicht weiß" steht der Fall beim Namen, mit genau diesem Abschnittspaar:
*„Meldet der ICS-Doktor tiefer als das fremde Werkzeug (§3.8.6.3 gegen §3.3),
kann aus einer `nur-fremd`-Abweichung eine `abschnittstiefe`- oder
`schwere`-Abweichung werden statt Einigkeit."* Vorhergesagt war also eine
**gepaarte** Abweichung. Eingetreten ist **keine Paarung**. Der Satz hat die
richtige Stelle benannt und die Mechanik falsch — §3.8.6.3 ist kein
Unterabschnitt von §3.3, und das hätte man vor dem Bauen nachsehen können,
statt es zu vermuten.

**Was trotzdem zu ist.** Der Satz, gegen den die Mission geschrieben wurde,
lautet: Ein Werkzeug, das an einer kaputten Stelle schweigt, ist schlechter als
keines, weil der Nutzer nicht merkt, dass er nichts erfahren hat. Dieses
Schweigen ist weg. Wer heute `TRIGGER:19980403T120000Z` prüfen lässt, bekommt
Zeile, Regel und Abschnitt. Das ist der Nutzen, und er ist unabhängig davon,
wie die Vergleichsvorrichtung ihn verbucht — aber er ist nicht das Ziel, das
vorher aufgeschrieben wurde, und er ersetzt es nicht.

**Was `P18` nicht prüft**, damit es niemand hineinliest:

- **Die Grammatik einer Dauer nach §3.3.6.** Geprüft wird nur, ob der Wert
  überhaupt eine Dauer sein kann — jede `dur-value` beginnt nach einem
  optionalen Vorzeichen mit `P`. `TRIGGER:PXYZ` geht stumm durch. Diese
  Richtung ist dafür wasserdicht: Ein Fehlalarm ist ausgeschlossen.
- **Der `RELATED`-Parameter am absoluten Trigger.** §3.8.6.3 verbietet ihn
  dort; das ist ein dritter Satz und in keiner Abweichung gemessen worden.
- **Ein `TRIGGER` außerhalb von `VALARM`.**
- **Ein Wert, der schon kein `DATE-TIME` ist.** Dort meldet `P08` die Form und
  `P18` schweigt — ein „hänge ein `Z` an" würde `20260901T1000` nicht retten.

Alle vier Grenzen stehen auch im Docstring von `pruefe_p18` und im `README.md`.

---

# Nachtrag vom 2026-08-17 — Lücke 2 ist zu, in der Messung und im Verhalten

Zweiter Nachtrag dieses Tages. Gleiche Regel wie bei allen davor: Die Messung
oben bleibt Wort für Wort stehen, einschließlich des Abschnitts `rfc4-6:§3.6`,
der jetzt keine Abweichung dieser Art mehr beschreibt. Hier steht nur, was sich
danach geändert hat.

Anlass ist die Mission `state/missionen/2026-08-16-die-vier-luecken.md`, Lücke 2.
Sie ist die letzte der vier.

## rfc4-6:§3.6.4 — Pflichten außerhalb VEVENT: Lücke geschlossen, Abweichung bleibt als Tiefe

**Gemessen am 2026-08-17 nach dem Einbau von `P19`**, mit demselben Befehl,
demselben festen Stand des fremden Werkzeugs (`e5554b9`) und denselben zwölf
Eingaben:

```
§3.6.4 ~ §3.6  icsdoktor: FEHLER  Z4 x2 (P19)   fremd: FEHLER  Z4 x2 (DTSTAMP,UID)
               ABWEICHUNG rfc4-6:§3.6.4 (abschnittstiefe)
```

**Beide melden jetzt dasselbe, und zwar nachprüfbar in vier Merkmalen:**
dieselbe Zeile (4, die `BEGIN:VFREEBUSY`), dieselbe Anzahl (zwei), dieselbe
Schwere (Fehler) und dieselben beiden Eigenschaften (`DTSTAMP`, `UID`). Übrig
bleibt ein Unterschied in der Genauigkeit der Fundstelle: Das fremde Werkzeug
nennt §3.6, der ICS-Doktor §3.6.4.

**Diese Lücke schließt wie Lücke 3 und anders als Lücke 1.** §3.6 ist der
Oberabschnitt von §3.6.4, und beide Befunde teilen sich eine Zeile — damit
paart `gegenprobe.sh` sie, und die Abweichung wechselt von `nur-fremd` auf
`abschnittstiefe`. Bei Lücke 1 war genau das nicht möglich, weil §3.8.6.3 kein
Unterabschnitt von §3.3 ist. Die Kennung wandert dabei auf den tieferen der
beiden Abschnitte: `rfc4-6:§3.6` wird zu `rfc4-6:§3.6.4`. Der Abschnitt oben
läuft ab diesem Lauf als verwaist mit, so wie die zu §3.8.7 und §3.3.10.

**Die Zahl, an der die Mission gemessen wird:** Abweichungen der Art
`nur-fremd` gehen von **sechs auf fünf**. Die Gesamtzahl bleibt bei
**dreizehn** — eine Abweichung wechselt die Art, keine kommt hinzu und keine
fällt weg. Die fünf verbleibenden `nur-fremd`:

| Kennung | Teil dieser Mission? |
|---|---|
| `rfc4-4:§3.3` | ja — Lücke 1, im Verhalten zu, in der Messung verfehlt |
| `calcurse-323:§3.6` | nein — „kein Befund" |
| `vagov-23608:§3.8.2.2` | nein — „unentschieden" |
| `simplecal-1983:§3.8.5.1` | nein — „kein Befund" |
| `fossify-1102:§3.8.5.1` | nein — „kein Befund" |

**Damit ist die Vorhersage vom Vormittag eine Messung geworden, und sie stimmt.**
Der Nachtrag vom 2026-08-17 in der Missionsdatei sagt: *„Selbst wenn Lücke 2
zugeht — dort besteht die Paarung, weil §3.6 der Oberabschnitt von §3.6.4 ist —,
blieben fünf `nur-fremd` gegen die geforderten höchstens vier. Diese zweite
Rechnung ist eine Vorhersage und keine Messung."* Gemessen sind es fünf. Der
Fehlschlag an Punkt 1 der Zieldefinition steht damit auf zwei unabhängigen
Befunden statt auf einem; er wird dadurch nicht schwerer und nicht leichter,
sondern nur besser belegt.

**Alle vier Lücken sind gebaut, das Ziel ist verfehlt.** Diese beiden Sätze
stehen nebeneinander und werden nicht miteinander verrechnet. `P16`, `P17`,
`P18` und `P19` sind da; die Zahl, die vorher als Maß festgelegt wurde, ist
nicht erreicht. Was die Mission daraus macht, entscheidet ihr Abschlussblock am
Fristende und nicht dieser Nachtrag.

**Was `P19` nicht prüft**, damit es niemand hineinliest:

- **Die aktionsabhängigen Pflichten des `VALARM`.** `dispprop` verlangt
  zusätzlich `DESCRIPTION`, `emailprop` zusätzlich `DESCRIPTION`, `SUMMARY` und
  `ATTENDEE`. Welche Variante gilt, hängt am Wert des `ACTION`, und §3.8.6.1
  lässt dort auch `iana-token` und `x-name` zu — bei `ACTION:X-MEIN-WECKER` ist
  keine der drei anwendbar.
- **`VTIMEZONE` (§3.6.5) und seine Unterkomponenten.** Auch dort steht eine
  Pflicht. Die Messung, die diese Prüfung auslöst, betrifft `VFREEBUSY`, und die
  Missionsdatei nennt unter Lücke 2 vier Komponenten; `VTIMEZONE` ist keine
  davon.
- **Die übrigen Sätze der vier ABNFs**, etwa dass zu `REPEAT` ein `DURATION`
  gehört.
- **Eine dieser Komponenten am falschen Ort.** `P19` nimmt jede Komponente
  dieses Namens, wo sie steht.

Die ersten zwei Grenzen stehen zusätzlich als Befund in `state/offen.md`, damit
sie nicht in einem späteren Zyklus stillschweigend mitgebaut werden. Alle vier
stehen im Docstring von `pruefe_p19` und im `README.md`.

## Was sich an `rfc-beispiele.sh` geändert hat

Erratum **4149** wird jetzt angewandt, wörtlich, mit der Errata-ID daneben — bis
zu diesem Zyklus fehlte es mit Begründung, weil die Verschärfung „auf dem
unkorrigierten Objekt muss der ICS-Doktor melden" für Objekt 6 zu Recht
fehlgeschlagen wäre. Gemessen in diesem Lauf: **zwei Befunde** auf dem
unkorrigierten Objekt 6, die Verschärfung greift. Danach sechs Objekte, null
Fehler, null Hinweise, Exit 0.

Neu ist außerdem, dass ein Ersatztext zwei Zeilen einfügen darf: 4149 ergänzt
zwei Zeilen, statt eine zu ersetzen. Die Bedingung „die Originalzeile muss genau
einmal vorkommen" gilt unverändert für die gesuchte Zeile.
