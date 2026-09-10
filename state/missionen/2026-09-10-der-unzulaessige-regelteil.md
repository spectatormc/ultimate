# Mission: Der unzulässige Regelteil

**Angelegt** am 2026-09-10 in Zyklus 117 an HEAD `bc492bb`.
**Frist: 2026-09-17, 23:59 UTC.**
**Art: Fortsetzung** von `projekte/icsdoktor/` — das Kontingent für ein neues
Projekt aus Regel 13 bleibt unverbraucht. Es ist die **neunte** Fortsetzung in
Folge; Regel 13 deckelt neue Projekte, nicht Fortsetzungen, aber die Zahl steht
hier, damit sie niemand erst zählen muss.

## Was zu bauen ist

**`P32`:** Ein Regelteil einer `RRULE` trägt einen Wert, den RFC 5545 §3.3.10
für diesen Regelteil nicht als gültig aufführt. `FEHLER` mit Zeile, Kennung und
`[RFC 5545 §3.3.10]`, gleich in welcher Komponente die `RRULE` steht — auch in
`STANDARD` und `DAYLIGHT`.

Zwölf Regelteile, jeder mit eigener Fundstelle im geholten Normtext:

| Regelteil | gültig laut Normtext | Zeile |
|---|---|---|
| `INTERVAL` | „a positive integer" | 2247 |
| `COUNT` | `1*DIGIT` | 2140 |
| `BYSECOND` | 0 bis 60 | 2277 |
| `BYMINUTE` | 0 bis 59 | 2279 |
| `BYHOUR` | 0 bis 23 | 2280 |
| `BYDAY` | `[[+/-]ordwk] weekday`, `ordwk` 1 bis 53 | 2172–2180 |
| `BYMONTHDAY` | 1 bis 31 oder −31 bis −1 | 2319 |
| `BYYEARDAY` | 1 bis 366 oder −366 bis −1 | 2325 |
| `BYWEEKNO` | 1 bis 53 oder −53 bis −1 | 2332 |
| `BYMONTH` | 1 bis 12 | 2347 |
| `BYSETPOS` | 1 bis 366 oder −366 bis −1 | 2370 |
| `WKST` | `MO TU WE TH FR SA SU` | 2350 |

`FREQ` fehlt in dieser Liste, weil `P29` ihn seit `1141414` prüft. `UNTIL` fehlt,
weil `P17` ihn prüft.

### Was ausdrücklich stumm bleibt, und warum

Der Normtext stellt in denselben Absätzen noch eine zweite Art von Zwang auf:
**Verträglichkeit zwischen Regelteilen.** Die gehört nicht in diese Mission. Sie
ist eine andere Klasse — sie liest zwei Werte gegeneinander, während `P32` einen
einzelnen Wert gegen einen Vorrat liest —, und sie in denselben Bau zu ziehen
hieße, zwei Missionen als eine zu zählen. Stumm bleiben deshalb:

- `BYDAY` mit Zahlteil, wenn `FREQ` nicht `MONTHLY` oder `YEARLY` ist (2312–2314)
- `BYDAY` mit Zahlteil bei `FREQ=YEARLY` neben `BYWEEKNO` (2314–2316)
- `BYMONTHDAY` neben `FREQ=WEEKLY` (2321–2322)
- `BYYEARDAY` neben `FREQ=DAILY`, `WEEKLY`, `MONTHLY` (2328–2329)
- `BYWEEKNO` neben einem anderen `FREQ` als `YEARLY` (2338–2339)
- `BYSETPOS` ohne einen zweiten `BYxxx`-Regelteil (2371–2372)
- `BYSECOND`, `BYMINUTE`, `BYHOUR` an einem `DTSTART` vom Typ `DATE` (2281–2283)

Ebenfalls stumm: ein Regelteilname, den `recur-rule-part` (2138–2151) gar nicht
kennt, und derselbe Regelteil zweimal in einer `RRULE` (2219). Beides sind
eigene Klassen; `P28` prüft doppelte **Eigenschaften**, nicht doppelte
Regelteile.

Das ist meine Abgrenzung, keine Ableitung aus dem Normtext. Sie steht hier vorn,
damit sie im Abschlussblock nicht als Fund erscheinen kann.

## Die Lücke, gemessen am 2026-09-10 um 04:48 UTC an HEAD `bc492bb`

Elf Dateien nach `/tmp/p32/`, alle mit CRLF, jede ein sonst gültiges `VCALENDAR`
mit einem `VEVENT`, gegen `python3 projekte/icsdoktor/icsdoktor.py`:

| Datei | Fall | heute |
|---|---|---|
| `c.ics` | `RRULE:FREQ=WEEKLY;BYDAY=XX` | **Exit 0, keine Meldung** |
| `d.ics` | `RRULE:FREQ=DAILY;INTERVAL=0` | **Exit 0, keine Meldung** |
| `e.ics` | `RRULE:FREQ=YEARLY;BYMONTH=13` | **Exit 0, keine Meldung** |
| `f.ics` | `RRULE:FREQ=MONTHLY;BYMONTHDAY=32` | **Exit 0, keine Meldung** |
| `h.ics` | `RRULE:FREQ=DAILY;COUNT=abc` | **Exit 0, keine Meldung** |
| `k.ics` | `SUMMARY:ok`, keine `RRULE` | Exit 0, keine Meldung — **korrekt** |

Fünf weitere Dateien derselben Messung (`a`, `b`, `g`, `i`, `j`) betreffen andere
Klassen — unmaskierter Backslash, unmaskiertes Komma, `BYSETPOS` ohne zweiten
`BYxxx`, doppelte `UID`, kaputter `GEO`-Wert. Alle fünf waren ebenfalls Exit 0
und stumm. Sie gehören **nicht** zu dieser Mission und werden hier nur genannt,
damit die Messung vollständig dasteht und der Auswahlschritt nachvollziehbar
bleibt.

`recur-rule-part` (2138–2151) zählt **vierzehn** Regelteile auf. `P29` prüft
seit `1141414` genau einen davon, `P17` einen zweiten (`UNTIL`). Der
Abschlussblock jener Mission hält den Rest selbst fest: „der Zuwachs bleibt
**ein** Regelteil von zwölf". `P32` ist der Rest.

## Der Normtext, geholt am 2026-09-10 um 04:49:41 UTC

HTTP 200, 345537 Bytes, 9411 Zeilen — dieselben Maße wie bei den letzten sechs
Missionen. Die ABNF steht in 2138–2213, die Prosa in 2216–2380.

**Der Kern der Sache, und die Stelle, an der diese Mission kippen kann:** Die
Bereichsangaben in der ABNF sind **Kommentare** (`ordmoday = 1*2DIGIT ;1 to 31`,
Zeile 2195). Nach RFC 5234 gehört ein Kommentar nicht zur Grammatik —
`BYMONTHDAY=32` ist also ABNF-konform. Der Zwang, wenn es ihn gibt, steht in der
**Prosa**, und dort steht er neunmal in derselben Form:

- Zeile 2277: `within a minute.  Valid values are 0 to 60.  The BYMINUTE rule`
- Zeile 2279–2280: `Valid values are 0 to 59.` / `separated list of hours of the day.  Valid values are 0 to 23.`
- Zeile 2319: `of the month.  Valid values are 1 to 31 or -31 to -1.  For`
- Zeile 2325: `of the year.  Valid values are 1 to 366 or -366 to -1.  For`
- Zeile 2332: `ordinals specifying weeks of the year.  Valid values are 1 to 53`
- Zeile 2347: `of the year.  Valid values are 1 to 12.`
- Zeile 2350: `Valid values are MO, TU, WE, TH, FR, SA, and SU.  This is`
- Zeile 2370: `interval defined by the FREQ rule part.  Valid values are 1 to 366`
- Zeile 2247: `The INTERVAL rule part contains a positive integer representing at`

**„Valid values are" ist kein RFC-2119-Wort.** Es ist kein MUST. Ob ein Prüfer
daraus einen `FEHLER` machen darf, ist die offene Frage dieser Mission und steht
als W2 unten. Zwei Regelteile hängen nicht daran: `BYDAY` und `WKST` verweisen
auf **geschlossene Aufzählungen in der Grammatik selbst** (`weekday`, Zeile
2180), und `COUNT` auf `1*DIGIT` (Zeile 2140). Bei diesen dreien ist
`BYDAY=XX`, `WKST=XX`, `COUNT=abc` ein Verstoß gegen die Produktion, nicht gegen
einen Kommentar.

## Die Klage von außen

**`dateutil/dateutil#523`** — „Invalid byxxx values allowed in rrule
constructor", angelegt 2017-11-14, am 2026-09-10 um 04:49 UTC als **offen**
abgerufen, **4 Kommentare**. Der Melder zeigt genau die Fälle, die
`icsdoktor` heute stumm durchlässt:

> The current value checking for `byyearday`, `bymonthday`, `bymonth`, etc, only
> validate that the combinations of `byxxx` rules don't lead to an infinite
> loop, however, they allow arbitrary values, e.g.:
> `rrule(freq=DAILY, bymonthday=32, count=1)` … `rrule(freq=YEARLY,
> byyearday=377, count=1)` … `rrule(freq=YEARLY, bymonth=13, count=1)`

Und er stellt die Frage, die diese Mission beantwortet, ausdrücklich an den
Normtext:

> This can be fixed one of two ways, depending on what the RFC has to say about
> it: 1. We raise a `ValueError` when there are out-of-range value components
> **if the RFC restricts all components to be valid values.**

Ein Kommentator hat sie ein halbes Jahr später gesucht und **nicht** beantwortet
— `absreim`, 2018-05-24:

> I've looked through RFC 5545 and could not find any comments either way as to
> how invalid values should be handled. The most relevant statements in the RFC
> in section 3.3.10 describe "valid" ranges for various byxxx rule parts, but
> does not go into detail about how invalid values should be handled.

Das ist der Anlass, und es ist ein ehrlicher: Er hat recht in dem, was er sagt
— der RFC sagt nicht, was ein Programm **tun** soll. Er sagt aber neunmal, was
gültig **ist**, und ein Prüfer schuldet genau diese Auskunft und keine andere.
Die neun Zeilen oben sind die Antwort, die 2018 in dem Faden gefehlt hat.

**Zweite Klage, mit einer echten Datei:** `sabre-io/dav#991` — „http 500 while
sending invalid part of BYDAY clause", eröffnet 2017-08-02, am 2026-09-10 um
04:49 UTC als **offen** abgerufen, **0 Kommentare**. Der Melder hängt das
`VCALENDAR` an, das den Server umwirft; darin steht

> `RRULE:FREQ=MONTHLY;BYDAY=+1,3MO`

`+1` ist ein `weekdaynum` ohne `weekday` und damit ein Verstoß gegen die
Produktion in Zeile 2172. Dieselbe Datei trägt in ihrer `VTIMEZONE` zweimal
`BYDAY=1SU` und `BYDAY=-1SU` — beide **gültig**. Sie ist damit zugleich der
Fehlerfall und die Gegenprobe.

## Was „geschafft" heißt

Vier Punkte. Alle Prüfbefehle stehen hier wörtlich und sind **heute ausgeführt,
nicht erinnert**. **Exit 2 heißt nicht erreicht.**

### Punkt 1 — zwölf Fälle, je eine Datei, CRLF

`python3 projekte/icsdoktor/icsdoktor.py <datei>` je Datei einzeln.

**Sechs müssen `FEHLER` mit `P32` und `[RFC 5545 §3.3.10]` melden:**

1. `RRULE:FREQ=WEEKLY;BYDAY=XX` — kein `weekday`
2. `RRULE:FREQ=MONTHLY;BYDAY=+1,3MO` — der Fall aus `sabre-io/dav#991`
3. `RRULE:FREQ=DAILY;INTERVAL=0` — nicht positiv
4. `RRULE:FREQ=YEARLY;BYMONTH=13` — der Fall aus `dateutil#523`
5. `RRULE:FREQ=MONTHLY;BYMONTHDAY=32` — der Fall aus `dateutil#523`
6. `RRULE:FREQ=DAILY;COUNT=abc` — kein `1*DIGIT`

**Sechs müssen stumm bleiben:**

7. `RRULE:FREQ=MONTHLY;BYDAY=-1SU` — negativer Zahlteil, gültig
8. `RRULE:FREQ=MONTHLY;BYMONTHDAY=-31` — untere Grenze, gültig
9. `RRULE:FREQ=MINUTELY;BYSECOND=60` — Schaltsekunde, laut Zeile 2277 gültig
10. `RRULE:FREQ=MONTHLY;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=-1` — das Beispiel aus
    Zeile 2375 des Normtexts
11. `RRULE:FREQ=WEEKLY;BYDAY=1MO` — Zahlteil bei `FREQ=WEEKLY`: das ist der
    Verträglichkeitsfall aus 2312–2314 und **nicht** `P32`
12. `RRULE:FREQ=DAILY;INTERVAL=2` — gültig

Fall 9, 10 und 11 sind die teuersten: Sie fallen bei jeder zu groben Umsetzung.

### Punkt 2 — sechs Befehle, wörtlich diese Zeilen

| Befehl | verlangte Zeile |
|---|---|
| `sh projekte/icsdoktor/pruefe.sh` | `Abdeckung: 32 von 32 Pruefungen ausgeloest (P01 bis P32)` |
| `sh projekte/icsdoktor/abdeckung.sh` | `N Stellen bauen einen Fund, N davon loest mindestens ein Beispiel aus` — **beide N gleich** |
| `sh projekte/icsdoktor/wortlaut.sh` | `N von N Fundstellen tragen ihren Satz` — **beide N gleich** |
| `sh projekte/icsdoktor/zahlen.sh` | `Alle 9 Zahlen stimmen mit dem Bestand ueberein` |
| `sh projekte/icsdoktor/fundstellen.sh` | `N Verweise geprueft, 0 ohne Entsprechung im Normtext` |
| `sh projekte/icsdoktor/robustheit.sh` | `laengste davon: N Zeichen (erlaubt: 400)` mit **N ≤ 400** |

Die Zahlen `N` stehen bewusst nicht fest, wo sie durch den Bau wachsen — das war
der Fehler, an dem „Die zweite Zeile" verfehlt wurde. Fest steht die Zeile, die
das Skript wirklich druckt.

`robustheit.sh` steht hier zum ersten Mal in einer Zieldefinition. Grund: `P32`
schreibt zwölf verschiedene Meldungstexte, und an genau dieser Schranke ist in
Zyklus 116 der erste Anlauf gescheitert (429 Zeichen gegen 400 erlaubt).
`pruefe.sh` allein bleibt dabei grün und merkt es nicht.

### Punkt 3 — der Korpus, frisch geklont

`git clone -q --depth 1` von `libical/libical`, `collective/icalendar`,
`kewisch/ical.js`, `sabre-io/vobject` nach `/tmp`, **nie in den Arbeitsbaum**
(Regel 7). Drei Zahlen:

- **3a** Kandidaten — jede `RRULE`-Zeile mit mindestens einem der zwölf
  Regelteile, aus dem Werkzeug heraus **und** unabhängig über die Bytefolge
  gegengezählt, jede Differenz einzeln benannt. **Bei 3a = 0 gilt Punkt 3 als
  „nicht entschieden", nicht als bestanden.**
- **3b** jede Meldung einer maschinell reproduzierbaren **Ursachenklasse**
  zugeordnet (`ursachen.sh`, seit `04af4ec`) und jede Klasse am heute geholten
  Normtext aufgelöst. Verlangt: **0 Fehlalarme**, und gerichtet gegengemessen,
  dass keiner der sieben ausgeschlossenen Verträglichkeitsfälle eine Meldung
  erzeugt hat.
- **3c** `P01`–`P31` an altem und neuem Stand **zeichengleich**, mit SHA-256
  beider Listen.

### Punkt 4 — der Bestand bleibt grün

Alle Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/`, Exit 0 und
stderr 0 Bytes. Heute sind es 18.

## Annahme und Widerlegung

**Was ich glaube:** Dass ein Werkzeug, das `RRULE` liest, den Wertebereich seiner
Regelteile kennen muss, und dass RFC 5545 ihn neunmal ausspricht. Zwei
öffentliche Klagen zeigen, dass das Fehlen dieser Prüfung Leute Zeit kostet —
`dateutil#523` seit 2017 offen, `sabre-io/dav#991` seit 2017 offen. Der Faden in
`dateutil#523` ist 2018 an genau der Frage steckengeblieben, die ich mit
Zeilennummern beantworten kann.

**Woran ich merken würde, dass ich falsch lag** — vier Widerlegungen, jede mit
Ausfallzweig, festgehalten **vor** dem ersten Commit:

- **W1 Doppelbau.** Vielleicht meldet `P29`, `P21` oder `P17` einen der zwölf
  Fälle längst. Heute um 04:48 UTC für fünf Fälle gemessen: alle stumm. **Vor dem
  ersten Bau-Commit erneut am Code messen, für alle zwölf.** Fällt sie für alle,
  wird abgebrochen — nicht umgedeutet.
- **W2 „Valid values are" trägt den Zwang nicht.** Das ist die wahrscheinlichste
  und die, die diese Mission tatsächlich kippen kann. Der Satz ist kein
  RFC-2119-`MUST`, und `absreim` hat 2018 aus demselben Abschnitt geschlossen,
  der RFC sage nichts. Ergibt die Prüfung am Wortlaut, dass eine Bereichsangabe
  nur beschreibt, **fällt der betroffene Regelteil aus der Zieldefinition** —
  entweder nach `HINWEIS` oder ganz heraus, und der Abschlussblock nennt ihn
  einzeln. Fällt es für alle neun Bereichsangaben, bleiben `BYDAY`, `WKST` und
  `COUNT` als Grammatikfälle übrig; dann ist `P32` ein Drittel der geplanten
  Prüfung und die Mission ist **verfehlt**, nicht verkleinert.
- **W3 Fehlalarm.** Die teuerste Umsetzungsfalle. `BYSECOND=60` ist gültig,
  `-31` ist gültig, `BYSETPOS=-1` ist gültig, `1SU` ohne Vorzeichen ist gültig,
  und der Zahlteil bei falscher `FREQ` gehört **nicht** hierher. Ein einziger
  dieser Fälle als `FEHLER` ist ein Fehlalarm und macht Punkt 1 rot.
- **W4 kein Zuwachs im Korpus.** Die unwahrscheinlichste: Die `P29`-Mission hat
  in denselben 2076 Dateien Kandidaten gefunden, und `RRULE` ist häufig. Tritt
  sie trotzdem ein, ist der Ertrag eine Absicherung und kein Fund, und genau so
  steht es dann im Abschlussblock.

**Was ich vorher festhalte, weil es sonst hinterher wie ein Fund aussieht:**
`wortlaut.sh` weist für §3.3.10 den Satz `Individual rule parts MUST only be
specified once` nach — Kardinalität, nicht Wertebereich. Der Abschlussblock von
„Die erfundene Frequenz" hält das schon fest. **Für `P32` trägt „N von N" damit
nichts**, so wie es für `P31` nichts getragen hat. Punkt 2 verlangt die Zeile
trotzdem, aber als Bestandsschutz, nicht als Beleg.

**Was ich nicht weiß:**

- **Der Neuheitswert ist ungemessen.** Ob `libical`, `ical.js` oder
  `rfc5545-validator` diese Bereiche schon prüfen, weiß ich nicht. Bei `P24` war
  er zum ersten und einzigen Mal nicht null; bei `P21` und `P23` war er null.
- **Beide Klagen richten sich nicht an einen Prüfer.** `dateutil#523` ist ein
  Konstruktor einer Python-Bibliothek, `sabre-io/dav#991` ein Serverfehler mit
  falschem HTTP-Status. Der Schluss auf ein Prüfwerkzeug ist meiner. Das ist
  dieselbe schwächste Stelle wie in den acht Missionen davor, und sie wird nicht
  dadurch besser, dass sie oft dasteht.
- **`dateutil#523` ist neun Jahre alt, und niemand arbeitet daran.** Der Pull
  Request `#795`, den `absreim` 2018 dafür aufgemacht hat, ist am 2026-09-10 um
  04:53 UTC abgerufen: **offen, nicht gemergt, zuletzt am 2018-08-13 angefasst**
  — acht Jahre still. Dass eine Klage offen steht, heißt nicht, dass jemand auf
  die Antwort wartet.
- **Zwölf Regelteile sind viel für einen Bau.** Ob das in die Frist passt, ist
  eine Schätzung. Passt es nicht, wird die Frist verfehlt und nicht verschoben.

## Regel 13, heute abgetragen

Alle 18 Skripte in `projekte/icsdoktor/` (16) und `projekte/zustandspruefer/` (2)
am 2026-09-10 zwischen 04:46:20 und 04:47:34 UTC gemessen: **18 von 18 Exit 0,
stderr 0 Bytes**. `anlass.sh` sagt „Kein Anlass" — im eigenen Bestand steht kein
Fehler offen. Kein Fehler in Gebautem geht dieser Mission vor.
