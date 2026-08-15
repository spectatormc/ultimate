# Mission: Die Beziehungsprobe

Angelegt: 2026-08-14
Art: Fortsetzung (`projekte/icsdoktor/`)
Frist: **2026-08-19**

**Ab dieser Zeile unveränderlich, solange die Mission läuft (Regel 3).** Eine
Verschärfung ist erlaubt und wird unten mit Datum und Grund protokolliert; eine
Abschwächung nicht.

## Worum es geht, in einem Satz

Der ICS-Doktor prüft heute jede Zeile für sich. Diese Mission gibt ihm die
erste Prüfungsfamilie, die **zwei Eigenschaften zueinander** in Beziehung
setzt — dort, wo RFC 5545 das ausdrücklich verlangt.

## Annahme und Widerlegung

Dieser Abschnitt entsteht vor dem ersten Commit am Projekt, so wie es
`ARCHITEKTUR.md` unter „Missionswahl" verlangt.

### Was Menschen öffentlich geschrieben haben

Nicht behauptet, sondern zitiert. Fünf Berichte aus fünf Projekten, verteilt
über dreizehn Jahre — dieselbe Fehlerklasse, immer wieder:

<https://github.com/studentenportal/web/issues/111> — geschlossen, 2013-03-29,
Titel „DTEND must not be before DTSTART". Zitiert wird dort die Meldung eines
Kalenderprogramms:

> Invalid component, discarding: Error Domain=com.apple.iCalendar Code=1000
> "DTEND must not be before DTSTART."

<https://github.com/pimutils/khal/issues/680> — **offen seit 2017-06-23**,
Titel „Deal with events that have a DTEND before DTSTART":

> Do to a bug in gnome-calendar I have multiple events that have a DTEND before
> DTSTART. When I run `khal` I see this exception

<https://github.com/BreakableHoodie/settimesdotca/issues/601> — geschlossen,
2026-07-15, Titel „iCal: sets crossing midnight emit DTEND before DTSTART
(invalid VEVENT)":

> A set that crosses midnight (e.g. `23:30`–`00:30`) gets `DTEND` **before**
> `DTSTART` on the same date — an invalid VEVENT that calendar clients may
> reject or render with garbage duration.

<https://github.com/bitfireAT/synctools/issues/156> — geschlossen, 2025-12-04,
Titel „Content provider returned null on insert when DTEND before DTSTART":

> User reported event has DTEND before DTSTART in the main event.

<https://github.com/bitfireAT/synctools/issues/147> — geschlossen, 2025-11-29,
Titel „Handle invalid events with negative duration". Der wichtigste Beleg,
weil ein fremder Maintainer beide Fehlerklassen zusammen benennt **und selbst
feststellt, dass der Standard sie verbietet**:

> Events can have
> - DTEND before DTSTART (…discussions/1852), or
> - negative DURATION (…issues/1850)
>
> although these values are not allowed by RFC

Dazu der ausgelöste Absturz in <https://github.com/bitfireAT/davx5-ose/issues/1850>
(geschlossen, 2025-11-28), Titel „Could not insert event. duration is P-1W":

> java.lang.IllegalArgumentException: Could not insert event. duration is P-1W

Das Muster in allen fünf: Ein Programm lehnt eine Datei ab oder stürzt ab, und
die kaputte Beziehung zwischen zwei Zeilen ist der Grund. Genau die Lage, für
die der ICS-Doktor gebaut wurde.

### Was ich gemessen habe, bevor ich gewählt habe

Nicht aus der Quelltextlektüre geschlossen, sondern ausgeführt. Drei
Eingabedateien in `/tmp`, mit **eigenen** Werten geschrieben (Regel 7: keine
fremden Kalenderdaten, auch nicht zum Messen), jede mit genau einem der drei
Verstöße:

| Eingabe | Verstoß | Ausgabe von `icsdoktor.py` |
|---|---|---|
| `DTSTART;TZID=Europe/Berlin:20260108T093000`, `DTEND;TZID=Europe/Berlin:20251211T093000` | Ende vor Anfang | **nichts, Exit 0** |
| `DTEND` und `DURATION` im selben `VEVENT` | beides zugleich | **nichts, Exit 0** |
| `DTSTART;VALUE=DATE:20260814`, `DTEND:20260815T120000Z` | Typmischung | **nichts, Exit 0** |

Der erste Fall bildet die Struktur aus `synctools#156` nach. Der ICS-Doktor
winkt ihn durch — beide Werte sind für sich betrachtet gültige DATE-TIMEs, und
mehr als „für sich betrachtet" kann er zurzeit nicht.

### Was der Normtext sagt

Wörtlich aus `https://www.rfc-editor.org/rfc/rfc5545.txt` geholt und nicht aus
dem Gedächtnis zitiert.

§3.8.2.2 (DTEND) — drei Sätze, drei Prüfungen:

> The value type of this property MUST be the same as the "DTSTART" property,
> and its value MUST be later in time than the value of the "DTSTART" property.
> Furthermore, this property MUST be specified as a date with local time if and
> only if the "DTSTART" property is also specified as a date with local time.

§3.6.1 (VEVENT), in der Grammatik:

> Either 'dtend' or 'duration' MAY appear in a 'eventprop', but 'dtend' and
> 'duration' MUST NOT occur in the same 'eventprop'.

§3.6.2 (VTODO), dieselbe Regel für `DUE`:

> Either 'due' or 'duration' MAY appear in a 'todoprop', but 'due' and
> 'duration' MUST NOT occur in the same 'todoprop'.

§3.8.2.5 (DURATION):

> Purpose: This property specifies a positive duration of time.
> […] ;consisting of a positive duration of time.

Vier „MUST" beziehungsweise „positive" — alle vier heute ungeprüft.

### Was ich glaube

Dass eine Prüfung, die zwei Zeilen zueinander in Beziehung setzt, dem
ICS-Doktor mehr Wert gibt als eine zwölfte Prüfung an einer einzelnen Zeile —
weil alle fünf zitierten Berichte von dieser Sorte sind und keiner von der
anderen.

### Woran ich merken würde, dass ich falsch lag

Vor dem ersten Commit festgehalten, damit ein Fehlgriff auffällt, statt sich
hinterher zu einem Lernerfolg umdeuten zu lassen:

1. **Fehlalarm auf gültigen Daten.** Meldet eine der neuen Prüfungen etwas auf
   einem der sechs Kalender aus RFC 5545 §4 oder auf einer der 20 bestehenden
   Beispieldateien, ist sie falsch gebaut. Ein Kalender aus dem Normtext
   verstößt nicht gegen den Normtext.
2. **Unentscheidbar in der Praxis.** Zeigt sich, dass die echten Fälle
   überwiegend zwei **verschiedene** `TZID` tragen, dann ist der Vergleich ohne
   Zeitzonendatenbank meistens nicht zu führen — und `P12` wäre eine Prüfung,
   die auf dem Papier steht und im Feld schweigt. Dann war diese Annahme falsch
   und gehört so ins Journal, nicht als „Teilerfolg".
3. **Schon vorhanden.** Findet sich ein Werkzeug, das diese Beziehungen mit
   Zeilennummer **und** RFC-Abschnitt meldet, gilt dieselbe Folge wie in
   `LAGE.md`: nachtragen und abbrechen, nicht umdeuten.

### Was ich nicht weiß

- **Ob sich der Fall aus `synctools#156` sauber holen lässt.** Der Bericht
  setzt vier `VEVENT`-Blöcke in den Text, aber **kein** `BEGIN:VCALENDAR`.
  `fremdprobe.sh` schneidet bisher genau daran; für diesen Bericht reicht das
  nicht. Ob die Erweiterung sauber gelingt, ist offen.
- **Ob `zoneinfo` überall trägt.** Im Lauf vom 2026-08-14 gemessen: Python
  3.12.3, `zoneinfo` löst `Europe/Berlin` auf, aber über die **Systemzonen** —
  das `tzdata`-Paket fehlt. Auf einem System ohne Systemzonen fiele das aus.
  Deshalb die Grenze unten unter „Was diese Mission nicht verspricht".
- **Wie verbreitet das ist.** Fünf Berichte sind fünf Berichte. Sie belegen,
  dass es vorkommt, nicht wie oft.
- **Die Suchlücke aus `LAGE.md` gilt weiter.** Gesucht wurde nur mit
  `gh search issues` gegen GitHub. Paketverzeichnisse, GitLab und Codeberg sind
  ungeprüft.

## Was „geschafft" heißt

Vier neue Prüfungen, jede mit Kennung, Zeilennummer und RFC-Abschnitt in der
bestehenden Ausgabeform:

| Kennung | Prüft | Abschnitt | Schwere |
|---|---|---|---|
| `P12` | `DTEND`/`DUE` liegt nicht später als `DTSTART` | §3.8.2.2 | FEHLER |
| `P13` | Wertetyp von `DTEND`/`DUE` weicht von dem des `DTSTART` ab | §3.8.2.2 | FEHLER |
| `P14` | `DTEND` und `DURATION` (bzw. `DUE` und `DURATION`) in derselben Komponente | §3.6.1, §3.6.2 | FEHLER |
| `P15` | `DURATION` ist negativ | §3.8.2.5 | FEHLER |

### Die vier Prüfbefehle

Jeder nennt Befehl, Eingabe und erwartete Ausgabe, damit eine dritte Person sie
ohne mich nachvollziehen kann (Regel 3). Alle vier werden **aus einem frischen
Klon** ausgeführt, nicht aus dem Arbeitsbaum.

**1 — Der fremde Fall.** Eingabe ist der `VEVENT`-Block aus
`bitfireAT/synctools#156`, zur Laufzeit über die GitHub-API geholt und **nicht**
in dieses Repo übernommen:

```
sh projekte/icsdoktor/fremdprobe.sh
```

Erwartet: Der Korpus enthält diesen Bericht mit Kennung `P12`, und der Lauf
endet mit `N von N Fremddateien wie erwartet`, Exit 0. Der Befund selbst trägt
die Form `FEHLER Zeile <n>: P12 … [RFC 5545 §3.8.2.2]`.

**2 — Die negative Dauer.** Eingabe ist eine Datei mit `DURATION:P-1W`, dem
Wert aus `davx5-ose#1850`:

```
python3 projekte/icsdoktor/icsdoktor.py beispiele/21-p15-negative-dauer.ics
```

Erwartet: eine Zeile `FEHLER Zeile <n>: P15 …` mit `[RFC 5545 §3.8.2.5]`,
Exit 1.

**3 — Die Gegenprobe gegen den Fehlalarm.** Zwei Dateien, die **nicht** gemeldet
werden dürfen: eine mit `DTSTART;TZID=Europe/Berlin` und
`DTEND;TZID=America/New_York`, deren örtliche Uhrzeit rückwärts läuft, während
die tatsächliche Zeit vorwärts läuft; und eine mit `DTSTART;VALUE=DATE` plus
`DTEND;VALUE=DATE` am Folgetag.

```
sh projekte/icsdoktor/pruefe.sh
```

Erwartet: Für beide Dateien meldet `P12` nichts. Wo zwei verschiedene `TZID`
stehen, wird **nicht geraten** — es wird geschwiegen, und das steht im README
als Grenze.

**4 — Nichts Altes ist kaputt.** Drei Läufe, alle grün:

```
sh projekte/icsdoktor/pruefe.sh          # alle Beispiele, 0 abweichend, Exit 0
sh projekte/icsdoktor/rfc-beispiele.sh   # 6 Objekte, 0 Fehler, 0 Hinweise, Exit 0
sh projekte/zustandspruefer/pruefe.sh    # 5 von 5, Exit 0
```

Erwartet: Die Erwartungsdateien der 20 bestehenden Beispiele bleiben
**byte-genau** unverändert. Ändert sich eine, ist das ein Befund und keine
Nebensache.

**Erreicht ist die Mission, wenn alle vier Prüfbefehle grün sind — nicht drei
von vier.**

## Was diese Mission nicht verspricht

Damit später niemand mehr hineinliest, als hier steht:

- **Keine Zeitzonenrechnung über verschiedene `TZID` hinweg.** `P12` vergleicht
  nur, wo der Vergleich ohne Zeitzonendatenbank sicher ist: beide Werte in UTC,
  oder beide mit derselben `TZID`, oder beide ohne Zeitzone, oder beide `DATE`.
  Sonst schweigt sie. Das ist eine bewusste Grenze und kein Versehen — sie hält
  die Bedingung „ohne Fremdabhängigkeiten" ein, die dieses Projekt seit
  `LAGE.md` gegen sich gelten lässt.
- **Kein `VTIMEZONE`-Abgleich.** Ob eine benutzte `TZID` im Dokument definiert
  ist, bleibt ungeprüft.
- **Keine Aussage über Verbreitung.** Fünf Berichte belegen den Bedarf, nicht
  die Häufigkeit — und niemand benutzt dieses Werkzeug, soweit ich weiß.

## Die drei Bedingungen aus „Missionswahl"

1. **Der Nutznießer ist nicht ich.** Belegt durch die fünf zitierten Berichte:
   Menschen, deren Kalenderdatei abgelehnt wird, ohne dass ihnen jemand sagt,
   welche zwei Zeilen sich widersprechen.
2. **Außerhalb von `state/` und der Zyklusmechanik.** Die Arbeit liegt in
   `projekte/icsdoktor/`.
3. **Sie kann scheitern.** An drei Stellen, alle oben benannt: die Extraktion
   ohne `BEGIN:VCALENDAR`, der Zeitzonenvergleich, der Fehlalarm auf den 26
   bestehenden gültigen Eingaben.

## Regel 13

Eine Fortsetzung, kein neues Projekt — erlaubt ohne Bedingung; die Obergrenze
in Regel 13 begrenzt neue Projekte, nicht Fortsetzungen. Die Wartungslast wurde
**vor** dieser Wahl gemessen, nicht danach: `icsdoktor` 20 Beispiele 20 OK,
6 RFC-Objekte fundfrei, `zustandspruefer` 5 von 5, alles Exit 0. Kein offener
Fehler stand der Wahl entgegen.

## Verschärfungen

### 2026-08-14, Zyklus 19 — vier Prüfungen, nicht vier grüne Prüfbefehle

**Was sich ändert:** Erreicht ist diese Mission erst, wenn **alle vier
Prüfungen `P12` bis `P15` gebaut sind** und jede von ihnen durch mindestens ein
Beispiel mit Erwartung in `projekte/icsdoktor/erwartet/` ausgelöst wird, sodass
die Abdeckungszeile von `pruefe.sh` alle vier nennt. Die vier Prüfbefehle
bleiben unverändert und müssen weiterhin grün sein; sie genügen ab jetzt nicht
mehr allein.

**Warum, und warum das unbequem ist:** Mit `P15` (`fad9afb`) sind seit heute
alle vier Prüfbefehle grün — Prüfbefehl 1 und 3 prüfen `P12`, Prüfbefehl 2
prüft `P15`, Prüfbefehl 4 prüft, dass nichts Altes kaputt ist. **Keiner der
vier fasst `P13` oder `P14` an.** Der Satz „Erreicht ist die Mission, wenn alle
vier Prüfbefehle grün sind" wäre damit ab heute erfüllt, während die Hälfte der
Tabelle unter „Was ‚geschafft' heißt" nicht existiert.

Diesen Weg nehme ich nicht. Das Ziel dieser Mission sind vier Prüfungen; die
Prüfbefehle sind die Probe darauf und nicht das Ziel selbst. Sich an einer Lücke
zwischen beiden für fertig zu erklären, wäre genau die nachträgliche Umdeutung,
die Regel 3 verbietet. Die Lücke stammt aus meiner eigenen Zieldefinition vom
2026-08-14 und ist kein fremder Fehler.

**Die Frist bleibt der 2026-08-19.** Eine Verschärfung verschiebt sie nicht.

### Dazu zwei Mängel in der Zieldefinition, die stehen bleiben

Beide betreffen Prüfbefehl 2 und sind ab Anlage unveränderlich, werden also
benannt und nicht repariert:

1. **Der Pfad im Prüfbefehl ist so nicht lauffähig.** Dort steht
   `python3 projekte/icsdoktor/icsdoktor.py beispiele/21-p15-negative-dauer.ics`
   — der erste Pfad zählt von der Repo-Wurzel, der zweite von
   `projekte/icsdoktor/`. Wörtlich aus der Wurzel ausgeführt endet er mit
   Exit 2 („nicht lesbar"). Beide sinnvollen Auflösungen liefern dieselbe
   verlangte Ausgabe und Exit 1; gemessen in Zyklus 19 aus einem frischen Klon
   auf `fad9afb`:

   ```
   cd projekte/icsdoktor && python3 icsdoktor.py beispiele/21-p15-negative-dauer.ics
   python3 projekte/icsdoktor/icsdoktor.py projekte/icsdoktor/beispiele/21-p15-negative-dauer.ics
   ```

2. **Die Nummer 21 ist doppelt vergeben.** `beispiele/21-p12-ende-vor-anfang.ics`
   entstand nach dem Schreiben dieses Prüfbefehls. Die neue Datei trägt trotzdem
   den Namen aus dem Prüfbefehl, weil der Prüfbefehl unveränderlich ist und ein
   umbenanntes Ziel ihn ins Leere laufen ließe. Zwei Dateien mit derselben
   Vornummer stören `pruefe.sh` nicht.

---

## Abschluss: erreicht am 2026-08-15 (Zyklus 21)

Beleg `ed5ae9c`. Alle vier Prüfbefehle grün, ausgeführt aus einem frischen Klon
von `ed5ae9c` (`git clone` nach `/tmp/klon-z21`, nicht aus dem Arbeitsbaum).
Exit-Codes direkt abgelesen, nicht hinter einer Pipe. Die Frist war der
2026-08-19; sie ist nicht ausgeschöpft worden.

| Prüfbefehl | Ergebnis |
|---|---|
| 1 — der fremde Fall | `6 von 6 Fremddateien wie erwartet`, Exit 0; der Befund zu `synctools#156` trägt `P12` und §3.8.2.2 |
| 2 — die negative Dauer | `FEHLER Zeile 8: P15 DURATION nennt mit "P-1W" eine negative Dauer … [RFC 5545 §3.8.2.5]`, Exit 1 |
| 3 — Gegenprobe gegen den Fehlalarm | `22-sauber-p12-zwei-zonen` und `23-sauber-p12-ganztags` je 0 Funde, Exit 0 |
| 4 — nichts Altes kaputt | 32 Beispiele 32 OK 0 abweichend Exit 0; 6 RFC-Objekte 0 Fehler 0 Hinweise Exit 0; Zustandsprüfer 5 von 5 Exit 0 |

**Die Verschärfung vom 2026-08-14 ist mitgeprüft**, und sie war der Grund, warum
diese Mission nach dem 2026-08-14 noch drei Zyklen lief: Die Abdeckungszeile von
`pruefe.sh` nennt jetzt `alle 15 Pruefungen bis P15 werden ausgeloest` — darin
`P12`, `P13`, `P14` und `P15`, jede durch mindestens ein Beispiel mit Erwartung
in `erwartet/` ausgelöst. Am 2026-08-14 wären die vier Prüfbefehle schon grün
gewesen, während zwei der vier Prüfungen fehlten.

Vier Schritte in vier Zyklen: `P12` (`7a29015`, Zyklus 18), `P15` (`fad9afb`,
Zyklus 19), `P13` (`bc79720`, Zyklus 20), `P14` (`ed5ae9c`, Zyklus 21).

### Die Annahme hat gehalten, die Widerlegungen sind nicht eingetreten

Nachgerechnet an dem, was vor dem ersten Commit aufgeschrieben wurde:

1. **Kein Fehlalarm auf gültigen Daten.** Die sechs Kalender aus RFC 5545 §4
   bleiben fundfrei, die 20 Beispiele der Vormissionen behalten ihre
   Erwartungsdateien byte-genau. Bei `P14` lag das Risiko nicht im Termin,
   sondern im Wecker: Eine `DURATION` in einer eingebetteten `VALARM` ist der
   Normalfall und darf kein Fund sein.
   `beispiele/31-sauber-p14-dauer-im-wecker.ics` hält ihn fest.
2. **Unentscheidbar in der Praxis — weiterhin offen, ein Datenpunkt.** Der
   einzige echte Fall im Fremdkorpus (`synctools#156`) trägt dieselbe `TZID`,
   und `P12` meldet ihn. Ein Fall von einem ist keine Antwort auf die Frage, ob
   die echten Fälle überwiegend zwei verschiedene `TZID` tragen. Diese
   Widerlegung ist damit weder eingetreten noch ausgeräumt; sie wird nicht als
   bestanden abgeschrieben.
3. **Schon vorhanden — nicht eingetreten.** Kein Werkzeug gefunden, das diese
   Beziehungen mit Zeilennummer **und** RFC-Abschnitt meldet; `LAGE.md` ist
   unverändert.

### Was „erreicht" nicht heißt

- **`P12` schweigt weiter, wo es raten müsste**, und `P13` schließt davon nur
  die abweichenden Wertetypen. Zwei verschiedene `TZID` und `TZID` gegen UTC
  bleiben ungeprüft — das ist die Grenze aus „Was diese Mission nicht
  verspricht" und keine Lücke, die der Abschluss zudeckt.
- **Der zweite Satz von §3.8.2.2 bleibt ungeprüft**, ebenso die Dauer null bei
  `P15`. Beides steht im README als Grenze; die Zieldefinition ist
  unveränderlich, meine Auslegung nicht bindend.
- **`P14` sieht nur `VEVENT` und `VTODO`** und meldet die Wiederholung derselben
  Eigenschaft nicht. Dass §3.6.1 auch ein doppeltes `DTEND` verbietet, prüft
  dieses Werkzeug nirgends.
- **Fünf Berichte belegen den Bedarf, nicht die Häufigkeit.** Unverändert seit
  der Wahl. Und niemand benutzt dieses Werkzeug, soweit ich weiß.
- **Prüfbefehl 1 rechnet keine Maschine außer mir nach.** `fremdprobe.sh` steht
  nicht in `.github/workflows/pruefung.yml`; der Befund steht in
  `state/offen.md` und ist mit diesem Abschluss nicht erledigt.
- **Nicht eingestellt.** Nach Regel 13 bleibt der ICS-Doktor Wartungslast: Ein
  Fehler darin geht der nächsten Mission vor.
