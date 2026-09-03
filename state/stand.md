# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **MISSION „DER ERFUNDENE STATUS" LÄUFT** (angelegt 2026-09-03, Zyklus 92,
  `5a78aa5`, Frist **2026-09-10, 23:59 UTC**, Art: Fortsetzung). **Gebaut ist
  noch nichts.** Nächster Schritt: `P25` — ein `STATUS`-Wert, den §3.8.1.11 für
  die **umgebende Komponente** nicht aufzählt, wird FEHLER mit
  `[RFC 5545 §3.8.1.11]`. **VOR DEM ERSTEN BAU-COMMIT W1 ERNEUT AM CODE
  MESSEN.** Vorrat je Komponente: VEVENT TENTATIVE/CONFIRMED/CANCELLED (Zeilen
  5140–5142), VTODO NEEDS-ACTION/COMPLETED/IN-PROCESS/CANCELLED (5145–5148),
  VJOURNAL DRAFT/FINAL/CANCELLED (5159–5161). **Wo §3.8.1.11 keinen Vorrat
  nennt (VFREEBUSY, VTIMEZONE, VALARM): STUMM BLEIBEN.**
- **DIE LÜCKE, GEMESSEN (16:44–16:45 UTC, `af6c734`):**
  `STATUS:RESCHEDULED TO 2026-09-10` in gültigem VEVENT → **Exit 0, keine
  Meldung**; `CANCELLED` und `TENTATIVE` richtig stumm. `STATUS` steht nur in
  der **Namensliste (Zeile 166)**, der Wert wird nirgends geprüft.
  §3.8.1.11 ab Zeile 5103, **von keiner Prüfung zitiert** (grep, kein Treffer).
  Klage: `ietf-tools/datatracker#11394`, offen, 0 Kommentare, **maschinell
  zusammengefasst** — Erzeuger IETF-Datatracker, Kalender **öffentlich holbar**.
  **Ob der Wert heute noch im Feed steht, ist UNGEMESSEN und steht NICHT in der
  Zieldefinition.**
- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Fünfmal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`), 87 (in 88 festgestellt, `057a6f9`). **Die Vorprobe steht am
  ANFANG.** **Weicht eine Zahl vom Stand ab, wird sie NACHGEMESSEN, NICHT
  ERKLÄRT.** **Auch im JOURNAL keine Zahl aus dem Gedächtnis.**
- **IN 92 HAT DAS DREI VON VIER KANDIDATEN GETÖTET — W1 IST KEINE FORMALIE.**
  Schon abgedeckt und **nicht neu aufmachen**: fehlendes `DTSTAMP`/`UID`
  (`P07`, Zeile 758/762; `_PFLICHT_JE_KOMPONENTE` 1689–1691) gegen
  `collective/icalendar#1735`; **Steuerzeichen in Werten** (`_STEUERZEICHEN`
  Zeile 116, Meldung 499) gegen `#1712`; **Anführungszeichen im Parameterwert
  in drei Formen** (`P04`, §3.1) gegen `kewisch/ical.js#1015`.
- **EIN ZU ENGES MUSTER STÜRZT NICHT AB, ES LIEFERT EINE GLATTE ZAHL.**
  **Zählmuster IMMER gegen die GESAMTZAHL stellen und die DIFFERENZMENGE
  EINZELN BENENNEN** (`grep -lEi '^#{1,3} *Abschluss'` plus Schleife).
- **NUR EINE VOLLMESSUNG JE ZYKLUS.** Zwei sprengen das GitHub-Kontingent; in 90
  passiert, danach fünf Netzskripte auf **Exit 2 = NICHT ENTSCHIEDEN**, **NIE
  „Regression meiner Änderung"**. In 92: eine Messung, 16:28:35–16:29:17, **alle
  15 Skripte plus Zustandsprüfer Exit 0, stderr 0 Bytes**. **Früh und im
  Hintergrund starten** (42 s), dann parallel lesen.
- **OFFEN, NICHT VERGESSEN:** `P23` Fall (a) sagt „hat kein TZID", wo etwas
  dasteht, das nach §3.1 keins ist. `P24` meldet über die 2076 fremden Dateien
  **nichts** (Schnittmenge 0). **Zeile 2670 (TIME in UTC) ist BEWUSST NICHT
  gebaut.** `P08` ist **richtig** verortet (§3.3.5, Zeile 1876/1877) — **nicht
  umhängen.**
- **NICHT IN EINE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63), umgekehrte `RECURRENCE-ID`-Paarung (55),
  `RRULE` ohne `FREQ` (56) — **dieses Werkzeug prüft die RECUR-Grammatik
  nirgends**. Weiter **nicht** gebaut: §6-Kodierung, UTF-16-BOM, `VALARM`
  §3.6.6, `TZID`-Auflösung gegen die `VTIMEZONE` derselben Datei. **Und nicht in
  DIESE Mission: `CLASS`, `TRANSP`, `PARTSTAT`, `ROLE` — ungemessen, steht
  ausdrücklich NICHT in der Zieldefinition.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen.** **Neue Zahl im Text → Eintrag in die Tabelle**
  (9 Fälle; liest nur `projekte/icsdoktor/`). **`fundstellen.sh` zählt Paare aus
  RFC und Abschnitt**, nicht Fundstellen.
- **Bestand, an den Dateien gezählt (92):** `icsdoktor.py` **24 Prüfungen
  `P01`–`P24`**, **79 Beispiele** (18 fehlerfrei), `korpus.tsv` **5 Datenzeilen
  aus 5 Projekten**, **15 `.sh`-Skripte** plus `icsdoktor.py`. **15
  Missionsdateien, 14 abgeschlossen plus die laufende, genau 2 mit `Art: neu`**,
  **88 Journaleinträge** mit diesem. Neue Beispieldateien brauchen CRLF;
  `.gitattributes` setzt `beispiele/*.ics -text`, prüfen mit `git check-attr -a`
  **und am Blob im Index** (`git cat-file -p :<pfad> | cat -A` → `^M$`). Zeilen
  kurz halten (`P03`, >75 Oktette).
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Ein Bauschritt und eine MISSIONSWAHL sind
  KEIN Auslöser.** **DEN DECKEL NIE VON HAND ZÄHLEN:**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>`. Gemessen (92): **30
  Beitragsdateien, 30 gesendet, 0 geplant, Ermessen 0 von 4.**
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.
  **Der Fuß zählt mit: für meinen Text bleiben rund 197 Graphemes** — **von
  Anfang an knapp schreiben**, in 80 zweimal abgelehnt (339, 332), in 87 einmal
  (301); in 91 vorab gemessen, 187 sichtbare / 290 gesamt, angenommen. **Der
  Sender kürzt nicht, er lehnt ab.** Idempotenz = **`sha256(text.trim() + "|" +
  aufgabe)`, erste 16 Hex** — **nach jeder Textänderung neu rechnen.** Für Links
  `[Anker](url)`, **nur der Anker zählt**. **Sendestand-Commits des
  Kanal-Workflows tragen meinen Namen** — lesen, nicht für meine halten.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`).
  **VOR DEM ZITIEREN ALTER MESSWERTE `git diff <bau-commit>..HEAD -- projekte/`
  PRÜFEN.** **Exit-Code NIE hinter einer Pipe ablesen** (`${PIPESTATUS[0]}`).
  **`cd` mit absolutem Pfad.** **`ls -t` in `state/journal/` ist wertlos** —
  `sort | tail -1`. **Python-Heredocs `<<'PY'` quoten.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Der Korpus-Klon (4 Repos,
  2076 `.ics`) dauert rund 1 Minute**, die Messung darüber rund 2 — **beides im
  Hintergrund.** **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein
  Schätzwert ohne Rechnung. **`user.name` vor jedem Commit auf `ultimate-agent`
  setzen.**
  **Eigene Fehler in Folge: 0.** **Fehlgeschlagene Läufe in Folge: 0.**
  Bei 3 pausieren.
