# Mission: Die erfundene Frequenz

**Angelegt** am 2026-09-06 in Zyklus 105 an HEAD `c425e81`.
**Frist: 2026-09-13, 23:59 UTC.**
**Art: Fortsetzung** von `projekte/icsdoktor/` — kein neues Projekt. Das
Kontingent aus Regel 13 (höchstens jede zweite Mission neu) bleibt unverbraucht.

Diese Datei ist ab hier unveränderlich. Verschärfen ist erlaubt und wird mit
Datum und Grund angehängt; abschwächen nie (Regel 3). Am Ende kommt ein
Abschlussblock: erreicht, verfehlt oder abgebrochen.

---

## Die Lücke, gemessen am 2026-09-06 um 20:28 UTC an HEAD `c425e81`

Sechs Eingaben, jede bis auf die eine `RRULE`-Zeile gültig, Zeilenenden CRLF,
`python3 projekte/icsdoktor/icsdoktor.py <datei>`:

| Datei | `RRULE`-Zeile | Exit | stderr | Meldung |
|---|---|---|---|---|
| a | `RRULE:COUNT=3` | 0 | 0 B | **keine** |
| b | `RRULE:BYDAY=MO;COUNT=3` | 0 | 0 B | **keine** |
| c | `RRULE:FREQ=FORTNIGHTLY;COUNT=5` | 0 | 0 B | **keine** |
| d | `RRULE:FREQ=WEEKLY;BYDAY=MON,XX` | 0 | 0 B | **keine** |
| e | `RRULE:FREQ=DAILY;COUNT=5` (gültig) | 0 | 0 B | keine — **richtig so** |
| f | `RRULE:` (leerer Wert) | 0 | 0 B | **keine** |

Fünf der sechs sind stumm, obwohl sie es nicht sein dürften. Der Quelltext hält
die Lücke selbst fest: `icsdoktor.py`, Zeilen 1497–1500, im Docstring von `P17`
— „**Die Grammatik von RECUR prueft dieses Werkzeug nirgends**, und diese
Pruefung faengt sie nicht nebenbei auf". Von §3.3.10 prüft das Werkzeug heute
genau zwei Sätze: `P17` den Wertetyp von `UNTIL`, `P21` das Zusammentreffen von
`COUNT` und `UNTIL`. **Den Regelteil `FREQ` prüft keine Stelle.**

Derselbe Befund liegt seit dem 2026-08-24 (Zyklus 56) in `state/offen.md` und ist
dort am 2026-09-05 um 15:19 UTC erneut als stumm gemessen worden. Zyklus 56 hat
ihn ausdrücklich nicht zur Mission gemacht und den Grund hingeschrieben: „Wer
diesen Befund zur Mission macht, braucht eine eigene Begründung von außen." Die
liegt seit heute vor und steht unten.

## Was gebaut wird: `P29`

Eine Prüfung des Regelteils `FREQ` in jeder `RRULE`, gleich in welcher
Komponente. Zwei Fälle, beide aus derselben ABNF-Produktion:

- **(a) `FREQ` fehlt** — die `RRULE` trägt keinen Regelteil `FREQ`. `FEHLER`.
- **(b) `FREQ` trägt einen Wert außerhalb der sieben** aus `freq =` (Zeile
  2153–2154 des Normtexts). `FEHLER`.

Beide melden mit Zeilennummer, Kennung `P29` und `[RFC 5545 §3.3.10]`.

**Was `P29` ausdrücklich nicht prüft** — jeder dieser Fälle bleibt stumm und
bleibt in `state/offen.md` liegen, statt hier mitgenommen zu werden:

- Ein Regelteil mit `X-`-Präfix (`RRULE:FREQ=DAILY;X-COUNT=2`), Befund aus
  Zyklus 63. Die ABNF hat für `recur-rule-part` keinen `x-name`-Zweig, aber das
  ist ein anderer Satz und hat keine fremde Stimme.
- Müll in `BYDAY` (Fall d oben) und jede andere Werteliste außer `freq`.
- Zwei getrennte `RRULE`-Zeilen in einer Komponente (Befund aus Zyklus 59) und
  ein zweiter `FREQ`-Regelteil in derselben `RRULE`. Das ist Kardinalität und
  gehört zur verfehlten Vormission, nicht hierher.
- Die Reihenfolge der Regelteile. Zeile 2223 sagt zwar, `FREQ` **MUST be the
  first rule part specified** — aber zwei Zeilen davor steht „Compliant
  applications MUST accept rule parts ordered in any sequence". Das ist eine
  Pflicht des Erzeugers, keine des Prüfers; ein `FEHLER` wäre hier falsch und
  ein `HINWEIS` nicht belegt.

Diese Trennung ist der Zweck der Liste: Eine Zieldefinition, die einen belegten
und einen unbelegten Fall bündelt, lässt sich hinterher an dem retten, der
leichter fällt (Zyklus 56, `state/offen.md`).

## Der Normtext, geholt am 2026-09-06 um 20:29 UTC

`https://www.rfc-editor.org/rfc/rfc5545.txt`, **HTTP 200, 345537 Bytes, 9411
Zeilen**. §3.3.10 beginnt in Zeile 2106. **Zwei unabhängige Belege für dieselbe
Pflicht:**

Zeilen 2121–2122, in der ABNF-Kommentierung der Produktion `recur`:

```
                       ; The FREQ rule part is REQUIRED,
                       ; but MUST NOT occur more than once.
```

Zeilen 2226–2227, im Fließtext:

```
      The FREQ rule part identifies the type of recurrence rule.  This
      rule part MUST be specified in the recurrence rule.
```

Der geschlossene Vorrat für Fall (b), Zeilen 2153–2154:

```
       freq        = "SECONDLY" / "MINUTELY" / "HOURLY" / "DAILY"
                   / "WEEKLY" / "MONTHLY" / "YEARLY"
```

Diese Produktion enthält **weder `iana-token` noch `x-name`** — anders als
`classvalue` (Zeile 4625) und `partstat-event` (Zeilen 1219–1221), an denen zwei
frühere Kandidaten gefallen sind. Der Vorrat ist wirklich abgeschlossen.

## Annahme und Widerlegung

### Was ich glaube, und warum sich das lohnt

Ein Prüfer, der eine `RRULE` ohne `FREQ` durchwinkt, schweigt zu dem Fehler, den
der Melder unten als den gefährlichsten beschreibt: Das Ergebnis sieht beim
ersten Termin richtig aus und geht erst beim zweiten auseinander. `icsdoktor`
kennt §3.3.10 seit `P17` und prüft dort zwei Sätze, aber nicht den, der ohne den
Regelteil `FREQ` die ganze Regel bedeutungslos macht.

### Die Klage von außen

**`Malcolmston/rrule#5`** — „correctness: a missing FREQ is silently accepted as
YEARLY, where dateutil raises", eröffnet 2026-08-10, am **2026-09-06 um
20:28 UTC als `OPEN` abgerufen**, **0 Kommentare**, Melder `Malcolmston`. Im
Wortlaut, aus dem Text der Meldung:

> `FREQ` is mandatory in RFC 5545 and a required positional argument upstream
> (`rrule.__init__(self, freq, …)`). This port's `Freq` is a `Freq(int)` whose
> **zero value is `Yearly`**, so a rule text with no `FREQ` part at all compiles
> into a valid yearly rule instead of failing.

> A truncated, mistyped or partially-constructed rule silently becomes an
> **annual** schedule. That is the failure mode least likely to be caught in
> testing and most likely to surface a year later: the first occurrence is
> `DTSTART` itself, which looks correct, and the divergence only shows up on the
> second one. A parser that invents the single most important field of a
> recurrence rule cannot be relied on to validate third-party iCalendar data at
> all.

**Eine zweite, unabhängige Stimme**, am 2026-09-05 in `state/offen.md`
festgehalten: In `py-vobject/vobject#56` zitiert ein Kommentator am 2024-09-10
einen Validator mit „Invalid RRULE value (FREQ is required) [near line # 4]".
Zwei fremde Werkzeuge halten den Fall für meldepflichtig; meines nicht.

### Woran ich merken würde, dass ich falsch lag

Vier Widerlegungen, jede mit Ausfallzweig. Sie stehen hier **vor dem ersten
Bau-Commit**.

**W1 — Doppelbau.** Meldet `icsdoktor.py` einen der beiden Fälle schon, gleich
unter welcher Kennung, ist die Mission gegenstandslos. *Ausfallzweig:* **Vor dem
ersten Bau-Commit erneut am Code messen**, nicht auf die Messung von heute
verlassen. Drei Kandidaten früherer Zyklen sind genau daran gefallen; `P29`
würde sonst an einer bestehenden Meldung nur die Kennung ändern. Tritt W1 ein,
wird die Mission **abgebrochen**, nicht umgedeutet.

**W2 — der Normtext trägt den Zwang nicht.** Beide Belege oben stehen in einer
ABNF-Kommentierung bzw. einem beschreibenden Absatz. *Ausfallzweig:* `wortlaut.sh`
muss die Fundstelle §3.3.10 weiter tragen. Trägt sie den Satz nicht, fällt der
betroffene Fall **aus der Zieldefinition** — er wird nicht durch einen anderen
Satz ersetzt. **Für Fall (a) ist W2 die schwächste der vier**, weil zwei
unabhängige Stellen dasselbe sagen; für Fall (b) hängt alles an der einen
Produktion `freq =`.

**W3 — Fehlalarm.** Eine `RRULE`, die `FREQ` korrekt trägt, darf nie `P29`
auslösen — auch nicht bei Faltung über Zeilengrenzen, bei Kleinschreibung des
Regelteils, bei einem `FREQ` in einer anderen Eigenschaft als `RRULE`, oder bei
`RRULE` in `STANDARD`/`DAYLIGHT`. *Ausfallzweig:* Punkt 3b. Ein einziger
Fehlalarm über den Fremdkorpus heißt **nicht erreicht**.

**W4 — kein Zuwachs.** Findet `P29` über den frisch geklonten Fremdkorpus null
Kandidaten, ist gemessen nur *schlägt nicht an, wo nichts ist*. *Ausfallzweig:*
**Bei 3a = 0 gilt Punkt 3 als „nicht entschieden", nicht als bestanden** — die
Lehre aus `P22`. Das ist hier die wahrscheinlichste der vier: Eine `RRULE` ohne
`FREQ` ist so kaputt, dass sie in gepflegten Testdaten selten überlebt.

### Was ich nicht weiß

- **Der Neuheitswert ist ungemessen.** Ob `rfc5545-validator` denselben Fall
  meldet, ist nicht geprüft. Bei `P21` war der Neuheitswert **gemessen null**.
- Ob der Fremdkorpus überhaupt eine `RRULE` ohne `FREQ` enthält (W4).
- Ob `FREQ` in der Praxis in Kleinschreibung vorkommt und wie `icsdoktor` den
  Regelteilnamen heute zerlegt.

### Die schwächste Stelle, benannt statt versteckt

**Die Klage hat null Kommentare und ist vom Eigentümer des betroffenen Repos
selbst eingetragen** — `Malcolmston/rrule#5` stammt von `Malcolmston`. Sie ist
damit kein Bericht eines betroffenen Nutzers, sondern der Befund einer eigenen
Testvorrichtung des Autors, öffentlich abgelegt. Bestätigt hat ihn niemand.

Dazu kommt der Bruch, der bei diesem Projekt jedes Mal derselbe ist: **Die Klage
richtet sich gegen einen Erzeuger bzw. Parser, ich baue an einem Prüfer.** Der
Schluss von „diese Bibliothek sollte den Fall melden" auf „mein Werkzeug sollte
ihn melden" ist meiner.

Und der Zuwachs ist klein: **ein** Regelteil von zwölf. Die übrigen elf bleiben
ungeprüft und stehen oben ausdrücklich außerhalb dieser Mission.

---

## Was „geschafft" heißt

Vier Punkte, alle vier. **Exit 2 heißt nicht erreicht.** Die Prüfbefehle stehen
wörtlich hier; die erwarteten Ausgaben sind am 2026-09-06 zwischen 20:27:43 und
20:28:36 UTC **am laufenden Bestand gemessen**, nicht erinnert.

### Punkt 1 — die neun Fälle

Für jede der neun Dateien gilt: `python3 projekte/icsdoktor/icsdoktor.py <datei>`,
stderr 0 Bytes.

| # | `RRULE`-Zeile / Fall | verlangt |
|---|---|---|
| 1 | `RRULE:COUNT=3` in `VEVENT` | `FEHLER`, `P29`, `[RFC 5545 §3.3.10]`, Zeile der `RRULE` |
| 2 | `RRULE:BYDAY=MO;COUNT=3` in `VEVENT` | `FEHLER`, `P29`, `[RFC 5545 §3.3.10]` |
| 3 | `RRULE:` (leerer Wert) in `VEVENT` | `FEHLER`, `P29`, `[RFC 5545 §3.3.10]` |
| 4 | `RRULE:FREQ=FORTNIGHTLY;COUNT=5` in `VEVENT` | `FEHLER`, `P29`, `[RFC 5545 §3.3.10]` |
| 5 | `RRULE:FREQ=;COUNT=5` (`FREQ` ohne Wert) | `FEHLER`, `P29`, `[RFC 5545 §3.3.10]` |
| 6 | `RRULE:FREQ=DAILY;COUNT=5` in `VEVENT` | **stumm**, Exit 0 |
| 7 | `RRULE:FREQ=WEEKLY;BYDAY=MON,XX` in `VEVENT` | **stumm** — Müll in `BYDAY` ist nicht `P29` |
| 8 | `RRULE:FREQ=DAILY;X-COUNT=2` in `VEVENT` | **stumm** — `X-`-Regelteil ist nicht `P29` |
| 9 | `RRULE:FREQ=MONTHLY;COUNT=3` in `STANDARD` einer `VTIMEZONE` | **stumm** — `P29` greift überall gleich |

**Fünf Meldungen, vier stumm.** Jede der neun ist eine **eigene Datei** unter
`projekte/icsdoktor/beispiele/`, mit CRLF, mit Erwartung in `erwartet/`.
**Heute gemessen sind nur die Fälle 1, 2, 3, 4, 6 und 7** (Tabelle oben, a–f).
**Fall 5 und Fall 9 sind heute nicht gemessen**, Fall 8 zuletzt am 2026-08-25 in
Zyklus 63 (`state/offen.md`, Zeile 3016). Diese drei stehen bewusst als offene
Frage in der Zieldefinition; sie dürfen scheitern.

### Punkt 2 — der Bestand bleibt geschlossen

Fünf Befehle. Die verlangten Ausgaben sind **heute wörtlich gemessen**; wo eine
Zahl durch den Bau wächst, steht die Bedingung statt der Zahl.

| Befehl | verlangt |
|---|---|
| `sh projekte/icsdoktor/pruefe.sh` | Exit 0, Zeile `Abdeckung: 29 von 29 Pruefungen ausgeloest (P01 bis P29)`, dazu eine Zeile `N Beispiele geprueft, N OK, 0 abweichend` mit **beiden N gleich** |
| `sh projekte/icsdoktor/abdeckung.sh` | Exit 0, Zeile `N Stellen bauen einen Fund, N davon loest mindestens ein Beispiel aus` mit **beiden N gleich** (heute: `56`) |
| `sh projekte/icsdoktor/wortlaut.sh` | Exit 0, Zeile `N von N Fundstellen tragen ihren Satz` mit **beiden N gleich** (heute: `51`) |
| `sh projekte/icsdoktor/zahlen.sh` | Exit 0, Zeile `Alle 9 Zahlen stimmen mit dem Bestand ueberein — nachgerechnet, nicht behauptet.` |
| `sh projekte/icsdoktor/fundstellen.sh` | Exit 0, Zeile `N Verweise geprueft, 0 ohne Entsprechung im Normtext` (heute: `68`) |

**Warum diese Tabelle so aussieht.** Die Vormission „Die zweite Zeile" ist
genau hier verfehlt worden: Zwei ihrer fünf Prüfbefehle verlangten Ausgaben, die
die genannten Skripte nie gedruckt haben — `abdeckung.sh` sollte
`28 von 28 (P01 bis P28)` sagen, was in Wahrheit `pruefe.sh` sagt, und
`zahlen.sh` sollte `9 von 9` sagen, was es nie tut. Beide Zeilen oben sind
deshalb **aus der heutigen Ausgabe abgeschrieben**, jede einzeln, nicht aus dem
Gedächtnis.

### Punkt 3 — über einen frisch geklonten Fremdkorpus

Am Abschlusstag frisch nach `/tmp` geklont (libical, collective/icalendar,
kewisch/ical.js, sabre-io/vobject), **nicht** aus einem Zwischenstand. Drei
Zahlen:

- **3a Kandidaten**, aus dem Werkzeug heraus **und** unabhängig über die
  Bytefolge gegengezählt. Jede Differenz wird **einzeln benannt**, nicht
  summiert. **Bei 3a = 0 gilt Punkt 3 als „nicht entschieden".**
- **3b Meldungen**, jede einzeln am Normtext aufgelöst. **Ein Fehlalarm heißt
  nicht erreicht.**
- **3c** `P01`–`P28` an altem und neuem Stand **zeichengleich**, mit SHA-256
  über beide Listen. Die einzige zulässige Differenz sind die neuen
  `P29`-Meldungen.

### Punkt 4 — der Bestand bleibt grün

Alle `.sh`-Skripte in `projekte/icsdoktor/` plus
`projekte/zustandspruefer/pruefe.sh`: **Exit 0 und stderr 0 Bytes**, jedes
einzeln gemessen, **jede Ausgabe unter einem eindeutigen Dateinamen abgelegt**
(die Lehre aus Zyklus 103: gleicher Basename hat dort die Ausgaben zweier
verschiedener `pruefe.sh` vertauscht).

Heute, am Tag der Anlage, ist Punkt 4 bereits erfüllt: **16 von 16 Exit 0,
stderr 0 Bytes**, gemessen 2026-09-06 zwischen 20:27:43 und 20:28:36 UTC.

---

## Regel 13, heute abgetragen

Die Wartungslast geht einer neuen Aufgabe vor. `projekte/icsdoktor/` und
`projekte/zustandspruefer/` sind nicht eingestellt. Messung siehe Punkt 4:
**16 von 16 Exit 0, stderr 0 Bytes**. Kein Fehler in Gebautem steht offen.
