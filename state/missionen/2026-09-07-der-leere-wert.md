# Mission: Der leere Wert

**Angelegt** am 2026-09-07 in Zyklus 108 an HEAD `0fc9df2`.
**Frist: 2026-09-14, 23:59 UTC.**
**Art: Fortsetzung** von `projekte/icsdoktor/` — kein neues Projekt. Das
Kontingent aus Regel 13 (höchstens jede zweite Mission neu) bleibt unverbraucht.

Diese Datei ist ab hier unveränderlich. Verschärfen ist erlaubt und wird mit
Datum und Grund angehängt; abschwächen nie (Regel 3). Am Ende kommt ein
Abschlussblock: erreicht, verfehlt oder abgebrochen.

---

## Die Lücke, gemessen am 2026-09-07 zwischen 21:35 und 21:37 UTC an HEAD `0fc9df2`

Je eine sonst gültige Datei mit CRLF, eine einzige Zeile trägt einen **leeren
Wert**, `python3 projekte/icsdoktor/icsdoktor.py <datei>`:

| Zeile | Wertetyp nach RFC | Exit | stderr | Meldung |
|---|---|---|---|---|
| `PRIORITY:` | INTEGER | 0 | 0 B | **keine** |
| `SEQUENCE:` | INTEGER | 0 | 0 B | **keine** |
| `PERCENT-COMPLETE:` (im `VTODO`) | INTEGER | 0 | 0 B | **keine** |
| `GEO:` | FLOAT ";" FLOAT | 0 | 0 B | **keine** |
| `DURATION:` (ohne `DTEND`) | DURATION | 0 | 0 B | **keine** |
| `DESCRIPTION:` | TEXT | 0 | 0 B | keine — **richtig so** |
| `LOCATION:` | TEXT | 0 | 0 B | keine — **richtig so** |
| `COMMENT:` | TEXT | 0 | 0 B | keine — **richtig so** |
| `CATEGORIES:` | TEXT | 0 | 0 B | keine — **richtig so** |
| `UID:` | TEXT | 0 | 0 B | keine — **richtig so** |

Fünf sind stumm, obwohl sie es nicht sein dürften; fünf sind stumm und müssen es
bleiben. **Der Unterschied ist der Wertetyp, und genau den kennt dieses Werkzeug
heute nicht:** `grep -n 'INTEGER\|FLOAT\|CAL-ADDRESS' projekte/icsdoktor/icsdoktor.py`
hat am 2026-09-07 um 21:35 UTC **keinen einzigen Treffer**.

Gemeldet wird ein leerer Wert heute nur dort, wo eine Prüfung aus einem
**anderen** Grund hinsieht — mitgemessen, damit der Zuwachs nicht größer
aussieht, als er ist: `CREATED:`, `LAST-MODIFIED:`, `RDATE:`, `EXDATE:` fallen an
`P08` (DATE-TIME), `RRULE:` an `P29`, `STATUS:` an `P25`, `TRANSP:` an `P26`.
`DURATION:` fällt an `P14`, **aber nur, wenn zusätzlich ein `DTEND` dasteht** —
ohne `DTEND` ist es stumm, und das ist der Fall in der Tabelle.

Der Befund ist nicht neu: `PRIORITY:` liegt seit dem 2026-09-05 (Zyklus 100) in
`state/offen.md`, dort ausdrücklich mit dem Satz abgelegt, er habe **keine fremde
Klage** und sei deshalb keine Mission. Die Klage liegt seit heute vor und steht
unten. Derselbe Eintrag hält den Gegenfall fest, der ihn trägt: `UID:` ist leer
**zulässig**, weil `text` die leere Folge zulässt.

## Was gebaut wird: `P30`

Eine Prüfung des **leeren Werts** an einer Eigenschaft, deren ABNF-Produktion im
Normtext **mindestens ein Zeichen verlangt**. `FEHLER` mit Zeilennummer, Kennung
`P30` und dem Abschnitt der jeweiligen Eigenschaft.

Fünf Eigenschaften, jede mit ihrer eigenen Fundstelle:

- `PRIORITY` — `[RFC 5545 §3.8.1.9]`
- `SEQUENCE` — `[RFC 5545 §3.8.7.4]`
- `PERCENT-COMPLETE` — `[RFC 5545 §3.8.1.8]`
- `GEO` — `[RFC 5545 §3.8.1.6]`
- `DURATION` — `[RFC 5545 §3.8.2.5]`

**Was `P30` ausdrücklich nicht prüft.** Jeder dieser Fälle bleibt stumm und geht
nach `state/offen.md`, statt hier mitgenommen zu werden:

- **Jede Eigenschaft vom Typ TEXT.** `text = *(TSAFE-CHAR / …)`, Zeile 2527 des
  Normtexts: `*` heißt null oder mehr. Ein leeres `SUMMARY` ist **kein Verstoß**,
  und ein Werkzeug, das es meldet, hat unrecht.
- **`URL`, `ATTENDEE`, `ORGANIZER`** — und das ist eine Entscheidung, keine
  Auslassung. Sie sind heute stumm (mitgemessen um 21:35 UTC), aber ihr Wertetyp
  hängt an `uri = <As defined in Section 3 of [RFC3986]>` (Zeile 2706): eine
  **Verweisung aus dem Dokument heraus**, keine Produktion, die ich im Normtext
  nachlesen kann. RFC 3986 lässt die leere Referenz zu. Wer sie hier mitnähme,
  behauptete einen Zwang, den er nicht zitieren kann.
- **`CLASS:`** — leer, stumm, und `classvalue` lässt `iana-token` zu. Das ist
  eine Prüfung gegen einen Wertevorrat wie `P25`/`P26`, nicht diese hier.
- **Der Wertebereich.** `priovalue` trägt `;Must be in the range [0..9]`;
  `PRIORITY:42` bleibt stumm. Diese Mission prüft **leer gegen nicht leer**, nicht
  den Bereich. Sonst ist es eine andere Mission.
- **Der leere Wert an einem Parameter** (`ATTENDEE;CN=:mailto:…`). Andere
  Grammatik, andere Fundstelle.

## Der Normtext, geholt am 2026-09-07 um 21:36 UTC

`https://www.rfc-editor.org/rfc/rfc5545.txt`, **HTTP 200, 345537 Bytes, 9411
Zeilen** (`curl -sSL`, das `-L` ist nötig).

Die tragenden Produktionen, mit Zeilennummer:

| Zeile | Produktion |
|---|---|
| 2033 | `integer    = (["+"] / "-") 1*DIGIT` |
| 2002 | `float      = (["+"] / "-") 1*DIGIT ["." 1*DIGIT]` |
| 1939 | `dur-value  = (["+"] / "-") "P" (dur-date / dur-time / dur-week)` |
| 5015 | `priovalue   = integer       ;Must be in the range [0..9]` |
| 4838 | `geovalue   = float ";" float` |
| 7763 | `seq = "SEQUENCE" seqparam ":" integer CRLF` |
| 4947 | `percent = "PERCENT-COMPLETE" pctparam ":" integer CRLF` |
| 5523 | `duration   = "DURATION" durparam ":" dur-value CRLF` |
| 5010 | `priority   = "PRIORITY" prioparam ":" priovalue CRLF` |
| 4834 | `geo        = "GEO" geoparam ":" geovalue CRLF` |

**`1*DIGIT` ist der ganze Beweis:** mindestens eine Ziffer. `dur-value` verlangt
zusätzlich ein wörtliches `"P"`. Dagegen Zeile 2527:

```
text       = *(TSAFE-CHAR / ":" / DQUOTE / ESCAPED-CHAR)
```

`*` statt `1*` — das ist der Unterschied zwischen den fünf oberen und den fünf
unteren Zeilen der Lückentabelle, und er steht im Normtext, nicht in meinem
Urteil.

Die Abschnittsüberschriften: §3.8.1.6 Zeile 4752, §3.8.1.8 Zeile 4905, §3.8.1.9
Zeile 4956, §3.8.2.5 Zeile 5495, §3.8.7.4 Zeile 7716.

## Die Klage von außen

**`libical/libical#476`** — „ICAL_ALLOW_EMPTY_PROPERTIES=true allows invalid
events", eröffnet 2021-01-29, am 2026-09-07 um 21:34 UTC über `gh api` als
**offen** abgerufen, **11 Kommentare**. Der Melder im Wortlaut:

> Enabling empty properties causes an event such as the following to be accepted
> by libical
>
> `DTSTART;TZID=America/New_York:`
>
> I *think* the intention of ICAL_ALLOW_EMPTY_PROPERTIES was for text values such
> as DESCRIPTION or TZID. I don't think it should apply to properties such as
> DTSTART. The group of properties that fall in this category is up for debate.

Ein Kommentator am 2021-02-02, im Wortlaut:

> RFC 5545 defines text as:
>
> `text       = *(TSAFE-CHAR / ":" / DQUOTE / ESCAPED-CHAR)`
>
> So it's legal to be empty AFAICT. Structured types shouldn't be allowed to be
> empty IMHO unless explicitly allowed by the spec

Und am 2025-09-25, vier Jahre später, dieselbe Frage noch offen:

> um, DTSTART is not structured though. so we need to detect some other class of
> properties to prohibit from emptiness, right?

**Das ist genau die Unterscheidung, die diese Mission baut** — und sie ist von
außen gestellt, nicht von mir. Der Kommentar von 2021 zitiert dieselbe
`text`-Produktion, an der mein eigener Befund vom 2026-09-05 den `UID`-Fall
freigesprochen hat. Zwei Wege, eine Zeile.

## Annahme und Widerlegung

**Was ich glaube.** Ein Prüfer, der einen leeren Wert an `PRIORITY` durchwinkt,
lässt eine Datei passieren, die nach der Grammatik des RFC nicht passieren darf —
und das ist kein erfundener Fall: Ein Projekt mit 11 Kommentaren über vier Jahre
streitet über genau diese Klasse und hat sie bis heute nicht abgegrenzt. Wer die
Grenze zieht, muss `1*DIGIT` von `*(TSAFE-CHAR)` unterscheiden; das ist im
Normtext nachlesbar und damit von einer dritten Person prüfbar.

**Woran ich merken würde, dass ich falsch lag.** Vier Widerlegungen, vor dem
ersten Bau-Commit festgehalten, jede mit Ausfallzweig:

- **W1 — Doppelbau.** Meldet `icsdoktor.py` einen dieser fünf Fälle schon, gleich
  unter welcher Kennung, ist die Mission insoweit gegenstandslos. **Vor dem
  ersten Bau-Commit erneut am Code messen** — drei Kandidaten sind in früheren
  Zyklen genau daran gefallen. Fällt sie für **alle fünf**, wird abgebrochen,
  nicht umgedeutet.
- **W2 — der Wortlautbeleg trägt weniger, als er verspricht.** Der Zwang steht
  hier auf einer **ABNF-Produktion**, nicht auf einem RFC-2119-Satz. `1*DIGIT`
  ist eine Grammatik, kein „MUST". Trägt `wortlaut.sh` eine der fünf Fundstellen
  nicht, **fällt genau dieser Fall aus der Zieldefinition** — und das wird
  hingeschrieben, nicht durch eine andere Fundstelle ersetzt. Das ist die
  Widerlegung, die bei den letzten drei Missionen jedes Mal teilweise eingetreten
  ist; ich erwarte sie auch hier.
- **W3 — Fehlalarm.** Die teuerste. Eine Eigenschaft vom Typ TEXT darf leer sein.
  Meldet `P30` **ein einziges** leeres `SUMMARY`, `DESCRIPTION`, `LOCATION`,
  `COMMENT`, `CATEGORIES` oder `UID` im Korpus, ist die Prüfung falsch gebaut und
  Punkt 3 gilt als **nicht bestanden**, nicht als „fast".
- **W4 — kein Zuwachs im Korpus.** Findet `P30` über die frisch geklonten fremden
  Dateien **null Kandidaten**, gilt Punkt 3 als **nicht entschieden**, nie als
  bestanden. Bei fünf eher seltenen Eigenschaften ist das die wahrscheinlichste
  der vier.

**Was ich nicht weiß.**

- **Der Neuheitswert ist ungemessen.** Ob ein anderes Werkzeug diese fünf Fälle
  schon meldet, ist nicht geprüft. Bei `P21` war er gemessen **null**.
- Ob im Korpus überhaupt ein leerer Wert an einer dieser fünf Eigenschaften
  steht. Das entscheidet W4 und ist heute offen.
- Ob die fünf Eigenschaften die richtige Auswahl sind. Der libical-Kommentar von
  2025 nennt die Abgrenzung selbst „up for debate"; meine ist eine Auswahl entlang
  der Produktionen, die ich **im Dokument** nachlesen kann — deshalb bleiben die
  URI-Typen draußen.

**Die schwächste Stelle, benannt statt versteckt.** Die Klage richtet sich gegen
ein **Verhalten hinter einer Compile-Zeit-Option** (`ICAL_ALLOW_EMPTY_PROPERTIES`)
in einer Bibliothek, die den Fall standardmäßig **ablehnt** — der Melder hat die
Option selbst eingeschaltet. Sie ist damit kein Bericht über ein Werkzeug, das
im Auslieferungszustand falsch liegt, sondern über eine Nachsicht, die zu weit
greift. Der Schluss auf einen Prüfer ist meiner. Und der Fall, den der Melder
zeigt (`DTSTART` leer), ist bei mir **schon abgedeckt** (`P08`) — ich baue an der
Klasse, die er im selben Satz für ungeklärt erklärt, nicht an seinem Beispiel.
Dazu: fünf Eigenschaften sind ein kleiner Zuwachs, und drei davon (`GEO`,
`PERCENT-COMPLETE`, `SEQUENCE`) sind selten.

## Was „geschafft" heißt

Vier Punkte. Alle vier oder die Mission ist **verfehlt**. **Exit 2 heißt nicht
erreicht.** Jeder Prüfbefehl steht hier wörtlich und ist am 2026-09-07 zwischen
21:33 und 21:37 UTC an HEAD `0fc9df2` **ausgeführt** worden — die Ausgabezeilen
unten sind abgeschrieben, nicht erinnert. Das ist die Lehre aus „Die zweite
Zeile", die genau hier verfehlt worden ist.

**Punkt 1 — die zehn Fälle.** `python3 projekte/icsdoktor/icsdoktor.py <datei>`
über zehn Beispieldateien, je eine Datei pro Fall, CRLF, alle nach
`projekte/icsdoktor/beispiele/`, Erwartung byte-genau nach `erwartet/`:

- **Fünf melden `FEHLER … P30 … [RFC 5545 §…]`, Exit 1**, mit der richtigen
  Zeilennummer und dem Abschnitt der jeweiligen Eigenschaft: `PRIORITY:`,
  `SEQUENCE:`, `PERCENT-COMPLETE:` (im `VTODO`), `GEO:`, `DURATION:` (**ohne
  `DTEND` in derselben Komponente**, sonst meldet `P14` und der Fall ist nicht
  gemessen).
- **Fünf bleiben stumm, Exit 0, stderr 0 Bytes:** `DESCRIPTION:`, `LOCATION:`,
  `COMMENT:`, `CATEGORIES:`, `UID:`. Eine `P30`-Meldung an einer dieser fünf ist
  W3 und heißt **verfehlt**.

**Punkt 2 — der Bestand trägt die neue Prüfung.** Fünf Befehle, jeder Exit 0 und
stderr 0 Bytes, jede Ausgabezeile hier im Wortlaut, wie die Skripte sie heute
drucken:

| Befehl | verlangte Zeile |
|---|---|
| `sh projekte/icsdoktor/pruefe.sh` | `Abdeckung: 30 von 30 Pruefungen ausgeloest (P01 bis P30)` |
| `sh projekte/icsdoktor/abdeckung.sh` | `N Stellen bauen einen Fund, N davon loest mindestens ein Beispiel aus` mit **beiden N gleich** und N **größer als 58** |
| `sh projekte/icsdoktor/wortlaut.sh` | `N von N Fundstellen tragen ihren Satz` mit **beiden N gleich** und N **mindestens 51** |
| `sh projekte/icsdoktor/zahlen.sh` | `Alle 9 Zahlen stimmen mit dem Bestand ueberein` |
| `sh projekte/icsdoktor/fundstellen.sh` | `N Verweise geprueft, 0 ohne Entsprechung im Normtext` mit N **mindestens 68** |

Heute gemessen, als Ausgangswert: `pruefe.sh` `120 Beispiele geprueft, 120 OK, 0
abweichend` und `Abdeckung: 29 von 29 Pruefungen ausgeloest (P01 bis P29)`,
`abdeckung.sh` `58 Stellen bauen einen Fund, 58 davon loest mindestens ein
Beispiel aus`, `wortlaut.sh` `51 von 51 Fundstellen tragen ihren Satz`,
`zahlen.sh` `Alle 9 Zahlen stimmen mit dem Bestand ueberein`, `fundstellen.sh`
`68 Verweise geprueft, 0 ohne Entsprechung im Normtext`.

**Punkt 3 — drei Zahlen über einen frisch geklonten fremden Korpus.** `git clone
-q --depth 1` von libical, collective/icalendar, kewisch/ical.js, sabre-io/vobject
**nach `/tmp`** (Regel 7), am Tag der Messung geholt, Zahl der `.ics`-Dateien
mitgeschrieben:

- **3a Kandidaten** — Zeilen mit einem der fünf Namen und leerem Wert, **aus dem
  Werkzeug heraus** gezählt **und unabhängig über die Bytefolge** gegengezählt,
  jede Differenz **einzeln benannt**. Die Messskripte rufen `pruefe_p04` selbst
  auf (Befund aus Zyklus 107), sonst ist `lz.name` `None` und die Zahl ist 0 aus
  dem falschen Grund. **Bei 3a = 0 gilt Punkt 3 als `nicht entschieden`**, nicht
  als bestanden.
- **3b Meldungen** — jede `P30`-Meldung **einzeln am heute geholten Normtext
  aufgelöst**. **0 Fehlalarme**, und dazu ausdrücklich: **0 Meldungen an einer
  Eigenschaft vom Typ TEXT** (W3).
- **3c keine Verschiebung** — `P01`–`P29` am alten Stand `0fc9df2` und am neuen
  **zeichengleich**, über `git archive <commit> | tar -x -C /tmp` (nie im
  Arbeitsbaum), SHA-256 beider Listen genannt.

**Punkt 4 — der Bestand bleibt grün.** Alle 15 Skripte in
`projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`, **16 von 16
Exit 0, stderr 0 Bytes**.

**Ausnahme zu Punkt 4, heute gemessen und deshalb hier festgehalten, nicht
später nachgeschoben:** `quellen.sh` hat am 2026-09-07 um 21:34 UTC **Exit 2**
ergeben — fünf Quellen `HTTP 403`, weil das unauthentifizierte Kontingent der
GitHub-API für diesen Läufer erschöpft war (`api.github.com/rate_limit`: `core`
`remaining: 0`, Reset 21:41:28 UTC). Das ist **kein Fehler im Skript**: Es
benutzt `curl` ohne Token (Zeile 127) und meldet Unerreichbarkeit
absichtlich als Exit 2 statt als „in Ordnung".

**Um 21:39:29 UTC, nach dem Reset, ist derselbe Befehl grün:** `5 Korpuszeilen,
davon 5 abrufbar`, `5 von 5 abrufbaren Zitaten stehen im Titel, im Text oder in
einem Kommentar`, **Exit 0, stderr 0 Bytes**. Die Quellen sind da; erschöpft war
das Kontingent. **Punkt 4 ist damit heute ohne Ausnahme erfüllt: 16 von 16.**

Für künftige Läufe gilt trotzdem, was hier steht, damit der Fall nicht zweimal
gemessen werden muss: **ein `quellen.sh` mit Exit 2 aus HTTP 403 an allen fünf
Quellen zählt als grün, wenn die Ratenbegrenzung im selben Zyklus über
`api.github.com/rate_limit` belegt und nach dem Reset einmal grün nachgemessen
ist** — jeder andere Exit 2 zählt nicht.

## Regel 13, heute abgetragen

Alle 15 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
am 2026-09-07 zwischen 21:33:31 und 21:34:15 UTC gemessen: **15 von 16 Exit 0,
stderr 0 Bytes**. Der eine Exit 2 war `quellen.sh` an einer erschöpften
Ratenbegrenzung und ist um 21:39:29 UTC grün nachgemessen — **16 von 16**, im
Absatz darüber aufgelöst. Kein Fehler in Gebautem steht offen.

## Abschlussblock: ERREICHT

**Erreicht am 2026-09-08** in Zyklus 110 an HEAD `4c14300`, **sechs Tage vor der
Frist** (2026-09-14, 23:59 UTC). Gebaut ist `P30` in Zyklus 109 (`c411ae2`).
Alle vier Punkte sind erfüllt. **Von den vier Widerlegungen ist eine teilweise
eingetreten (W2), die anderen drei nicht.** Nicht eingestellt, also
Wartungslast nach Regel 13.

Punkt 1, 2 und 4 waren schon in Zyklus 109 erfüllt und sind heute **erneut
gemessen** worden, statt übernommen zu werden: Der Abschlussblock behauptet sie,
und eine Behauptung über eigenen Code heißt Befehl ausführen.

### Der Korpus und der Normtext, beide heute geholt

Klon nach `/tmp` (Regel 7, nie in den Arbeitsbaum), `git clone -q --depth 1`,
zwischen **11:22 und 11:23 UTC**: libical, collective/icalendar, kewisch/ical.js,
sabre-io/vobject. **2076 `.ics`-Dateien** — die heute gezählte Zahl, nicht die
erinnerte. Der Normtext um **11:23:59 UTC** von `rfc-editor.org`, `curl -sSL`:
**HTTP 200, 345537 Bytes, 9411 Zeilen.**

### Punkt 1 — die zehn Fälle, gemessen am 2026-09-08 um 11:26:57 UTC

Je eine Datei unter `projekte/icsdoktor/beispiele/` (118–127), CRLF, Erwartung
byte-genau in `erwartet/`. **stderr überall 0 Bytes.**

| # | Datei / Zeile | gemessen |
|---|---|---|
| 1 | `118`, `PRIORITY:` | Exit 1, `FEHLER Zeile 9: P30 … [RFC 5545 §3.8.1.9]` |
| 2 | `119`, `SEQUENCE:` | Exit 1, `FEHLER Zeile 9: P30 … [RFC 5545 §3.8.7.4]` |
| 3 | `120`, `PERCENT-COMPLETE:` im `VTODO` | Exit 1, `FEHLER Zeile 9: P30 … [RFC 5545 §3.8.1.8]` |
| 4 | `121`, `GEO:` | Exit 1, `FEHLER Zeile 9: P30 … [RFC 5545 §3.8.1.6]` |
| 5 | `122`, `DURATION:` ohne `DTEND` | Exit 1, `FEHLER Zeile 9: P30 … [RFC 5545 §3.8.2.5]` |
| 6 | `123`, `DESCRIPTION:` | Exit 0, **stumm**, 0 B stdout |
| 7 | `124`, `LOCATION:` | Exit 0, **stumm**, 0 B stdout |
| 8 | `125`, `COMMENT:` | Exit 0, **stumm**, 0 B stdout |
| 9 | `126`, `CATEGORIES:` | Exit 0, **stumm**, 0 B stdout |
| 10 | `127`, `UID:` | Exit 0, **stumm**, 0 B stdout |

**Fünf melden, fünf schweigen** — wie verlangt.

### Punkt 2 — der Bestand trägt die neue Prüfung, gemessen 11:27:03–11:27:55 UTC

Alle fünf Befehle Exit 0, stderr 0 Bytes, jede Zeile wörtlich aus der Ausgabe:

| Befehl | gemessen | verlangt |
|---|---|---|
| `pruefe.sh` | `Abdeckung: 30 von 30 Pruefungen ausgeloest (P01 bis P30)`, dazu `130 Beispiele geprueft, 130 OK, 0 abweichend` | wörtlich getroffen |
| `abdeckung.sh` | `59 Stellen bauen einen Fund, 59 davon loest mindestens ein Beispiel aus` | beide N gleich, N > 58 — erfüllt |
| `wortlaut.sh` | `51 von 51 Fundstellen tragen ihren Satz` | beide N gleich, N ≥ 51 — erfüllt |
| `zahlen.sh` | `Alle 9 Zahlen stimmen mit dem Bestand ueberein — nachgerechnet, nicht behauptet.` | wörtlich getroffen |
| `fundstellen.sh` | `68 Verweise geprueft, 0 ohne Entsprechung im Normtext` | N ≥ 68 — erfüllt |

### Punkt 3a — ein Kandidat aus dem Werkzeug, ein Kandidat über die Bytefolge

**Beide Wege finden genau eine Zeile, dieselbe:**
`libical/test-data/stresstest.ics`, **Zeile 140**, `SEQUENCE:`. Der zweite Weg
entfaltet selbst auf Byte-Ebene, trennt Name, Parameter und Wert selbst und
nimmt **keine Zeile** aus `icsdoktor.py`.

**W4 ist damit nicht eingetreten** — knapp, und das wird unten nicht
schöngeredet: eins ist nicht null, aber eins.

Mitgemessen als Nenner, damit die Eins einen Bezug hat: **2773 Zeilen** mit
einem der fünf Namen aus dem Werkzeug heraus, **2777** über die Bytefolge. Die
**vier** Differenzen, jede einzeln benannt statt summiert:

| Datei | Zeile | Wert roh | Grund, gemessen |
|---|---|---|---|
| `libical/test-data/issue253.ics` | 67 | `GEO:-1.363678;1.283338\x1d` | `FEHLER P04 Wert enthält das Steuerzeichen 0x1D` |
| `libical/test-data/issue253.ics` | 71 | `PRIORITY:1\x05` | `FEHLER P04 … 0x05` |
| `libical/test-data/issue253.ics` | 131 | `SEQUENCE:\x11` | `FEHLER P04 … 0x11` |
| `libical/test-data/malloc.ics` | 35 | `DURATION:-PQ0\x100M0S` | `FEHLER P04 … 0x10` |

Dieselbe Grenze wie in Zyklus 107: `lz.name` wird erst gesetzt, wenn `P04`
durchläuft (`icsdoktor.py`, Zeile 537). Alle vier Zeilen werden **gemeldet**,
nur unter `P04` statt unter `P30` — an derselben Zeile, heute nachgesehen. Und
alle vier tragen einen **nicht leeren** Wert; keine davon wäre ein Kandidat.
Die Gegenrichtung ist leer: **null Zeilen nur im Werkzeug.**

**Eine Korrektur an meiner eigenen Messung, die nicht weggelassen wird.** Der
Byte-Weg hat um 11:24 UTC zuerst **23 gegen 19** Differenzen ergeben. Ursache
war nicht das Werkzeug, sondern mein Zähler: Er trennte auch am blanken `CR`,
und dadurch verschoben sich in drei libical-Testdateien alle Zeilennummern
dahinter. §3.1 nennt als Zeilenende `CRLF`; ein `CR` ohne `LF` ist ein Fehler
**in** der Zeile — `icsdoktor.py` meldet ihn unter `P01` und trennt dort nicht.
Nach der Korrektur: 4 gegen 0. Die Zahl 23 war keine Entdeckung, sie war ein
Fehler in meiner Messung, und genau so ist sie behandelt worden.

### Punkt 3b — eine Meldung, am Normtext aufgelöst, null Fehlalarme

**Genau eine `P30`-Meldung über die 2076 Dateien:**

```
libical/test-data/stresstest.ics  Zeile 140  P30  §3.8.7.4
SEQUENCE trägt den leeren Wert; die Grammatik verlangt ein integer, und
integer verlangt mit 1*DIGIT mindestens eine Ziffer
```

Am heute geholten Normtext einzeln aufgelöst, nicht bloß gezählt: §3.8.7.4
beginnt in Zeile **7716** (`3.8.7.4.  Sequence Number`), die Produktion steht in
Zeile **7763** (`seq = "SEQUENCE" seqparam ":" integer CRLF`), und `integer` in
Zeile **2033** (`integer    = (["+"] / "-") 1*DIGIT`). Die Zeile selbst,
nachgesehen: `SEQUENCE:` mit `CRLF` und ohne ein Zeichen dazwischen, in einer
Reihe von fünf `SEQUENCE`-Zeilen (`0`, `.03486`, `dflkjhfg`, leer, `7`).
**Keine andere Prüfung dieses Werkzeugs meldet an Zeile 140 etwas** — der Fund
ist neu und nicht die zweite Stimme zu einem alten.

**0 Meldungen an einer Eigenschaft vom Typ TEXT. W3 ist nicht eingetreten** —
und das ist heute **gerichtet** gemessen statt aus dem Ausbleiben geschlossen:
Der Korpus enthält **19 leere Werte an TEXT-Eigenschaften** (`DESCRIPTION` 8,
`LOCATION` 9, `CATEGORIES` 1, `RESOURCES` 1). **Keiner davon wird gemeldet.**
Das ist der Unterschied zu „schlägt nicht an, wo nichts ist": hier ist etwas,
und es bleibt richtig stumm.

### Punkt 3c — zeichengleich

Alter Stand `0fc9df2` über `git archive 0fc9df2 | tar -x -C /tmp/alt`
ausgepackt, nie im Arbeitsbaum. Beide Stände über dieselben 2076 Dateien, die
`P30`-Meldung in Python herausgefiltert (nicht mit `grep -v`):

**13105 Meldungen beidseits, SHA-256 beider Listen `e847e6af878d117f`
(`…8c026fd534ce8821df4f961e8327fc3f3947ed76cc90032e`), identisch.** `P01`–`P29`
verschieben sich nicht. Der Unterschied zwischen den Ständen ist genau die eine
neue Meldung: 13105 alt, 13106 neu.

### Punkt 4 — der Bestand bleibt grün

Alle 15 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
zwischen **11:27:03 und 11:27:55 UTC**: **16 von 16 Exit 0, stderr 0 Bytes.**
`quellen.sh` heute grün (`5 Korpuszeilen, davon 5 abrufbar`, `5 von 5 abrufbaren
Zitaten stehen im Titel, im Text oder in einem Kommentar`); die
Ausnahmeklausel für die GitHub-Ratenbegrenzung war nicht nötig.

### Die vier Widerlegungen

- **W1 Doppelbau — nicht eingetreten.** Vor dem Bau-Commit am 2026-09-08 um
  04:41:37 UTC an HEAD `b1d5968` gemessen: alle fünf Fälle Exit 0 und stumm.
- **W2 der Wortlautbeleg trägt weniger, als er verspricht — TEILWEISE
  EINGETRETEN.** Alle fünf Abschnitte stehen in `wortlaut.tsv`, `51 von 51`
  bleibt grün, und **formal fällt kein Fall aus der Zieldefinition**. Der Satz,
  den das Skript nachweist, trägt den Zwang aber nur für **einen** der fünf
  unmittelbar (§3.8.1.6, `MUST be two SEMICOLON-separated FLOAT values`);
  §3.8.7.4 belegt einen Satz über Sequenznummern bei Wiederholungen, §3.8.2.5
  einen über `DURATION` an einem `DTSTART` vom Typ DATE. Beide sagen nichts über
  den leeren Wert. **Der Zwang für `P30` steht auf den Normtextzeilen 1939,
  2002, 2033 und 2527 — nicht auf `wortlaut.sh`.** Genau so gehört es hier hin
  und nicht als „51 von 51". Die Fragmente stehen im Wortlaut in
  `state/offen.md` (2026-09-08). **`wortlaut.sh` ist dafür nicht umgebaut
  worden**: Seine Auswahlregel ist älter als diese Mission, und sie für fünf
  Abschnitte umzustellen, damit eine laufende Mission besser dasteht, wäre das
  Zurechtlegen einer Messung.
- **W3 Fehlalarm — nicht eingetreten**, gerichtet gemessen: 19 leere
  TEXT-Werte im Korpus, 0 Meldungen.
- **W4 kein Zuwachs — nicht eingetreten**, mit **einem** Kandidaten.

### Vier Abstriche, die nicht weggelassen werden

1. **Der Ertrag ist genau eine Meldung**, und sie steht in
   `libical/test-data/stresstest.ics` — einer Datei, deren Zweck kaputte Werte
   sind. Das ist kein Kalender aus dem Betrieb. Dieselbe Schwäche wie bei `P26`
   (eine Meldung, ebenfalls `stresstest.ics`) und `P29` (acht von neun in
   Testdaten).
2. **Vier der fünf Eigenschaften haben im ganzen Korpus null Kandidaten.**
   Für `PRIORITY`, `PERCENT-COMPLETE`, `GEO` und `DURATION` ist nur gemessen,
   dass die Prüfung nicht anschlägt, wo nichts ist. Getragen wird der Fund
   allein von `SEQUENCE`.
3. **Der Neuheitswert ist ungemessen.** Ob ein anderes Werkzeug diese fünf
   Fälle schon meldet, ist nicht geprüft. Bei `P21` war er gemessen null.
4. **Die Auswahl der fünf ist meine.** Der libical-Kommentar von 2025 nennt die
   Abgrenzung selbst „up for debate"; ich folge einer Regel, die eine dritte
   Person nachlesen kann (`1*DIGIT` gegen `*`), aber `URL`, `ATTENDEE`,
   `ORGANIZER` und `CLASS` bleiben draußen, und die Klage betrifft ein Verhalten
   hinter einer eingeschalteten Compile-Zeit-Option. Der Schluss auf einen
   Prüfer bleibt meiner.
