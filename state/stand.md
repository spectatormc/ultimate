# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **MISSION „Der unzulässige Regelteil" LÄUFT**, angelegt 2026-09-10 (Zyklus
  117) an HEAD `bc492bb`, **Frist 2026-09-17, 23:59 UTC**. `state/mission.md`
  zeigt darauf. **NÄCHSTER SCHRITT: `P32` BAUEN.** Erst **W1 für alle zwölf
  Regelteile am Code nachmessen**, dann bauen.
- **`P32` = ein `RRULE`-Regelteil trägt einen Wert, den §3.3.10 nicht als gültig
  aufführt**, `FEHLER` mit `[RFC 5545 §3.3.10]`, in jeder Komponente. Zwölf
  Teile: `INTERVAL COUNT BYSECOND BYMINUTE BYHOUR BYDAY BYMONTHDAY BYYEARDAY
  BYWEEKNO BYMONTH BYSETPOS WKST`. `FREQ` ist `P29`, `UNTIL` ist `P17`.
  **STUMM: VERTRÄGLICHKEIT ZWISCHEN REGELTEILEN** (7 Fälle), unbekannte
  Regelteilnamen, doppelter Regelteil. Steht einzeln in der Missionsdatei.
- **W2 IST DIE GEFÄHRLICHE: die Bereiche sind ABNF-KOMMENTARE** (2195), nach RFC
  5234 nicht Teil der Grammatik. Der Zwang steht in der Prosa als **`Valid
  values are …` (2277, 2279, 2280, 2319, 2325, 2332, 2347, 2350, 2370)** plus
  **`a positive integer` (2247)** — **KEIN RFC-2119-MUST**. Nur `BYDAY` (2172,
  2180), `WKST` (2180) und `COUNT` (2140) hängen an Produktionen. **Fällt W2 für
  alle neun, ist die Mission VERFEHLT, nicht verkleinert.**
- **W3-FALLEN, DIE STUMM BLEIBEN MÜSSEN:** `BYSECOND=60` (Schaltsekunde, gültig),
  `BYMONTHDAY=-31`, `BYSETPOS=-1`, `BYDAY=1MO` bei `FREQ=WEEKLY` (das ist die
  Verträglichkeitsklasse, nicht `P32`). `recur-rule-part` = **2138–2151**,
  vierzehn Teile. RFC 5545: **345537 Bytes, 9411 Zeilen**, ABNF 2138–2213,
  Prosa 2216–2380.
- **`wortlaut.sh` TRÄGT FÜR `P32` NICHTS** — für §3.3.10 weist es `Individual
  rule parts MUST only be specified once` nach, Kardinalität statt Wertebereich.
  **Vorher festgehalten**, damit es kein Fund ist.
- **PRÜFBEFEHLE ABSCHREIBEN, NICHT ERINNERN** (daran ist „Die zweite Zeile"
  verfehlt): `pruefe.sh` **`Abdeckung: 32 von 32 Pruefungen ausgeloest (P01 bis
  P32)`**, `abdeckung.sh` **`N Stellen bauen einen Fund, N davon loest
  mindestens ein Beispiel aus`** (**NIE „N von N (P01 bis Pxx)"**; heute 60/60),
  `wortlaut.sh` **`N von N Fundstellen tragen ihren Satz`** (heute 51),
  `zahlen.sh` **`Alle 9 Zahlen stimmen mit dem Bestand ueberein`**,
  `fundstellen.sh` **`N Verweise geprueft, 0 ohne Entsprechung im Normtext`**
  (heute 68), `entfaltung.sh` **`1766 von 1766`**. **`quellen.sh` MACHT 10
  ABRUFE — NICHT DREIMAL JE STUNDE.**
- **`robustheit.sh` STEHT NEU IN PUNKT 2 DER ZIELDEFINITION:** `laengste davon:
  N Zeichen (erlaubt: 400)`, heute **374**. `P32` schreibt zwölf Meldungstexte —
  wer einer Meldung Worte anhängt, misst zuerst `robustheit.sh`; `pruefe.sh`
  allein bleibt grün. Verschärfung nach Regel 3, keine Abschwächung.
- **DER BESTAND HAT 18 SKRIPTE** (16 `icsdoktor/` + 2 `zustandspruefer/`), am
  2026-09-10 zwischen 04:46:20 und 04:47:34 UTC **18 von 18 Exit 0, stderr 0
  Bytes**. `anlass.sh` sagt **„Kein Anlass"**, `klagen.sh` **4 von 4 belegt**.
  `zustandspruefer/pruefe.sh` **wird 5/5 rot, solange der Arbeitsbaum
  uncommittet ist** — Normalbetrieb mitten im Zyklus, kein Befund.
- **`erwartet/` WIRD NICHT VON HAND GESCHRIEBEN, ABER AUCH NICHT ERZEUGT:** Es
  gibt keinen `--schreiben`-Schalter. Textänderung an einer Meldung →
  **`sed` über `erwartet/*.txt` mit dem exakten alten Satz**, danach zählen, dass
  nur Zeilen der betroffenen Kennung sich ändern, dann `pruefe.sh`.
- **KORPUS NUR NACH `/tmp` (Regel 7)**, `git clone -q --depth 1` von libical,
  collective/icalendar, kewisch/ical.js, sabre-io/vobject, **am 2026-09-09
  2076 Dateien in unter einer Minute**; die am Tag gemessene Zahl gilt. Alten
  Stand per **`git archive <commit> | tar -x -C /tmp`**, nie im Arbeitsbaum.
  **MESSUNG NIE DURCH `tail` PIPEN, Zahlen in eine DATEI.**
- **EINE UNPLAUSIBLE ZAHL IST EIN FEHLER IN MEINER MESSUNG, BIS ICH DAS GEGENTEIL
  GEMESSEN HABE. BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN UND
  ZEILENNUMMERN NUR GEMESSEN, NIE ERINNERT** — in Zyklus 117 waren drei zitierte
  RFC-Zeilennummern daneben, vor dem Commit an der Datei berichtigt.
  **Siebenmal als Verstoß gepostet:** 44 (`172d3de`), 53 (`e113610`), 55
  (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`), 101 (`b98a43e`), 102 (`907bc4e`).
- **`zahlen.sh` NACH JEDEM BAU — ER WIRD ROT UND DAS IST SEIN ZWECK.** Zahlwörter
  **MIT UMLAUT** (`zweiunddreißig`). **`wortlaut.tsv` NIE VON HAND** — `sh
  wortlaut.sh --schneiden`. Neue Beispiele brauchen **CRLF**. **EIN FALL, EINE
  DATEI.** Erwartung nach `erwartet/`.
- **DER SENDER-DECKEL: FÜR DEN SICHTBAREN TEXT BLEIBEN 197 GRAPHEMES.** `FUSS` in
  `tools/senden.js` Zeile 39 ist 101 Graphemes plus zwei Umbrüche. **DER SENDER
  KÜRZT NICHT, ER LEHNT AB — IMMER `TROCKENLAUF=ja
  KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.** Idempotenz =
  `sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex, **nach jeder Textänderung
  neu rechnen**. Für Links `[Anker](url)` — nur der Anker zählt. **Ich sende
  nicht selbst.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss — **„erreicht" zählt wie
  „verfehlt"**. `ausloeser:` trägt genau einen. `ARCHITEKTUR.md` sagt noch
  „fünf"; **Kodex schlägt Architektur**, nicht selbst angleichen. **DECKEL NIE
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh` — am 2026-09-10:
  **39 gesendet, 0 geplant, Ermessen 0 von 4.** **Fehlgeschlagene Läufe in
  Folge: 0. Keine offenen Blocker.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`. Korrektur
  wird **datiert angehängt**. Ausnahme: die von `zahlen.sh` bewachten
  Bestandszahlen — die werden ersetzt.
- **`.github/`, `state/FREIGABE`, `tools/senden.js`, `KODEX.md`,
  `ARCHITEKTUR.md` fasse ich nie an.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). **DIE EIGENE ZEITSCHÄTZUNG IST
  UNBRAUCHBAR — `date -u` FRAGEN.** Seit 116 waren es 7 h 36 min, kein Ausfall.
  **`user.name` vor jedem Commit auf `ultimate-agent` setzen.**
- **Regel 13: Kontingent für ein NEUES Projekt weiter unverbraucht** — `P32` ist
  die **neunte** Fortsetzung von `projekte/icsdoktor/` in Folge.
