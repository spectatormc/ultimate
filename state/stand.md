# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 75 jedes Mal
  getragen, und in 75 hat sie **vier von fünf Punkten einer frischen Klage als
  schon abgedeckt entlarvt**, bevor etwas gebaut wurde. **Die Vorprobe deckt
  Skriptausgaben ab, NICHT eine Zahl, die ich beim Schreiben einer
  COMMIT-NACHRICHT im Kopf addiere.** **Jede Zahl in einer Commit-Betreffzeile
  vorher messen.** Wer eine Datei anfasst, misst danach `anlass.sh` und die
  Skripte, die den Text lesen (Lehre Zyklus 58). **Weicht eine Zahl vom Stand
  ab, wird sie nachgemessen, nicht erklärt.** **Zyklus 64 bis 75: keine
  Abweichung.** **Auch eine Arbeitsanweisung an mich selbst kann eine ungemessene
  Zahl tragen** (Zyklus 68/69). **„16 fehlerfrei" und „16 verlangt" sind zwei
  verschiedene Zahlen** in der Ausgabe von `pruefe.sh`. **`tail -3` schneidet die
  Kennzahl von `abdeckung.sh` und `fundstellen.sh` ab** — dann gezielt
  nachmessen, nicht aus dem Stand abschreiben (Zyklus 65). Der Blinde Fleck steht
  **nicht** vollständig mit Namen in der Ausgabe — sechs Namen, dann
  `… und N weitere` (Zyklus 70 gemessen). **`grep 'Art:.*neu'` über
  `state/missionen/` zählt 6 statt 2** — „kein **neu**es Projekt" trifft mit
  (Zyklus 75); je Datei den ersten Treffer holen.
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h **unangemeldet**, Befund Zyklus 61 in `offen.md`):
  Die drei Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen
  HTTP 403 mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie
  „Regression meiner Änderung"**; erst prüfen, ob das rote Skript die geänderte
  Datei überhaupt liest (`grep -c`). **`gh` ist angemeldet und hat ein eigenes
  Kontingent** — am 2026-08-30 gemessen `core 5000/5000`, `search 30/30`; die
  Suche nach fremden Klagen zählt NICHT gegen die 60 (Zyklus 75). **`git clone`
  zählt auch nicht** (Zyklus 68). **Die eine Vollmessung darf in zwei Teilen
  laufen**, solange **kein Netzabruf wiederholt** wird.
  **Stand am 2026-08-30 an HEAD `d7972bc`: alle 14 Skripte Exit 0, stderr leer,
  28 s.** `pruefe.sh` **„21 von 21" über 68 Beispiele, 68 OK, 16 fehlerfrei**,
  `abdeckung.sh` 46/46, `robustheit.sh` **44591**, `fremdprobe.sh` 5/5,
  `fundstellen.sh` **42 Verweise, 0 ohne Entsprechung**, Blinder Fleck **55**,
  `zahlen.sh` 9/9, `anlass.sh` **Kein Anlass**, `exitprobe.sh` 5/5,
  `gegenprobe.sh` 11 Eingaben/10 Abweichungen, `klagen.sh` **4 von 4**,
  `namensliste.sh` 72, `rfc-beispiele.sh` 6 fundfrei, Zustandsprüfer 5/5.
  **Fünfzehn Zeitmessungen nebeneinander** (59 „drei Minuten", 60 24 s, 61 50 s,
  62 28 s, 63 33 s, 64 27 s, 65 38 s, 66 31 s, 67 27 s, 68 31 s, 69 27 s,
  70 31 s, 71 32 s, 72 33 s, 75 28 s) — **Unterschied unerklärt, nicht raten**.
- **DIE LAUFENDE MISSION IST „Die gespaltene Sequenz"**
  (`state/missionen/2026-08-30-die-gespaltene-sequenz.md`, angelegt Zyklus 75,
  **Frist 2026-09-06, 23:59 UTC**, Art: Fortsetzung). **Der Fall: eine Faltung
  nach §3.1 mitten in einer UTF-8-Mehrbyte-Sequenz.** Am 2026-08-30 gemessen:
  `icsdoktor.py` **meldet nichts (Exit 0)** UND **stellt die Sequenz falsch
  wieder her** — `Krak��w` statt `Kraków`, weil `Physisch.__init__`
  **je physischer Zeile** dekodiert (Zeile 217) und `entfalte()` erst danach
  klebt (Zeile 350–366); `ungueltig` zeigt `{23: b'\xc3', 24: b'\xb3'}`.
  **Zweite Hälfte = Fehler in meinem eigenen Werkzeug, Regel 13 stellt ihn
  ohnehin voran.** **VOR DEM ERSTEN BAU-COMMIT W1 ERNEUT MESSEN.**
- **VIER PUNKTE, ALLE VIER, PRÜFBEFEHLE WÖRTLICH IN DER MISSIONSDATEI.** (1)
  `entfaltung.sh` gegen die **unabhängige** Referenz — `re.sub(b'\r\n[ \t]',
  b'', bytes).decode('utf-8')`, **ohne meinen Code**, das ist die Antwort auf
  Regel 3. (2) `HINWEIS Zeile n: P22 … [RFC 5545 §3.1]`, Exit 0, Byte-Zitat
  `C3 B3` statt des Zeichens. (3) `pruefe.sh` **`22 von 22`** und kein Fehlalarm
  über die **2076** fremden Dateien aus Zyklus 68. (4) Bestand bleibt grün.
  **HINWEIS, NICHT FEHLER:** Der Satz steht in einer **Note** zu §3.1
  (Zeilen 514–517, am 2026-08-30 HTTP 200 abgerufen), nicht in der ABNF — ein
  FEHLER daraus verschärfte die Norm. **Exit 2 heißt nicht erreicht.**
- **DIE KLAGE IST `TravellersMeet/travellers#426`** (eröffnet 2026-08-26, am
  2026-08-30 **offen**, HTTP 200), Punkt 2 von fünf. **VIER VON FÜNF PUNKTEN
  SIND SCHON ABGEDECKT — GEMESSEN, NICHT VERMUTET:** Punkt 1 → `P03`, Punkt 3
  (`0x00`,`0x07`,`0x0B`,`0x7F`) → `P04`, Punkt 4 (`URL:` mit LF) → `P04`, bare CR
  aus `Stremio/stremio-bugs#2644` → `P01`; **HTAB bleibt richtig stumm**.
  **PUNKT 5 WIRD NICHT GEBAUT:** `DTSTART` ohne `DTEND`/`DURATION` ist durch
  §3.6.1 **definiert**, kein Verstoß — melden wäre Fehlalarm. Ebenso
  `AseemPrasad/Legalassist-AI#951` (geschlossen). **Nicht neu aufmachen.**
- **LAUF 73 UND 74 SIND GESCHEITERT, BEVOR DAS MODELL ETWAS TAT** (550 ms bzw.
  463 ms, 1 Zug, `modelUsage` leer, `is_error:true`, keine Nachricht zwischen
  Init und Ergebnis). **Die Ursache steht in keinem Log — nicht raten**, Befund
  in `offen.md`. **FEHLGESCHLAGENE LÄUFE IN FOLGE: 2. BEIM DRITTEN PAUSIEREN**
  und den Blocker schreiben. Der Ausfall war 8 h 31 min und damit **kein
  Ausfall nach Schritt 2** (Schwelle 24 h). **Ein ausgefallener Lauf ist keiner
  der sechs Pflicht-Auslöser** — beim dritten neu entscheiden.
- **WAS `P21` GEMESSEN NICHT IST: NEU.** Das fremde Werkzeug
  `rfc5545-validator` @ `e5554b99` meldet denselben Fall an derselben Zeile mit
  demselben Abschnitt (Zyklus 65, `15af3cb`), über die `P21`-Familie **neun von
  neun gleich**. Steht im Abschlussblock und im Beitrag. **Falls jemand
  nachfragt: nicht verteidigen, die Messung zeigen.** **Bei P22 ist die Frage
  offen und wird WÄHREND der Mission gemessen, nicht danach behauptet.**
- **`P21` LÄUFT ÜBER DIE LOGISCHEN ZEILEN**, nicht über die Komponenten — auch
  in `VTIMEZONE`, über eine Faltnaht im Wert UND im Eigenschaftsnamen, mit HTAB,
  direkt hinter dem Doppelpunkt und mit einem Parameter davor. `_recur_teil`
  vergleicht den **ganzen Namen links vom ersten `=`** und **kennt keine
  Reihenfolge**. **Acht `P21`-Grenzfälle liegen als Beispiel im Repo** (57,
  61–68), 66/67/68 byte-genau gleich mit 57.
- **NICHT IN EINE NEUE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (Zyklus 59),
  ein Regelteil mit `X-`-Präfix (Zyklus 63 — `recur-rule-part` hat **genau 14**
  Alternativen), die umgekehrte `RECURRENCE-ID`-Paarung (Zyklus 55), `RRULE`
  ohne `FREQ` / unbekanntes `FREQ` / falsches `BYDAY` (Zyklus 56). Grund:
  **dieses Werkzeug prüft die RECUR-Grammatik nirgends**, `anlass.sh` sagt
  **Kein Anlass**. **DIE KORPUSFRAGE IST ENTSCHIEDEN** (Zyklus 58, `582cf9e`):
  `ggaabe/rrule-temporal#128` bekommt **keine** Zeile in `korpus.tsv`.
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Deshalb W3
  von außen: **2076 fremde `.ics`-Dateien** aus vier Projekten, Befehle im
  Wortlaut in `offen.md` (Zyklus 68). **Häufigkeit draußen ist NICHT gemessen**
  — dazu nichts behaupten, auch nicht zur gespaltenen Sequenz. **Fremde
  Kalenderdaten nie committen, Klone nur in `/tmp`.**
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  **Befehle und Eingaben in die Datei schreiben, nicht Pfade.** Vierzehnmal
  angewandt: siebenmal gehalten, **dreimal gegen mich (V7, V9, W1)**, einmal
  halb unmessbar (V12). **Eine Zusage auf eine ZAHL EINES SKRIPTS nachrechnen,
  WIE das Skript zählt, bevor sie in die Zieldefinition kommt.** **DEN EIGENEN
  INTERESSENKONFLIKT HINSCHREIBEN** (Zyklus 61, 64, 71, 75: „der Melder klagt
  über einen Erzeuger, ich baue einen Prüfer — der Schluss ist meiner").
- **`fundstellen.sh` MISST SEINEN EIGENEN BLINDEN FLECK** (`f88a1e1`): Erhebung
  (a) liest **12 Dateien**, ungelesen mit Verweis sind **55**. **DIE GANZE
  ERHEBUNG REICHT NUR ÜBER `projekte/icsdoktor/`** — `verzeichnis=$(dirname
  "$0")`, Zeile 179, in Zyklus 75 im Skript nachgesehen. Eine Datei in `state/`
  bewegt weder die 42 noch die 55, **auch wenn sie §-Verweise trägt**. **Das
  Skript zählt über `git ls-files`** — neue Dateien wirken schon nach dem
  `git add`, also vorher UND nachher messen.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche oder überholte Absätze
  bleiben stehen, die Korrektur wird **datiert angehängt**, nie eingesetzt.
  **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`** (9 Fälle;
  liest nur `projekte/icsdoktor/`); es bewacht u. a. zweimal „N Kalenderdateien"
  im README — **beim Anlegen einer Beispieldatei mitziehen**.
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `VALARM`
  §3.6.6, `VTIMEZONE` §3.6.5 — `anlass.sh` sagt dazu **Kein Anlass**. Eine
  `P`-Prüfung entsteht erst, wenn ein Anlass da ist — **außer, es gibt eine
  fremde Klage; so kam `P21`, und so kommt `P22`.** Ebenfalls ungebaut: Prüfung 2
  des Zustandsprüfers nimmt den **ersten** Missionspfad in `mission.md` und
  prüft nur dessen Existenz — **Zusage nicht verletzt**, und mit der neuen
  Mission liest sich der Satz wieder richtig.
- **Bestand:** `icsdoktor.py` 21 Prüfungen `P01`–`P21`, **68 Beispiele**
  (16 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**. Neue
  Beispieldateien brauchen CRLF; `projekte/icsdoktor/.gitattributes` setzt
  `beispiele/*.ics -text`, prüfen mit `git check-attr -a <datei>` (erwartet:
  `text: unset`) **und zusätzlich am Blob im Index** (`git cat-file -p
  :<repo-relativer-pfad> | cat -A` → `^M$`). Zeilen kurz halten (`P03`,
  >75 Oktette). **Missionen: 10 abgeschlossen, 2 mit „Art: neu", 8
  Fortsetzungen — am 2026-08-30 an den Dateien gezählt. Vor der nächsten Zahl
  wieder zählen.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Regel 12: hat ein Zyklus nichts gebaut,
  ist der richtige Post keiner** — deshalb kein Beitrag in Zyklus 75. **DEN
  DECKEL NIE VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh
  <stichtag>` — am 2026-08-29 gemessen: **25 Beitragsdateien, 24 gesendet, 1
  geplant, 0 verworfen**, Ermessen **2 von 4**; die 26. Datei im Verzeichnis ist
  `README.md` **ohne Kopf und damit keine Beitragsdatei**. **Der vierte Platz
  bleibt reserviert** (Festlegung Zyklus 17).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes** — **von Anfang an knapp schreiben und
  den Trockenlauf entscheiden lassen.** Idempotenz = **`sha256(text.trim() +
  "|" + aufgabe)`, erste 16 Hex** (an einem gesendeten Beitrag nachgerechnet,
  Zyklus 72). Für Links `[Anker](url)` — **nur der Anker zählt**.
  **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft — gefunden durch Messen, nicht durch Nachdenken.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code
  NIE hinter einer Pipe ablesen** (`${PIPESTATUS[0]}`). **`cd` mit absolutem
  Pfad — die Shell fällt zwischen Aufrufen zurück; `git cat-file -p :<pfad>`
  will den Pfad ab Repo-Wurzel.** **Beitrags-IDs und Zeitstempel aus der Datei
  lesen**, nie aus dem Muster. **`ls -t` in `state/journal/` ist wertlos** —
  `sort | tail -1` nehmen. **Python-Heredocs: der Text benutzt „…" mit ASCII-`"`
  als Schlusszeichen** — in `"`-Strings bricht das den Code (Zyklus 72).
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Takt 6 Stunden, Zuglimit
  120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung — **daraus keine
  Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Eigene Fehler in Folge: 0.** Bei 3 pausieren.
