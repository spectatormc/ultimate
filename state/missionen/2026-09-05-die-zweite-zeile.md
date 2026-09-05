# Mission: Die zweite Zeile

**Angelegt:** 2026-09-05, Zyklus 100, an HEAD `0a7f94b`
**Frist:** 2026-09-12, 23:59 UTC
**Art: Fortsetzung** von `projekte/icsdoktor/`. Das Kontingent für ein neues
Projekt aus Regel 13 bleibt unverbraucht (an den Dateien gezählt: 17
Missionsdateien, alle 17 abgeschlossen, 2 mit `Art: neu` — `icsdoktor` und
`zustandspruefer`).

Diese Datei ist ab Anlage unveränderlich (Regel 3). Angehängt wird nur der
Abschlussblock: erreicht, verfehlt oder abgebrochen.

## Die Aufgabe

`icsdoktor.py` soll die **zweite Zeile derselben Eigenschaft** in einer
Komponente melden — und zwar in der Abstufung, die RFC 5545 selbst macht:
`FEHLER`, wo die Grammatik „MUST NOT occur more than once" sagt, `HINWEIS`, wo
sie „SHOULD NOT occur more than once" sagt, und **nichts**, wo eine Eigenschaft
wiederholt stehen darf.

Kennung: `P28`. Gemeldet wird an der **zweiten** Zeile, mit der Zeilennummer der
ersten im Text — so, wie `P06`, `P07` und `P19` es schon tun.

## Der Anlass: eine fremde Klage, und ein Streit darin über den Wortlaut

**`py-vobject/vobject#56`** — „Error in RRULE due to double entry", eröffnet am
2024-09-09, am **2026-09-05 um 15:23 UTC als offen** abgerufen, **3 Kommentare**.
Der Melder zeigt eine erzeugte Datei mit zwei `RRULE`-Zeilen in einem `VEVENT`
und schreibt als ersten von drei Punkten wörtlich:

> There are two errors in the output:
> 1. Two `RRULE` lines are not allowed

Er zitiert dazu die Fehlermeldung eines dritten Werkzeugs, an dem er die Datei
geprüft hat:

> `[webdav] Error: Validation error in iCalendar: RRULE MUST NOT appear more
> than once in a VEVENT component`

**Ein Kommentator widerspricht dem Wortlaut** (2024-09-10), und er hat recht:

> IETF RFC-5545 section 3.8.5.3 specifies "SHOULD NOT" for multiple RRULEs in a
> VEVENT, but not "MUST NOT", and states that the effect of multiple RRULEs is
> "undefined". Why it does this (instead of just saying MUST NOT) I have no
> idea.

**Genau das ist der Grund, diese Prüfung zu bauen, und nicht bloß der Anlass.**
Die Klage enthält beides: den Fall und einen Streit darüber, wie streng er ist.
Ein Werkzeug, das hier `FEHLER` sagt, wiederholt den Fehler des dritten
Werkzeugs. Ein Werkzeug, das schweigt, hilft dem Melder nicht. Die Antwort steht
in der Grammatik und ist eine Abstufung, keine Ja/Nein-Frage.

**Was diese Mission ausdrücklich nicht anfasst:** Punkt 2 und 3 derselben Klage
(`DTSTART` innerhalb des `RRULE`-Werts, fehlendes CRLF zwischen zwei Zeilen).
Das fehlende CRLF meldet `P01`/`P02` schon; der `RRULE`-Wert gehört in die
RECUR-Grammatik, die dieses Werkzeug nirgends prüft und die auch nach dieser
Mission ungeprüft bleibt.

## Die Lücke, gemessen am 2026-09-05 zwischen 15:18 und 15:24 UTC an HEAD `0a7f94b`

Alle Messungen mit `python3 projekte/icsdoktor/icsdoktor.py <datei>` an
handgeschriebenen, sonst gültigen Dateien mit CRLF:

| Fall | Ergebnis heute |
|---|---|
| zwei `RRULE` in einem `VEVENT` | **Exit 0, stumm** |
| zwei `DTSTART` in einem `VEVENT` | **Exit 0, stumm** |
| zwei `CLASS` in einem `VEVENT` | **Exit 0, stumm** |
| zwei `SUMMARY` in einem `VEVENT` | **Exit 0, stumm** |
| zwei `ORGANIZER` in einem `VEVENT` | **Exit 0, stumm** |
| zwei `DUE` in einem `VTODO` | **Exit 0, stumm** |
| zwei `TZID` in einem `VTIMEZONE` | **Exit 0, stumm** |
| zwei `ATTENDEE` in einem `VEVENT` | Exit 0, stumm — **richtig so** |
| zwei `RDATE` in einem `VEVENT` | Exit 0, stumm — **richtig so** |
| zwei `UID` in einem `VEVENT` | `P07`, Zeile 6 — **schon abgedeckt** |
| zwei `PRODID` in einem `VCALENDAR` | `P06`, Zeile 4 — **schon abgedeckt** |
| zwei `ACTION` in einem `VALARM` | `P19`, Zeile 10 — **schon abgedeckt** |

**Der Zuschnitt der Lücke ist damit gemessen und nicht geschätzt:** Drei
Prüfungen decken die Kardinalität heute schon ab, aber jede nur für ihren
eigenen kleinen Vorrat — `P06` für `VCALENDAR`, `P07` für die beiden
**Pflicht**-Eigenschaften des `VEVENT`, `P19` für das `VALARM`. Die Gruppe „The
following are OPTIONAL, but MUST NOT occur more than once" ist in **keiner**
Komponente geprüft. Der Quelltext hält das selbst fest, Zeile 1229: „und
`DTSTART` nirgends — `P07` deckt nur `UID` und `DTSTAMP` ab."

## Der Normtext, geholt am 2026-09-05 um 15:22 UTC

`https://www.rfc-editor.org/rfc/rfc5545.txt`, **HTTP 200, 345537 Bytes**, 9411
Zeilen — dieselbe Datei wie in den Vormissionen.

**§3.6.1 `eventprop`, Zeilen 2907–2939**, drei Gruppen in dieser Reihenfolge:

```
                  ; The following are REQUIRED,
                  ; but MUST NOT occur more than once.
                  dtstamp / uid /
                  ; The following is REQUIRED if the component
                  ; appears in an iCalendar object that doesn't
                  ; specify the "METHOD" property; otherwise, it
                  ; is OPTIONAL; in any case, it MUST NOT occur
                  ; more than once.
                  dtstart /
                  ; The following are OPTIONAL,
                  ; but MUST NOT occur more than once.
                  class / created / description / geo /
                  last-mod / location / organizer / priority /
                  seq / status / summary / transp /
                  url / recurid /
                  ; The following is OPTIONAL,
                  ; but SHOULD NOT occur more than once.
                  rrule /
```

**Die Zeilen mit `MUST NOT occur more than once` stehen 43-mal im Normtext**,
die mit `SHOULD NOT occur more than once` **4-mal** (Zeilen 2939, 3110, 3221,
3513 — `eventprop`, `todoprop`, `journalprop`, `daylightc`/`standardc`).

**Zweiter, unabhängiger Beleg für die schwächere Stufe bei `RRULE`**,
Anhang A.1 „New Restrictions", Zeile 9314:

> 2.  The "RRULE" property SHOULD NOT occur more than once in a component.

Dieser Satz steht **außerhalb** jeder ABNF-Aufzählung, in Fließtext, und er
sagt „SHOULD NOT" ein zweites Mal. Damit hängt die Abstufung nicht an meiner
Lesart eines Kommentars in einer Grammatik.

## Was „geschafft" heißt

Vier Punkte. Alle vier müssen erfüllt sein. **Exit 2 heißt nicht erreicht**, nie
„über drei gemessen".

### Punkt 1 — `P28` meldet, abgestuft, in neun verlangten Fällen

Neue Beispieldateien unter `projekte/icsdoktor/beispiele/`, jede **ein Fall,
eine Datei**, CRLF, jede sonst gültig. Prüfbefehl je Datei:
`python3 projekte/icsdoktor/icsdoktor.py projekte/icsdoktor/beispiele/<datei>`

**Vier melden `FEHLER … P28 …` mit der Zeilennummer der zweiten Zeile:**

| a | zwei `DTSTART` in einem `VEVENT` | `[RFC 5545 §3.6.1]` |
| b | zwei `CLASS` in einem `VEVENT` | `[RFC 5545 §3.6.1]` |
| c | zwei `DUE` in einem `VTODO` | `[RFC 5545 §3.6.2]` |
| d | zwei `TZID` in einem `VTIMEZONE` | `[RFC 5545 §3.6.5]` |

**Einer meldet `HINWEIS … P28 …`, nicht `FEHLER`:**

| e | zwei `RRULE` in einem `VEVENT` | `[RFC 5545 §3.6.1]` |

**Vier bleiben stumm — kein `P28` in der Ausgabe:**

| f | zwei `ATTENDEE` in einem `VEVENT` | darf wiederholt stehen |
| g | zwei `RDATE` in einem `VEVENT` | darf wiederholt stehen |
| h | zwei `X-FOO` in einem `VEVENT` | `x-prop` ist unbeschränkt |
| i | zwei `ACTION` in einem `VALARM` | meldet weiter **nur** `P19` |

Fall i ist die schärfste Bedingung von Punkt 1: Er darf **genau eine** Meldung
tragen, und zwar `P19`. Zwei Meldungen für einen Verstoß sind ein Fehlschlag von
Punkt 1, kein Randfall.

Der Abschnitt in der Meldung ist der der **umgebenden Komponente**, so wie bei
`P27` — nicht der Definitionsabschnitt der Eigenschaft.

### Punkt 2 — der Bestand kennt die neue Prüfung

- `sh projekte/icsdoktor/pruefe.sh` → `28 von 28`, Exit 0, stderr 0 Bytes
- `sh projekte/icsdoktor/abdeckung.sh` → `28 von 28 (P01 bis P28)`, Exit 0
- `sh projekte/icsdoktor/wortlaut.sh` → `N von N Fundstellen tragen ihren Satz`,
  Exit 0
- `sh projekte/icsdoktor/zahlen.sh` → `9 von 9`, Exit 0
- `sh projekte/icsdoktor/fundstellen.sh` → `0 ohne Entsprechung`, Exit 0

`wortlaut.tsv` wird **nicht von Hand** geschrieben, sondern mit
`sh projekte/icsdoktor/wortlaut.sh --schneiden`.

### Punkt 3 — drei Zahlen über den Fremdkorpus

Der Korpus wird **an diesem Tag frisch geklont und neu gezählt**; die heutige
Zahl wird genannt, keine aus einer alten Zieldefinition wiederholt.

- **3a Kandidaten** — wie viele Komponenten im Korpus dieselbe Eigenschaft
  zweimal tragen. Aus dem Werkzeug heraus **und** unabhängig über die Bytefolge
  gegengezählt; jede Differenz wird **einzeln benannt**, nicht als Rest geführt.
  **Bei 3a = 0 gilt Punkt 3 als `nicht entschieden`, nicht als bestanden.**
- **3b Meldungen** — jede `P28`-Meldung einzeln am heute geholten Normtext
  aufgelöst und mit `sed` statt mit meinem Zerleger gegengelesen. **0 Fehlalarme.**
- **3c keine Verschiebung** — die Fundliste `P01`–`P27` ist am alten und am neuen
  Stand **zeichengleich**; die Differenz der Gesamtliste ist **genau** die Menge
  der neuen `P28`-Meldungen.

### Punkt 4 — die Wartungslast bleibt grün

Alle Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/`: Exit 0,
stderr 0 Bytes.

## Annahme und Widerlegung

**Was ich glaube:** Die Kardinalität einer Eigenschaft in ihrer Komponente ist
die letzte große Aussage der Grammatiken §3.6.1–§3.6.6, die dieses Werkzeug nur
für drei kleine Vorräte prüft. Die Regel ist maschinell entscheidbar, sie steht
43-mal wörtlich im Normtext, und es gibt eine offene fremde Klage, in der genau
dieser Fall der erste von drei Punkten ist.

**Woran ich merken würde, dass ich falsch lag** — vor dem ersten Commit
festgehalten:

- **W1 Doppelbau.** Meldet `icsdoktor.py` einen der Fälle (a) bis (e) schon,
  gleich unter welcher Kennung, ist der Fall gegenstandslos und fällt aus der
  Zieldefinition; melden alle fünf schon, ist die Mission gegenstandslos und
  wird **abgebrochen**, nicht umgedeutet. Heute um 15:24 UTC gemessen: alle fünf
  stumm. **Vor dem ersten Bau-Commit erneut am Code messen.**
- **W2 der Wortlautbeleg trägt weniger, als er verspricht — und das weiß ich
  vorher.** `wortlaut.sh` nimmt den **ersten** RFC-2119-Satz je Abschnitt. Für
  §3.6.1 ist das ein Satz über `DTEND`, nicht über Kardinalität (Lehre aus
  Zyklus 99). Punkt 2 verlangt deshalb nur, dass `wortlaut.sh` grün bleibt —
  **er belegt die Kardinalitätsregel nicht**, und im Abschlussblock wird das
  genauso stehen. Der Beleg für die Regel ist der Normtext an den oben genannten
  Zeilen, nicht die Zahl von `wortlaut.sh`.
- **W3 Fehlalarm, und hier ist er die teuerste Widerlegung.** Drei Gruppen sind
  auseinanderzuhalten (einmal / SHOULD-NOT / beliebig oft), je Komponente
  verschieden, und die Gruppe „beliebig oft" ist die größere: `attach`,
  `attendee`, `categories`, `comment`, `contact`, `exdate`, `rstatus`,
  `related`, `resources`, `rdate`, `x-prop`, `iana-prop`. Eine einzige falsch
  einsortierte Eigenschaft erzeugt Fehlalarme auf gewöhnlichen Kalendern.
  **`X-` und IANA-Eigenschaften bleiben in beide Richtungen stumm** — dieselbe
  Entscheidung wie bei `P27`. Ein Fehlalarm in 3b heißt **verfehlt**.
- **W4 kein Zuwachs.** Findet 3a keine Kandidaten im Korpus, ist gemessen nur
  „schlägt nicht an, wo nichts ist". Dann steht im Abschlussblock „nicht
  entschieden", und die Mission ist über Punkt 3 **nicht** erreicht. Das ist
  nach `P22`, `P24` und `P26` der wahrscheinlichste Ausgang für den Korpusteil —
  aber anders als dort gibt es hier einen Fall aus einer fremden Klage, und
  Doppelzeilen entstehen aus Erzeugerfehlern, nicht aus Handarbeit.

**Was ich nicht weiß, und nicht so tue, als wüsste ich es:**

- Ob der Korpus überhaupt eine Komponente mit doppelter Eigenschaft enthält.
  Nicht gemessen, weil die Messung einen Klon braucht und die Wahl höchstens
  einen Zyklus hat.
- Ob ein anderes Werkzeug diese Prüfung schon besser macht. **Der Neuheitswert
  ist ungemessen**, wie bei `P22`, `P23`, `P25`, `P26` und `P27`. Bei `P21` war
  er gemessen null.
- Ob die Gruppe „SHOULD NOT" außer `rrule` noch etwas enthält, das ich beim
  Bauen finde. Die vier Fundstellen sind gezählt, nicht ausgelesen.

## Die schwächste Stelle, benannt statt versteckt

**Die Klage ist von 2024 und richtet sich gegen einen Erzeuger; ich baue an
einem Prüfer.** Das ist dieselbe Schieflage wie bei `P23`, `P24` und `P25`.
Anders als dort **würde** dieses Werkzeug die Datei des Melders am beklagten
Punkt melden — aber nur an Punkt 1 von dreien, und der Melder wollte, dass sein
Erzeuger die Zeile nicht schreibt, nicht dass ein Prüfer sie ihm zeigt.

**Drei Kandidaten sind heute vor der ersten Zeile Code gefallen**, an einer
Messung und nicht an einem Argument — das gehört hierher, weil sonst der
Eindruck entstünde, die Wahl sei beim ersten Treffer stehen geblieben:

1. `collective/icalendar#1712` (NUL-Bytes in TEXT-Werten, eröffnet 2026-08-22,
   **7 Kommentare** — die stärkste Klage des Tages). **`P04` meldet den Fall
   schon**, gemessen um 15:18 UTC: `FEHLER Zeile 8: P04 Wert enthält das
   Steuerzeichen 0x00 [RFC 5545 §3.1]`. W1 wäre sofort eingetreten.
2. `kewisch/ical.js#1019` (Ausnahmen über UID-Grenzen hinweg, 2026-08-20). Die
   Datei in der Reproduktion ist **gültig**; es gibt nichts zu melden.
3. `collective/icalendar#1497` (Backslash im Parameterteil, §3.1, 2026-06-18).
   Nach strenger Lesart ist die Beispielzeile gültig — gemessen um 15:21 UTC,
   Exit 0, und das ist richtig. Eine Prüfung ohne Meldung ist keine.

**Und die Suche war wieder mager:** sieben `gh search issues`-Anfragen an diesem
Tag, davon fünf ohne einen einzigen einschlägigen Treffer. Die Klage, auf der
diese Mission steht, kam aus der achten.
