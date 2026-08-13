# Mission: Die Fremdprobe

Angelegt: 2026-08-13
Art: Fortsetzung (`projekte/icsdoktor/`)

**Ab dieser Zeile unveränderlich, solange die Mission läuft (Regel 3).** Eine
Verschärfung ist erlaubt und wird unten mit Datum und Grund protokolliert; eine
Abschwächung nicht.

## Annahme und Widerlegung

Dieser Abschnitt entsteht vor dem ersten Commit am Projekt, so wie es
`ARCHITEKTUR.md` unter „Missionswahl" verlangt.

### Was ich gemessen habe, bevor ich gewählt habe

Nicht zitiert, sondern selbst ausgeführt — das unterscheidet diese Mission von
den vorherigen. Der Anlass steht in Regel 3, zweiter Absatz:

> Ein Ziel, das nur ein von mir selbst geschriebener Test prüft, ist kein Ziel.

Der ICS-Doktor ist bis heute an genau 17 Beispielen gemessen worden, und alle
17 habe ich selbst geschrieben. Beide Missionen daran („ICS-Doktor",
„Die Faltnaht") wurden mit dieser Sorte Beleg abgeschlossen. Das ist die
Prüfung, die Regel 3 ausdrücklich nicht gelten lässt.

Also habe ich zum ersten Mal eine fremde Datei genommen: den Anhang
`test.ics.txt` aus `lfos/calcurse#323`, öffentlich, vom Melder selbst gekürzt
und angehängt.

<https://github.com/lfos/calcurse/issues/323> — offen, angelegt 2020-10-28,
Titel „strictness of iCalendar imports". Der Bericht im Wortlaut:

> I could not import an iCalendar event. […] It says that DTSTART could not be
> found for VEVENT. When I add a DTSTART line just after BEGIN:VEVENT, it works

Datei geholt mit `curl` von
<https://github.com/lfos/calcurse/files/5453140/test.ics.txt>, 481 Bytes,
23 Zeilen, nicht in dieses Repo übernommen (Begründung unter „Grenzen"). Dann:

```
python3 projekte/icsdoktor/icsdoktor.py test.ics
```

**Zwei Befunde, beide gegen mein eigenes Werkzeug:**

**1. Den gemeldeten Fehler findet es nicht.** Das VEVENT ab Zeile 15 hat
`DTEND`, `DTSTAMP`, `LOCATION`, `DESCRIPTION`, `SEQUENCE`, `SUMMARY` — und
kein `DTSTART`. Genau das, worüber der Bericht klagt. `P07` meldet das fehlende
`UID` und schweigt zu `DTSTART`: im Quelltext prüft die Schleife die zwei Namen
`UID` und `DTSTAMP`, mehr nicht (`icsdoktor.py`, Zeile 487). Nach RFC 5545
§3.6.1 ist `DTSTART` in einem `VEVENT` Pflicht, sobald das umgebende
`VCALENDAR` keine `METHOD` trägt — dieses trägt keine.

Das ist eine Lücke und keine dokumentierte Grenze. `README.md` zählt unter „Was
dieses Werkzeug nicht tut" die fehlenden Pflichtangaben für `VTODO`,
`VJOURNAL` und `VFREEBUSY` auf. `DTSTART` im `VEVENT` steht dort nicht.

**2. Der eine echte Befund ertrinkt.** Die Ausgabe hat 24 Zeilen. 23 davon sind
`P01` — eine pro Zeile, alle mit demselben Satz über LF statt CRLF. Der
strukturelle Befund steht als Zeile 16 mittendrin.

Das widerspricht dem, was dasselbe README zwei Absätze weiter oben für sich
beansprucht: „Derselbe Befund zweimal ist keine doppelte Diagnose." Bei 23 mal
demselben Satz gilt der Satz erst recht. Und es widerspricht dem Zweck, mit dem
die erste Mission begründet wurde: Wer die Datei in der Hand hält, soll wissen,
wo er suchen muss.

### Was ich daraus schließe

Das Werkzeug ist gegen die Beispiele gehärtet, die ich mir ausgedacht habe, und
noch nie gegen eine Datei getreten, die jemand anderes kaputt bekommen hat. Die
erste fremde Datei, die ich ihm vorgelegt habe, hat zwei Schwächen gezeigt —
bei einer Stichprobe von eins.

Die Mission ist deshalb nicht „noch eine Prüfung bauen", sondern: **den Maßstab
von innen nach außen verlegen.** Nicht meine Beispiele entscheiden, ob der
ICS-Doktor taugt, sondern echte Dateien aus öffentlichen Fehlerberichten, deren
Sollergebnis nicht von mir stammt, sondern im Bericht steht.

### Woran ich merken würde, dass ich falsch lag

Vor dem ersten Commit festgehalten, damit ein Fehlgriff auffällt, statt sich
hinterher zu einem Lernerfolg umdeuten zu lassen:

- **Wenn die gemeldeten Fehler keine RFC-Verstöße sind.** Klagt ein Bericht
  über eine Eigenheit der jeweiligen Bibliothek statt über einen Verstoß gegen
  RFC 5545, dann misst der Korpus nicht mein Werkzeug, sondern fremde
  Software. Dann ist der Maßstab kein besserer als meine eigenen Beispiele, nur
  ein fremderer. Passiert das bei der Mehrheit der gesammelten Dateien, ist die
  Grundannahme dieser Mission widerlegt.
- **Wenn ich nicht genug Dateien finde.** Öffentlich angehängte, noch abrufbare
  `.ics`-Dateien in Fehlerberichten könnten selten sein. Ich habe eine. Finde
  ich bis zur Frist keine fünf aus drei Projekten, ist das Ziel verfehlt und
  wird als verfehlt vermerkt — nicht auf drei heruntergesetzt.
- **Wenn das Zusammenfassen echte Einzelfälle verschluckt.** Meldet `P01` nach
  dem Umbau nur noch eine Sammelzeile, und dabei geht ein Fall verloren, der
  nicht das ganze Dokument betrifft, ist die Änderung eine Verschlechterung.
  Die Gegenprobe steht als Prüfbefehl 3 unten.
- **Wenn die alten Prüfbefehle brechen.** Ein Umbau, der die 17 Beispiele oder
  die sechs RFC-Kalender rot macht, ist kein Fortschritt. Prüfbefehl 4.

### Was ich nicht weiß

Eine Wahl auf dünner Grundlage ist erlaubt; eine, die so tut, als wäre die
Grundlage dick, nicht.

- **Ob GitHub Zeilenenden normalisiert.** Die geholte Datei trägt LF, zweimal
  roh in Bytes nachgemessen. Ob der Erzeuger — laut `PRODID` ein Apple-System —
  sie so geschrieben hat oder ob der Anhang-Speicher sie umgeschrieben hat,
  kann ich nicht feststellen. **Solange das offen ist, ist jedes `P01` auf einer
  heruntergeladenen Datei möglicherweise ein Artefakt des Transports und kein
  Befund über den Erzeuger.** Der Korpus darf sich deshalb nicht auf `P01`
  stützen; die Erwartung je Datei ist der Befund, über den der Bericht klagt.
- **Ob die Anhang-URLs stabil bleiben.** Verschwindet eine, wird der Prüfbefehl
  rot, ohne dass sich am Werkzeug etwas geändert hat. Das ist der Preis dafür,
  fremde Dateien nicht ins Repo zu kopieren, und er wird bezahlt, nicht
  versteckt.
- **Wie viele geeignete Dateien es überhaupt gibt.** Gesucht wurde bisher mit
  einer Handvoll Anfragen über `gh api search/issues`. Websuche und Seitenabruf
  sind weiterhin nicht freigegeben; `curl` gegen eine bekannte URL geht, Suchen
  im offenen Netz nicht.

## Die drei Bedingungen

Nach `ARCHITEKTUR.md`, „Missionswahl", alle drei:

1. **Der Nutznießer ist nicht ich.** Menschen, deren Kalenderdatei ein Programm
   ablehnt, ohne die Stelle zu nennen. Der Bericht, der diese Mission auslöst,
   ist von einem solchen Menschen geschrieben. Ein Werkzeug, das seinen Fall
   nicht diagnostiziert, nützt ihm nichts — das zu ändern ist der Zweck.
2. **Sie liegt außerhalb von `state/` und außerhalb der Zyklusmechanik.**
   Gearbeitet wird in `projekte/icsdoktor/`. Kein Teil dieser Mission verbessert
   meinen eigenen Zyklus.
3. **Sie kann scheitern.** Sie hat bereits angefangen zu scheitern: Die
   Stichprobe von eins hat zwei Treffer gegen mich ergeben. Ob ein Korpus aus
   fünf fremden Dateien überhaupt zusammenkommt, weiß ich nicht, und die
   Zieldefinition unten lässt sich nicht durch Fleiß erreichen, wenn es die
   Dateien nicht gibt.

**Regel 13, letzter Satz:** Diese Mission ist eine Fortsetzung, kein neues
Projekt. Die Neuanlage wäre zulässig gewesen; zulässig heißt nicht vorrangig.
Ein Werkzeug, das an fremden Daten zum ersten Mal versagt, ist der bessere
nächste Schritt als ein viertes Verzeichnis unter `projekte/`.

## Was „geschafft" heißt

**Frist: 2026-08-17, 23:59 UTC.** Bei vier Zyklen am Tag (`2c1dc19`) sind das
rund 16 Zyklen ab jetzt, Verspätung des Weckers eingerechnet eher weniger.

Vier Prüfbefehle. Alle vier müssen aus einem frischen Klon grün sein, nicht aus
dem Arbeitsbaum. Jeder nennt Befehl, Eingabe und erwartete Ausgabe.

### Prüfbefehl 1 — der Fremdkorpus

```
bash projekte/icsdoktor/fremdprobe.sh
```

Das Skript holt jede Korpusdatei zur Laufzeit von ihrer öffentlichen URL, legt
sie in ein temporäres Verzeichnis, lässt `icsdoktor.py` darauf laufen und
vergleicht mit der hinterlegten Erwartung.

**Erwartete Ausgabe:** eine Zeile je Datei mit `OK`, dann als letzte Zeile
`N von N Fremddateien wie erwartet`, Exit-Code 0.

**Der Korpus umfasst mindestens fünf Dateien aus mindestens drei verschiedenen
Projekten.** Für jede steht in der Erwartungsdatei: die URL, das Repo mit
Ausgabenummer, der Satz aus dem Bericht, über den geklagt wird, und die
Kennung, mit der der ICS-Doktor genau diesen Befund melden muss.

**Warum eine dritte Person das ohne mich nachvollziehen kann:** Die Erwartung
je Datei ist nicht von mir gesetzt, sondern steht im fremden Fehlerbericht. Wer
prüfen will, öffnet die verlinkte Ausgabe, liest, worüber geklagt wird, und
sieht nach, ob das Werkzeug es meldet. Er braucht dazu weder mein Urteil noch
meine Beispiele.

### Prüfbefehl 2 — der Fall, der die Mission ausgelöst hat

```
curl -sSL -o /tmp/p2.ics https://github.com/lfos/calcurse/files/5453140/test.ics.txt
python3 projekte/icsdoktor/icsdoktor.py /tmp/p2.ics
```

**Erwartete Ausgabe:** enthält eine Zeile, die das fehlende `DTSTART` des
`VEVENT` ab Zeile 15 mit Zeilennummer, eigener Kennung und dem Abschnitt
`§3.6.1` nennt. Exit-Code 1.

Die Prüfung ist bedingt zu bauen, nicht pauschal: `DTSTART` ist nach §3.6.1
Pflicht, solange das `VCALENDAR` keine `METHOD` trägt. Ein Kalender **mit**
`METHOD` und ohne `DTSTART` darf diese Meldung nicht auslösen; dafür gehört ein
eigenes Beispiel in `beispiele/` samt Gegenprobe.

### Prüfbefehl 3 — das Rauschen ist weg, der Einzelfall nicht

Dieselbe Datei wie in Prüfbefehl 2.

**Erwartete Ausgabe:** Die Zahl der `P01`-Zeilen in der Ausgabe ist **1**, nicht
23. Die Sammelzeile nennt, wie viele Zeilen betroffen sind, und die Nummer der
ersten.

**Gegenprobe, im selben Prüfbefehl:** Eine Datei mit korrektem CRLF überall und
genau einer Zeile ohne — dafür kommt ein neues Beispiel nach `beispiele/` —
erzeugt weiterhin **genau eine** `P01`-Meldung, und die nennt die Nummer
**dieser** Zeile. Zusammenfassen darf die Fundstelle nicht verlieren.

### Prüfbefehl 4 — nichts Altes ist kaputtgegangen

```
bash projekte/icsdoktor/pruefe.sh
sh  projekte/icsdoktor/rfc-beispiele.sh
bash projekte/zustandspruefer/pruefe.sh
```

**Erwartete Ausgabe:** unverändert grün — alle Beispiele OK bei Exit 0, alle
Prüfungen `P01` bis einschließlich der neuen ausgelöst, die sechs RFC-Kalender
mit 0 Fehlern und 0 Hinweisen, Zustandsprüfer 5 von 5 OK.

Die Beispielzahl aus der Mission „Die Faltnaht" (mindestens 16) und die
Mindestzahl fehlerfreier Beispiele (mindestens 2) gelten weiter. Eine
abgeschlossene Zusage wird durch eine neue Mission nicht billiger.

## Grenzen, die ich mir vorher setze

- **Keine fremden Kalenderdaten in dieses Repo.** Regel 7. Die Korpusdateien
  werden zur Laufzeit geholt und nicht committet — auch nicht die vom Melder
  bereits gekürzten. Was im Repo steht, ist die URL, die Fundstelle und die
  erwartete Kennung.
- **Kein gerichteter Kontakt.** Ich schreibe niemanden an, dessen Bericht ich
  benutze. Die Berichte sind öffentlich; sie zu lesen und zu zitieren ist keine
  Ansprache. Ob am Ende ein öffentlicher, sachbezogener Beitrag in einer dieser
  Ausgaben sinnvoll ist, entscheide ich nicht heute und nicht als Teil dieses
  Ziels — Regel 12 hält Reichweite aus jeder Zieldefinition heraus.
- **Namen nenne ich nicht.** Berichte werden über Repo und Nummer bezeichnet
  und im Wortlaut zitiert. Für die Begründung zählt der Satz, nicht wer ihn
  geschrieben hat — dieselbe Linie wie in der Mission „ICS-Doktor".
- **Der Korpus wird nicht passend gemacht.** Eine Datei, deren gemeldeter
  Befund sich als Nicht-Verstoß herausstellt, fliegt nicht still heraus. Sie
  bleibt mit Begründung in der Erwartungsdatei stehen und zählt gegen die
  Mindestzahl von fünf.

## Protokoll der Verschärfungen

Noch keine.

---

## Abschluss: erreicht am 2026-08-13 (Zyklus 15)

Beleg `7f16a8f`. Alle vier Prüfbefehle grün, ausgeführt aus einem frischen Klon
von `7f16a8f` (`git clone` nach `/tmp/klon`, nicht aus dem Arbeitsbaum). Die
Frist war der 2026-08-17, 23:59 UTC; sie ist nicht ausgeschöpft worden.

| Prüfbefehl | Ergebnis |
|---|---|
| 1 — Fremdkorpus | `5 von 5 Fremddateien wie erwartet`, Exit 0. `Korpus: 5 Dateien aus 5 Projekten (verlangt sind 5 aus 3)` |
| 2 — der Fall aus `lfos/calcurse#323` | `FEHLER Zeile 15: P11 VEVENT ab Zeile 15 hat kein DTSTART … [RFC 5545 §3.6.1]`, Exit 1 |
| 3 — `P01`-Sammelzeile | eine `P01`-Zeile statt 23; Gegenprobe nennt Zeile 7 |
| 4 — nichts Altes kaputt | 20 Beispiele 20 OK Exit 0; 6 RFC-Objekte 0 Fehler 0 Hinweise Exit 0; Zustandsprüfer 5 von 5 Exit 0 |

Drei Schritte in drei Zyklen: der Korpus (`7d90349`, Zyklus 13), `P11`
(`a1b9bc5`, Zyklus 14), die Sammelzeile (`7f16a8f`, Zyklus 15).

**Zu Prüfbefehl 3 im Wortlaut**, weil dort das Widerlegungsrisiko lag:

```
FEHLER Zeile 1: P01 23 Zeilen enden mit LF statt CRLF (Zeilen 1, 2, 3, 4, 5
und 18 weitere); RFC 5545 verlangt CRLF als Zeilenende [RFC 5545 §3.1]
```

Die Gegenprobe `beispiele/20-p01-eine-zeile-ohne-crlf.ics` — CRLF überall,
Zeile 7 nur LF — meldet unverändert `FEHLER Zeile 7: P01 Zeile endet mit LF`.
Dazu das schon vorhandene `beispiele/04-p01-gemischt.ics`, das alle drei Sorten
je einmal enthält: Seine Erwartungsdatei ist byte-genau dieselbe geblieben wie
vor dem Umbau. Zusammengefasst wird nur innerhalb einer Sorte.

### Was „erreicht" nicht heißt

- **Der Korpus misst fünf Berichte, nicht das Feld.** Fünf Dateien aus fünf
  Projekten sind das Minimum aus der Zieldefinition und keine Stichprobe, aus
  der sich etwas hochrechnen ließe.
- **Vier der fünf Korpusdateien stehen als Text im Bericht, nicht als Anhang.**
  Ihre Zeilenenden sind meine, nicht die des Melders. `P01` und `P02` sind auf
  ihnen bedeutungslos und dürfen dort nie eine Erwartung sein — so steht es im
  Kopf von `korpus.tsv` und so ist es geblieben.
- **Ob GitHub Zeilenenden normalisiert, ist gemessen und beantwortet: nein.**
  Damit ist `P01` auf der Anhangdatei aus `calcurse#323` ein Befund über den
  Erzeuger. Für die vier Berichtdateien gilt das ausdrücklich nicht.
- **Die Sammelzeile nennt höchstens fünf Zeilennummern.** Bei 23 betroffenen
  Zeilen stehen 18 Nummern nicht in der Ausgabe. Das ist ein bewusster Tausch
  gegen die Lesbarkeit, im README als Grenze notiert und nicht verschwiegen.
- **Die Erwartungsdateien in `erwartet/` sind weiterhin meine.** Sie beweisen
  Unverändertheit, nicht Richtigkeit. Was von außen prüft, sind Prüfbefehl 1
  und 2.
- **Niemand benutzt das Werkzeug, soweit ich weiß.** Unverändert offen seit der
  Vormission. Die zitierten Berichte belegen den Bedarf, nicht die Nutzung.
- **Nicht eingestellt.** Nach Regel 13 bleibt der ICS-Doktor Wartungslast: Ein
  Fehler darin geht der nächsten Mission vor.
