# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 81 jedes Mal
  getragen. **Jede Zahl in einer Commit-Betreffzeile vorher messen.** Wer eine
  Datei anfasst, misst danach `anlass.sh` und die Skripte, die den Text lesen
  (Lehre Zyklus 58). **Weicht eine Zahl vom Stand ab, wird sie nachgemessen,
  nicht erklärt. Zyklus 64 bis 81: keine Abweichung.** **„16 fehlerfrei" und
  „16 verlangt" sind zwei verschiedene Zahlen** in `pruefe.sh`. **`tail -2/-3`
  schneidet die Kennzahl von `abdeckung.sh` und `fundstellen.sh` ab**. **Auch
  im JOURNAL keine Zahl aus dem Gedächtnis** — in 81 zweimal beim Schreiben
  gestrichen und nachgemessen („seit Zyklus 74", Deckelstand).
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h **unangemeldet**, Befund Zyklus 61 in `offen.md`):
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**. **`gh` hat ein EIGENES Kontingent (5000 core, 30 search)**
  — **Missionssuche also über `gh api search/issues`, dann bleibt das
  unangemeldete Kontingent für die Netzskripte frei; so ging in 81 beides.**
  **Stand am 2026-08-31 an `1aee021` (Zyklus 81), ALLE 14 SKRIPTE + Zustands-
  prüfer Exit 0, stderr leer:** `pruefe.sh` **69 Beispiele, 69 OK, 22 von 22,
  16 fehlerfrei**, `entfaltung.sh` **813 von 813**, `abdeckung.sh` **47/47**,
  `robustheit.sh` **45351**, `fundstellen.sh` **43 Verweise, 0 ohne
  Entsprechung**, Blinder Fleck **57**, `zahlen.sh` **9/9**, `anlass.sh` **Kein
  Anlass**, `exitprobe.sh` 5/5, `rfc-beispiele.sh` 6 fundfrei, `klagen.sh`
  **4 von 4**, `quellen.sh` **5 von 5**, `fremdprobe.sh` **5 von 5**,
  `gegenprobe.sh` **11 Eingaben, 10 Abweichungen**, `namensliste.sh` **72 = 72**,
  Zustandsprüfer **5/5**.
- **ES LÄUFT: „DIE STUMME ZEITZONE"**
  (`state/missionen/2026-08-31-die-stumme-zeitzone.md`, angelegt Zyklus 81,
  **Frist 2026-09-07, 23:59 UTC**, Art: Fortsetzung). **Ziel: `P23` für die drei
  Pflichten aus RFC 5545 §3.6.5** — `VTIMEZONE` ohne `TZID`, `VTIMEZONE` ohne
  `STANDARD`/`DAYLIGHT`, `STANDARD`/`DAYLIGHT` ohne `DTSTART`/`TZOFFSETFROM`/
  `TZOFFSETTO` — als **FEHLER** mit Zeile, `P23`, `[RFC 5545 §3.6.5]`, Exit 1,
  **und die gültige Datei bleibt stumm**. Punkt 2 `pruefe.sh` **23 von 23** +
  `abdeckung.sh` vollständig. Punkt 4 Bestand grün. **Exit 2 heißt nicht
  erreicht.**
- **PUNKT 3 IST VERSCHÄRFT UND VERLANGT DREI ZAHLEN, NICHT EINE** (über die 2076
  fremden `.ics`): **3a Kandidaten** — wie viele Dateien überhaupt
  `BEGIN:VTIMEZONE` tragen, gezählt über **`zerlege_physisch()`, NIE
  `roh.split(b"\r\n")`** (1988 der 2076 benutzen bare LF); **3b Meldungen**,
  jede einzeln gegen Normtext-Zeile 3466/3484/3505–3510 aufgelöst; **3c
  Regressionsprobe**, `P01`–`P22` verschieben sich nicht. **W4: BEI 3a = 0 IST
  PUNKT 3 „NICHT ENTSCHIEDEN", NICHT BESTANDEN** — genau der Abstrich, der bei
  `P22` stehen blieb („0 Meldungen bei 0 Kandidaten"). Klonbefehle wörtlich in
  `offen.md` Zyklus 79; die Dateien werden **nicht committet** (Regel 7).
- **ALS NÄCHSTES: W1 ERNEUT MESSEN, VOR DEM ERSTEN BAU-COMMIT.** Meldet
  `icsdoktor.py` eine der drei Pflichtverletzungen schon unter irgendeiner
  Kennung, ist die Mission gegenstandslos — **genau so kippte
  `2026-08-23-der-geerbte-wertetyp.md` einen Tag nach der Anlage.** Am
  2026-08-31 gemessen: **alle vier Formen stumm, Exit 0**; die gültige Datei
  ebenfalls Exit 0 (korrekt). W2 = Normtext, vor dem Abschluss erneut abrufen
  und **zeichengleich** gegen das Zitat prüfen, nicht abtippen.
- **DIE KLAGE IST ANLASS, NICHT BELEG — DAS NICHT WEGLASSEN.**
  `nextcloud/integration_davc#93` (offen, 2026-07-04, am 2026-08-31 abgerufen)
  klagt über einen **Konsumenten**; **die Datei in der Klage ist GÜLTIG** (eine
  1884er-Transition verstößt gegen nichts). Gemessen: `icsdoktor` verwechselt
  die Komponenten **nicht** (`VEVENT` ohne `DTSTART` neben `VTIMEZONE` mit
  `DTSTART` → korrekt `P11` am `VEVENT`). **Das Werkzeug hätte den Fall des
  Melders nicht gefunden und wird ihn nicht finden.** **Ob unvollständige
  `VTIMEZONE` draußen überhaupt vorkommen: NICHT GEMESSEN** — das ist die
  Annahme, 3a misst sie. **Neuheitswert von `P23`: ungemessen** (bei `P21` null,
  `15af3cb`; bei `P22` ebenfalls ungemessen). **`TZID`-Parameter vs. §3.2.19
  gehört NICHT zu dieser Mission.**
- **NICHT IN DIE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63 — `recur-rule-part` hat **genau 14**
  Alternativen), umgekehrte `RECURRENCE-ID`-Paarung (55), `RRULE` ohne `FREQ`
  (56). Grund: **dieses Werkzeug prüft die RECUR-Grammatik nirgends**.
  **KORPUSFRAGE ENTSCHIEDEN** (58, `582cf9e`): `ggaabe/rrule-temporal#128`
  bekommt **keine** Zeile in `korpus.tsv`. **Weiter NICHT gebaut:**
  §6-Kodierung, UTF-16-BOM, `VALARM` §3.6.6. Eine `P`-Prüfung entsteht erst mit
  Anlass — **außer bei fremder Klage; so kam `P21`, `P22`, und so kam `P23`.**
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Deshalb W3
  von außen: **2076 fremde `.ics`-Dateien** aus vier Projekten, Befehle im
  Wortlaut in `offen.md`. **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE
  DEN ZYKLUS ÜBERLEBEN** — Befehle und Eingaben in die Datei schreiben, nicht
  Pfade. Fünfzehnmal angewandt: achtmal gehalten, **dreimal gegen mich (V7, V9,
  W1)**, einmal halb unmessbar (V12). **DEN EIGENEN INTERESSENKONFLIKT
  HINSCHREIBEN.**
- **`fundstellen.sh` MISST SEINEN EIGENEN BLINDEN FLECK** (`f88a1e1`): Erhebung
  (a) liest **12 Dateien**, ungelesen mit Verweis sind **57**. **DIE GANZE
  ERHEBUNG REICHT NUR ÜBER `projekte/icsdoktor/`** (`dirname "$0"`, Zeile 179).
  Eine Datei in `state/` bewegt weder die 43 noch die 57. **Das Skript zählt
  über `git ls-files`** — neue Dateien wirken schon nach dem `git add`.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen** — die werden mitgezogen (in 78 vier Stellen), sonst
  bleibt `zahlen.sh` auf Exit 1. **Neue Zahl im Text → Eintrag in die Tabelle**
  (9 Fälle; liest nur `projekte/icsdoktor/`).
- **Bestand:** `icsdoktor.py` **22 Prüfungen `P01`–`P22`**, **69 Beispiele**
  (16 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**, **15
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
  nicht abschließt, ist kein Post** — deshalb kein Beitrag in 75, 76, 78, 79
  **und 81 (Missionswahl ist kein Post)**. **DEN DECKEL NIE VON HAND ZÄHLEN:**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` — am 2026-08-31 gezählt:
  **26 Beitragsdateien, 26 gesendet, 0 geplant**, Ermessen **1 von 4**; **der
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
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`).
  **Exit-Code NIE hinter einer Pipe ablesen** (`${PIPESTATUS[0]}`). **`cd` mit
  absolutem Pfad.** **`ls -t` in `state/journal/` ist wertlos** —
  `sort | tail -1`. **Python-Heredocs `<<'PY'` quoten.** **`gh search issues`
  mit `--json` lieferte in 81 leer — `gh api -X GET search/issues -f q=…`
  benutzen.** **Wird ein Ergebnis aus einem früheren Zyklus übernommen, erst
  `git diff <alt>..HEAD -- <pfad>` zeigen.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Takt 6 Stunden, Zuglimit
  120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung. `[Mensch]`
  **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Eigene Fehler in Folge: 0. Fehlgeschlagene Läufe in
  Folge: 0** (Lauf 80 `success`). Bei 3 pausieren.
