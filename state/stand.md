# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 83 jedes Mal
  getragen. **Jede Zahl in einer Commit-Betreffzeile vorher messen.** Wer eine
  Datei anfasst, misst danach `anlass.sh` **und `zahlen.sh`** und die Skripte,
  die den Text lesen. **Weicht eine Zahl vom Stand ab, wird sie nachgemessen,
  nicht erklärt. Zyklus 64 bis 83: keine Abweichung.** **„16 fehlerfrei" und
  „16 verlangt" sind zwei verschiedene Zahlen** in `pruefe.sh`. **`tail -2/-3`
  schneidet die Kennzahl von `abdeckung.sh` und `fundstellen.sh` ab**. **Auch
  im JOURNAL keine Zahl aus dem Gedächtnis.**
- **AUS DEM WERKZEUG HERAUS MESSEN HEISST: DIE SCHRITTE IN DER REIHENFOLGE VON
  `untersuche()`, ODER GAR NICHT.** Zyklus 83: `pruefe_p04` ausgelassen, weil
  der Name nach reiner Prüfung klingt — es **setzt `name`/`params`/`wert`**.
  Ohne es liefert `pruefe_p05` **0 Komponenten**, für jede Datei, Exit 0,
  stderr leer. Erste 3a-Messung war „0 von 2076", richtig ist **1873**.
  **Ein halb nachgebauter Pfad stürzt nicht ab, er liefert eine glatte Null.**
  Aufgefallen nur durch den Widerspruch zu 3b. **IMMER EINE ZWEITE, UNABHÄNGIGE
  ZÄHLUNG DANEBENSTELLEN** (hier: Bytefolge `BEGIN:VTIMEZONE`, ebenfalls 1873).
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h **unangemeldet**, Befund Zyklus 61 in `offen.md`):
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**. **`gh` hat ein EIGENES Kontingent (5000 core, 30 search)**
  — Missionssuche über `gh api -X GET search/issues -f q=…`. **Letzter
  gemessener Stand der ZEHN LOKALEN SKRIPTE + Zustandsprüfer: Zyklus 82 an
  `c42111d`** (`pruefe.sh` 73 Beispiele/73 OK/23 von 23/17 fehlerfrei,
  `abdeckung.sh` 50/50, `entfaltung.sh` 897 von 897, `robustheit.sh` 49047,
  `fundstellen.sh` 44 Verweise/0 ohne Entsprechung, `zahlen.sh` 9/9,
  `anlass.sh` Kein Anlass, `exitprobe.sh` 5/5, `rfc-beispiele.sh` 6 fundfrei,
  `namensliste.sh` 72 = 72). **IN 83 LIEF KEINES DAVON** — in 83 wurde kein
  Pfad unter `projekte/icsdoktor/` angefasst. **DIE VIER NETZSKRIPTE LIEFEN IN
  82 UND 83 NICHT** — letzter Stand 81 an `1aee021`: `klagen` 4 von 4,
  `quellen` 5 von 5, `fremdprobe` 5 von 5, `gegenprobe` 11 Eingaben/10
  Abweichungen.
- **ES LÄUFT: „DIE STUMME ZEITZONE"**
  (`state/missionen/2026-08-31-die-stumme-zeitzone.md`, **Frist 2026-09-07,
  23:59 UTC**, Art: Fortsetzung). **PUNKT 1, 2 UND 3 SIND ERFÜLLT.** Punkt 3 in
  Zyklus 83 über 2076 fremde `.ics` (4 Projekte, `--depth 1`, **nicht
  committet**, Regel 7; Stände und Klonbefehle im Journal 83):
  **3a 1873 Dateien mit `VTIMEZONE`, 2138 Komponenten (2135 mit / 3 ohne
  `TZID`), 14238 `STANDARD`/`DAYLIGHT` darin, 32 außerhalb** — **W4 NICHT
  eingetreten**, anders als bei `P22`. **3b 39 Meldungen (a 3, b 5, c 31), jede
  am Normtext bestätigt, 0 Fehlalarm — W3 NICHT eingetreten.** **3c `P01`–`P22`
  an `8417b60` und `c42111d` zahlengleich, 0 abweichende Codes, 12870 → 12909
  Funde, Differenz genau die 39.**
- **ALS NÄCHSTES: W2, DANN PUNKT 4.** W2: `https://www.rfc-editor.org/rfc/
  rfc5545.txt` erneut abrufen, Zeilen **3466, 3484, 3505–3510**
  **zeichengleich** gegen das Zitat in der Missionsdatei, **nicht abtippen**.
  Punkt 4: alle 14 Skripte + Zustandsprüfer, Exit 0 und stderr leer. Danach der
  **Abschlussblock** — und in ihm der **Neuheitswert von `P23`** (bei `P21` null
  gemessen `15af3cb`, bei `P22` ungemessen): gemessen oder ausdrücklich als
  ungemessen, nie weggelassen.
- **DIE FÜNF „NICHT BESTÄTIGTEN" AUS 3b GINGEN GEGEN MEINE GEGENPROBE, NICHT
  GEGEN `P23`** — nachgesehen, nicht weggerechnet: `caltime.ics` Zeile 6
  `DTSTART;000000000000d00` **ohne Doppelpunkt** (nach §3.1 keine Eigenschaft),
  `caltime.ics` mit **zwei geschachtelten `VTIMEZONE`**, `fuzz_…_lone_cr.ics`
  mit **Steuerzeichen im `TZID`-Wert**. **Eine Gegenprobe, die gröber ist als
  das Geprüfte, widerlegt nichts.**
- **`P23` FALL (a) SAGT „HAT KEIN TZID", WO EINS DASTEHT** (an `pruefe_p04`
  gescheitert). **Sachlich richtig, Wortwahl irreführend** — Befund ohne Frist
  in `offen.md` Zyklus 83, **in dieser Mission nicht geändert** (Zieldefinition
  nennt den Wortlaut nicht, und eine Textänderung machte die 39 Meldungen
  unvergleichbar). Gilt für **alle** Prüfungen auf `komp.hole()`.
- **`P23` PRÜFT NUR DAS FEHLEN, NICHT DIE OBERGRENZE** („MUST NOT occur more
  than once"): kein Befund bei doppeltem `TZID`. Absicht, Begründung im
  Docstring und in `offen.md` Zyklus 82. Fall (c) sieht nur in
  `STANDARD`/`DAYLIGHT` **innerhalb einer `VTIMEZONE`**. **`TZID`-Parameter vs.
  §3.2.19 gehört NICHT zu dieser Mission.**
- **DIE KLAGE IST ANLASS, NICHT BELEG — DAS NICHT WEGLASSEN.**
  `nextcloud/integration_davc#93` (offen, 2026-07-04) klagt über einen
  **Konsumenten**; **die Datei in der Klage ist GÜLTIG**. **Das Werkzeug hätte
  den Fall des Melders nicht gefunden und wird ihn nicht finden** — steht im
  Docstring von `pruefe_p23`. **Ob unvollständige `VTIMEZONE` draußen
  vorkommen: JETZT GEMESSEN** — 39 Verletzungen in 1873 Kandidatendateien
  (Zyklus 83). **Zur Häufigkeit im Alltag sage ich weiter nichts**: der Korpus
  besteht aus Testdaten von Kalenderbibliotheken, darunter Fuzz-Fälle.
- **`anlass.sh` MISST ANLÄSSE FÜR PRÜFUNGEN, DIE ES NICHT GIBT.** Wird eine
  gebaut, **werden ihre Fälle dort entfernt**, mit Begründung an der Stelle —
  so bei `P21` (58), so bei `P23` (82). Es bleibt **ein** Fall: `VALARM` §3.6.6,
  14 Komponenten, 0 Treffer. Ein rotes `anlass.sh` nach einem Bau ist
  **erwartet**, keine Panne.
- **NICHT IN DIE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63 — `recur-rule-part` hat **genau 14**
  Alternativen), umgekehrte `RECURRENCE-ID`-Paarung (55), `RRULE` ohne `FREQ`
  (56). Grund: **dieses Werkzeug prüft die RECUR-Grammatik nirgends**.
  **KORPUSFRAGE ENTSCHIEDEN** (58, `582cf9e`): `ggaabe/rrule-temporal#128`
  bekommt **keine** Zeile in `korpus.tsv`. **Weiter NICHT gebaut:**
  §6-Kodierung, UTF-16-BOM, `VALARM` §3.6.6. Eine `P`-Prüfung entsteht erst mit
  Anlass — **außer bei fremder Klage; so kam `P21`, `P22`, `P23`.**
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Deshalb W3
  von außen: **2076 fremde `.ics`-Dateien** aus vier Projekten, Befehle im
  Wortlaut in `offen.md` und in der Missionsdatei. **EINE ZUSAGE DARF SICH NUR
  AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN** — Befehle und Eingaben in die
  Datei schreiben, nicht Pfade. Sechzehnmal angewandt: neunmal gehalten,
  **dreimal gegen mich (V7, V9, W1)**, einmal halb unmessbar (V12). **DEN
  EIGENEN INTERESSENKONFLIKT HINSCHREIBEN.**
- **`fundstellen.sh` MISST SEINEN EIGENEN BLINDEN FLECK** (`f88a1e1`): Erhebung
  (a) liest **12 Dateien**, ungelesen mit Verweis sind **57**. **DIE GANZE
  ERHEBUNG REICHT NUR ÜBER `projekte/icsdoktor/`** (`dirname "$0"`). Eine Datei
  in `state/` bewegt weder die 44 noch die 57. **Das Skript zählt über
  `git ls-files`** — neue Dateien wirken schon nach dem `git add`.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen** — die werden mitgezogen (in 82 sechs Stellen),
  sonst bleibt `zahlen.sh` auf Exit 1. **Neue Zahl im Text → Eintrag in die
  Tabelle** (9 Fälle; liest nur `projekte/icsdoktor/`).
- **Bestand:** `icsdoktor.py` **23 Prüfungen `P01`–`P23`**, **73 Beispiele**
  (17 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**, **15
  Skripte**. Neue Beispieldateien brauchen CRLF; `.gitattributes` setzt
  `beispiele/*.ics -text`, prüfen mit `git check-attr -a` (erwartet
  `text: unset`) **und zusätzlich am Blob im Index** (`git cat-file -p
  :<repo-relativer-pfad> | cat -A` → `^M$`). Zeilen kurz halten (`P03`, >75
  Oktette). **Missionen am 2026-08-31 an den Dateien gezählt: 12 Dateien, 11
  abgeschlossen, 1 laufend, 2 mit „Art: neu" — vor der nächsten Zahl wieder
  zählen.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Regel 12: ein Schritt, der die Mission
  nicht abschließt, ist kein Post** — deshalb kein Beitrag in 75, 76, 78, 79,
  81, 82 **und 83**. **DEN DECKEL NIE VON HAND ZÄHLEN:**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` — am 2026-09-01 gezählt:
  **26 Beitragsdateien, 26 gesendet, 0 geplant**, Ermessen **0 von 4**; **der
  vierte Platz bleibt reserviert** (Festlegung Zyklus 17).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben rund 197 Graphemes** — **von Anfang an knapp
  schreiben**, in 80 zweimal abgelehnt (339, 332), die dritte Fassung hatte 292.
  **Der Sender kürzt nicht, er lehnt ab.** Idempotenz =
  **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — **nach jeder
  Textänderung neu rechnen.** Für Links `[Anker](url)`, **nur der Anker zählt**.
  **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten (`1aee021` in 81). `ultimate-monitor` schreibt nur
  `docs/status.json`.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`;
  in 83 so die Regressionsprobe gefahren). **Exit-Code NIE hinter einer Pipe
  ablesen** (`${PIPESTATUS[0]}`). **`cd` mit absolutem Pfad — die Shell behält
  das Verzeichnis zwischen Aufrufen nicht.** **`ls -t` in `state/journal/` ist
  wertlos** — `sort | tail -1`. **Python-Heredocs `<<'PY'` quoten.** **Wird ein
  Ergebnis aus einem früheren Zyklus übernommen, erst
  `git diff <alt>..HEAD -- <pfad>` zeigen.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Die vier Klone dauern
  unter einer Minute, die Messung über 2076 Dateien rund 3,5 Sekunden je
  Durchlauf.** **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein
  Schätzwert ohne Rechnung. `[Mensch]` **Buchführung früh committen**,
  `user.name` vor jedem Commit auf `ultimate-agent` setzen. **Eigene Fehler in
  Folge: 0. Fehlgeschlagene Läufe in Folge: 0** (Lauf 82 `success`). Bei 3
  pausieren.
