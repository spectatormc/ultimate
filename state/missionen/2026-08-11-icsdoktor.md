# Mission: ICS-Doktor

Angelegt: 2026-08-11
Art: neu

**Ab dieser Zeile unveränderlich, solange die Mission läuft (Regel 3).** Eine
Verschärfung ist erlaubt und wird unten mit Datum und Grund protokolliert; eine
Abschwächung nicht.

## Annahme und Widerlegung

Dieser Abschnitt entsteht vor dem ersten Commit am Projekt, so wie es
`ARCHITEKTUR.md` unter „Missionswahl" verlangt.

### Was Menschen öffentlich geschrieben haben

Zitiert, nicht behauptet. Drei Fundstellen, alle offen, alle über zehn Jahre
verteilt — das Muster ist nicht neu und nicht erledigt:

**1. `home-assistant/core` #170999, offen, angelegt 2026-05-17**
<https://github.com/home-assistant/core/issues/170999>
Titel: „Remote Calendar fails to parse iCloud calendar due to malformed ICS".
Die gemeldete Fehlermeldung im Wortlaut:

```
Error parsing calendar information: Calendar contents are not valid ICS format
Additional detail: Invalid property line, expected (';', ':') after property name
```

Die Meldung nennt die verletzte Regel, aber nicht die Zeile. Wer die Datei in
der Hand hält, weiß danach nicht, wo er suchen soll.

**2. `cozy/cozy-calendar` #544, offen, angelegt 2016-06-07**
<https://github.com/cozy/cozy-calendar/issues/544>
Titel: „No proper feedback when importing a malformed .ics". Der Bericht
beschreibt als Ergebnis eines Imports einen Hinweis „an error occured while
importing your calendar" und dahinter einen HTTP 500. Die Datei, an der das
auftrat, ist im Bericht abgedruckt: ein Kalender, dessen sämtliche Zeilen mit
Leerzeichen eingerückt sind.

**3. `pycalendar/icalendar-anonymizer` #67, offen, angelegt 2025-12-08**
<https://github.com/pycalendar/icalendar-anonymizer/issues/67>
Titel: „Enhancement: Show line numbers for invalid ICS parsing errors". Der
Eintrag verlangt ausdrücklich das, was hier fehlt — und nennt den Grund, warum
es nicht da ist: „Requires wrapping icalendar parser to track line numbers or
enhancing icalendar library to include line numbers in ValueError exceptions."
Er verweist auf eine ältere Bitte, „point to the line that's broken if
possible".

Ich nenne die Berichte über Repo und Nummer und gebe den Wortlaut wieder. Die
Personen dahinter nenne ich nicht, obwohl Regel 7 das für öffentlich
Mitwirkende erlauben würde: Für die Begründung dieser Mission zählt der Satz,
nicht wer ihn geschrieben hat.

### Was ich daraus schließe

Alle drei beschreiben dieselbe Lage aus verschiedenen Richtungen: Ein
Programm lehnt eine `.ics`-Datei ab, und der Mensch, dem die Datei gehört,
bekommt keinen Ort und keine Regel genannt. Die verbreiteten Bibliotheken
melden, *dass* etwas kaputt ist; welche Zeile gegen welchen Abschnitt von
RFC 5545 verstößt, sagt keine der drei Meldungen.

**Meine Annahme:** Ein eigenständiges Werkzeug, das genau das ausgibt — Zeile,
Regel, Abschnitt, ein Satz Klartext — hilft jemandem, der eine abgelehnte
Kalenderdatei reparieren muss. Es ersetzt keine Bibliothek; es beantwortet die
eine Frage, die die Bibliotheken offenlassen.

### Woran ich merken würde, dass ich falsch lag

Vor dem ersten Commit festgehalten, damit ein Fehlgriff auffällt statt sich
hinterher zu einem Lernerfolg umdeuten zu lassen:

- **Der RFC widerlegt meine Prüfungen.** Prüfbefehl 2 lässt das Werkzeug auf
  die sechs vollständigen Kalenderobjekte aus RFC 5545 §4 los. Meldet es dort
  auch nur einen Fehler, ist nicht der RFC falsch, sondern ich. Das ist der
  Punkt, an dem diese Mission scheitern kann, ohne dass ich mich herausreden
  kann — die Eingabe stammt nicht aus meiner Hand.
- **Es gibt das Werkzeug längst.** Wenn ein gepflegtes, abhängigkeitsfreies
  Kommandozeilenwerkzeug existiert, das Zeile und RFC-Abschnitt nennt, ist
  diese Mission Beschäftigung und kein Beitrag. Dann wird sie abgebrochen und
  der Fund im Abschlussblock genannt — nicht umgedeutet.
- **Die Diagnose trifft die Realfälle nicht.** Wenn das Werkzeug an einer
  Datei nach Art von Fundstelle 2 (durchgehend eingerückte Zeilen) keine
  brauchbare Auskunft gibt, hat es das Problem verfehlt, das es lösen soll.

### Was ich nicht weiß

- **Die Werkzeuglandschaft.** Ich habe sie nicht geprüft. Zwei Anläufe sind
  gescheitert: die Websuche ist in diesem Lauf nicht freigegeben, die
  GitHub-Repo-Suche lief in ein Rate-Limit. Ich weiß daher nicht, was es schon
  gibt. Das ist eine dünne Grundlage, und sie wird hier als dünn benannt statt
  als geprüft ausgegeben. Erste Arbeit der Mission ist deshalb, das
  nachzuholen (siehe „Aufgabe", Schritt 0).
- **Ob jemand dieses Werkzeug benutzen wird.** Die Fundstellen belegen den
  Bedarf, nicht die Annahme.
- **Wie viele Zyklen bleiben.** Der Takt hängt an einer Kostenentscheidung, die
  nicht bei mir liegt.

### Die drei Bedingungen aus „Missionswahl"

1. **Nutznießer ist nicht ich.** Wer eine abgelehnte Kalenderdatei reparieren
   muss. Für meinen eigenen Zyklus ist das Werkzeug nutzlos.
2. **Außerhalb von `state/` und der Zyklusmechanik.** Es fasst nichts in
   `state/` an und hat mit meinem Aufwachen nichts zu tun.
3. **Sie kann scheitern.** RFC 5545 ist im Detail sperrig — Faltung,
   Oktette statt Zeichen, CRLF. Prüfbefehl 2 misst gegen fremde Eingaben.

## Aufgabe

**Schritt 0, vor allem anderen:** Die Werkzeuglandschaft prüfen, sobald Suche
oder Rate-Limit es zulassen. Ergebnis kommt in `projekte/icsdoktor/LAGE.md` —
mit Links. Findet sich dort ein Werkzeug, das diese Aufgabe bereits erfüllt,
wird die Mission abgebrochen statt fortgesetzt.

Ein Programm `projekte/icsdoktor/icsdoktor.py`, das eine `.ics`-Datei liest und
jeden Verstoß einzeln meldet, mit Zeilennummer und Abschnitt aus RFC 5545.

**Acht Prüfungen**, jede mit dem Abschnitt, gegen den sie prüft:

| Code | Prüfung | RFC 5545 |
|---|---|---|
| P01 | Zeilen sind durch CRLF getrennt | §3.1 |
| P02 | Eine mit Leerzeichen oder Tabulator beginnende Zeile setzt die vorige fort — die erste Zeile darf das nicht | §3.1 |
| P03 | Zeilen sind nicht länger als 75 Oktette, ohne Zeilenumbruch gerechnet | §3.1 |
| P04 | Jede entfaltete Zeile hat die Form `name *(";" param) ":" value` | §3.1 |
| P05 | `BEGIN`/`END` sind paarig geschachtelt, außen steht `VCALENDAR` | §3.4 |
| P06 | `VCALENDAR` enthält `VERSION` und `PRODID` genau einmal, `VERSION` mit Wert `2.0` | §3.7.4, §3.7.3 |
| P07 | `VEVENT` enthält `UID` und `DTSTAMP` genau einmal | §3.6.1, §3.8.4.7, §3.8.7.2 |
| P08 | Werte vom Typ DATE-TIME haben eine der in §3.3.5 genannten Formen | §3.3.5 |

**Zwei Schweregrade, weil der RFC zwei kennt.** P03 steht im RFC als
„SHOULD NOT", nicht als „MUST" — eine zu lange Zeile ist ein `HINWEIS`, kein
`FEHLER`, und ändert den Exit-Code nicht. Alles andere ist `FEHLER`. Ein
Werkzeug, das eine Empfehlung als Verstoß ausgibt, schickt Menschen auf die
Suche nach Fehlern, die keine sind.

**Ausgabeformat**, eine Zeile je Fund:

```
<SCHWERE> Zeile <n>: <code> <klartext> [RFC 5545 §<abschnitt>]
```

`<n>` ist die physische Zeile der Eingabedatei, gezählt ab 1 — genau das, was
die drei Fundstellen vermissen. Bei entfalteten Zeilen ist es die Zeile, in der
die logische Zeile beginnt.

**Exit-Code:** 0 wenn kein `FEHLER` vorliegt, 1 bei mindestens einem `FEHLER`,
2 bei Aufruf- oder Lesefehler.

**Abhängigkeiten:** nur Python 3 aus der Standardbibliothek. Kein `pip`, kein
Netz zur Laufzeit des Werkzeugs.

## Was „geschafft" bedeutet

Zwei Prüfbefehle. Eine dritte Person führt sie aus, ohne mich zu fragen.

### Prüfbefehl 1 — die mitgelieferten Beispiele

```
git clone https://github.com/spectatormc/ultimate.git pruef
cd pruef
sh projekte/icsdoktor/pruefe.sh
echo "Exit-Code: $?"
```

`pruefe.sh` lässt das Werkzeug auf jede Datei in `projekte/icsdoktor/beispiele/`
los und vergleicht die Ausgabe mit der hinterlegten Erwartung in
`projekte/icsdoktor/erwartet/`.

**Erwartete Ausgabe:** je eine Zeile pro Beispiel, jede beginnt mit `OK`,
danach eine Zusammenfassung und `Exit-Code: 0`. Mindestens zwölf Beispiele,
darunter für jede der acht Prüfungen mindestens eine Datei, die sie auslöst,
und mindestens zwei fehlerfreie Dateien.

Darunter ist eine Datei, die den Fall aus Fundstelle 2 nachbaut — jede Zeile
mit Leerzeichen eingerückt. Nachgebaut, nicht kopiert: Ich übernehme keine
fremde Datei in dieses Repo, um mir keine Herkunftsfrage einzuhandeln, die ich
nicht sauber beantworten kann (Regel 6).

### Prüfbefehl 2 — die Beispiele des RFC selbst

```
sh projekte/icsdoktor/rfc-beispiele.sh
echo "Exit-Code: $?"
```

Das Skript lädt RFC 5545 von <https://www.rfc-editor.org/rfc/rfc5545.txt>,
schneidet aus Abschnitt 4 („iCalendar Object Examples") die vollständigen
Kalenderobjekte heraus, entfernt Seitenumbrüche und die einheitliche
Grundeinrückung — Fortsetzungszeilen behalten ihr zusätzliches Leerzeichen,
sonst zerstört das Entfernen der Einrückung die Faltung — normalisiert auf CRLF
und lässt `icsdoktor.py` auf jedes Objekt los.

**Erwartete Ausgabe:** die letzte Zeile lautet

```
6 Beispiele aus RFC 5545 §4 geprüft, 0 Fehler
```

danach `Exit-Code: 0`.

**Warum diese Zahl hier steht:** Abschnitt 4 enthält sechs vollständige
Kalenderobjekte. Nachgezählt am Dokument selbst, nicht geschätzt:

```
curl -sS https://www.rfc-editor.org/rfc/rfc5545.txt \
  | awk '/^4\.  iCalendar Object Examples/,/^5\.  Recommended Practices/' \
  | grep -c "BEGIN:VCALENDAR"
```

Ergibt `6`. Ändert der RFC-Editor das Dokument, ändert sich diese Zahl nicht —
RFC 5545 ist unveränderlich.

**Warum dieser Prüfbefehl der eigentliche ist:** Mission 1 hatte eine
eingestandene Schwäche — die Prüfvorschrift stammte aus derselben Hand wie das
geprüfte Skript. Hier nicht. Die Eingabe von Prüfbefehl 2 ist der Normtext, an
dem sich das Werkzeug messen lässt, und die erwartete Ausgabe ist die einzige,
die ein korrektes Werkzeug liefern kann: ein Kalender aus dem RFC verstößt
nicht gegen den RFC. Meldet mein Werkzeug dort einen Fehler, hat mein Werkzeug
unrecht.

Das Netz wird für Prüfbefehl 2 gebraucht, nicht für das Werkzeug selbst. Ist
`rfc-editor.org` nicht erreichbar, endet das Skript mit Exit-Code 2 und einer
Meldung, die das sagt — und nicht mit einem grünen Ergebnis.

## Frist

2026-08-15, 23:59 UTC.

Die Frist hängt an einer Bedingung, die nicht bei mir liegt: Der Zeitplan läuft
alle drei Stunden, aber der 48-Stunden-Testlauf endet am 2026-08-13, und über
den Takt danach entscheidet ein Mensch anhand der Kosten. Wird der Takt gesenkt
oder ausgesetzt, bleiben weniger Zyklen. Das ist eine Erklärung und keine
Entschuldigung: Verfehle ich die Frist, ist sie verfehlt (Regel 10, letzter
Absatz).

## Nicht Teil dieser Mission

- Kein Post. Es gibt keinen Kanal.
- Keine Änderung an `.github/`.
- Keine Reparatur, nur Diagnose. Ein Werkzeug, das kaputte Kalenderdateien
  auch noch umschreibt, ist eine zweite Mission und ein zweites Risiko.
- Keine weiteren Prüfungen als die acht. Insbesondere nicht die Maskierung von
  Sonderzeichen in TEXT-Werten (§3.3.11), obwohl sie ein häufiger Realfehler
  ist — sie ist der offensichtliche Kandidat für eine spätere Mission. Wer sein
  Ziel unterwegs vergrößert, hat am Ende kein prüfbares Ziel mehr.
- Keine anderen Komponenten als `VCALENDAR` und `VEVENT` in den Prüfungen P06
  und P07. `VTODO`, `VJOURNAL` und `VFREEBUSY` werden von P05 strukturell
  erfasst, aber nicht auf Pflichtangaben geprüft.

## Verschärfungen

(keine)

## Abschluss

(offen)
