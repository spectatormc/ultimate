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

`pruefe.sh` vergleicht Byte für Byte gegen `erwartet/` und leitet den erwarteten
Exit-Code aus der Erwartung ab, statt ihn danebenzuschreiben. Zusätzlich rechnet
er die Vorgaben der Missionsdatei nach: mindestens zwölf Beispiele, jede
Prüfung mindestens einmal ausgelöst, mindestens zwei fehlerfreie Dateien. Die
abgeschlossene Mission „Die Faltnaht" verlangt mehr — 16 Beispiele und die zehn
Prüfungen `P01` bis `P10` —, und wo das steht, sagt die letzte Zeile der
Ausgabe, damit ein grüner Exit-Code nicht als „Mission erreicht" gelesen wird.
`P11` bis `P15` füllen diese Zehn nicht auf, sondern werden getrennt gezählt:
Eine abgeschlossene Zusage wird nicht dadurch billiger, dass später eine Prüfung
dazukommt. Die Abdeckungsliste nennt, was gebaut ist; seit dem 2026-08-15 steht
`P14` mit darin und damit alle fünfzehn. Ob die laufende Mission erreicht ist,
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
- **Es prüft genau die fünfzehn Prüfungen** und nicht mehr. Bis zum 2026-08-15
  stand hier „dreizehn"; die Zahl war seit `P13` um eine zu klein und ist keine
  weggefallene Prüfung, sondern ein nicht nachgezogener Satz. Insbesondere nicht
  die Maskierung von Sonderzeichen in TEXT-Werten (§3.3.11) — `P10` sieht nur, wo
  eine Faltung sie zerschneidet, nicht ob sie richtig ist —, nicht die
  Zeichenkodierung, nicht `RRULE`, und für `VTODO`, `VJOURNAL` und `VFREEBUSY`
  keine Pflichtangaben — die erfasst nur `P05` strukturell.

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

## Dateien

```
icsdoktor.py        Das Werkzeug. Nur Standardbibliothek.
pruefe.sh           Prüfbefehl 1: Beispiele gegen Erwartungen.
rfc-beispiele.sh    Prüfbefehl 2: die sechs Kalender aus RFC 5545 §4.
namensliste.sh      Herkunftsprüfung der Namensliste von P09. Kein Prüfbefehl
                    der Mission — er beweist die Herkunft, nicht die Prüfung.
beispiele/          32 Kalenderdateien, byte-genau, teils mit Absicht kaputt.
erwartet/           Je eine Datei mit der erwarteten Ausgabe.
LAGE.md             Geprüfte Werkzeuglandschaft, mit Links.
.gitattributes      Hält CRLF in beispiele/ auch über einen Klon hinweg.
```

Die Beispiele sind nachgebaut, nicht kopiert: Keine fremde Kalenderdatei liegt
in diesem Repo, damit keine Herkunftsfrage entsteht, die ich nicht sauber
beantworten kann. Siehe `HERKUNFT.md`.
