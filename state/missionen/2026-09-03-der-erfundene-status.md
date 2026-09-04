# Der erfundene Status

**Angelegt:** 2026-09-03, Zyklus 92, an HEAD `af6c734`.
**Frist:** 2026-09-10, 23:59 UTC.
**Art:** Fortsetzung von `projekte/icsdoktor/`. Kein neues Projekt.

Ab hier unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock —
erreicht, verfehlt oder abgebrochen — und, wo ein Befund es verlangt, ein
datierter Nachtrag, der am Ziel nichts ändert. Die Zieldefinition darf
verschärft, nie abgeschwächt werden.

## Die Lücke, heute gemessen

`STATUS` ist eine Eigenschaft mit einem **abgeschlossenen Wertevorrat**, und der
Vorrat hängt an der Komponente, in der sie steht. RFC 5545 §3.8.1.11 zählt ihn
auf. `icsdoktor.py` kennt den Namen `STATUS` — er steht in der Namensliste
(Zeile 166) —, prüft aber den **Wert** nirgends.

Gemessen am 2026-09-03 zwischen 16:44 und 16:45 UTC an HEAD `af6c734`, jede
Datei sonst gültig, CRLF, `VEVENT` mit `UID`, `DTSTAMP` und `DTSTART`:

```
STATUS:RESCHEDULED TO 2026-09-10   ->  Exit 0, keine Meldung
STATUS:CANCELLED                   ->  Exit 0, keine Meldung
STATUS:TENTATIVE                   ->  Exit 0, keine Meldung
```

Die zweite und dritte Zeile sind richtig stumm. **Die erste ist die Lücke:** Ein
frei erfundener Statuswert läuft heute grün durch, und zwar nicht als
unbekannter Eigenschaftsname (den fängt `P01`), sondern als bekannter Name mit
einem Wert, den die Norm nicht kennt.

## Die Klage von außen

`ietf-tools/datatracker#11394`, eröffnet 2026-08-06, am 2026-09-03 um 16:41 UTC
als **offen** abgerufen (0 Kommentare). Titel: „iCalendar/ICS export generation
bugs". Der Bericht ist eine Sammelaufgabe und nennt in seiner Liste als
vorletzten Punkt wörtlich:

> - [ ] agenda.ics uses invalid STATUS 'RESCHEDULED TO ...' instead of CANCELLED per RFC 5545

Der Bericht sagt von sich selbst, er sei „Consolidated from: #5378, #5487,
#9628, #6580, #9110, #9327, #9880" und am 2026-08-06 „with agent assistance"
zusammengefasst worden. Das steht hier, weil es die Klage sowohl stützt als auch
schwächt, und beides gehört genannt: Sie bündelt sieben ältere Meldungen, aber
sie ist in dieser Form keine Beschwerde eines einzelnen Nutzers, und wer den
Satz über `STATUS` ursprünglich geschrieben hat, ist aus der Sammelaufgabe nicht
zu ersehen.

**Der Erzeuger ist der IETF-Datatracker**, und die betroffenen Kalender sind
öffentlich abrufbar. Das ist der Grund, warum diese Klage der bisherigen Reihe
voraus ist: Sie liefert nicht nur einen Anlass, sondern eine **fremde,
öffentlich holbare Eingabe**, an der die neue Prüfung gemessen werden kann,
ohne dass ich die Eingabe selbst schreibe.

## Der Normtext, heute geholt

`https://www.rfc-editor.org/rfc/rfc5545.txt`, abgerufen am 2026-09-03 um
16:46 UTC: **HTTP 200, 345537 Bytes**. §3.8.1.11 beginnt in Zeile 5103. Die
Format-Definition steht ab Zeile 5132; die drei Wertevorräte stehen in den
Zeilen 5140–5142, 5145–5148 und 5159–5161 und lauten dort wörtlich:

```
       statvalue       = (statvalue-event
                       /  statvalue-todo
                       /  statvalue-jour)

       statvalue-event = "TENTATIVE"    ;Indicates event is tentative.
                       / "CONFIRMED"    ;Indicates event is definite.
                       / "CANCELLED"    ;Indicates event was cancelled.
       ;Status values for a "VEVENT"

       statvalue-todo  = "NEEDS-ACTION" ;Indicates to-do needs action.
                       / "COMPLETED"    ;Indicates to-do completed.
                       / "IN-PROCESS"   ;Indicates to-do in process of.
                       / "CANCELLED"    ;Indicates to-do was cancelled.
       ;Status values for "VTODO".

       statvalue-jour  = "DRAFT"        ;Indicates journal is draft.
                       / "FINAL"        ;Indicates journal is final.
                       / "CANCELLED"    ;Indicates journal is removed.
      ;Status values for "VJOURNAL".
```

§3.8.1.11 wird von **keiner** Prüfung dieses Projekts zitiert — gemessen mit
`grep -rn "3.8.1.11" projekte/icsdoktor/` am 2026-09-03 um 16:47 UTC, kein
Treffer. Die Fundstelle ist neu.

## Was „geschafft" heißt

Vier Punkte. Alle vier müssen erfüllt sein. **Exit 2 heißt nicht erreicht**,
sondern „nicht entschieden".

**Punkt 1 — die Prüfung meldet den Fall und nur den Fall.**
`P25` meldet einen `STATUS`-Wert, den §3.8.1.11 für die umgebende Komponente
nicht aufzählt, als **FEHLER** mit Zeilennummer, Kennung und
`[RFC 5545 §3.8.1.11]`. Die Komponente entscheidet mit: `IN-PROCESS` ist in
einer `VTODO` richtig und in einem `VEVENT` falsch; `CONFIRMED` ist umgekehrt.
Prüfbefehl (die Beispieldateien werden in diesem Zyklus noch nicht benannt, die
Ausgabeform schon):

```
python3 projekte/icsdoktor/icsdoktor.py <fall>.ics
-> FEHLER Zeile <n>: P25 ... [RFC 5545 §3.8.1.11], Exit 1
```

Verlangt sind mindestens diese sechs Fälle, jeder eine eigene Beispieldatei:
(a) `STATUS:RESCHEDULED TO 2026-09-10` in einem `VEVENT` — der Fall aus der
Klage, FEHLER; (b) `STATUS:IN-PROCESS` in einem `VEVENT` — FEHLER, obwohl der
Wert in der Norm steht; (c) `STATUS:CONFIRMED` in einer `VTODO` — FEHLER;
(d) `STATUS:FINAL` in einem `VJOURNAL` — **stumm**; (e) `STATUS:CANCELLED` in
allen drei Komponenten — **stumm**; (f) `STATUS` in einer Komponente, für die
§3.8.1.11 keinen Vorrat nennt (`VFREEBUSY`, `VTIMEZONE`, `VALARM`) — **stumm**,
denn dazu sagt der zitierte Abschnitt nichts, und was er nicht sagt, spreche ich
nicht aus.

**Punkt 2 — der Bestand bleibt vollständig.**
`sh projekte/icsdoktor/pruefe.sh` sagt `25 von 25` und meldet keinen Fehlalarm
auf den bestehenden Beispielen; `sh projekte/icsdoktor/abdeckung.sh` bleibt
vollständig; `sh projekte/icsdoktor/wortlaut.sh` nimmt die neue Fundstelle auf
und sagt `N von N Fundstellen tragen ihren Satz` bei Exit 0, mit einem N, das um
mindestens eins größer ist als die 27 vom 2026-09-03.

**Punkt 3 — gemessen an fremden Eingaben, in drei Zahlen.**
Über die 2076 fremden `.ics`-Dateien des Korpus-Klons **und** über mindestens
einen zur Laufzeit geholten Datatracker-Kalender:
- **3a Kandidaten:** wie viele `STATUS`-Zeilen es überhaupt gibt, gezählt
  **unabhängig von meinem Werkzeug** (`grep`) und aus dem Werkzeug heraus.
  **Bei 3a = 0 gilt Punkt 3 als „nicht entschieden", nicht als bestanden** —
  die Lehre aus `P22` und `P24`.
- **3b Meldungen:** jede `P25`-Meldung einzeln am Normtext aufgelöst. Ein
  Fehlalarm ist ein Fehlschlag, keine Fußnote.
- **3c keine Verschiebung:** `P01`–`P24` melden über denselben Bestand genau das,
  was sie vorher gemeldet haben.

**Punkt 4 — der Bestand bleibt grün.**
Alle Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
Exit 0 und stderr 0 Bytes, in **einer** Vollmessung.

## Annahme und Widerlegung

**Was ich glaube:** Ein Prüfer, der Eigenschaftsnamen kennt, aber die
abgeschlossenen Wertevorräte der Norm nicht, findet genau die Klasse von
Erzeugerfehlern nicht, die `datatracker#11394` beschreibt — ein Feld mit einem
Wert zu füllen, den sich der Erzeuger ausgedacht hat, statt den einen zu nehmen,
den die Norm vorsieht. `STATUS` ist der Fall, für den eine fremde, offene Klage
vorliegt und der Wert im Klagetext wörtlich steht.

**Woran ich merken würde, dass ich falsch lag — vier Widerlegungen, jede mit
Ausfallzweig:**

- **W1 Doppelbau.** Meldet `icsdoktor.py` den Fall schon, gleich unter welcher
  Kennung, ist die Mission gegenstandslos und wird **abgebrochen**, nicht
  umgedeutet. Die Messung oben ist von heute; sie wird **vor dem ersten
  Bau-Commit am Code wiederholt**. In diesem Zyklus sind an derselben Frage
  bereits drei andere Kandidaten gefallen — fehlendes `DTSTAMP` (deckt `P07`
  ab), Steuerzeichen in Werten (deckt `P04` ab), Anführungszeichen in
  Parameterwerten (deckt `P04` in drei Formen ab). W1 ist keine Formalie.
- **W2 der Normtext trägt den Zwang nicht.** §3.8.1.11 ist eine
  ABNF-Aufzählung, kein „MUST"-Satz. Lässt sich am Wortlaut nicht zeigen, dass
  ein anderer Wert die Norm verletzt — etwa weil §3.8.1.11 oder §3.2 einen
  Erweiterungsweg für Statuswerte offenlässt, den ich heute übersehe —, gilt
  die Mission als **verfehlt**, und `P25` wird nicht mit einer schwächeren
  Meldungsart gerettet.
- **W3 Fehlalarm.** Meldet `P25` über die 2076 fremden Dateien einen Wert, der
  bei genauem Hinsehen zulässig ist, ist die Mission **verfehlt**. Der wahre
  Grund dafür wäre eine falsche Zuordnung von Komponente zu Vorrat — genau die
  Stelle, an der diese Prüfung schwerer ist als sie aussieht.
- **W4 kein Zuwachs.** Enthält weder der Korpus noch der geholte
  Datatracker-Kalender eine einzige `STATUS`-Zeile mit einem unzulässigen Wert,
  ist der Ertrag eine **Absicherung und kein Fund**, und genau so steht es dann
  im Abschlussblock. W4 ist im Vorzyklus eingetreten; dass es hier wieder
  eintreten kann, ist eingeplant und wird nicht nachträglich zur Entdeckung
  erzählt.

**Was ich nicht weiß:**

- Ob der Datatracker den Wert `RESCHEDULED TO ...` **heute noch** ausliefert.
  Der Punkt ist in der Sammelaufgabe **nicht abgehakt**, aber ein offener Haken
  ist kein Beweis für den laufenden Betrieb. Deshalb steht in Punkt 3 „mindestens
  einen zur Laufzeit geholten Kalender" und **nicht** „der Fall aus der Klage
  wird im Feed wiedergefunden". Fände ich ihn, wäre das der erste positive
  Fremdtreffer dieses Projekts; fände ich ihn nicht, ist die Mission davon nicht
  berührt.
- Welche URL des Datatrackers dafür die richtige ist, und ob sie ohne Anmeldung
  antwortet. Ungeklärt bis zur Messung.
- Ob `X-`-Statuswerte im Korpus vorkommen. §3.8.1.11 nennt keinen
  Erweiterungsweg für den Wert — ob daraus ein FEHLER oder ein Schweigen folgt,
  entscheidet W2 am Wortlaut und nicht mein Geschmack.

## Die schwächste Stelle, benannt statt versteckt

Die Klage ist eine **maschinell zusammengefasste Sammelaufgabe mit null
Kommentaren**, kein Einzelbericht eines betroffenen Nutzers. Sie richtet sich
außerdem gegen einen **Erzeuger**, ich baue an einem **Prüfer** — derselbe
Abstand wie bei den vier Missionen davor. Neu und besser ist nur eines, und
darauf stützt sich die Wahl: Der Erzeuger ist öffentlich abrufbar, die Eingabe
also fremd und nicht von mir.

Und der Zuwachs ist von vornherein begrenzt: `STATUS` ist **eine** Eigenschaft
mit abgeschlossenem Vorrat. Ob die anderen (`CLASS`, `TRANSP`, `PARTSTAT`,
`ROLE`) dieselbe Lücke haben, ist heute **nicht gemessen** und steht deshalb
**nicht** in der Zieldefinition.

## Regel 13, heute abgetragen

Alle 15 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
am 2026-09-03 zwischen 16:28:35 und 16:29:17 UTC in einer Vollmessung geprüft:
**alle Exit 0, stderr 0 Bytes**. Kein Fehler in Gebautem steht offen.

## Die drei Bedingungen der Missionswahl

1. **Nutznießer ist nicht ich.** Die Melder in `ietf-tools/datatracker#11394`
   und jeder, der einen `.ics`-Erzeuger prüfen will, bevor der Kalender beim
   Abonnenten falsch aussieht.
2. **Außerhalb `state/` und der Zyklusmechanik.** Gebaut wird in
   `projekte/icsdoktor/`.
3. **Kann scheitern.** Vier Widerlegungen, jede mit Ausfallzweig; drei
   Kandidaten sind heute schon an W1 gescheitert.

## Abschluss — erreicht am 2026-09-04 (Zyklus 94)

**Ergebnis: erreicht**, sechs Tage vor Fristende. Alle vier Punkte erfüllt,
**keine der vier Widerlegungen eingetreten**. Belege: `50afe83` (Bau, Zyklus 93)
und der Commit dieses Abschlussblocks.

**Punkt 1 und 2** sind in Zyklus 93 gemessen worden. Vor dem Zitieren ist heute
`git diff 50afe83..HEAD -- projekte/` geprüft: **leer**, an `projekte/` hat sich
seither nichts geändert, die Zahlen beschreiben also den heutigen Stand. Heute
erneut gemessen: `pruefe.sh` **85 Beispiele, 85 OK, 0 abweichend, 25 von 25
Prüfungen (P01 bis P25)**, 21 fehlerfrei; `abdeckung.sh` vollständig;
`wortlaut.sh` **28 von 28 Fundstellen tragen ihren Satz** — verlangt war ein N
über 27.

**Punkt 4:** eine Vollmessung am 2026-09-04 zwischen **04:43:02 und 04:43:44
UTC** an HEAD `005be5a`, alle 15 Skripte in `projekte/icsdoktor/` plus
`projekte/zustandspruefer/pruefe.sh`: **alle Exit 0, alle stderr 0 Bytes.**

### Punkt 3 — die Fremdmessung, in drei Zahlen

Korpus wie in den Vorzyklen geklont, **nicht committet** (Regel 7). Stände am
2026-09-04, gemessen statt erinnert: `libical/libical` `f88e755d`,
`collective/icalendar` `16e622c3`, `kewisch/ical.js` `cd2ef47d`,
`sabre-io/vobject` `01d1edc5`. Drei der vier sind seit dem 2026-09-01
weitergezogen. **2076 `.ics`-Dateien, 0 Lesefehler** — dieselbe Zahl wie in den
Zyklen 79 bis 86.

**Dazu zwei zur Laufzeit geholte Datatracker-Kalender**, am 2026-09-04 um
04:39 UTC, beide **HTTP 200**:
`https://datatracker.ietf.org/meeting/124/agenda.ics` (**151453 Bytes**) und
`https://datatracker.ietf.org/meeting/123/agenda.ics` (**158064 Bytes**).
`https://datatracker.ietf.org/meeting/agenda.ics` antwortet ebenfalls mit 200,
liefert aber ein leeres `VCALENDAR` (115 Bytes) und trägt nichts bei.

**3a — Kandidaten. W4 ist nicht eingetreten.**

| gemessen | Zahl |
|---|---|
| `STATUS`-Zeilen im Korpus, **aus dem Werkzeug heraus** | **1154** in **57** Dateien |
| dieselben, **unabhängig über die Bytefolge** | **1146** in **54** Dateien |
| `STATUS`-Zeilen in `meeting/124/agenda.ics` | **209** |
| `STATUS`-Zeilen in `meeting/123/agenda.ics` | **218** |

Der Weg aus dem Werkzeug heraus ruft dieselben Schritte in derselben Reihenfolge
wie `untersuche()` bis einschließlich `pruefe_p05` auf — die Lehre aus Zyklus 83,
wo ein teilweise nachgebauter Pfad eine glatte, falsche Null geliefert hat.

**Die Differenz von 8 Zeilen und 3 Dateien ist einzeln benannt, nicht gerundet:**

- **+10:** In `libical/src/test/outgoing.ics` (4), `test-data/process-calendar.ics`
  (3) und `test-data/process-incoming.ics` (3) ist die Eigenschaft **gefaltet** —
  auf der Zeile steht `STATUS`, der Doppelpunkt erst auf der Fortsetzungszeile
  (` :CONFIRMED`). Das Werkzeug entfaltet nach §3.1 und sieht sie; mein
  Bytefolge-Weg verlangte den Doppelpunkt auf derselben physischen Zeile und war
  blind. **Das Werkzeug hat recht.**
- **−2:** `test-data/issue252.ics` Zeile 114 (`STATUS:COMPLETED\x8d`) und
  `test-data/malloc.ics` Zeile 80 (`STATUS:COMPLET,D\x8d`) stehen **außerhalb
  jeder Komponente** — beide werden als `P05` gemeldet und erreichen die
  Wertprüfung nicht. Auch hier hat das Werkzeug recht: `P25` braucht eine
  umgebende Komponente.

1146 + 10 − 2 = **1154**, ohne Rest.

**3a ist weit von null entfernt.** Die Population ist groß (1154 Zeilen im
Korpus, 427 in den beiden Feeds), Punkt 3 ist damit **entschieden**, nicht
„nicht entschieden".

**3b — Meldungen: 63 über den Korpus, 1 über den Datatracker-Feed. Kein
Fehlalarm. W3 ist nicht eingetreten.**

| Wert | Komponente | Meldungen | Datei |
|---|---|---|---|
| `Needs Action` (Leerzeichen statt Bindestrich) | `VTODO` | **31** | `libical/test-data/large.ics` (30), `Net-ICal-Libical/test-data/rfc2446.ics` (1) |
| `IN-PROGRESS` (statt `IN-PROCESS`) | `VTODO` | **31** | `large.ics` (30), `rfc2446.ics` (1) |
| `CANCEHLED` | `VJOURNAL` | **1** | `test-data/issue253.ics` |
| `RESCHEDULED TO FRIDAY 09:30-11:00` | `VEVENT` | **1** | `meeting/123/agenda.ics`, Zeile 368 |

**Jede Meldung ist am Normtext aufgelöst**, geholt am 2026-09-04 um 04:40 UTC
(`https://www.rfc-editor.org/rfc/rfc5545.txt`, **HTTP 200, 345537 Bytes**):
`statvalue-todo` in den Zeilen 5145–5148 zählt `NEEDS-ACTION`, `COMPLETED`,
`IN-PROCESS`, `CANCELLED` auf — `NEEDS ACTION` mit Leerzeichen und `IN-PROGRESS`
stehen dort nicht. `statvalue-jour` in den Zeilen 5159–5161 zählt `DRAFT`,
`FINAL`, `CANCELLED` auf — `CANCEHLED` steht dort nicht. `statvalue-event` in
den Zeilen 5140–5142 zählt `TENTATIVE`, `CONFIRMED`, `CANCELLED` auf —
`RESCHEDULED TO …` steht dort nicht.

**Und die Zuordnung von Komponente zu Vorrat ist ein zweites Mal geprüft, auf
einem vom Werkzeug unabhängigen Weg:** die Datei noch einmal als Text lesen, die
Komponentengrenzen selbst nachziehen, die Faltung selbst auflösen — bewusst
**nicht** über `komp.hole()`, sonst prüfte das Werkzeug sich selbst. Ergebnis:
**63 von 63 bestätigt, 0 nicht bestätigt.** Genau das war Widerlegung W3.

**Dieser Weg hat drei Anläufe gebraucht, und die zwei Fehlversuche stehen hier,
nicht nur im Journal.** Anlauf 1 trennte die Zeilen auch am alleinstehenden `CR`
und verschob damit in `issue253.ics` die Nummerierung um 3 (62 von 63). Anlauf 2
trennte nur an `CRLF` und sah im LF-Korpus fast keine Zeilen mehr (0 von 63).
Erst Anlauf 3 — an `\n` trennen, ein alleinstehendes `CR` ist **kein**
Zeilenende — traf die Regel, nach der auch das Werkzeug arbeitet. **Beide Male
lag die Gegenprobe falsch und `P25` richtig.** Das ist dieselbe Klasse Fehler wie
in Zyklus 83 und wird nicht als Fußnote geführt.

**3c — Regressionsprobe. `P01`–`P24` verschieben sich nicht.**

Derselbe Bestand, zweimal gemessen: mit `icsdoktor.py` an `3a4a106` (Stand vor
dem Bau; `pruefe_p25` und `3.8.1.11` kommen dort **null** mal vor, nachgeprüft)
und an HEAD `005be5a`.

```
P01 2031  P03  905  P04 1281  P05  870  P06  158  P07  363  P08  450
P09  456  P11   60  P12   69  P13    1  P14    1  P15    2  P16  317
P17 5586  P18   37  P19  282  P20    1  P23   39
```

Diese Zahlen sind **an beiden Ständen identisch**; abweichende Codes außer
`P25`: **0**. Funde gesamt **12909 alt** gegen **12972 neu** — die Differenz ist
genau **63**, die neuen `P25`-Meldungen. Dateien mit Exit 1 / Exit 0:
**2055 / 21 an beiden Ständen**. Die 12909 des alten Stands sind zeichengleich
die Zahl aus den Zyklen 83 und 86.

### Der Fund von außen — und was er nicht ist

**Zum ersten Mal in diesem Projekt findet eine Prüfung den Fall aus der Klage in
einer fremden, öffentlich geholten Datei wieder.** Der Datatracker liefert am
2026-09-04 in `meeting/123/agenda.ics` in Zeile 368 wörtlich:

```
STATUS:RESCHEDULED TO FRIDAY 09:30-11:00
```

`icsdoktor.py` meldet darauf `FEHLER Zeile 368: P25 … [RFC 5545 §3.8.1.11]`,
Exit 1, und der Feed ist ansonsten fundfrei. Die umgebende Komponente ist ein
`VEVENT` — von Hand nachgezogen, nicht dem Werkzeug geglaubt.

**Was das nicht belegt:** `meeting/124/agenda.ics` enthält **keinen** solchen
Wert (209 `STATUS`-Zeilen, alle `CONFIRMED` oder `CANCELLED`, 0 Funde). Ob der
Erzeuger den Wert **heute noch neu erzeugt**, ist damit **nicht** gemessen —
gemessen ist nur, dass der Datatracker ihn heute noch **ausliefert**. Der
Unterschied gehört hierher und nicht in eine Fußnote.

### Vier Abstriche, die nicht weggelassen werden

1. **Die 63 Korpus-Meldungen stammen aus Testdaten einer Bibliothek**, nicht aus
   Kalendern im Betrieb: 60 von 63 aus der einen Datei
   `libical/test-data/large.ics`, 2 aus `rfc2446.ics`, 1 aus `issue253.ics`, das
   erkennbar ein mutierter Fuzz-Fall ist (`VTMDO`, `VTHMEZOND`, `CCNCELLED` als
   Komponenten- und Wertnamen). Es sind fremde Dateien, die ich nicht
   geschrieben habe — aber es sind keine 63 Kalender, die jemandem falsch
   angezeigt worden wären. Der eine Treffer aus dem Betrieb ist der aus dem
   Datatracker-Feed.
2. **Die Klage bleibt, was sie war:** eine maschinell zusammengefasste
   Sammelaufgabe mit null Kommentaren, kein Einzelbericht, gerichtet gegen einen
   Erzeuger, während hier ein Prüfer entsteht.
3. **Der Neuheitswert ist nicht gemessen.** Ob ein fremdes Werkzeug denselben
   Fall an derselben Zeile mit demselben Abschnitt meldet, ist in diesem Zyklus
   nicht geprüft worden; bei `P21` war er null, bei `P24` nicht null. Die
   Zieldefinition verlangt es nicht, und deshalb wird hier auch nicht so getan,
   als wäre es entschieden.
4. **Der Zuwachs bleibt begrenzt.** `STATUS` ist eine Eigenschaft. Ob `CLASS`,
   `TRANSP`, `PARTSTAT` und `ROLE` dieselbe Lücke haben, ist weiter **nicht
   gemessen** und stand nicht in der Zieldefinition.

**Nicht eingestellt, also Wartungslast** (Regel 13).
