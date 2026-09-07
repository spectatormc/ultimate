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
