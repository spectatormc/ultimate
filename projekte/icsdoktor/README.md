# ICS-Doktor

Ein Werkzeug, das eine kaputte `.ics`-Kalenderdatei liest und für jeden Verstoß
**Zeile, Regel und Abschnitt aus RFC 5545** nennt.

Die Aufgabe, die acht Prüfungen `P01` bis `P08`, das Ausgabeformat und die Frist
stehen in `state/missionen/2026-08-11-icsdoktor.md` und sind ab Anlage der
Mission unveränderlich. Diese Datei erklärt nur, was daraus geworden ist.

`P09` und `P10` kommen aus der Folgemission
`state/missionen/2026-08-12-faltnaht.md`: `P09` prüft den Eigenschaftsnamen
gegen die IANA-Registry, `P10` die Faltstelle gegen die Maskierung. Beide sind
gebaut; ob die Mission damit erreicht ist, entscheidet ihr Abschlussblock und
nicht diese Datei.

`P11` kommt aus der Mission `state/missionen/2026-08-13-fremdprobe.md` und
unterscheidet sich von allen zehn davor: Sie stammt nicht aus einem Beispiel,
das ich mir ausgedacht habe, sondern aus einer fremden Datei, die ein Mensch
öffentlich als kaputt gemeldet hat (`lfos/calcurse#323`). Sie meldet ein
`VEVENT` ohne `DTSTART` — und zwar nur, solange das umgebende `VCALENDAR` keine
`METHOD` trägt, weil §3.6.1 die Pflicht genau daran knüpft.

`P12` kommt aus der Mission `state/missionen/2026-08-14-beziehungsprobe.md` und
ist die erste Prüfung, die **zwei Eigenschaften zueinander** in Beziehung setzt
statt jede Zeile für sich zu lesen: Das Ende (`DTEND`, im `VTODO` `DUE`) muss
später liegen als `DTSTART`. §3.8.2.2 sagt „later in time", nicht „not earlier"
— Gleichstand ist deshalb ebenfalls ein Verstoß. Wo der Vergleich ohne
Zeitzonendatenbank nicht zu führen ist, meldet `P12` nichts; die drei Fälle
stehen unten unter „Was dieses Werkzeug nicht tut".

`P15` stammt aus derselben Mission und meldet eine **negative `DURATION`**:
§3.8.2.5 nennt die Eigenschaft „a positive duration of time". Der Anlass ist
fremd — `bitfireAT/synctools#147` benennt die negative Dauer neben dem Ende vor
dem Anfang und stellt selbst fest, dass der Standard beide verbietet;
`bitfireAT/davx5-ose#1850` ist der ausgelöste Absturz, mit dem Wert `P-1W` im
Klartext der Fehlermeldung. Genau diese Form steht in
`beispiele/21-p15-negative-dauer.ics`. Dass die Kennung `P15` vor `P13` und
`P14` gebaut wurde, hat einen Grund und keinen Zufall: Die Nummern stammen aus
der Missionsdatei und sind dort seit Anlage unveränderlich, die Reihenfolge des
Bauens ist es nicht.

`P13` kommt aus derselben Mission und prüft den ersten Halbsatz von §3.8.2.2:
„The value type of this property MUST be the same as the `DTSTART` property."
Ein Termin, der am 14. als **ganzer Tag** beginnt und am 15. um **12:00 Uhr UTC**
endet, mischt `DATE` und `DATE-TIME` — beide Werte sind für sich gelesen
tadellos, zusammen sind sie kein gültiges `VEVENT`. Diese Prüfung schließt genau
die Lücke, in der `P12` schweigt, und sie braucht dafür **keine
Zeitzonendatenbank**: Der Wertetyp steht in den Parametern und nicht im Wert.
Beide können deshalb nie zugleich anschlagen.

`P14` ist die letzte der vier aus dieser Mission und die einzige, bei der
**keine der beiden Zeilen für sich falsch ist**: §3.6.1 sagt in der Grammatik
des `VEVENT` „`dtend` and `duration` MUST NOT occur in the same `eventprop`",
§3.6.2 denselben Satz über `DUE` und `DURATION` im `VTODO`. Stehen beide da,
behaupten zwei Zeilen das Ende desselben Termins, und wer die Datei liest, muss
raten, welche gilt. Gemeldet wird an der späteren der beiden Zeilen, die frühere
steht im Text — eine Meldung je Komponente, weil es ein Fehler ist und nicht
zwei.

`P16` kommt aus der Mission `state/missionen/2026-08-16-die-vier-luecken.md` und
prüft, dass **`DTSTAMP` in UTC steht** (§3.8.7.2): „The value MUST be specified
in the UTC time format." Sie meldet zwei Formen desselben Verstoßes — einen Wert
ohne `Z` am Ende und einen Wert mit `TZID`-Parameter, also mit Zeitzonenbezug
statt in UTC.

Ihre Herkunft unterscheidet sie von allen fünfzehn davor: Sie stammt weder aus
einem ausgedachten Beispiel noch aus einem Fehlerbericht, sondern aus einer
**Messung gegen ein fremdes Werkzeug**. `gegenprobe.sh` hat am 2026-08-16 unter
der Kennung `vagov-23608:§3.8.7` gezeigt, dass
[rfc5545-validator](https://github.com/WapplerSystems/rfc5545-validator) hier
meldet und der ICS-Doktor schweigt; die Auflösung am Normtext steht in
`GEGENPROBE.md`. Dass der Fall in echter Software vorkommt, belegt
`deni-zen/qcal#19` — offen seit 2014.

`P16` beantwortet **genau eine Frage**: Steht der Wert in der UTC-Form? Ob er
überhaupt ein `DATE-TIME` ist, fragt `P08`. Eine Zeile kann deshalb zwei
Meldungen bekommen, eine je Frage. Was `P16` nicht prüft, steht unten unter „Was
dieses Werkzeug nicht tut".

`P17` stammt aus derselben Mission und derselben Messung (Kennung
`simplecal-1983:§3.3.10`) und prüft, dass der **`UNTIL`-Regelteil einer `RRULE`
zum `DTSTART` derselben Komponente passt** (§3.3.10): derselbe Wertetyp, und
wenn `DTSTART` in UTC steht oder einen Zeitzonenbezug trägt, muss `UNTIL` in UTC
stehen. Eine Serie, die am 1. März um 09:00 UTC beginnt und mit `UNTIL=20230331`
endet, mischt `DATE-TIME` und `DATE` — genau der Fall aus der Fremddatei zu
`SimpleMobileTools/Simple-Calendar#1983`, und `jkbrzt/rrule#440` (offen seit
2020) zeigt denselben Fehler von der anderen Seite: „Note the absence of 'Z' in
UNTIL."

Sie liest zwei Zeilen zueinander wie `P12` bis `P14`, holt den zweiten Wert aber
nicht aus einer eigenen Eigenschaft, sondern aus einem **Regelteil innerhalb
eines Eigenschaftswertes**. Wo der Vergleich nicht zu führen ist — kein
`DTSTART`, ein unlesbares `DTSTART`, ein `UNTIL`, das keine der drei Formen
trifft —, meldet sie nichts; die Fälle stehen unten unter „Was dieses Werkzeug
nicht tut".

`P18` stammt aus derselben Mission und derselben Messung (Kennung `rfc4-4:§3.3`)
und prüft **`TRIGGER`** (§3.8.6.3): „The default value type is DURATION. The
value type can be set to a DATE-TIME value type, in which case the value MUST
specify a UTC-formatted DATE-TIME value." Zwei Sätze, zwei Zweige — ohne
`VALUE=DATE-TIME` muss der Wert eine Dauer sein, mit diesem Parameter ein
`DATE-TIME` in UTC.

Ihr Beleg ist der einzige im Werkzeug, der weder vom Normtext allein noch aus
einem Fehlerbericht kommt, sondern vom **RFC-Editor**: Errata-ID **2039**,
Status *Verified*, korrigiert die Zeile `TRIGGER:19980403T120000Z` im vierten
Kalenderobjekt aus §4 zu `TRIGGER;VALUE=DATE-TIME:19980403T120000Z`. Dass der
Fall in echter Software vorkommt, zeigt `derekantrican/GAS-ICS-Sync#475` (offen
seit 2025): Ein Erzeuger schreibt den absoluten Zeitpunkt ohne Parameter, der
Verbraucher zerbricht daran — „invalid duration value".

**Der erste Zweig ist bewusst nur halb scharf.** Geprüft wird, ob der Wert eine
Dauer sein *kann*: Jede `dur-value` nach §3.3.6 beginnt nach einem optionalen
Vorzeichen mit `P`. Fehlt dieses `P`, ist der Wert sicher keine Dauer — ein
Fehlalarm ist in dieser Richtung ausgeschlossen. Was hinter dem `P` steht, prüft
dieses Werkzeug nirgends, auch bei `DURATION` selbst nicht. Die Grenzen stehen
unten unter „Was dieses Werkzeug nicht tut".

**Ehrlichkeitshalber, weil die Zahl es nicht zeigt:** `P18` schließt die
gemessene Lücke im Verhalten, aber nicht in der Messung. Beide Werkzeuge melden
danach dieselbe Zeile, `gegenprobe.sh` paart sie trotzdem nicht — §3.8.6.3 ist
kein Unterabschnitt von §3.3. Die Abweichung `rfc4-4:§3.3` bleibt deshalb
`nur-fremd`, und das Ziel der Mission ist an diesem Punkt verfehlt. Der ganze
Vorgang steht im Nachtrag vom 2026-08-17 in `GEGENPROBE.md`.

`P19` stammt aus derselben Mission und derselben Messung (Kennung
`rfc4-6:§3.6`) und ist die erste Prüfung, die **außerhalb von `VEVENT` nach
Pflichteigenschaften sieht**: `UID` und `DTSTAMP` in `VTODO` (§3.6.2),
`VJOURNAL` (§3.6.3) und `VFREEBUSY` (§3.6.4), `ACTION` und `TRIGGER` in
`VALARM` (§3.6.6). Alle vier ABNFs sagen es mit demselben Satz — „The following
are REQUIRED, but MUST NOT occur more than once" —, und deshalb meldet `P19`
beide Hälften: die fehlende Eigenschaft und die wiederholte.

Sie ist `P07` nachgebaut, das dasselbe für `VEVENT` tut, bis in den Wortlaut der
Meldung. `VEVENT` selbst bleibt bei `P07` und `P11`: Dieselbe Pflicht zweimal zu
melden wäre kein zweiter Befund. Für `VALARM` braucht die Prüfung den Wert des
`ACTION` nicht zu kennen — der Satz über `action` und `trigger` steht in
`audioprop`, `dispprop` und `emailprop` gleichlautend.

Ihr Beleg ist wieder ein Erratum des **RFC-Editors**: Errata-ID **4149**, Status
*Verified* (gemeldet 2014-10-29, bestätigt 2014-10-30), ergänzt im sechsten
Kalenderobjekt aus §4 das fehlende `UID` und `DTSTAMP` des `VFREEBUSY` und
zitiert als Begründung die ABNF aus §3.6.4. Dass die Familie in echter Software
vorkommt, zeigt `owncloud/tasks#272` (offen seit 2015): Dort meldet ein Programm
„Every VTODO component must have an UID", und der Melder hält das für einen
Fehler, weil `UID` in der ABNF von **RFC 2445** §4.6.2 optional war. In
RFC 5545 §3.6.2 ist es REQUIRED — der Bericht ist damit kein Beleg gegen die
Pflicht, sondern dafür, dass sie schwer zu finden ist.

**Was `P19` nicht prüft, steht unten** unter „Was dieses Werkzeug nicht tut":
die aktionsabhängigen Pflichten des `VALARM` und die Pflichten in `VTIMEZONE`.

## Warum

Drei öffentliche Fehlerberichte, in der Missionsdatei mit Link und Wortlaut
zitiert, beschreiben dieselbe Lage aus verschiedenen Richtungen: Ein Programm
lehnt eine Kalenderdatei ab, und der Mensch, dem die Datei gehört, erfährt
nicht, wo er suchen soll. Die verbreiteten Bibliotheken melden entweder die
Regel oder die Zeile — die geprüfte Werkzeuglandschaft steht in `LAGE.md`, mit
dem Befund, der gegen diese Mission spricht.

## Aufruf

```
python3 projekte/icsdoktor/icsdoktor.py DATEI.ics
```

Eine Zeile je Fund:

```
<SCHWERE> Zeile <n>: <code> <klartext> [RFC 5545 §<abschnitt>]
```

`<n>` ist die physische Zeile der Datei, gezählt ab 1. Bei gefalteten Zeilen ist
es die Zeile, in der die logische Zeile beginnt.

Exit-Code: `0` kein FEHLER, `1` mindestens ein FEHLER, `2` Aufruf- oder
Lesefehler. Nur Python 3 aus der Standardbibliothek, kein Netz zur Laufzeit.

Beispiel:

```
$ python3 icsdoktor.py beispiele/12-p08-datumszeit.ics
FEHLER Zeile 6: P08 DTSTAMP: Wert "2026-08-12T05:00:00Z" ist kein DATE-TIME; …
FEHLER Zeile 7: P08 DTSTART: den 30. gibt es im Monat 02 des Jahres 2026 nicht …
```

## Zwei Schweregrade

`P03` (Zeilenlänge) steht im RFC als „SHOULD NOT" und ist deshalb `HINWEIS`; er
ändert den Exit-Code nicht. `P09` ist ebenfalls `HINWEIS`: Ein unbekannter
Eigenschaftsname verstößt gegen kein „MUST", und Hersteller-Eigenschaften ohne
`X-` gibt es wirklich. `P10` ebenso: §3.1 erlaubt die Faltung an nahezu jeder
Stelle, gemeldet wird also keine Regelverletzung, sondern eine Stelle, an der
Programme messbar auseinandergehen. Alles andere ist `FEHLER`. Ein Werkzeug,
das eine Empfehlung als Verstoß ausgibt, schickt Menschen auf die Suche nach
Fehlern, die keine sind.

Die Missionsdatei nennt diesen Grad „Warnung". Das Werkzeug hat genau zwei
Grade, und der nicht-fehlerhafte heißt seit der Vormission `HINWEIS` — gemeint
ist derselbe. Umbenannt wird nichts, damit die dreizehn älteren Erwartungen in
`erwartet/` byte-genau bleiben.

## Selbst nachprüfen

```
sh projekte/icsdoktor/pruefe.sh          # die mitgelieferten Beispiele
sh projekte/icsdoktor/rfc-beispiele.sh   # die sechs Kalender aus RFC 5545 §4
sh projekte/icsdoktor/namensliste.sh     # woher die Namensliste von P09 kommt
```

Der zweite ist der wichtigere: Seine Eingabe stammt nicht von mir, sondern aus
dem Normtext. Ein Kalender aus dem RFC verstößt nicht gegen den RFC — meldet das
Werkzeug dort einen Fehler, hat das Werkzeug unrecht. Er braucht Netz; ist
`rfc-editor.org` nicht erreichbar, endet er mit Exit-Code 2 und sagt das, statt
grün zu melden.

**Für zwei der sechs Objekte stimmt dieser Satz nicht**, und zwar nicht nach
meiner Auslegung, sondern nach **verifizierten Errata des RFC-Editors**: Objekt
4 trägt `TRIGGER:19980403T120000Z`, wo §3.8.6.3 eine `DURATION` verlangt
(Errata-ID 2039), Objekt 6 einem `VFREEBUSY` ohne `UID` und `DTSTAMP`
(Errata-ID 4149). Seit dem 2026-08-17 wendet `rfc-beispiele.sh` deshalb die
verifizierten Errata auf die **Eingabe** an, wörtlich und mit der Errata-ID
daneben, bevor es prüft — statt die Erwartung „kein Fehler und kein Hinweis"
aufzuweichen, nachdem das Ergebnis dasteht. Diese Erwartung steht Wort für Wort
unverändert.

Damit der Patch kein Versteck wird, verlangt dasselbe Skript zweierlei: Die
Originalzeile muss im Ausschnitt **genau einmal** vorkommen (sonst Exit 2 —
ein Patch, der nichts trifft, prüft stillschweigend den alten Text), und auf dem
**unkorrigierten** Objekt muss der ICS-Doktor melden (sonst Exit 1 — sonst wäre
die Null nur seine eigene Stille). Angewandt ist bisher nur Erratum 2039;
Erratum 4149 gehört zu einer Prüfung, die noch nicht gebaut ist, und fehlt
deshalb ausdrücklich statt versehentlich.

`pruefe.sh` vergleicht Byte für Byte gegen `erwartet/` und leitet den erwarteten
Exit-Code aus der Erwartung ab, statt ihn danebenzuschreiben. Zusätzlich rechnet
er die Vorgaben der Missionsdatei nach: mindestens zwölf Beispiele, jede
Prüfung mindestens einmal ausgelöst, mindestens zwei fehlerfreie Dateien. Die
abgeschlossene Mission „Die Faltnaht" verlangt mehr — 16 Beispiele und die zehn
Prüfungen `P01` bis `P10` —, und wo das steht, sagt die letzte Zeile der
Ausgabe, damit ein grüner Exit-Code nicht als „Mission erreicht" gelesen wird.
`P11` bis `P19` füllen diese Zehn nicht auf, sondern werden getrennt gezählt:
Eine abgeschlossene Zusage wird nicht dadurch billiger, dass später eine Prüfung
dazukommt. Die Abdeckungsliste nennt, was gebaut ist; seit dem 2026-08-17 stehen
`P18` und `P19` mit darin und damit alle neunzehn. Ob die laufende Mission erreicht ist,
sagt ihre Missionsdatei und nicht dieser Exit-Code.

Seit `rfc-beispiele.sh` auch bei einem `HINWEIS` mit `1` endet, ist er die
Kontrolle gegen Fehlalarme von `P09` und `P10`: Ein Kalender aus dem Normtext
darf keine Warnung erzeugen — die sechs Objekte aus §4 sind gefaltet, und eine
der beiden Prüfungen hätte dort anschlagen können. `namensliste.sh` holt die
IANA-Registry sowie die Tabellen aus
RFC 5545 §8.3.2 und RFC 7986 §9.1 und vergleicht sie mit der Liste im Werkzeug;
weicht sie ab, endet er mit `1` und nennt jeden Unterschied. Beide brauchen Netz.

## Entscheidungen, die im RFC nicht festgelegt sind

Wo der Standard mehrere Lesarten zulässt, steht hier, welche gewählt wurde:

- **Eine Zeile, deren Form unklar ist, geht nicht in die weiteren Prüfungen
  ein.** Scheitert `P04`, wird die Zeile für `P05` bis `P08` übersprungen statt
  geraten. Sie fehlt dann in der Struktur — das erzeugt manchmal einen zweiten,
  echten Befund.
- **`P08` prüft die Eigenschaften, deren Wert nach RFC vom Typ DATE-TIME ist**
  (`DTSTAMP`, `DTSTART`, `DTEND`, `DUE`, `CREATED`, `LAST-MODIFIED`,
  `COMPLETED`, `RECURRENCE-ID`, `EXDATE`, `RDATE`), und überspringt sie, wenn
  ein `VALUE`-Parameter einen anderen Typ nennt. `TRIGGER` ist ohne
  `VALUE=DATE-TIME` eine DURATION und wird nur mit diesem Parameter geprüft.
  `FREEBUSY` ist PERIOD und wird nicht geprüft.
- **Sekunde 60 ist erlaubt** — §3.3.5 lässt sie für Schaltsekunden zu.
- **Ein `END`, das nicht zum offenen `BEGIN` passt, schließt das offene
  trotzdem.** Sonst hängt der Rest der Datei an einem Fehler, der zehn Zeilen
  weiter oben passiert ist.
- **`P01` meldet ein CR ohne folgendes LF, aber `P04` meldet es nicht als
  Steuerzeichen im Wert.** Derselbe Befund zweimal ist keine doppelte
  Diagnose.
- **Fehlt der Datei am Ende das CRLF, ist das ein `P01`-Fehler** — §3.1
  schließt jede Inhaltszeile mit CRLF ab, auch die letzte.
- **`P01` meldet je Sorte einmal, nicht je Zeile.** Eine Datei, die durchgehend
  LF benutzt, ist ein Befund über die ganze Datei; als 23 gleichlautende Zeilen
  verdeckt er jeden anderen Fund. Die Sammelzeile steht auf der ersten
  betroffenen Zeile und nennt die Zahl der betroffenen Zeilen sowie ihre
  Nummern, höchstens fünf davon und dann „und N weitere". Zusammengefasst wird
  nur **innerhalb** einer Sorte: „endet mit LF", „endet ohne CRLF" und „enthält
  ein CR ohne LF" sind drei Befunde und bleiben getrennt. Ist von einer Sorte
  genau eine Zeile betroffen, steht dort unverändert die Einzelmeldung mit
  **deren** Zeilennummer — der Preis des Zusammenfassens darf nicht die
  Fundstelle sein. Prüfbar an `beispiele/04-p01-gemischt.ics` (drei Sorten, je
  eine Zeile, drei Einzelmeldungen) und
  `beispiele/20-p01-eine-zeile-ohne-crlf.ics`.

## Was dieses Werkzeug nicht tut

Die Grenzen gehören in die Beschreibung, nicht in die Fußnote:

- **Es repariert nichts.** Nur Diagnose. So steht es in der Mission.
- **Es prüft genau die neunzehn Prüfungen** und nicht mehr. Bis zum 2026-08-15
  stand hier „dreizehn"; die Zahl war seit `P13` um eine zu klein und ist keine
  weggefallene Prüfung, sondern ein nicht nachgezogener Satz. Seit dem
  2026-08-16 sind `P16` und `P17` dazugekommen, seit dem 2026-08-17 `P18` und
  `P19`.
  Insbesondere nicht
  die Maskierung von Sonderzeichen in TEXT-Werten (§3.3.11) — `P10` sieht nur, wo
  eine Faltung sie zerschneidet, nicht ob sie richtig ist — und nicht die
  Zeichenkodierung.

  Bis zum 2026-08-17 stand in dieser Aufzählung, für `VTODO`, `VJOURNAL` und
  `VFREEBUSY` würden keine Pflichtangaben geprüft. Der Satz galt und ist durch
  `P19` überholt: `UID` und `DTSTAMP` sind dort jetzt erfasst, in `VALARM`
  `ACTION` und `TRIGGER`. Widerlegt hat ihn keine Überlegung von mir, sondern
  eine Messung gegen ein fremdes Werkzeug und ein verifiziertes Erratum.

  Bis zum 2026-08-16 stand in dieser Aufzählung auch `RRULE`. Der Satz ist
  seit `P17` nicht mehr richtig und wird deshalb nicht stehen gelassen: Geprüft
  wird ab jetzt der `UNTIL`-Regelteil gegen `DTSTART`, und sonst nichts an
  einer `RRULE` — die Grammatik des Wertetyps RECUR aus §3.3.10 bleibt
  ungeprüft.

  Für das `VEVENT` sind seit `P11` alle drei Pflichtangaben aus §3.6.1 erfasst:
  `UID` und `DTSTAMP` durch `P07`, `DTSTART` durch `P11`. Bis zum 2026-08-13
  stand hier, `DTSTART` sei nicht darunter — der Satz galt und ist durch die
  fremde Datei aus `lfos/calcurse#323` widerlegt worden, nicht durch eine
  Überlegung von mir.
- **`P11` prüft nur das fehlende `DTSTART`, nicht das doppelte.** §3.6.1
  verbietet auch, dass es zweimal vorkommt; das ist nicht gebaut, weil der
  Prüfbefehl der Mission den fehlenden Fall verlangt. Ein `VEVENT` ohne
  umgebendes `VCALENDAR` meldet `P11` ebenfalls nicht — dort fehlt der
  Bedingung ihr Bezugspunkt, und `P05` meldet die Stelle bereits.
- **`P12` schweigt, wo es ohne Zeitzonendatenbank raten müsste.** Drei Fälle,
  alle drei vor dem ersten Commit festgelegt und nicht hinterher entdeckt:
  zwei **verschiedene** `TZID`; eine Zeit mit `TZID` gegen eine in UTC; und
  abweichende Wertetypen (`DATE` gegen `DATE-TIME`). Der erste Fall ist der
  wichtigste: Ein Anfang um 23:30 in `Europe/Berlin` und ein Ende um 18:00 in
  `America/New_York` laufen **örtlich rückwärts und tatsächlich vorwärts**. Wer
  das ohne Zonendaten vergleicht, meldet einen Fehlalarm auf einer gültigen
  Datei. `beispiele/22-sauber-p12-zwei-zonen.ics` hält diesen Fall fest und
  muss stumm bleiben. Der dritte Fall ist keine Lücke, sondern die
  Zuständigkeit von `P13` — seit dem 2026-08-15 gebaut, siehe den nächsten
  Punkt.
- **`P13` vergleicht den ausgewiesenen Typ und nicht den geschriebenen Wert.**
  Drei Grenzen:

  - **Der zweite Satz von §3.8.2.2 bleibt ungeprüft.** „This property MUST be
    specified as a date with local time if and only if the `DTSTART` property is
    also specified as a date with local time" — ein Ende in UTC neben einem
    Anfang ohne Zeitzone verletzt das, trägt aber denselben Wertetyp
    `DATE-TIME` und geht durch. Die Missionsdatei sagt „Wertetyp weicht ab", und
    das ist etwas anderes. Diese Lücke steht hier, statt durch eine eigene
    Auslegung geschlossen zu werden.
  - **Zwei Meldungen an einer Zeile sind Absicht.** Eine Zeile mit `VALUE=DATE`
    und einem unlesbaren Wert bekommt `P08` zum Wert und `P13` zum Typ. Es sind
    zwei verschiedene Fehler, und wer nur den einen behebt, hat den anderen
    noch.
  - **Ein Typ, den §3.8.2.2 gar nicht zulässt, wird nur als Abweichung
    gemeldet.** `DTEND;VALUE=PERIOD` neben einem `DTSTART` in `DATE-TIME`
    erzeugt einen Fund, weil die Typen abweichen — nicht weil `PERIOD` an
    dieser Stelle unzulässig wäre. Dass dort nur `DATE` und `DATE-TIME` stehen
    dürfen, prüft dieses Werkzeug nirgends.

  Dass `DTSTART;VALUE=DATE-TIME:…` und ein `DTSTART` ohne Parameter derselbe Typ
  sind, ist die Vorgabe aus §3.8.2.2 und §3.8.2.4 und keine Auslegung;
  `beispiele/27-sauber-p13-typ-ausgeschrieben.ics` hält den Fall fest und muss
  stumm bleiben.
- **`P15` meldet die negative Dauer und sonst nichts an `DURATION`.** Drei
  Grenzen, alle drei bewusst:

  - **Ein negativer `TRIGGER` ist kein Fund.** Das ist eine andere Eigenschaft,
    und §3.8.6.3 erlaubt ihr das Vorzeichen ausdrücklich — ein Wecker, der
    fünfzehn Minuten vor dem Termin klingelt, trägt `TRIGGER:-PT15M`. Wer das
    meldet, meldet den Normalfall.
    `beispiele/25-sauber-p15-trigger-negativ.ics` hält ihn fest und muss stumm
    bleiben.
  - **Die Dauer null wird nicht gemeldet.** „Positive" schließt `PT0S` dem
    Wortsinn nach aus. Die Missionsdatei sagt aber „`DURATION` ist negativ", und
    das ist etwas anderes als „nicht positiv". Die Lücke steht hier, statt durch
    eine eigene Auslegung geschlossen zu werden.
  - **Die Form nach §3.3.6 prüft niemand.** `DURATION:morgen` trägt kein Minus
    und geht durch. Es gibt in diesem Werkzeug keine Prüfung für die Grammatik
    des Wertetyps DURATION, und `P15` erfindet sie nicht nebenbei.

  Gemeldet werden zwei Schreibweisen: `-PT1H` (das Vorzeichen, wo §3.3.6 es
  vorsieht) und `P-1W` (das Minus hinter dem `P` — grammatisch gar keine Dauer,
  aber genau der Wert, an dem der zitierte Absturz hängt). Die zweite Meldung
  sagt den Unterschied dazu, statt beide Fälle gleich aussehen zu lassen.
- **`P14` sieht nur `VEVENT` und `VTODO`, und nur je die erste Zeile.** Drei
  Grenzen:

  - **Kein `VFREEBUSY`.** Es steht bei `P12` und `P13` mit dabei, weil §3.8.2.2
    die Eigenschaft `DTEND` beschreibt und nicht die Komponente. Den Satz aus
    §3.6.1 und §3.6.2 sagt §3.6.4 aber nicht, und in seiner Grammatik kommt
    `DURATION` überhaupt nicht vor. Welche Eigenschaften eine Komponente tragen
    darf, prüft dieses Werkzeug nirgends — `P14` fängt damit nicht nebenbei an.
  - **Eine `DURATION` in einer eingebetteten `VALARM` ist kein Fund.** Sie
    gehört zu ihrer eigenen Komponente und nicht zu dem Termin darum herum;
    §3.6.6 sieht sie dort neben `REPEAT` ausdrücklich vor. Ein Wecker, der
    zweimal klingelt, ist der Normalfall.
    `beispiele/31-sauber-p14-dauer-im-wecker.ics` hält ihn fest und muss stumm
    bleiben.
  - **Die Wiederholung derselben Eigenschaft meldet niemand.** Stehen zwei
    `DTEND` in einer Komponente, nimmt `P14` das erste. Dass §3.6.1 auch das
    verbietet, prüft dieses Werkzeug für `DTEND`, `DURATION` und `DTSTART`
    nirgends; `P07` deckt `UID` und `DTSTAMP` ab und sonst nichts. Bis zum
    2026-08-15 stand im Quelltext, das sei die Sache von `P07` — das war falsch
    und ist dort jetzt richtiggestellt.

  Ob die Dauer taugt, fragt `P14` nicht: Ein `VEVENT` mit `DTEND` und
  `DURATION:-PT1H` bekommt `P14` und `P15`. Es sind zwei verschiedene Fehler,
  und wer nur die Dauer umdreht, hat den anderen noch.
- **Auch bei gleicher `TZID` kann `P12` in genau einer Stunde im Jahr irren.**
  Verglichen wird die Ortszeit. Fällt der Zeitraum in die doppelte Stunde der
  Zeitumstellung, läuft sie rückwärts, während die tatsächliche Zeit vorwärts
  läuft. Das ist ein bekannter Fehlalarm und steht hier, statt durch Raten
  geschlossen zu werden.
- **Ein unbekannter Eigenschaftsname ist weiter kein Fehler, aber seit `P09`
  ein Hinweis.** Der Satz, der hier bis zum 2026-08-12 stand — „keine der acht
  Prüfungen schlägt an, der Fehler ist echt, das Werkzeug sieht ihn nicht" —
  galt für den Fall, dass eine Fortsetzungszeile ihr führendes Leerzeichen
  verliert und aus `\r\n mailto:employee-A@example.com` die formal gültige
  Eigenschaft `mailto` wird. Genau dieser Fall wird jetzt gemeldet, mit Zeile,
  Kennung `P09` und dem Namen. Der alte Wortlaut steht in der Git-Historie und
  wird nicht begradigt.
- **`P09` kann irren, und zwar in eine Richtung.** Wer eine
  Hersteller-Eigenschaft ohne `X-` benutzt oder eine, die nach dem Stand der
  Liste registriert wurde, bekommt einen Hinweis auf eine Faltung, die intakt
  ist. Deshalb Hinweis statt Fehler, deshalb „möglicherweise" in der Meldung,
  und deshalb ist die Liste nachprüfbar (`namensliste.sh`) statt behauptet.
- **`P10` meldet eine Stelle, die der RFC erlaubt.** Eine Faltung zwischen `\`
  und dem maskierten Zeichen ist nach §3.1 zulässig; wer entfaltet, bevor er
  auswertet, sieht nichts Falsches. Gemeldet wird sie trotzdem, weil der
  zitierte Fehlerbericht zeigt, dass Programme hier auseinandergehen — ein
  Kalender wurde von einem Dienst nicht angezeigt und von einem anderen ohne
  Klage gelesen. Wer `P10` für zu streng hält, hat einen Punkt, den dieser
  Absatz nicht wegdiskutiert: Der Hinweis nennt eine Uneinigkeit zwischen
  Programmen, keinen Verstoß.
- **`P10` sieht die Naht, nicht den Sinn.** Erkannt wird eine ungerade Zahl von
  `\` am Zeilenende vor einer Fortsetzung. Ein `\\` am Zeilenende ist eine
  vollständige, maskierte Maskierung und wird nicht gemeldet
  (`beispiele/17-sauber-maskierter-rueckwaertsstrich.ics` ist genau diese
  Gegenprobe). Ob der maskierte Buchstabe dahinter überhaupt einer ist, den
  §3.3.11 kennt, prüft `P10` nicht — das wäre eine Prüfung der Maskierung und
  steht in keiner Mission.
- **`P16` prüft den UTC-Zwang nur an `DTSTAMP`.** `CREATED` (§3.8.7.1) und
  `LAST-MODIFIED` (§3.8.7.3) tragen im Normtext denselben Satz und werden
  trotzdem nicht geprüft. Der Grund ist keine Nachlässigkeit, sondern die
  Herkunft dieser Prüfung: Sie schließt eine **gemessene** Lücke, und gemessen
  ist `DTSTAMP`. Die beiden anderen wären eine Prüfung, die ich mir ausgedacht
  habe, während die Mission ausdrücklich nach Messungen gebaut wird. Wer sie
  will, bekommt sie mit einer Messung, die sie zeigt.

  Ebenfalls nicht geprüft: dass `DTSTAMP` überhaupt ein wohlgeformtes
  `DATE-TIME` ist — das ist `P08`. Auf einem Wert, der beides verletzt, stehen
  deshalb zwei Meldungen, und das ist Absicht. Der Fall ist real: Die Fremddatei
  aus `department-of-veterans-affairs/va.gov-team#23608` trägt
  `DTSTAMP:NaNNaNNaNTNaNNaNNaN` und bekommt `P08` **und** `P16`.
- **`P17` prüft `UNTIL` gegen `DTSTART` und sonst nichts an einer `RRULE`.**
  Drei Grenzen, alle vor dem ersten Commit festgelegt:

  - **Die Form des `UNTIL`-Wertes bleibt ungeprüft.** `UNTIL=morgen` oder
    `UNTIL=20201220T14` treffen keine der drei Formen aus §3.3.4/§3.3.5, und
    `P17` schweigt dazu. Sie fragt, ob `UNTIL` zum `DTSTART` passt, nicht ob der
    Wert wohlgeformt ist — und keine andere Prüfung fängt das auf, weil `P08`
    nur ganze Eigenschaftswerte liest und nicht in einen `RRULE`-Wert hinein.
  - **`UNTIL` und `COUNT` zugleich** verbietet §3.3.10 im selben Abschnitt. Das
    ist eine andere Frage, in keiner Abweichung gemessen, und deshalb nicht
    gebaut.
  - **Ohne vergleichbares `DTSTART` kein Vergleich.** Fehlt es in der Komponente
    oder trifft sein Wert keine der drei Formen, meldet `P17` nichts; der zweite
    Fall steht bereits als `P08` an seiner eigenen Zeile. Dieselbe Zurückhaltung
    wie bei `P12` und aus demselben Grund: Ein geratener Fehlalarm ist schlimmer
    als eine benannte Lücke.

  Dass ein `DTSTART` in Ortszeit ein `UNTIL` in Ortszeit **verlangt** und ein
  `Z` dort ein Verstoß ist, steht so im Normtext und ist keine Auslegung;
  `beispiele/36-sauber-p17-beide-ortszeit.ics` hält den zulässigen Fall fest und
  muss stumm bleiben, `beispiele/37-p17-until-utc-bei-ortszeit.ics` den
  umgekehrten.
- **`P18` prüft `TRIGGER` an zwei Sätzen und nicht an vieren.** Vier Grenzen,
  alle vor dem ersten Commit festgelegt:

  - **Die Grammatik einer Dauer bleibt ungeprüft.** `TRIGGER:PXYZ` beginnt mit
    `P` und geht deshalb stumm durch. Geprüft wird nur, ob der Wert eine Dauer
    sein *kann*; diese Richtung ist dafür wasserdicht.
  - **Der `RELATED`-Parameter am absoluten Trigger** ist nach §3.8.6.3 dort
    verboten („MUST only be specified when the value type is DURATION"). Ein
    dritter Satz, in keiner Abweichung gemessen, nicht gebaut.
  - **Ein `TRIGGER` außerhalb von `VALARM`** verstößt gegen die
    Conformance-Zeile desselben Abschnitts und wird nicht gemeldet.
  - **Ein `VALUE`-Parameter, der weder `DURATION` noch `DATE-TIME` nennt**,
    lässt `P18` ganz schweigen, statt den Wert an einem Typ zu messen, den die
    Zeile nicht behauptet.

  Bei einem Wert, der schon kein `DATE-TIME` ist, meldet `P08` die Form und
  `P18` schweigt — bei `TRIGGER;VALUE=DATE-TIME:20260901T1000` würde ein
  angehängtes `Z` nichts retten, und ein Rat, der nicht trägt, ist schlechter
  als keiner. **`P16` macht das an derselben Stelle anders** und meldet auch auf
  einem kaputten `DTSTAMP` das fehlende `Z`. Der Unterschied ist gesehen, nicht
  übersehen; er steht in `state/offen.md` und wird nicht still angeglichen.
- **`P19` liest genau den Satz „The following are REQUIRED" und keinen
  anderen.** Vier Grenzen, alle vor dem ersten Commit festgelegt:

  - **Die aktionsabhängigen Pflichten des `VALARM` bleiben ungeprüft.**
    `dispprop` verlangt zusätzlich `DESCRIPTION`, `emailprop` zusätzlich
    `DESCRIPTION`, `SUMMARY` und `ATTENDEE`. Welche der drei Varianten gilt,
    hängt am Wert des `ACTION` — und §3.8.6.1 lässt dort auch `iana-token` und
    `x-name` zu. Bei `ACTION:X-MEIN-WECKER` ist keine der drei anwendbar, und
    eine Prüfung, die dann die nächstliegende nimmt, meldet einen Verstoß gegen
    eine Regel, die es für diesen Wert nicht gibt.
  - **`VTIMEZONE` (§3.6.5) und seine Unterkomponenten** haben ebenfalls
    Pflichten (`TZID`; in `STANDARD` und `DAYLIGHT` `DTSTART`, `TZOFFSETTO`,
    `TZOFFSETFROM`). Die Messung, die `P19` auslöst, betrifft `VFREEBUSY`, und
    die Missionsdatei nennt vier Komponenten — `VTIMEZONE` ist keine davon.
  - **Die übrigen Sätze der vier ABNFs.** Dass zu `REPEAT` ein `DURATION`
    gehört, meldet niemand; dass `DUE` und `DURATION` nicht zusammen stehen
    dürfen, meldet `P14`.
  - **Eine dieser Komponenten am falschen Ort.** Ein `VFREEBUSY` innerhalb eines
    `VEVENT` verstößt gegen die Schachtelung aus §3.6; welche Komponente wohin
    gehört, prüft dieses Werkzeug nirgends. `P19` nimmt jede Komponente dieses
    Namens, wo sie steht.

  Die ersten zwei Grenzen stehen zusätzlich als Befund in `state/offen.md`,
  damit sie nicht in einem späteren Zyklus stillschweigend mitgebaut werden.

## Dateien

```
icsdoktor.py        Das Werkzeug. Nur Standardbibliothek.
pruefe.sh           Prüfbefehl 1: Beispiele gegen Erwartungen.
rfc-beispiele.sh    Prüfbefehl 2: die sechs Kalender aus RFC 5545 §4.
namensliste.sh      Herkunftsprüfung der Namensliste von P09. Kein Prüfbefehl
                    der Mission — er beweist die Herkunft, nicht die Prüfung.
beispiele/          46 Kalenderdateien, byte-genau, teils mit Absicht kaputt.
erwartet/           Je eine Datei mit der erwarteten Ausgabe.
LAGE.md             Geprüfte Werkzeuglandschaft, mit Links.
.gitattributes      Hält CRLF in beispiele/ auch über einen Klon hinweg.
```

Die Beispiele sind nachgebaut, nicht kopiert: Keine fremde Kalenderdatei liegt
in diesem Repo, damit keine Herkunftsfrage entsteht, die ich nicht sauber
beantworten kann. Siehe `HERKUNFT.md`.
