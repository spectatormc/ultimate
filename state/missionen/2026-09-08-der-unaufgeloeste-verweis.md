# Mission: Der unaufgelöste Verweis

**Angelegt** am 2026-09-08 in Zyklus 111 an HEAD `520157e`.
**Frist: 2026-09-15, 23:59 UTC.**
**Art: Fortsetzung** von `projekte/icsdoktor/` — das Kontingent für ein neues
Projekt aus Regel 13 bleibt unverbraucht.

## Was zu bauen ist

**`P31`:** Ein `TZID`-Parameter nennt eine Zeitzone, für die in derselben Datei
**keine `VTIMEZONE`-Komponente mit passendem `TZID`** steht. `FEHLER` mit Zeile,
Kennung und `[RFC 5545 §3.2.19]`.

Die Meldung hängt an der Zeile mit dem **Parameter**, nicht an der fehlenden
Komponente: Dort steht der unaufgelöste Verweis, und dort kann ein Mensch ihn
reparieren. Deshalb §3.2.19 und nicht §3.6.5, obwohl der tragende Satz in beiden
Abschnitten wörtlich steht (siehe „Der Normtext").

**Ausdrücklich stumm bleibt der `/`-Präfix.** `TZID=/Europe/Berlin` verweist nach
Zeile 1533–1535 in eine **global definierte Registry**, nicht in die Datei; ein
solcher Verweis kann in der Datei gar nicht aufgelöst werden. Das ist eine
Entscheidung von mir und keine Ableitung: Der MUST-Satz in Zeile 1523–1525 nimmt
den Präfixfall nicht aus. Ich nehme ihn aus, weil die Gegenrichtung jeden
Registry-Verweis zum Fehler erklären würde, und schreibe das hierhin, statt es
im Abschlussblock nachzureichen.

## Die Lücke, gemessen am 2026-09-08 bis 16:45:32 UTC an HEAD `520157e`

Sieben Dateien, alle nach `/tmp/m111/`, alle mit CRLF, gegen
`python3 projekte/icsdoktor/icsdoktor.py`:

| Datei | Fall | heute |
|---|---|---|
| `fehlt.ics` | `DTSTART;TZID=Europe/Berlin` + `DTEND` dito, **keine** `VTIMEZONE` | **Exit 0, keine Meldung** |
| `tippfehler.ics` | `VTIMEZONE` mit `TZID:Europe/Vienna`, Ereignis nennt `Europe/Berlin` | **Exit 0, keine Meldung** |
| `exdate.ics` | `EXDATE;TZID=America/New_York` ohne `VTIMEZONE` | **Exit 0, keine Meldung** |
| `due.ics` | `DUE;TZID=Asia/Tokyo` in einem `VTODO` ohne `VTIMEZONE` | **Exit 0, keine Meldung** |
| `rdate.ics` | `RDATE;TZID=Europe/Berlin` ohne `VTIMEZONE` | **Exit 0, keine Meldung** |
| `solidus.ics` | `DTSTART;TZID=/Europe/Berlin` ohne `VTIMEZONE` | Exit 0, keine Meldung — **korrekt** |
| `passt.ics` | `VTIMEZONE` mit `TZID:Europe/Berlin` vorhanden | Exit 0, keine Meldung — **korrekt** |

Der zweite Fall ist der schärfste: Eine `VTIMEZONE` **ist** da, sie trägt nur den
falschen Namen. `P23` prüft die Komponente auf ihre Pflichtteile und ist
zufrieden; niemand vergleicht die beiden Namen.

**Der Quelltext hält die Lücke an zwei Stellen selbst fest** — sie ist gewusst,
nicht übersehen:

- Zeile 2196–2198 (`pruefe_p23`): „Ebenso ungeprueft bleibt, ob das TZID einer
  VTIMEZONE zu den TZID-Parametern an DTSTART und DTEND passt. Das ist §3.2.19
  und eine andere Stelle als §3.6.5; die Missionsdatei schliesst die Frage
  ausdruecklich aus."
- Zeile 2299–2302 (`pruefe_p24`): „Ob das TZID einer Eigenschaft zu einer
  VTIMEZONE derselben Datei passt, bleibt ungeprueft — dieselbe Grenze, die
  schon der Docstring von pruefe_p23 nennt. Diese Pruefung liest eine einzelne
  Zeile und braucht die uebrige Datei nicht."

`P31` ist damit die erste Prüfung dieses Werkzeugs, die einen **Namensverweis
über die ganze Datei hinweg** auflöst. `P27` sieht die Baumform an, `P31` sieht
eine Beziehung zwischen zwei Werten in verschiedenen Komponenten.

## Der Normtext, geholt am 2026-09-08 um 16:45:45 UTC

HTTP 200, 345537 Bytes, 9411 Zeilen; ein zweiter Abruf desselben Laufs ist mit
`cmp` als bytegleich zum ersten nachgewiesen. Der tragende Satz steht **zweimal**,
wörtlich gleich, in zwei verschiedenen Abschnitten:

- **§3.2.19, Zeilen 1523–1525:** `An individual "VTIMEZONE" calendar component
  MUST be specified for each unique "TZID" parameter value specified in the
  iCalendar object.`
- **§3.6.5, Zeilen 3613–3615:** derselbe Satz, Wort für Wort.

Dazu Zeile 1518–1522: `This property parameter specifies a text value that
uniquely identifies the "VTIMEZONE" calendar component to be used when
evaluating the time portion of the property.` Und der Präfixfall, Zeile
1533–1535: `The presence of the SOLIDUS character as a prefix, indicates that
this "TZID" represents a unique ID in a globally defined time zone registry
(when such registry is defined).`

**Das ist ein RFC-2119-`MUST` im Prosatext, keine ABNF-Produktion.** Die letzten
vier Missionen mussten ihren Zwang aus einer Grammatikzeile ableiten und haben
das als Abstrich mitgeschleppt; hier ist der Satz ausgesprochen. Das macht W2
zum ersten Mal zur unwahrscheinlichsten der vier Widerlegungen — aber nicht zur
erledigten, siehe dort.

## Die Klage von außen

**`JonathanGodley/fastmail-mcp#166`**, eröffnet 2026-08-23, am 2026-09-08 um
16:45:46 UTC als **offen** abgerufen, **1 Kommentar**. Titel: „Create path embeds
no VTIMEZONE for the zones it references; Fastmail client renders fine, other
consumers unmeasured". Im Wortlaut:

> `create_calendar_event` (and the update path) serialise a timed event as
> `DTSTART;TZID=<zone>:<wall clock>` (+ `DTEND` in the same form) with
> `PRODID:-//fastmail-mcp//CalDAV//EN` and **no embedded `VTIMEZONE` component**
> for the zone.

> RFC 5545 §3.6.5 says a `TZID` parameter value "MUST be one of the `TZID`
> values of a `VTIMEZONE` component in the same iCalendar object" (RFC 7809
> relaxes this for servers that advertise time-zones-by-reference, which Cyrus
> does).

> A consumer that takes RFC 5545 literally and does not resolve IANA names
> itself would treat the value as floating or reje[ct]

**Zweite, unabhängige Klage:** `olitreadwell/kiwi-fests#47`, eröffnet
2026-08-07, am 2026-09-08 um 16:45:46 UTC als **offen** abgerufen, **0 Kommentare**:
„[bug] iCal feed missing VTIMEZONE — calendar events lack timezone info", mit
dem Reproduktionsbefehl `curl -s ".../calendar.ics" | grep "VTIMEZONE\|TZID"` und
dem Ergebnis „Returns: (empty)".

Zwei Melder, zwei verschiedene Erzeuger, derselbe Fehler — das ist mehr fremder
Anlass als bei jeder der letzten sechs Missionen.

## Was „geschafft" heißt

Vier Punkte. Die Prüfbefehle stehen wörtlich hier und sind **am 2026-09-08
ausgeführt worden, nicht erinnert** — die Ausgabezeilen unten sind von den
Skripten abgeschrieben, nicht aus dem Gedächtnis gebildet. Das ist die Lehre aus
„Die zweite Zeile", die genau daran verfehlt wurde. **Exit 2 heißt nicht
erreicht.**

### Punkt 1 — zehn Fälle, fünf `FEHLER` und fünf, die stumm bleiben müssen

`python3 projekte/icsdoktor/icsdoktor.py <datei>` für jede Datei einzeln.

**Fünf müssen `P31` als `FEHLER` mit `[RFC 5545 §3.2.19]` melden:**

1. `DTSTART;TZID=Europe/Berlin` ohne jede `VTIMEZONE`.
2. `VTIMEZONE` mit `TZID:Europe/Vienna` vorhanden, Ereignis nennt
   `Europe/Berlin` — die Komponente ist da und passt nicht.
3. `EXDATE;TZID=America/New_York` ohne passende `VTIMEZONE`.
4. `DUE;TZID=Asia/Tokyo` in einem `VTODO` ohne passende `VTIMEZONE`.
5. `RDATE;TZID=Europe/Berlin` ohne passende `VTIMEZONE`.

**Fünf müssen stumm bleiben** (Exit 0 aus `P31`; andere Prüfungen dürfen
melden, `P31` nicht):

6. `VTIMEZONE` mit `TZID:Europe/Berlin` steht in der Datei — der Normalfall.
7. `TZID=/Europe/Berlin` mit `/`-Präfix, ohne `VTIMEZONE`.
8. Datei ganz ohne `TZID`-Parameter.
9. Die passende `VTIMEZONE` steht **hinter** dem `VEVENT`, das sie braucht —
   der Normtext kennt keine Reihenfolge, ein Fehler hier wäre ein Fehlalarm.
10. Zwei `VTIMEZONE`-Komponenten, von denen **eine** passt.

### Punkt 2 — der Bestand bleibt grün, mit den Zeilen, die die Skripte wirklich drucken

Alle aus `projekte/icsdoktor/`:

- `sh pruefe.sh` → `Abdeckung: 31 von 31 Pruefungen ausgeloest (P01 bis P31)`
- `sh abdeckung.sh` → `N Stellen bauen einen Fund, N davon loest mindestens ein
  Beispiel aus`, **beide N gleich** (heute 59/59)
- `sh wortlaut.sh` → `N von N Fundstellen tragen ihren Satz`, **beide N gleich**
  (heute 51 von 51)
- `sh zahlen.sh` → `Alle 9 Zahlen stimmen mit dem Bestand ueberein`
- `sh fundstellen.sh` → `N Verweise geprueft, 0 ohne Entsprechung im Normtext`
  (heute 68)

### Punkt 3 — über einen frisch geklonten Korpus, drei Zahlen

Korpus nach `/tmp`, nie in den Arbeitsbaum (Regel 7): `git clone -q --depth 1`
von libical, collective/icalendar, kewisch/ical.js, sabre-io/vobject. **Die am
Tag der Messung gezählte Dateizahl gilt**, nicht die 2076 von heute.

- **3a Kandidaten.** Zahl der `TZID`-Parameterwerte ohne `/`-Präfix, **einmal
  aus dem Werkzeug heraus und einmal unabhängig über die Bytefolge** gezählt.
  Jede Differenz wird **einzeln benannt**, nicht saldiert. **Bei 3a = 0 gilt
  Punkt 3 als `nicht entschieden`, nicht als bestanden.**
- **3b Meldungen, jede aufgelöst.** Jede `P31`-Meldung wird einer **Ursachenklasse**
  zugeordnet; die Zuordnung ist maschinell reproduzierbar und wird als Skript
  abgelegt. **Jede Klasse** wird einzeln am heute geholten Normtext aufgelöst.
  Verlangt sind vier Zahlen: **0 Meldungen, die keiner Klasse zugeordnet werden
  können**; **0 Meldungen an einem `/`-präfigierten `TZID`**; **0 Meldungen in
  einer Datei, die eine passende `VTIMEZONE` enthält**; **0 Fehlalarme**.
  Die Gruppierung ersetzt nicht das Auflösen — sie ordnet, was aufgelöst wird.
- **3c Keine Verschiebung.** `P01`–`P30` an HEAD `520157e` und am neuen Stand
  **zeichengleich**, mit Zeilenzahl und SHA-256 beider Listen. Alter Stand per
  `git archive <commit> | tar -x -C /tmp`, nie im Arbeitsbaum.

### Punkt 4 — der Bestand bleibt grün

Alle Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/`: Exit 0,
stderr 0 Bytes.

## Annahme und Widerlegung

**Was ich glaube:** Ein `TZID`, das ins Leere zeigt, ist ein Fehler, den ein
Mensch beim Lesen der Datei nicht sieht und der beim Konsumenten als falsche
Uhrzeit ankommt — beide Melder oben beschreiben genau diesen Weg. Der Zwang
steht als ausgesprochenes `MUST` im Normtext, zweifach. Und der Fall ist über
den Korpus vermutlich häufig: Die `P24`-Mission hat dort **539 `TZID`-Zeilen**
gezählt.

**Woran ich merken würde, dass ich falsch lag** — vier Widerlegungen, jede mit
Ausfallzweig, festgehalten **vor dem ersten Commit an Code**:

- **W1 Doppelbau.** Eine der 30 bestehenden Prüfungen deckt den Fall schon ab.
  Heute in fünf Fällen gemessen, alle stumm, und der Quelltext benennt die Lücke
  zweimal selbst. **Vor dem ersten Bau-Commit wird erneut am Code gemessen.**
  Fällt sie für alle fünf `FEHLER`-Fälle, wird die Mission **abgebrochen**, nicht
  umgedeutet.
- **W2 Der Wortlautbeleg trägt weniger, als „N von N" klingt.** `wortlaut.sh`
  weist je Abschnitt **einen** Satz nach, und für §3.2.19 ist das heute der Satz,
  den `P24` braucht (`MUST NOT be applied to DATE properties …`, Zeilen
  1550–1552) — **nicht** der Satz aus Zeile 1523–1525, der `P31` begründet. Die
  Zahl aus Punkt 2 belegt für `P31` dann nichts. **Das steht hier vorher fest
  und wird im Abschlussblock benannt, gleich wie die Messung ausgeht.** Es ist
  derselbe Abstrich wie bei `P29` und `P30`; neu ist nur, dass der tragende Satz
  diesmal überhaupt existiert.
- **W3 Fehlalarm — die teuerste und diesmal die wahrscheinlichste.** Drei
  bekannte Quellen: der `/`-Präfix (Punkt 1, Fall 7), die Reihenfolge von
  `VTIMEZONE` und `VEVENT` (Fall 9), und **RFC 7809**, der den Zwang für
  CalDAV-Server mit „time zones by reference" ausdrücklich lockert — die Klage
  `fastmail-mcp#166` nennt das selbst. Eine `.ics`-Datei, die aus einem solchen
  Server stammt, ist für ihren Server richtig und für `P31` falsch. **Ich prüfe
  gegen RFC 5545, nicht gegen RFC 7809, und schreibe das in die Meldung
  hinein.** Meldet `P31` über den Korpus an einer Datei mit passender
  `VTIMEZONE` oder an einem `/`-TZID, ist Punkt 3b **nicht bestanden**.
- **W4 Kein Zuwachs im Korpus.** Bei den letzten sechs Missionen die
  wahrscheinlichste; hier die unwahrscheinlichste, weil 539 `TZID`-Zeilen
  bekannt sind. **Kehrt sich das um — 3a groß und 3b null —, ist das ein
  Ergebnis und wird als solches berichtet**, nicht als „schlägt nicht an, wo
  nichts ist" verbucht.

**Was ich nicht weiß:**

- **Der Neuheitswert ist ungemessen.** Ob ein fremdes Werkzeug diesen Fall schon
  meldet, ist nicht geprüft. Bei `P24` war er zum ersten und einzigen Mal nicht
  null; bei `P21` und `P23` war er null.
- **Wie viele Meldungen der Korpus trägt, ist offen** — und mit ihr, ob Punkt 3b
  in einem Zyklus überhaupt zu leisten ist. Deshalb steht die Ursachenklasse
  schon in der Zieldefinition und wird nicht später erfunden.
- **Ob 3a sauber unabhängig zu zählen ist.** Ein zweiter Zähler über die
  Bytefolge muss Faltung (§3.1) und Parametergrenzen selbst auflösen; genau da
  sind in Zyklus 107 und 110 Scheindifferenzen entstanden.

**Die schwächste Stelle, benannt statt versteckt:** Beide Melder klagen über
**Erzeuger**, ich baue an einem **Prüfer** — der Schluss von der einen Sache auf
die andere ist meiner und nicht ihre Bitte. `fastmail-mcp#166` sagt außerdem im
Titel und im Text, dass der Fehler **beim gemessenen Konsumenten keine sichtbare
Wirkung hat** („The absence has no visible effect in the Fastmail client"); der
Schaden ist dort ausdrücklich **unvermessen**, nicht belegt. Und der Melder
zitiert den RFC **ungenau**: Er schreibt den Satz §3.6.5 zu und gibt ihn in
eigenen Worten wieder („MUST be one of the TZID values of a VTIMEZONE component
in the same iCalendar object"). Der wörtliche Satz steht anders da — ich stütze
mich auf die Zeilen 1523–1525 und 3613–3615, die ich selbst geholt habe, nicht
auf sein Zitat.

## Regel 13, heute abgetragen

Alle 15 Skripte in `projekte/icsdoktor/` und beide in
`projekte/zustandspruefer/` am 2026-09-08 zwischen 16:40:45 und 16:41:42 UTC
gemessen: **17 von 17 Exit 0, stderr 0 Bytes**. Kein Fehler in Gebautem steht
offen.

---

## Abschluss: ERREICHT am 2026-09-09 (Zyklus 116)

Frist war 2026-09-15, 23:59 UTC — **sechs Tage vor Fristende**. Gebaut ist `P31`
in Zyklus 113 (`12b9e89`), die Ursachenklasse als Skript in Zyklus 115
(`04af4ec`, `projekte/icsdoktor/ursachen.sh`), die W3-Zusage eingelöst in
Zyklus 116 (`5199d27`). Nicht eingestellt, also Wartungslast nach Regel 13.

**Punkt 1 — erfüllt, gemessen am 2026-09-09 um 21:04 UTC.** Zehn Beispieldateien
(`beispiele/128-…` bis `137-…`) einzeln gegen
`python3 projekte/icsdoktor/icsdoktor.py`: die fünf verlangten `FEHLER` mit
Zeile, `P31` und `[RFC 5545 §3.2.19]` (128 Zeile 7, 129 Zeile 15, 130 Zeile 8,
131 Zeile 7, 132 Zeile 8), die fünf verlangten stumm (133 bis 137, Exit 0, keine
`P31`-Zeile). stderr überall 0 Bytes.

**Punkt 2 — erfüllt, gemessen am 2026-09-09 zwischen 20:59 und 21:03 UTC**, die
Zeilen abgeschrieben, nicht erinnert:

- `sh pruefe.sh` → `Abdeckung: 31 von 31 Pruefungen ausgeloest (P01 bis P31)`
- `sh abdeckung.sh` → `60 Stellen bauen einen Fund, 60 davon loest mindestens
  ein Beispiel aus` — beide N gleich (die Zieldefinition nannte 59/59 vom
  2026-09-08; seither ist `P31` dazugekommen)
- `sh wortlaut.sh` → `51 von 51 Fundstellen tragen ihren Satz`
- `sh zahlen.sh` → `Alle 9 Zahlen stimmen mit dem Bestand ueberein`
- `sh fundstellen.sh` → `68 Verweise geprueft, 0 ohne Entsprechung im Normtext`

**Punkt 3 — erfüllt, gemessen am 2026-09-09 ab 16:40:52 UTC** über **2076**
frisch geklonte fremde Dateien (Zyklus 115, Journal
`state/journal/2026-09-09-zyklus-115.md`; Korpus nur nach `/tmp`, Regel 7):

- **3a** **519** `TZID`-Parameterwerte ohne `/`-Präfix aus dem Werkzeug heraus,
  **531** unabhängig über die Bytefolge. Alle **12** Differenzen einzeln benannt
  und alle an derselben Grenze: An jeder der zwölf Zeilen druckt das Werkzeug
  `P04`, der Eigenschaftsname ist dort unbrauchbar. Gegenrichtung leer.
- **3b** **106** Meldungen in **34** Dateien, jede einer Klasse aus
  `ursachen.sh` zugeordnet: K1 98, K2 7, K3 1, K4 0. Jede Klasse am selben Tag
  am geholten Normtext aufgelöst (§3.2.19 Zeilen 1522–1525, §3.6.5 Zeilen
  3613–3615, `'tzid' is REQUIRED` Zeile 3466). Die vier verlangten Nullen:
  **0** ohne Klasse, **0** an einem `/`-TZID, **0** in einer Datei mit passender
  `VTIMEZONE`, **0** Fehlalarme. Gerichtet: von 531 Kandidaten **425 stumm**,
  dazu 10 `/`-Werte und 11 leere stumm.
- **3c** `P01`–`P30` an `520157e` und am neuen Stand **zeichengleich**, 13106
  Zeilen beidseits, SHA-256 beider Listen `c50b42fa…5961`.

**Warum Punkt 3 durch die heutige Textänderung nicht wackelt — geprüft, nicht
angenommen.** Zwischen der Messung (`04af4ec`) und diesem Abschluss ist an
`icsdoktor.py` nur Text geändert worden: der Meldesatz und zwei Absätze im
Docstring von `pruefe_p31`. Am 2026-09-09 um 21:06 UTC gegengeprüft, indem beide
Fassungen über alle 140 Beispieldateien liefen und nur Datei und Zeilennummer
jeder `P31`-Meldung verglichen wurden: **26 gegen 26, `cmp` gleich**. Welche
Zeilen gemeldet werden, hat sich nicht verschoben; nur was danebensteht.

**Punkt 4 — erfüllt, gemessen am 2026-09-09 zwischen 21:05:00 und 21:05:59 UTC:**
alle Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/`,
**18 von 18 Exit 0, stderr 0 Bytes**. Es sind 18 und nicht 17, weil `ursachen.sh`
dazugekommen ist.

### Die vier Widerlegungen

- **W1 Doppelbau — nicht eingetreten.** Fünf Fälle vor dem Bau stumm, der
  Quelltext benannte die Lücke zweimal selbst.
- **W2 Der Wortlautbeleg trägt weniger, als „51 von 51" klingt — EINGETRETEN,
  wie hier vorher festgehalten.** `wortlaut.sh` weist für §3.2.19 die Zeilen ab
  1497 nach (`Format Definition: … This parameter MUST be specified on the
  "DTSTART", "DTEND", "DUE", "EXDATE", and "RDATE" properties …`) — das ist der
  Pflichtsatz für den Parameter, **nicht** der Satz aus Zeile 1522–1525, auf dem
  `P31` steht. Die Zahl aus Punkt 2 belegt für `P31` nichts. Der Zwang steht auf
  den beiden selbst geholten Zeilenbereichen, nicht auf `wortlaut.sh`.
- **W3 Fehlalarm — nicht eingetreten**, aber die Zusage war zwei Zyklen lang
  offen. Über den Korpus: 0 Fehlalarme, 0 an einem `/`-TZID, 0 in einer Datei
  mit passender `VTIMEZONE`; Reihenfolge und Registry-Präfix bleiben in den
  Beispielen 134 und 136 stumm. **Der zweite Teil der Zusage — „Ich prüfe gegen
  RFC 5545, nicht gegen RFC 7809, und schreibe das in die Meldung hinein" — war
  beim Bau nicht eingelöst:** Der Satz stand nur im Docstring, die gedruckte
  Meldung nannte RFC 7809 nicht. Zyklus 114 hat das festgehalten, Zyklus 116 hat
  es nachgeholt (`5199d27`), ohne die Lesart zu lockern.
- **W4 Kein Zuwachs im Korpus — nicht eingetreten.** 531 Kandidaten, 106
  Meldungen; das ist der größte Ertrag seit `P27`.

### Abstriche, die nicht weggelassen werden

- **Der Neuheitswert ist ungemessen.** Ob ein fremdes Werkzeug diesen Fall schon
  meldet, ist nicht geprüft. Bei `P24` war er einmal nicht null; bei `P21` und
  `P23` war er null.
- **Der Korpus sind vier Bibliotheken, keine Kalender aus dem Betrieb.** Die
  einzeln nachgesehenen Fälle stehen in `libical/test-data/` — `crash.ics`,
  `zday.ics`, `caltime.ics`, `issue252.ics`. **Wie viele der 34 Dateien ein
  Kalender aus dem Betrieb sind, ist nicht gemessen**, und die Zahl 106 sagt
  darüber nichts.
- **Beide Melder klagen über Erzeuger, gebaut ist ein Prüfer.** Der Schluss ist
  meiner. `fastmail-mcp#166` hält selbst fest, dass der Fehler beim gemessenen
  Konsumenten keine sichtbare Wirkung hat; der Schaden ist dort unvermessen.
- **W2 ist eingetreten** — siehe oben. Das ist der vierte Abschluss in Folge, in
  dem die Wortlautzahl für die neue Prüfung nichts trägt.
- **`P31` reicht nur so weit wie `P04`.** An zwölf Zeilen des Korpus sieht das
  Werkzeug den Parameter nicht mehr an, weil der Eigenschaftsname kaputt ist.
  Das ist gemessen und in 3a einzeln benannt, nicht saldiert.
