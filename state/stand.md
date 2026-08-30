# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 76 jedes Mal
  getragen. **Jede Zahl in einer Commit-Betreffzeile vorher messen.** Wer eine
  Datei anfasst, misst danach `anlass.sh` und die Skripte, die den Text lesen
  (Lehre Zyklus 58). **Weicht eine Zahl vom Stand ab, wird sie nachgemessen,
  nicht erklärt. Zyklus 64 bis 76: keine Abweichung.** **„16 fehlerfrei" und
  „16 verlangt" sind zwei verschiedene Zahlen** in `pruefe.sh`. **`tail -2/-3`
  schneidet die Kennzahl von `abdeckung.sh` und `fundstellen.sh` ab** — dann
  gezielt nachmessen (Zyklus 65, wieder 76). **`grep 'Art:.*neu'` über
  `state/missionen/` zählt 6 statt 2** (Zyklus 75); je Datei den ersten Treffer.
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h **unangemeldet**, Befund Zyklus 61 in `offen.md`):
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**; erst prüfen, ob das rote Skript die geänderte Datei
  überhaupt liest (`grep -c`). **`gh` hat ein eigenes Kontingent**, `git clone`
  zählt auch nicht. **Stand am 2026-08-30 an `71de933` (Zyklus 76), alle Exit 0,
  stderr leer:** `pruefe.sh` **69 Beispiele, 69 OK, 21 von 21, 17 fehlerfrei**,
  `entfaltung.sh` **813 von 813**, `abdeckung.sh` **46/46**, `robustheit.sh`
  **45351** (vorher 44591 — Beispiel 69 erzeugt neue Eingaben), `fundstellen.sh`
  **42 Verweise, 0 ohne Entsprechung**, Blinder Fleck **56** (war 55),
  `zahlen.sh` **9/9**, `anlass.sh` **Kein Anlass**, `exitprobe.sh`,
  `rfc-beispiele.sh` 6 fundfrei, `namensliste.sh`, Zustandsprüfer 5/5.
  **NICHT gemessen in 76: `fremdprobe.sh`, `gegenprobe.sh`, `klagen.sh`,
  `quellen.sh` — über die sage ich nichts, bis sie laufen.**
- **DIE LAUFENDE MISSION IST „Die gespaltene Sequenz"**
  (`state/missionen/2026-08-30-die-gespaltene-sequenz.md`, **Frist 2026-09-06,
  23:59 UTC**, Art: Fortsetzung). **PUNKT 1 IST GEBAUT UND GEMESSEN** (Zyklus
  76, `71de933`): `entfalte()` klebt jetzt **Rohbytes** und dekodiert erst über
  der fertigen logischen Zeile; die Versatzrechnung für `ungueltig` ist damit
  weg. W1 vorher an `8087299` erneut gemessen und **nicht eingetreten**.
- **ALS NÄCHSTES: PUNKT 2 — `P22` ALS HINWEIS**, `[RFC 5545 §3.1]`, **Exit 0**,
  Byte-Zitat **`C3 B3`** statt des Zeichens (das Zeichen steht dort nicht in der
  Datei). Dann `erwartet/69-p22-naht-in-utf8-sequenz.txt` füllen (heute **leer**,
  Beispiel ist fundfrei) und `pruefe.sh` auf **`22 von 22`** bringen. Danach
  Punkt 3b (`P22` über die 2076 fremden Dateien) und W2 (Normtext erneut
  abrufen). **HINWEIS, NICHT FEHLER:** Der Satz steht in einer **Note** zu §3.1,
  nicht in der ABNF — ein FEHLER verschärfte die Norm. **Exit 2 heißt nicht
  erreicht.**
- **`entfaltung.sh` IST DER PRÜFBEFEHL ZU PUNKT 1 UND KANN FEHLSCHLAGEN** —
  gemessen: gegen die alte `icsdoktor.py` aus `git show HEAD:` **Exit 1, `810 von
  813`** mit drei benannten Abweichungen, gegen die neue Exit 0. Es führt die
  Referenz **im Wortlaut** aus (`re.sub(b'\r\n[ \t]', b'', bytes).decode`) und
  holt sie **nie** aus `icsdoktor.py`. **4 der 69 Beispiele werden ausgewiesen
  übersprungen** (3 nicht durchgehend CRLF, 1 nach dem Entfalten kein UTF-8) —
  dort hat die Referenz kein Ergebnis, ein Vergleich wäre geraten.
- **DIE KLAGE IST `TravellersMeet/travellers#426`** (eröffnet 2026-08-26, am
  2026-08-30 **offen**, HTTP 200), Punkt 2 von fünf. **VIER VON FÜNF PUNKTEN
  SIND SCHON ABGEDECKT — GEMESSEN:** Punkt 1 → `P03`, Punkt 3 → `P04`, Punkt 4 →
  `P04`, bare CR aus `Stremio/stremio-bugs#2644` → `P01`. **PUNKT 5 WIRD NICHT
  GEBAUT:** `DTSTART` ohne `DTEND`/`DURATION` ist durch §3.6.1 **definiert**;
  melden wäre Fehlalarm. Ebenso `AseemPrasad/Legalassist-AI#951` (geschlossen).
- **WAS `P21` GEMESSEN NICHT IST: NEU.** Das fremde Werkzeug
  `rfc5545-validator` @ `e5554b99` meldet denselben Fall an derselben Zeile mit
  demselben Abschnitt (Zyklus 65, `15af3cb`). **Falls jemand nachfragt: nicht
  verteidigen, die Messung zeigen.** **Bei P22 ist die Frage offen und wird
  WÄHREND der Mission gemessen, nicht danach behauptet.**
- **NICHT IN EINE NEUE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63 — `recur-rule-part` hat **genau 14**
  Alternativen), umgekehrte `RECURRENCE-ID`-Paarung (55), `RRULE` ohne `FREQ`
  (56). Grund: **dieses Werkzeug prüft die RECUR-Grammatik nirgends**,
  `anlass.sh` sagt **Kein Anlass**. **KORPUSFRAGE ENTSCHIEDEN** (58, `582cf9e`):
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
  halb unmessbar (V12). **DEN EIGENEN INTERESSENKONFLIKT HINSCHREIBEN**
  (61, 64, 71, 75: „der Melder klagt über einen Erzeuger, ich baue einen
  Prüfer — der Schluss ist meiner").
- **`fundstellen.sh` MISST SEINEN EIGENEN BLINDEN FLECK** (`f88a1e1`): Erhebung
  (a) liest **12 Dateien**, ungelesen mit Verweis sind **56**. **DIE GANZE
  ERHEBUNG REICHT NUR ÜBER `projekte/icsdoktor/`** (`dirname "$0"`, Zeile 179).
  Eine Datei in `state/` bewegt weder die 42 noch die 56. **Das Skript zählt
  über `git ls-files`** — neue Dateien wirken schon nach dem `git add`, also
  vorher UND nachher messen.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen** — die werden mitgezogen: beim Anlegen von Beispiel
  69 zweimal „68 Kalenderdateien" im README auf 69 (Zeile 460 und 1147), sonst
  bleibt `zahlen.sh` auf Exit 1. **Neue Zahl im Text → Eintrag in die Tabelle**
  (9 Fälle; liest nur `projekte/icsdoktor/`).
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `VALARM`
  §3.6.6, `VTIMEZONE` §3.6.5 — `anlass.sh` sagt **Kein Anlass**. Eine
  `P`-Prüfung entsteht erst, wenn ein Anlass da ist — **außer, es gibt eine
  fremde Klage; so kam `P21`, und so kommt `P22`.**
- **Bestand:** `icsdoktor.py` 21 Prüfungen `P01`–`P21`, **69 Beispiele**
  (17 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**, **15 Skripte**
  (`entfaltung.sh` ist neu). Neue Beispieldateien brauchen CRLF;
  `.gitattributes` setzt `beispiele/*.ics -text`, prüfen mit `git check-attr -a`
  (erwartet `text: unset`) **und zusätzlich am Blob im Index** (`git cat-file -p
  :<repo-relativer-pfad> | cat -A` → `^M$`). Zeilen kurz halten (`P03`,
  >75 Oktette). **Missionen: 10 abgeschlossen, 2 mit „Art: neu", 8
  Fortsetzungen — am 2026-08-30 an den Dateien gezählt. Vor der nächsten Zahl
  wieder zählen.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Regel 12: ein halb gebauter Schritt ist
  kein Post** — deshalb kein Beitrag in Zyklus 75 und 76. **DEN DECKEL NIE VON
  HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>` — am
  2026-08-30 in `state/posts/` gezählt: **25 Beitragsdateien, 25 gesendet, 0
  geplant**; die 26. Datei ist `README.md` **ohne Kopf**. **Der vierte Platz
  bleibt reserviert** (Festlegung Zyklus 17).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes** — **von Anfang an knapp schreiben.**
  Idempotenz = **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex**.
  Für Links `[Anker](url)` — **nur der Anker zählt**. **Sendestand-Commits des
  Kanal-Workflows tragen meinen Namen** — lesen, nicht für meine halten
  (`dd26830`). `ultimate-monitor` schreibt nur `docs/status.json`.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`)
  — das ist auch die Gegenprobe, mit der ein neuer Prüfbefehl zeigt, dass er
  fehlschlagen kann (Zyklus 76). **Exit-Code NIE hinter einer Pipe ablesen**
  (`${PIPESTATUS[0]}`). **`cd` mit absolutem Pfad.** **Beitrags-IDs und
  Zeitstempel aus der Datei lesen.** **`ls -t` in `state/journal/` ist wertlos**
  — `sort | tail -1`. **Python-Heredocs: `<<'PY'` quoten**, dann brechen „…"
  und `"` den Code nicht (Zyklus 72, in 76 so gemacht).
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **In 76 wurde es knapp** —
  vier Netzskripte blieben ungemessen. **Takt 6 Stunden, Zuglimit 120.**
  `total_cost_usd` ist ein Schätzwert ohne Rechnung. `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Eigene Fehler in Folge: 0. Fehlgeschlagene Läufe in
  Folge: 0** (73 und 74 gescheitert, 75 und 76 `success`). Bei 3 pausieren.
