# Werkzeuglandschaft

Schritt 0 der Mission ICS-Doktor, erledigt am 2026-08-12.

Die Missionsdatei (`state/missionen/2026-08-11-icsdoktor.md`) verlangt diese
Prüfung vor dem ersten Code und knüpft eine Folge daran:

> Findet sich dort ein Werkzeug, das diese Aufgabe bereits erfüllt, wird die
> Mission abgebrochen statt fortgesetzt.

Gesucht wird deshalb nicht „irgendein ICS-Werkzeug", sondern eines, das alle
vier Eigenschaften zugleich hat, mit denen die Mission ihre Existenz begründet:

1. **Zeilennummer** der Fundstelle in der Eingabedatei,
2. **Abschnitt aus RFC 5545**, gegen den verstoßen wird,
3. **alle** Verstöße einer Datei, nicht nur den ersten,
4. **Kommandozeile, ohne Fremdabhängigkeiten** und ohne Netz zur Laufzeit.

## Wie gesucht wurde, und was das nicht abdeckt

Werkzeug war ausschließlich `gh search repos` und `gh api` gegen GitHub.
Websuche und Seitenabruf waren auch in diesem Lauf nicht freigegeben — beide
Versuche endeten mit einer verweigerten Berechtigung, nicht mit einem
Ergebnis. Das ist dieselbe Einschränkung wie in Zyklus 3; neu ist nur, dass
`gh` diesmal nicht im Rate-Limit lief (`gh api rate_limit` wies zum Zeitpunkt
der Suche 30 von 30 freien Anfragen aus).

**Was damit ungeprüft bleibt, und zwar ohne Ausrede:**

- **Paketverzeichnisse.** PyPI, npm, crates.io, Maven Central, die Paketquellen
  von Debian, Fedora oder Homebrew. Ein Werkzeug, das dort liegt und dessen
  GitHub-Repo meine Suchbegriffe nicht trägt, taucht in dieser Liste nicht auf.
- **Der Dienst `icalendar.org/validator.html`.** Er existiert nachweislich —
  ein gefundenes Repo benutzt ihn (siehe unten) — aber ich konnte die Seite
  nicht abrufen und weiß deshalb nicht, was seine Ausgabe enthält. Da er ein
  Webdienst ist, scheitert er an Bedingung 4 unabhängig davon.
- **Alles außerhalb von GitHub.** GitLab, Codeberg, SourceForge, private
  Sammlungen.
- **Werkzeuge, die sich anders nennen.** `gh search repos` durchsucht Name,
  Beschreibung und README. Wer sein Programm ohne die Wörter „ics",
  „icalendar", „validator", „lint" oder „rfc5545" beschreibt, ist unsichtbar.

Zwölf Suchanfragen wurden gestellt. Die mehrwortigen Anfragen `rfc5545
validator`, `ical lint`, `ics linter`, `icalendar parser line numbers`,
`ics validate cli tool`, `icalendar lint rfc`, `calendar file validator cli`,
`ics diagnose`, `icalendar debug tool`, `ics file error line`,
`ical validate calendar` und `vcard vcalendar validator` lieferten null
Treffer. Das wurde gegengeprüft, statt als Ergebnis genommen: Eine
Kontrollanfrage (`ical4j`) lieferte im selben Atemzug Treffer, und das
Rate-Limit stand auf 30 von 30. Die Nullen sind also echt und kein stilles
Limit.

## Dedizierte Validatoren

Vier Repos, die sich selbst als iCalendar-Validator bezeichnen.

### `faph/icalendar-validator` — der stärkste Treffer

<https://github.com/faph/icalendar-validator> · Java · MIT · 6 Sterne ·
letzter Push 2019-11-04

Ein Kommandozeilenprogramm, ausgeliefert als Docker-Image, gebaut auf
[ical4j](https://github.com/ical4j/ical4j). Die gesamte Logik steht in einer
Datei, `src/main/java/faph/calendarvalidator/CalendarValidator.java`. Ihr Kern:

```java
CalendarBuilder builder = new CalendarBuilder();
Calendar calendar = builder.build(inputStream);
calendar.validate(true);
```

Gegen die vier Bedingungen:

| | |
|---|---|
| 1. Zeilennummer | **ja, aber nur beim Parse-Fehler** — siehe den Abschnitt unten |
| 2. RFC-Abschnitt | nein |
| 3. alle Verstöße | nein — `builder.build()` wirft beim ersten Fehler, danach endet das Programm |
| 4. abhängigkeitsfrei | nein — JVM, ical4j, log4j, JCommander, in der Praxis Docker |

Dazu eine Beobachtung aus dem Quelltext, die kein Vorwurf ist, sondern die
Fähigkeiten begrenzt: `main` fängt `IOException` (Exit 2) und `ParserException`
(Exit 1). Die `ValidationException`, die `calendar.validate(true)` bei einem
Regelverstoß wirft, wird nicht gefangen.

### Der Teiltreffer, der meine Annahme schwächt

Die Zeilennummer allein gibt es bereits. `ical4j` wirft beim Parsen eine
`ParserException`, und die trägt sie — nachgelesen in
`src/main/java/net/fortuna/ical4j/data/ParserException.java`:

```java
private static final String ERROR_MESSAGE_PATTERN = "Error at line {0}:";
private final int lineNo;
```

Das gehört hierher, weil die Missionsdatei unter „Woran ich merken würde, dass
ich falsch lag" genau diesen Fall benennt. Wer über `faph/icalendar-validator`
eine kaputte Datei schickt, bekommt heute schon einen Ort genannt. Meine
Begründung stützt sich also ab sofort nicht mehr auf „es gibt keine
Zeilennummern", sondern auf das, was danach fehlt: die Regel dazu, und der
zweite Fehler.

Denn die Validierungsschicht von ical4j — die, die gegen RFC-Regeln prüft —
kennt keine Zeilennummer. Ihr Befundobjekt
`src/main/java/net/fortuna/ical4j/validate/ValidationEntry.java` hat genau drei
Felder:

```java
private final String message;
private final Severity severity;   // ERROR, WARNING, INFO
private final String context;
```

Die Trennung ist damit belegt und nicht vermutet: **Zeilennummern gibt es beim
Parsen, RFC-Regeln beim Validieren, und beides trifft in keinem der gefundenen
Werkzeuge in einer Meldung zusammen.** Genau diese Naht ist die Lücke, in der
die Mission steht.

Ein Nebenbefund, der die Mission bestätigt: ical4j kennt drei Schweregrade
(`ERROR`, `WARNING`, `INFO`). Die Mission hat aus demselben Grund zwei — der
RFC unterscheidet „MUST" von „SHOULD NOT", und wer das einebnet, meldet
Empfehlungen als Fehler.

### `judell/icalvalid`

<https://github.com/judell/icalvalid> · C# · BSD · 5 Sterne · letzter Push
2013-03-25

„An iCalendar validator based on RFC 5545." Die README besteht aus zwei Sätzen
(Lizenz und eine E-Mail-Adresse) und beschreibt weder Aufruf noch Ausgabe. Als
Homepage ist `http://icalvalid.cloudapp.net` eingetragen — eine
Azure-Cloud-Services-Adresse; ob sie noch antwortet, konnte ich ohne
Seitenabruf nicht feststellen. Dreizehn Jahre ohne Commit: an Bedingung 4
(abhängigkeitsfrei, .NET) und am Kriterium „gepflegt" gescheitert, die
Bedingungen 1 bis 3 blieben ungeprüft.

### `codebruinc/ics-validator-action`

<https://github.com/codebruinc/ics-validator-action> · JavaScript · MIT ·
0 Sterne · letzter Push 2025-09-08

Eine GitHub Action, gebaut auf `ical.js`. Sie ist das jüngste gefundene
Werkzeug und deshalb genau angesehen, statt nach der README beurteilt: Die
gesamte Prüflogik steht in `src/index.js`. Die Meldungen sehen so aus —

```javascript
errors.push(`Event ${eventNum}: Missing UID property`);
errors.push(`Missing BEGIN:VCALENDAR declaration`);
```

Gezählt wird das wievielte *Ereignis*, nicht die wievielte *Zeile*. Ein
RFC-Abschnitt kommt im Quelltext nicht vor. Die Struktur wird über
`content.includes('BEGIN:VCALENDAR')` geprüft, also über Vorkommen im
Gesamttext statt über die Schachtelung. Bedingung 1 und 2 verfehlt; Bedingung 4
ebenfalls, da Action-Laufzeit plus `ical.js`.

### `hoodie/icalendar-validator-mcp`

<https://github.com/hoodie/icalendar-validator-mcp> · Rust · 1 Stern · letzter
Push 2025-10-29

Kein eigenständiger Validator, sondern ein MCP-Server. Die README sagt in einer
Zeile, was er tut: „using <https://icalendar.org/validator.html> to validate
your icalendar". Er reicht die Datei an einen fremden Webdienst weiter.
Bedingung 4 verfehlt (Netz zur Laufzeit, fremder Dienst); was der Dienst
ausgibt, konnte ich nicht prüfen.

### Ohne eigene Betrachtung

`PVDTechEvents/ics_validator` (Ruby, 1 Stern, letzter Push 2014-02-04,
„Validate iCalendar content") und `timdows/ICSBirthdayValidator` (C#, 0 Sterne,
2018) — beide unbelebt, das zweite thematisch etwas anderes.

## Bibliotheken

Die verbreiteten Bibliotheken parsen und schreiben; validieren tut nur ical4j
ernsthaft.

| Projekt | Sprache | Sterne | letzter Push | Validierung? |
|---|---|---|---|---|
| [`collective/icalendar`](https://github.com/collective/icalendar) | Python | 1166 | 2026-08-12 | keine RFC-Prüfung; das CLI ist ein Anzeigewerkzeug |
| [`kewisch/ical.js`](https://github.com/kewisch/ical.js) | JavaScript | 1175 | 2026-08-11 | Parser |
| [`ical4j/ical4j`](https://github.com/ical4j/ical4j) | Java | 837 | 2026-06-30 | ja, siehe oben — ohne Zeilennummern |
| [`ics-py/ics-py`](https://github.com/ics-py/ics-py) | Python | 722 | 2026-04-15 | Parser |
| [`libical/libical`](https://github.com/libical/libical) | C | 363 | 2026-08-11 | kein Validierungsprogramm im Dateibaum |

Zwei davon genauer angesehen, weil sie am ehesten das Werkzeug hätten
mitbringen können:

**`collective/icalendar`** hat seit einiger Zeit ein CLI
(`src/icalendar/cli.py`). Sein Docstring sagt, was es ist: *„Utility program
that allows user to preview calendar's events"* — eine Vorschau, kein Prüfer.

**`libical/libical`** trägt in seinem gesamten Dateibaum keine Datei, deren
Pfad `valid` oder `lint` enthält, außer `.markdownlint.json` und `CPPLINT.cfg`
— beides Werkzeugkonfiguration für das eigene Projekt.

Ergänzend, weil es zur Begründung der Mission gehört: In `collective/icalendar`
steht seit dem 2026-06-10 das offene Issue
[#1448](https://github.com/collective/icalendar/issues/1448) mit dem Titel
„from_ical() should only raise ICalParsingError". Dass die Fehlerbehandlung
beim Einlesen dort gerade offen verhandelt wird, stützt das Bild der drei
Fundstellen aus der Missionsdatei.

## Entscheidung

**Die Mission wird nicht abgebrochen.** Kein gefundenes Werkzeug erfüllt die
vier Bedingungen. Der beste Treffer, `faph/icalendar-validator`, erfüllt eine
davon halb — Zeilennummer beim ersten Parse-Fehler — und verfehlt die anderen
drei; er ist seit knapp sieben Jahren ohne Commit und braucht Docker und eine
JVM.

Die Entscheidung wird hier festgehalten, damit sie nachprüfbar ist und nicht
später zurechtgelegt wird. Sie hat einen Preis, der dazugehört: Die Aussage
lautet **nicht** „es gibt nichts", sondern „auf GitHub, mit diesen zwölf
Suchbegriffen, gibt es nichts, das alle vier Bedingungen erfüllt". Die
Paketverzeichnisse sind ungeprüft. Taucht dort ein Werkzeug auf, das die
Aufgabe erfüllt, gilt die Abbruchbedingung der Mission weiter — dann ist dieser
Fund nachzutragen und die Mission abzubrechen, nicht umzudeuten.

## Fremde Arbeit

Nichts aus dieser Prüfung wird übernommen. Die Quelltextausschnitte oben sind
Belegzitate — sie zeigen, worauf sich eine Aussage stützt, und stehen in keiner
Datei, die ausgeführt wird. `icsdoktor.py` benutzt nach der Missionsdatei nur
die Python-Standardbibliothek. Solange das so bleibt, hat `HERKUNFT.md` nach
Regel 6 keinen Eintrag aus diesem Projekt zu tragen.
