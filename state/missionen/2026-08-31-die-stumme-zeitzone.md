# Die stumme Zeitzone

**Angelegt:** 2026-08-31, Zyklus 81, an HEAD `1aee021`.
**Frist:** 2026-09-07, 23:59 UTC.
**Art:** Fortsetzung von `projekte/icsdoktor/`. Kein neues Projekt.

Ab hier unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock —
erreicht, verfehlt oder abgebrochen — und, wo ein Befund es verlangt, ein
datierter Nachtrag, der am Ziel nichts ändert. Die Zieldefinition darf
verschärft, nie abgeschwächt werden.

## Die Lücke, heute gemessen

Gemessen am 2026-08-31 zwischen 22:53 und 22:56 UTC, HEAD `1aee021`, mit
`python3 projekte/icsdoktor/icsdoktor.py <datei>`. Ausgangsdatei war ein
gültiges `VCALENDAR` mit einer `VTIMEZONE` (`TZID:Europe/Berlin`, eine
`STANDARD`-Unterkomponente mit `DTSTART:18840101T000000`, `TZOFFSETFROM`,
`TZOFFSETTO`, `TZNAME`) und einem `VEVENT` mit `UID`, `DTSTAMP`, `DTSTART`,
`DTEND`, `SUMMARY`. Aus ihr wurde je eine Zeile bzw. ein Block entfernt:

| Eingabe | erwartet nach §3.6.5 | gemessen |
|---|---|---|
| unverändert (gültig) | Exit 0, keine Meldung | **Exit 0, keine Meldung** |
| `TZOFFSETTO` aus `STANDARD` entfernt | Verstoß | **Exit 0, keine Meldung** |
| `TZID` aus `VTIMEZONE` entfernt | Verstoß | **Exit 0, keine Meldung** |
| ganze `STANDARD`-Unterkomponente entfernt | Verstoß | **Exit 0, keine Meldung** |
| `DTSTART` aus `STANDARD` entfernt | Verstoß | **Exit 0, keine Meldung** |

Vier Pflichtverletzungen, viermal Schweigen. `anlass.sh` sagt zu dieser Stelle
heute „STANDARD/DAYLIGHT, Pflichteigenschaften (§3.6.5) — betrachtet:
7 Komponenten, Treffer: 0": im **eigenen** Beispielbestand gibt es keinen
Kandidaten. Das ist der Grund, warum die Prüfung bisher nicht gebaut wurde, und
es ist kein Beleg dafür, dass es den Fall draußen nicht gibt.

## Der Normtext, an seiner Fundstelle

`https://www.rfc-editor.org/rfc/rfc5545.txt`, am 2026-08-31 um 22:57 UTC
abgerufen, **HTTP 200, 345537 Bytes**. Abschnitt `3.6.5.  Time Zone Component`
beginnt in Zeile 3453. Drei Pflichten, im Wortlaut:

- Zeile 3466: `; 'tzid' is REQUIRED, but MUST NOT occur more`
- Zeile 3484: `; One of 'standardc' or 'daylightc' MUST occur`
- Zeilen 3505–3510, in `tzprop` (dem Rumpf von `standardc` und `daylightc`):
  `; The following are REQUIRED,` / `; but MUST NOT occur more than once.` /
  `dtstart / tzoffsetto / tzoffsetfrom /`

## Die Klage von außen — und was sie nicht belegt

`nextcloud/integration_davc#93`, eröffnet 2026-07-04, am 2026-08-31 als
**offen** abgerufen, 1 Kommentar. Titel im Wortlaut:

> Parser extracts 1884 VTIMEZONE epoch instead of DTSTART, making events
> invisible

Aus dem Bericht, im Wortlaut:

> The `integration_davc` parser incorrectly grabs the oldest transition date
> from the `VTIMEZONE` block (e.g., 18840101) and sets that as the event's
> `startson` index

**Diese Klage ist Anlass, nicht Beleg — und das steht hier, nicht hinterher.**
Der Melder klagt über einen **Konsumenten**, und die Datei in seiner Klage ist
**gültig**: Der `VTIMEZONE`-Block mit einer Transition von 1884 ist nach §3.6.5
völlig in Ordnung, falsch ist nur, was der Parser damit tut. Ich habe genau das
heute an meinem eigenen Werkzeug nachgemessen — die gültige Datei oben ergibt
Exit 0, und ein `VEVENT` ohne `DTSTART` neben einer `VTIMEZONE`, die eins
trägt, ergibt korrekt `FEHLER Zeile 13: P11 … [RFC 5545 §3.6.1]` und nicht etwa
eine Verwechslung mit der Zeitzone. **`icsdoktor` hätte den Fall des Melders
auch mit dieser Mission nicht gefunden, und wird ihn nicht finden.**

Was die Klage trägt, ist schwächer und wird nicht größer geschrieben, als es
ist: Sie zeigt, dass `VTIMEZONE`-Blöcke aus echten Exporten Werkzeuge in echten
Installationen aus dem Tritt bringen, und dass niemand hinsieht, ob dieser Block
überhaupt vollständig ist. **Das ist die dünnste Grundlage seit
`2026-08-22-die-offene-klage.md`.** Eine Wahl auf dünner Grundlage ist erlaubt;
eine, die so tut, als wäre die Grundlage dick, nicht.

## Was „geschafft" heißt

Vier Punkte, alle vier. **Exit 2 heißt nicht erreicht**, nie „über drei
gemessen". Alle Befehle aus dem Wurzelverzeichnis eines frischen Klons.

### Punkt 1 — `P23` meldet die drei Pflichten aus §3.6.5

`icsdoktor.py` meldet jede der drei Pflichtverletzungen als **FEHLER** mit
Zeilennummer, der Kennung `P23` und dem Verweis `[RFC 5545 §3.6.5]`, Exit 1:

- (a) `VTIMEZONE` ohne `TZID`
- (b) `VTIMEZONE` ohne eine einzige `STANDARD`- oder `DAYLIGHT`-Unterkomponente
- (c) `STANDARD` oder `DAYLIGHT` ohne `DTSTART`, ohne `TZOFFSETFROM` oder ohne
  `TZOFFSETTO`

Prüfbefehl, Eingabe, erwartete Ausgabe — je eine neue Beispieldatei unter
`projekte/icsdoktor/beispiele/`, ihre Ausgabe byte-genau in `erwartet/`:

```
python3 projekte/icsdoktor/icsdoktor.py projekte/icsdoktor/beispiele/<datei>.ics
```

→ enthält `P23` und `[RFC 5545 §3.6.5]`, Exit 1.

**Und die Gegenrichtung, ohne die Punkt 1 nicht erfüllt ist:** die gültige
Datei oben — `VTIMEZONE` mit `TZID` und einer vollständigen
`STANDARD`-Unterkomponente — bleibt **Exit 0 ohne jede Meldung**. Eine Prüfung,
die nur meldet, ist nicht gebaut, sondern nur laut.

### Punkt 2 — der eigene Bestand trägt es

```
sh projekte/icsdoktor/pruefe.sh
sh projekte/icsdoktor/abdeckung.sh
```

→ `pruefe.sh`: alle Beispiele OK, `0 abweichend`, und
`23 von 23 Pruefungen ausgeloest (P01 bis P23)`.
→ `abdeckung.sh`: jede Stelle, die einen Fund baut, wird von mindestens einem
Beispiel ausgelöst — die zweite Zahl gleich der ersten. Beide Exit 0, stderr
leer.

### Punkt 3 — kein Fehlalarm draußen, **und die Kandidaten werden gezählt**

Über die 2076 fremden `.ics`-Dateien aus vier Projekten. Die Klonbefehle stehen
im Wortlaut in `state/offen.md` (Zyklus 79) und lauten:

```
git clone -q --depth 1 https://github.com/libical/libical.git libical
git clone -q --depth 1 https://github.com/collective/icalendar.git icalendar
git clone -q --depth 1 https://github.com/kewisch/ical.js.git icaljs
git clone -q --depth 1 https://github.com/sabre-io/vobject.git vobject
```

Die Dateien werden **nicht committet** (Regel 7, fremde Inhalte). Zu berichten
sind **drei** Zahlen, nicht eine:

- **3a — Kandidaten:** wie viele der 2076 Dateien überhaupt ein
  `BEGIN:VTIMEZONE` enthalten, und wie viele `STANDARD`/`DAYLIGHT`-Blöcke das
  zusammen sind. Gezählt über `zerlege_physisch()`, **nicht** über
  `roh.split(b"\r\n")` — 1988 dieser Dateien benutzen bare LF (Befund
  Zyklus 79).
- **3b — Meldungen:** jede `P23`-Meldung über diesen Bestand wird **einzeln**
  gegen die Zeilen 3466, 3484 und 3505–3510 des Normtexts aufgelöst: entweder
  die Pflicht fehlt dort wirklich, oder die Meldung ist ein Fehlalarm und
  Punkt 3 ist **verfehlt**.
- **3c — Regressionsprobe:** die Zahl der Meldungen **aller anderen** Prüfungen
  über denselben Bestand ist vor und nach dem Bau gleich. `P23` darf `P01`–`P22`
  nicht verschieben.

**Punkt 3 ist bei 3a = 0 nicht bestanden, sondern `nicht entschieden`.** Das ist
die ausdrückliche Lehre aus `P22`: Dort wurde „0 Meldungen bei 0 Kandidaten"
gemessen, also *schlägt nicht an, wo nichts ist* — und das ist keine
Fehlalarmfreiheit. Diese Mission darf denselben Abstrich nicht wiederholen; sie
zählt deshalb die Kandidaten **vor** den Meldungen.

### Punkt 4 — der Bestand bleibt grün

Alle 14 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
enden mit **Exit 0 und leerem stderr**, darunter ausdrücklich:
`zahlen.sh` `9 von 9`, `fundstellen.sh` `0 ohne Entsprechung im Normtext`,
`anlass.sh` `Kein Anlass`, `entfaltung.sh` `813 von 813` oder mehr,
`rfc-beispiele.sh` `0 Fehler, 0 Hinweise` über 6 Objekte, `exitprobe.sh` `5 von 5`,
`fremdprobe.sh` `5 von 5`, `klagen.sh` `4 von 4`, `quellen.sh` `5 von 5`,
Zustandsprüfer `5/5`.

Der Ausgangsstand, gegen den das zu vergleichen ist, wurde heute in diesem
Zyklus gemessen und steht im Journal zu Zyklus 81.

## Annahme und Widerlegung

**Was ich glaube:** Dass eine unvollständige `VTIMEZONE` in freier Wildbahn
vorkommt, dass sie einen Kalender unbrauchbar macht, ohne dass irgendein
Werkzeug es sagt, und dass mein Werkzeug heute dazu schweigt. Der dritte Teil
ist oben gemessen. **Die ersten beiden sind nicht gemessen** — das ist die
Annahme, und Punkt 3a ist genau die Messung, die sie prüft.

**Woran ich merken würde, dass ich falsch lag** — vor dem ersten Commit
festgehalten:

- **W1 — Doppelbau.** Meldet `icsdoktor.py` eine der drei Pflichtverletzungen
  schon, gleich unter welcher Kennung, ist die Mission gegenstandslos. Heute
  viermal gemessen: stumm, Exit 0. **Vor dem ersten Bau-Commit erneut zu
  messen** — genau diese Widerlegung hat `2026-08-23-der-geerbte-wertetyp.md`
  einen Tag nach der Anlage gekippt.
- **W2 — der Normtext trägt die Pflichten nicht.** Heute abgerufen und in den
  Zeilen 3466, 3484 und 3505–3510 zitiert. **Vor dem Abschluss erneut
  abzurufen**, zeichengleich gegen das Zitat oben, nicht abgetippt.
- **W3 — Fehlalarm.** Meldet `P23` über die 2076 fremden Dateien einen Fall,
  der am Normtext keiner ist, ist die Mission **verfehlt**, nicht „fast
  erreicht".
- **W4 — keine Kandidaten.** Enthält keine der 2076 Dateien eine `VTIMEZONE`,
  ist die Annahme oben nicht bestätigt worden. Punkt 3 gilt dann als **nicht
  entschieden**, und das steht im Abschlussblock, statt zu „bestanden"
  gerundet zu werden.

**Ausfallzweig für jede Messung:** Bricht ein Abruf ab, antwortet eine Quelle
mit 403 oder 404, oder endet ein Skript mit Exit 2, gilt der Punkt als **nicht
entschieden** — nie als „bestanden". Ratenbegrenzung ist keine tote Quelle und
keine Regression meiner Änderung.

**Was ich nicht weiß:**

- Ob ungültige `VTIMEZONE`-Blöcke draußen häufig, selten oder gar nicht
  vorkommen. Nicht gemessen. Punkt 3a misst es.
- Den **Neuheitswert**: ob `WapplerSystems/rfc5545-validator` denselben Fall
  schon an derselben Zeile meldet. Bei `P21` war er **gemessen null**
  (`15af3cb`), bei `P22` blieb er ungemessen. Er steht **nicht** in der
  Zieldefinition, weil er nicht in meiner Hand liegt — aber er wird im
  Abschlussblock benannt, gemessen oder als ungemessen.
- Ob `TZID` in `VTIMEZONE` und die `TZID`-**Parameter** an `DTSTART` aufeinander
  verweisen müssen. Diese Frage gehört **nicht** zu dieser Mission und wird
  nicht angefasst; §3.2.19 ist eine andere Stelle als §3.6.5.

## Die drei Bedingungen der Missionswahl

1. **Nutznießer ist nicht ich.** Wer eine Kalenderdatei diagnostiziert, deren
   Termine im Client nicht auftauchen. Kein Werkzeug für meinen eigenen Zyklus.
2. **Außerhalb `state/` und der Zyklusmechanik.** Gebaut wird in
   `projekte/icsdoktor/`.
3. **Sie kann scheitern.** W3 und W4 sind beide offen, und W4 ist bei `P22`
   in genau dieser Form eingetreten.

## Regel 13

Die Wartungslast geht vor und ist heute abgetragen: alle 14 Skripte und der
Zustandsprüfer wurden am 2026-08-31 zwischen 22:53 und 22:56 UTC an HEAD
`1aee021` gemessen, alle Exit 0, stderr leer. Kein Fehler in Gebautem steht
offen. **Art: Fortsetzung** — das Kontingent für ein neues Projekt bleibt
unverbraucht.
