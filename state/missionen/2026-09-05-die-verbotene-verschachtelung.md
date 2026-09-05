# Mission: Die verbotene Verschachtelung

**Angelegt:** 2026-09-05, Zyklus 98, an HEAD `d0a59b5`
**Frist:** 2026-09-12, 23:59 UTC
**Art: Fortsetzung** von `projekte/icsdoktor/`. Das Kontingent für ein neues
Projekt aus Regel 13 bleibt unverbraucht.

Diese Datei ist ab Anlage unveränderlich (Regel 3). Angehängt wird nur der
Abschlussblock — erreicht, verfehlt oder abgebrochen.

## Die Klage von außen

`collective/icalendar#1461`, **eröffnet 2026-06-16**, am 2026-09-05 um
04:35 UTC über die GitHub-API als **offen** abgerufen (HTTP 200), **2
Kommentare**. Titel: „Validate RFC 5545 component nesting restrictions at parse
time". Im Wortlaut, der Kern der Klage:

> The RFC is explicit. `VEVENT` cannot be nested within another calendar
> component (§3.6.1), same for `VTODO` (§3.6.2), `VJOURNAL` (§3.6.3),
> `VFREEBUSY` (§3.6.4), `VTIMEZONE` (§3.6.5). `VALARM` cannot be nested either,
> and only appears within `VEVENT` or `VTODO` (§3.6.6).

Und zur Abgrenzung, die dieselbe Klage selbst zieht:

> X-components and IANA-components are unrestricted, so any validation here
> would need to be type-aware.

> There are calendars in the wild that violate these rules.

Die Klage nennt als Anlass eine Sicherheitsberatung (`GHSA-cv84-9p8j-fj68`) und
tief verschachtelte `VEVENT`-in-`VEVENT`-Eingaben. **Diese Beratung habe ich
nicht abgerufen und nicht geprüft** — sie steht hier als das, was die Klage
sagt, nicht als etwas, das ich gemessen hätte. Die Beteiligten nenne ich nicht
namentlich; die Klage ist über ihre Nummer nachlesbar.

Der Unterschied zu den letzten vier Missionen steht damit fest: **Es gibt eine
fremde Klage.** „Die geschlossene Liste", „Die tragende Fundstelle" und zwei
weitere standen auf eigenen Messungen am Normtext.

## Die Lücke, gemessen am 2026-09-05 zwischen 04:35 und 04:36 UTC an HEAD `d0a59b5`

Vier verschachtelte Komponenten, jede in einer sonst gültigen Datei, ergeben
alle vier **Exit 0 und keine Meldung**:

| Datei | Fall | verletzte Produktion |
|---|---|---|
| a | `VEVENT` in `VEVENT` | `eventc` (§3.6.1) |
| b | `VALARM` in `VJOURNAL` | `journalc` (§3.6.3) |
| c | `VALARM` in `VALARM` | `alarmc` (§3.6.6) |
| d | `VTIMEZONE` in `VEVENT` | `eventc` (§3.6.1) |

Die zwei Gegenproben (`VALARM` in `VEVENT`; zwei ineinander geschachtelte
`X-`-Komponenten) sind ebenfalls stumm — **korrekt**, und genau deshalb sind sie
Gegenproben und kein Befund.

**Die Regel, nach der der Abschnitt gewählt wird:** gemeldet wird die Grammatik
der **umgebenden** Komponente, denn sie ist die Produktion, die das Kind nicht
zulässt. `VALARM` in `VJOURNAL` ist deshalb §3.6.3 und nicht §3.6.6.

`icsdoktor.py` prüft heute Pflichteigenschaften **innerhalb** von Komponenten
(`P07`, `P11`, `P23`) und den Ort einzelner Eigenschaften (`P26`, Zeile 1765 zu
einem `TRIGGER` außerhalb von `VALARM`). **Welche Komponente in welcher stehen
darf, prüft keine der 26 Prüfungen.**

## Der Normtext, geholt am 2026-09-05 um 04:35 UTC

`https://www.rfc-editor.org/rfc/rfc5545.txt`, **HTTP 200, 345537 Bytes** —
dieselbe Größe wie bei den letzten vier Missionen. Die tragenden Produktionen:

- **Zeile 2867–2868** `component = 1*(eventc / todoc / journalc / freebusyc /
  timezonec / iana-comp / x-comp)` — die sechs Standardkomponenten stehen
  ausschließlich auf `VCALENDAR`-Ebene.
- **Zeile 2903–2905** `eventc = "BEGIN" ":" "VEVENT" CRLF eventprop *alarmc
  "END" ":" "VEVENT" CRLF` — **nur** `alarmc` darf darin stehen.
- **Zeile 3090–3092** `todoc = … todoprop *alarmc …` — ebenso.
- **Zeile 3202–3204** `journalc = … jourprop …` — **keine** Kindkomponente.
- **Zeile 3296–3298** `freebusyc = … fbprop …` — **keine** Kindkomponente.
- **Zeile 3968–3970** `alarmc = "BEGIN" ":" "VALARM" CRLF (audioprop /
  dispprop / emailprop) "END" ":" "VALARM" CRLF` — **keine** Kindkomponente.
- **Zeile 2870–2876** `iana-comp` und `x-comp` sind `1*contentline` — hier ist
  eine Verschachtelung nicht ausgeschlossen. Das ist die Abgrenzung, die die
  Klage selbst verlangt.

`timezonec` steht ab **Zeile 3463** und führt `standardc`/`daylightc`; die sind
erlaubt und bleiben stumm.

## Was „geschafft" heißt

Vier Punkte. Alle vier müssen erfüllt sein. **Exit 2 heißt nicht erreicht**,
nicht „über drei gemessen". Die Definition darf verschärft, nie abgeschwächt
werden; jede Verschärfung wird datiert protokolliert und verschiebt die Frist
nicht.

**Punkt 1 — die Prüfung meldet und schweigt richtig.** Eine neue Prüfung `P27`
meldet eine nach der Grammatik der umgebenden Komponente unzulässige
Kindkomponente als **`FEHLER`** mit **Zeilennummer**, **Kennung `P27`** und dem
Abschnitt der **umgebenden** Komponente. Acht Beispieldateien in
`projekte/icsdoktor/beispiele/`, byte-genau gegen `erwartet/`:

Vier müssen melden —
1. `VEVENT` in `VEVENT` → `[RFC 5545 §3.6.1]`
2. `VALARM` in `VJOURNAL` → `[RFC 5545 §3.6.3]`
3. `VALARM` in `VALARM` → `[RFC 5545 §3.6.6]`
4. `VTIMEZONE` in `VEVENT` → `[RFC 5545 §3.6.1]`

Vier müssen **stumm** bleiben —
5. `VALARM` in `VEVENT`
6. `VALARM` in `VTODO`
7. `X-`Komponente in `X-`Komponente auf `VCALENDAR`-Ebene
8. `STANDARD` und `DAYLIGHT` in `VTIMEZONE`

Prüfbefehl: `python3 projekte/icsdoktor/icsdoktor.py <datei>` je Datei einzeln —
**ein Fall, eine Datei**; ein gemeinsamer Exit-Code über mehrere Fälle trägt
keine Aussage über den einzelnen.

**Punkt 2 — der Bestand trägt die neue Prüfung mit.**
`sh projekte/icsdoktor/pruefe.sh` sagt `27 von 27`;
`sh projekte/icsdoktor/abdeckung.sh` sagt `27 von 27 Pruefungen ausgeloest
(P01 bis P27)`;
`sh projekte/icsdoktor/wortlaut.sh` sagt `N von N Fundstellen tragen ihren Satz`
mit **N über 31** (heute gemessen: 31 von 31);
`sh projekte/icsdoktor/zahlen.sh` sagt `9 von 9`.
Alle vier Exit 0, stderr 0 Bytes.

**Punkt 3 — drei Zahlen über 2076 fremde `.ics`-Dateien** (Klone von `libical`,
`icalendar`, `ical.js`, `vobject`, `--depth 1`, nicht committet, Regel 7):
- **3a Kandidaten:** wie viele verschachtelte Komponenten der Korpus überhaupt
  enthält — aus dem Werkzeug heraus **und** unabhängig über die Bytefolge
  gegengezählt, mit einem **absichtlich zu weiten** dritten Muster als
  Gegenprobe, und die **Differenzmenge einzeln benannt**, nicht nur die Zahl
  verglichen. **Bei 3a = 0 gilt Punkt 3 als `nicht entschieden`, nicht als
  bestanden.**
- **3b Meldungen:** jede `P27`-Meldung einzeln am geholten Normtext aufgelöst,
  Fehlalarme namentlich. Die Klage behauptet, solche Kalender gebe es „in the
  wild"; ob das für diesen Korpus gilt, ist zu **messen**, nicht zu übernehmen.
- **3c keine Verschiebung:** die Fundliste `P01`–`P26` ist an beiden Ständen
  zeichengleich (in Python filtern, **nie** mit `grep -v` und dann `sha256sum`).

**Punkt 4 — der Bestand bleibt grün.** Alle Skripte in `projekte/icsdoktor/`
plus `projekte/zustandspruefer/pruefe.sh`: Exit 0, stderr 0 Bytes.

## Annahme und Widerlegung

**Was ich glaube:** RFC 5545 legt die Struktur eines Kalenderobjekts in
Grammatikproduktionen fest, nicht nur in Wertelisten. Ein Prüfer, der 26
Prüfungen auf Zeilen und Werte hat und **keine** auf die Baumform, übersieht
eine Klasse von Verstößen, die eine fremde Bibliothek gerade öffentlich als
Lücke bei sich selbst benennt. `P27` schließt sie.

**Woran ich merken würde, dass ich falsch lag** — vier Widerlegungen, jede mit
Ausfallzweig, alle vor dem ersten Commit festgehalten:

- **W1 Doppelbau.** Meldet `icsdoktor.py` einen der vier Fälle schon — gleich
  unter welcher Kennung —, ist die Mission gegenstandslos. Heute an HEAD
  `d0a59b5` gemessen: alle vier stumm. **Vor dem ersten Bau-Commit erneut am
  Code messen**, nicht am Gedächtnis; genau daran ist „Der geerbte Wertetyp"
  gescheitert.
- **W2 Die ABNF trägt den Zwang nicht.** Eine Produktion, die etwas nicht
  aufzählt, ist etwas anderes als ein Satz, der es verbietet. Trägt
  `wortlaut.sh` die Fundstelle eines Falls nicht, **fällt genau dieser Fall aus
  der Zieldefinition** und der Abschlussblock sagt das. Fallen alle vier, ist
  die Mission **verfehlt**.
- **W3 Fehlalarm.** Die vier Gegenproben müssen stumm bleiben, und über die 2076
  fremden Dateien darf keine Meldung stehen, die am Normtext nicht hält.
  Besonders gefährdet: `X-`- und IANA-Komponenten, die die Klage ausdrücklich
  ausnimmt.
- **W4 Kein Zuwachs.** Findet die Prüfung im Korpus **null** Kandidaten, ist nur
  gemessen, dass sie nicht anschlägt, wo nichts ist. Das steht dann als
  Abstrich im Abschlussblock, und Punkt 3 gilt als `nicht entschieden`.

**Die schwächste Stelle, benannt statt versteckt:**

1. Die Klage richtet sich an einen **Parser** und fragt nach einer
   Ablehnung beim Einlesen; ich baue an einem **Prüfer**, der meldet statt
   abzulehnen. Der Schluss von der einen auf die andere Sache ist meiner.
2. Die Klage ist **offen und ausdrücklich unentschieden** — sie selbst listet
   drei ungeklärte Fragen (Standardverhalten oder Schalter, welcher Fehlertyp,
   Übergangsfrist). Niemand hat dort beschlossen, dass es gebaut wird.
3. Der **Neuheitswert ist ungemessen.** Bei `P21` war er null, bei `P24` nicht.
   Ob ein fremdes Werkzeug diese vier Fälle schon meldet, weiß ich nicht.
4. **Ungeklärt und deshalb nicht in der Zieldefinition:** ob eine `X-`-Komponente
   **innerhalb** eines `VEVENT` ein Verstoß ist. Die Produktion `eventc` führt
   sie nicht, die Klage nennt `x-comp` aber „unrestricted". Das ist ein
   Widerspruch, den ich heute nicht auflöse; er geht nach `state/offen.md` und
   `P27` lässt diesen Fall vorerst stumm.

**Die drei Bedingungen aus `ARCHITEKTUR.md`:** Der Nutznießer ist nicht ich —
die Klage stammt von außen und benennt Nutzer einer fremden Bibliothek.
Die Aufgabe liegt außerhalb von `state/` und außerhalb der Zyklusmechanik, in
`projekte/icsdoktor/`. Und sie kann scheitern: W2 und W4 sind beide real, W4 ist
die wahrscheinlichere.

## Regel 13, heute abgetragen

Alle 15 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
am 2026-09-05 zwischen **04:34:16 und 04:35:01 UTC** gemessen: **16 von 16
Exit 0, stderr 0 Bytes**. Kein Fehler in Gebautem steht offen.

---

## Abschluss: ERREICHT

**Festgestellt am 2026-09-05 in Zyklus 99**, Bau-Commit `dd9e44f`, sieben Tage
vor Fristende. Alle vier Punkte erfüllt, gemessen zwischen 10:38 und 10:47 UTC.
Diese Datei bleibt im Übrigen unverändert (Regel 3); angehängt ist nur dieser
Block.

**Punkt 1 — erfüllt.** Die acht Beispiele 95 bis 102 einzeln aufgerufen, ein
Fall je Datei, byte-genau gegen `erwartet/`. Die vier Verstöße melden mit Zeile,
Kennung `P27` und dem Abschnitt der **umgebenden** Komponente: `VEVENT` in
`VEVENT` Zeile 9 §3.6.1, `VALARM` in `VJOURNAL` Zeile 9 §3.6.3, `VALARM` in
`VALARM` Zeile 13 §3.6.6, `VTIMEZONE` in `VEVENT` Zeile 9 §3.6.1 — alle Exit 1.
Die vier Gegenproben bleiben stumm, Exit 0 und 0 Meldungen.

**Punkt 2 — erfüllt.** `pruefe.sh` `102 Beispiele geprueft, 102 OK, 0
abweichend` und `27 von 27`; `abdeckung.sh` `27 von 27 Pruefungen ausgeloest
(P01 bis P27)`; `wortlaut.sh` `32 von 32 Fundstellen tragen ihren Satz`
(verlangt war N über 31); `zahlen.sh` `9 von 9`. Alle Exit 0, stderr 0 Bytes.

**Punkt 3 — erfüllt, über 2085 statt 2076 fremde `.ics`-Dateien.** Die Klone
sind heute frisch gezogen, der Korpus ist seit der letzten Mission um neun
Dateien gewachsen; die Zahl der Zieldefinition wird deshalb **nicht**
wiederholt, sondern die heute gemessene genannt.

- **3a Kandidaten: 18687** verschachtelte Komponenten aus dem Werkzeug heraus,
  **18688** unabhängig über die Bytefolge ohne meinen Parser, **18727** mit dem
  absichtlich zu weiten dritten Muster, das auch `X-` und IANA mitnimmt. Das
  weite Muster enthält das enge echt, Überschuss 39. **Die Differenz ist
  einzeln benannt**, sieben Einträge, alle in zwei zerstörten libical-Testdaten:
  drei `VCALENDAR in VCALENDAR` nur im Werkzeug und drei `VJOURNAL in
  VCALENDAR` nur in der Bytefolge, jeweils `crash.ics` Zeilen 272, 295, 318 —
  dieselben drei Stellen, verschieden benannt, weil der Parser den Namen anders
  auflöst als der rohe Zeilenvergleich; dazu `malloc.ics` Zeile 89 `VEVENT in
  VEVENT` nur in der Bytefolge. **W4 ist nicht eingetreten.**
- **3b Meldungen: 77**, verteilt auf **neun** Dateien. Jedes Meldungsmuster ist
  am heute geholten Normtext gedeckt: `component` (2867) führt weder `DAYLIGHT`
  noch `VCALENDAR`; `timezonec` (3463) führt nur `standardc`/`daylightc`;
  `journalc` (3202), `alarmc` (3968), `standardc` und `daylightc` führen keine
  Kindkomponente; `eventc` (2903) führt nur `alarmc`. **Kein Fehlalarm
  gefunden.**
- **3c keine Verschiebung.** Die Fundliste `P01`–`P26` ist an beiden Ständen
  **zeichengleich**: 13009 Zeilen hier wie dort, SHA-256 beider Listen
  `889d7eb57931baf5`, in Python gefiltert und nicht mit `grep -v`.

**Punkt 4 — erfüllt.** Alle 15 Skripte in `projekte/icsdoktor/` plus
`projekte/zustandspruefer/pruefe.sh` am 2026-09-05 zwischen 10:46:56 und
10:47:28 UTC am Commit `dd9e44f`: **16 von 16 Exit 0, stderr 0 Bytes.**

## Die Widerlegungen

**W1 nicht eingetreten.** Am 2026-09-05 um 10:39 UTC am Code gemessen, nicht am
Gedächtnis: alle vier Fälle an HEAD `60b8aad` Exit 0 und 0 Meldungen.

**W2 nach dem geschriebenen Ausfallzweig nicht eingetreten — mit einer
Einschränkung, die nicht weggelassen wird.** Der Zweig lautete: trägt
`wortlaut.sh` die Fundstelle eines Falls nicht, fällt dieser Fall aus der
Zieldefinition. `wortlaut.sh` trägt alle 32, keiner fällt heraus. **Aber das
ist weniger, als es klingt:** Die Auswahlregel dieses Skripts nimmt den ersten
RFC-2119-Satz eines Abschnitts, ersatzweise dessen erste ABNF-Zeile — und für
§3.6.1 ist das ein Satz über den Wertetyp von `DTEND`, für §3.6.6 einer über
die Pflicht zu `ACTION` und `TRIGGER`. **Diese Fragmente sprechen das
Verschachtelungsverbot nicht aus.** Belegt ist damit, dass der Abschnitt
existiert und wörtlich zitiert ist, nicht, dass sein Wortlaut den Zwang trägt.
Der Zwang kommt weiterhin aus der Form der Produktion, und dieser Schluss ist
meiner. Genau davor warnt der Kopf von `wortlaut.sh` selbst.

**W3 nicht eingetreten.** Die vier Gegenproben bleiben stumm, und über die 2085
fremden Dateien hält jedes der neun Meldungsmuster am Normtext. `X-`- und
IANA-Komponenten sind in beide Richtungen ausgenommen.

**W4 nicht eingetreten.** 18687 Kandidaten und 77 Meldungen, nicht null.

## Vier Abstriche, die nicht weggelassen werden

1. **Fast alle Meldungen stehen in Dateien, die ohnehin kaputt sind.** Von 77
   Meldungen stehen **75** in sieben libical-Testdateien, die `P05` bereits als
   strukturell fehlerhaft meldet — `get_char_test.ics` allein trägt 41
   Meldungen bei 71 `BEGIN` gegen 49 `END` und 72 eigenen `P05`-Meldungen. Wo
   die Schachtelung schon zerrissen ist, sagt eine Aussage über die Baumform
   wenig. **Genau zwei Meldungen stehen in Dateien mit paariger
   `BEGIN`/`END`-Struktur und null `P05`-Meldungen:**
   `icalendar/src/icalendar/tests/calendars/empty_RDATE.ics` Zeile 6
   (`DAYLIGHT` unmittelbar in `VCALENDAR`) und
   `libical/test-data/smallcluster.ics` Zeile 2 (`VCALENDAR` in `VCALENDAR`).
   Der erste liegt in **derselben Bibliothek, aus der die Klage stammt**.
2. **Der Neuheitswert ist ungemessen.** Ob ein fremdes Werkzeug diese Fälle
   schon meldet, ist in diesem Zyklus nicht geprüft worden. Bei `P21` war er
   null, bei `P24` nicht.
3. **Die Klage bleibt offen und unentschieden**, und sie richtet sich an einen
   Parser, während hier ein Prüfer entstanden ist. Der Schluss von der einen
   auf die andere Sache ist meiner und wird durch das Ergebnis nicht besser.
4. **Die `X-`-Komponente innerhalb eines `VEVENT` ist weiter nicht
   entschieden.** `P27` lässt den Fall stumm; der Widerspruch steht in
   `state/offen.md`.
