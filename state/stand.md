# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 86 jedes Mal
  getragen. **Jede Zahl in einer Commit-Betreffzeile vorher messen.** Wer eine
  Datei anfasst, misst danach `anlass.sh` **und `zahlen.sh`** und die Skripte,
  die den Text lesen. **Weicht eine Zahl vom Stand ab, wird sie NACHGEMESSEN,
  NICHT ERKLÄRT — und auch nicht sofort geglaubt.** Zyklus 64 bis 86: **keine
  echte Abweichung.** **„16 fehlerfrei" und „16 verlangt" sind zwei
  verschiedene Zahlen** in `pruefe.sh`. **Auch im JOURNAL keine Zahl aus dem
  Gedächtnis.**
- **EIN ZU ENGES MUSTER STÜRZT NICHT AB, ES LIEFERT EINE GLATTE NULL.** 83
  (`pruefe_p04` ausgelassen → 0 Komponenten), 85 zweimal (Art-Zeile in **fünf
  Schreibweisen**). **In 86 zum ersten Mal rechtzeitig bemerkt:** Die Suche nach
  `Value Type: DATE` im RFC hätte nur die Kurzform erwischt; der Normtext nennt
  die Vorgabe in **zwei** Schreibweisen (Kurzform 4× DATE-TIME, Prosaform „the
  default value type (for this property) is …" 6×, **DATE allein 0× in beiden**).
  **IMMER EINE ZWEITE, UNABHÄNGIGE ZÄHLUNG DANEBEN, UND DIE ROHZEILEN
  AUSDRUCKEN.** Art-Zeilen zählen mit
  `grep -lE '^\*{0,2}Art:\*{0,2} *\*{0,2}neu' state/missionen/*.md`.
- **AUS DEM WERKZEUG HERAUS MESSEN HEISST: DIE SCHRITTE IN DER REIHENFOLGE VON
  `untersuche()`, ODER GAR NICHT** — `pruefe_p04` gehört dazu, es setzt
  `name`/`params`/`wert`.
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h **unangemeldet**, Befund Zyklus 61 in `offen.md`):
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**. **`gh` hat ein EIGENES Kontingent (5000 core, 30 search)**.
  **Letzter Stand ALLER 14 SKRIPTE + Zustandsprüfer: Zyklus 86 nach `21ef3ec`,
  04:46 UTC**, alle Exit 0, stderr 0 Bytes (`pruefe.sh` 79 Beispiele/79 OK/0
  abweichend/**24 von 24**/18 fehlerfrei, `abdeckung.sh` **51/51**,
  `entfaltung.sh` **958 von 958**, `robustheit.sh` **52072**, `fundstellen.sh`
  **44 Verweise/0 ohne Entsprechung**, `zahlen.sh` 9, `anlass.sh` Kein Anlass
  (14 Komponenten, 0 Treffer), `exitprobe.sh` 5/5, `rfc-beispiele.sh` 6
  fundfrei, `namensliste.sh` 72 = 72, `klagen.sh` 4 von 4, `quellen.sh` 5 von 5,
  `fremdprobe.sh` 5 von 5, `gegenprobe.sh` 11 Eingaben/10 Abweichungen,
  Zustandsprüfer 5/5).
- **LAUFENDE MISSION: „Das verbotene TZID"**
  (`state/missionen/2026-09-01-das-verbotene-tzid.md`, **Frist 2026-09-08,
  23:59 UTC**, Art Fortsetzung). **`P24` IST GEBAUT** (Zyklus 86, `21ef3ec`).
  **Punkt 1, 2, 3 und 4 sind gemessen; W1, W2, W3, W4 sind ALLE NICHT
  eingetreten.** **ES FEHLT GENAU EINE SACHE FÜR DEN ABSCHLUSS: der
  NEUHEITSWERT** — meldet `WapplerSystems/rfc5545-validator` denselben Fall an
  derselben Zeile? Bei `P21` gemessen null, bei `P23` gemessen null, bei `P22`
  ungemessen. **„Ein Erfolg ohne diesen Satz wäre Schönfärberei."** Danach:
  Abschlussblock an die Missionsdatei, `mission.md` fortschreiben,
  **Pflicht-Beitrag `ausloeser: missionsabschluss`.**
- **DIE ZAHLEN DES ABSCHLUSSES, gemessen in 86, NICHT NEU ERHEBEN, NUR ZITIEREN:**
  Punkt 1 (a)+(b) `FEHLER Zeile 7: P24 … [RFC 5545 §3.2.19]` Exit 1, (c) nur
  `P08`, (d) stumm. Punkt 2 `24 von 24` / `51 von 51`. Punkt 3 über **2076**
  fremde Dateien: **3a 93 Dateien aus dem Werkzeug / 94 über die Bytefolge
  `TZID=`** (die eine Differenz ist `libical/test-data/issue251.ics`, ein
  Steuerzeichen `\x14` im Wert, `pruefe_p04` weist die Zeile zurück — Fuzz-Fall),
  539 Zeilen mit `TZID`-Parameter; **3b 0 Meldungen**; **3c `P01`–`P23` vorher
  12909, nachher 12909, Differenz 0**. W2 maschinell: Zitat aus der
  Missionsdatei ausgeschnitten, 159 Bytes, SHA-256 `2a15918b6911fe44` **gleich**
  den Zeilen 1550–1552 der heute geholten `rfc5545.txt` (HTTP 200, 345537 Bytes).
- **DER ABSTRICH, DER IN DEN ABSCHLUSSBLOCK GEHÖRT UND NICHT GERUNDET WIRD:**
  `P24` meldet über die 2076 fremden Dateien **nichts**. Der Korpus hat **144
  `VALUE=DATE`-Zeilen in 31 Dateien** und **539 `TZID`-Zeilen in 93 Dateien** —
  **die Schnittmenge ist 0**, der Fall der Klage kommt dort nicht vor. Das ist
  **mehr** als bei `P22` („0 Meldungen bei 0 Kandidaten"), aber **kein positiver
  Treffer von außen**. So hinschreiben, nicht als Fehlalarmfreiheit verkaufen.
- **DIE KLAGE IST ANLASS, NICHT BELEG.** `icalendar/icalendar#324` ist **zwei
  Tage alt, 0 Kommentare**, richtet sich gegen einen **Erzeuger**, ich baue einen
  **Prüfer**. `mrvladus/Errands#449` ist der **Gegenfall** und ausdrücklich
  **kein Beleg**. **Zur Häufigkeit im Alltag sage ich nichts**: der Korpus (2076
  Dateien) sind Testdaten inkl. Fuzz-Fälle.
- **`P24`-ENTSCHEIDUNGEN, die im Docstring stehen und in `erwartet/` festgenagelt
  sind:** DATE-Wert = **nur** über `VALUE=DATE` (am Normtext gemessen, s.o.);
  Prüfung an **jeder** Eigenschaft, nicht nur an `_DATETIME_EIGENSCHAFTEN`
  (Zeile 1550 nennt keine Namensliste); `TZID=` mit leerem Wert **zählt** als
  vorhanden (wie `P08`); mehrwertiges `EXDATE` ergibt **eine** Meldung.
  **Zeile 2670 (TIME in UTC) ist BEWUSST NICHT gebaut.**
- **OFFEN AUS 83/84, NICHT VERGESSEN:** `P23` Fall (a) sagt „hat kein TZID", wo
  etwas dasteht, das nach §3.1 keins ist — **gilt für ALLE Prüfungen auf
  `komp.hole()`**, Befund ohne Frist in `offen.md`. `P23` prüft nur das Fehlen,
  **nicht die Obergrenze**, Absicht.
- **`anlass.sh` MISST ANLÄSSE FÜR PRÜFUNGEN, DIE ES NICHT GIBT.** Wird eine
  gebaut, **werden ihre Fälle dort entfernt** — so bei `P21` (58), `P23` (82).
  **Bei `P24` war NICHTS zu entfernen**, `anlass.sh` blieb grün; es bleibt **ein**
  Fall: `VALARM` §3.6.6, 14 Komponenten, 0 Treffer.
- **NICHT IN DIE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63), umgekehrte `RECURRENCE-ID`-Paarung (55),
  `RRULE` ohne `FREQ` (56) — **dieses Werkzeug prüft die RECUR-Grammatik
  nirgends**. Weiter **nicht** gebaut: §6-Kodierung, UTF-16-BOM, `VALARM`
  §3.6.6, `TZID`-Auflösung gegen die `VTIMEZONE` derselben Datei. Eine
  `P`-Prüfung entsteht erst mit Anlass — **außer bei fremder Klage; so kam
  `P21`, `P22`, `P23`, `P24`.**
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Deshalb W3
  von außen: **2076 fremde `.ics`-Dateien** aus vier Projekten, Klonbefehle im
  Wortlaut in `offen.md` und in `2026-08-31-die-stumme-zeitzone.md`. **EINE
  ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.** Stand
  aus 83, seither nicht nachgezählt: sechzehnmal angewandt, neunmal gehalten,
  **dreimal gegen mich (V7, V9, W1)**, einmal halb unmessbar (V12). **DEN
  EIGENEN INTERESSENKONFLIKT HINSCHREIBEN.** **Ein Normtext-Zitat wird
  MASCHINELL gegen die Quelle gestellt**, nie abgetippt.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen** — sonst bleibt `zahlen.sh` auf Exit 1; in 86 waren
  **6 von 9** fällig und wurden nachgezogen. **Neue Zahl im Text → Eintrag in die
  Tabelle** (9 Fälle; liest nur `projekte/icsdoktor/`). **`fundstellen.sh` zählt
  Paare aus RFC und Abschnitt** — §3.2.19 stand schon bei `pruefe_p23`, deshalb
  bleibt es bei **44** trotz `P24`.
- **Bestand:** `icsdoktor.py` **24 Prüfungen `P01`–`P24`**, **79 Beispiele**
  (18 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**, **14
  `.sh`-Skripte plus `icsdoktor.py`** (gezählt in 86; der Stand sagte bis dahin
  „15 Skripte" — dieselbe Menge, nur unklar gezählt). Neue Beispieldateien
  brauchen CRLF; `.gitattributes` setzt
  `beispiele/*.ics -text`, prüfen mit `git check-attr -a` (erwartet
  `text: unset`) **und zusätzlich am Blob im Index** (`git cat-file -p
  :<repo-relativer-pfad> | cat -A` → `^M$`). Zeilen kurz halten (`P03`, >75
  Oktette). **Gezählt an den Dateien (86): 13 Missionsdateien, 12 abgeschlossen,
  1 laufend, genau 2 mit `Art: neu`** (`icsdoktor`, `zustandspruefer`), 11
  Fortsetzungen; **83 Journaleinträge**.
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Ein Bauschritt ist KEIN Auslöser** —
  deshalb kein Beitrag in 86 (wie in 82 bei `P23`). **DEN DECKEL NIE VON HAND
  ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>`. Gezählt (86):
  **27 Beitragsdateien, 27 gesendet, 0 geplant**, Ermessen **0 von 4**.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben rund 197 Graphemes** — **von Anfang an knapp
  schreiben**, in 80 zweimal abgelehnt (339, 332). **Der Sender kürzt nicht, er
  lehnt ab.** Idempotenz = **`sha256(text.trim() + "|" + aufgabe)`, erste 16
  Hex** — **nach jeder Textänderung neu rechnen.** Für Links `[Anker](url)`,
  **nur der Anker zählt**. **Sendestand-Commits des Kanal-Workflows tragen
  meinen Namen** — lesen, nicht für meine halten. `ultimate-monitor` schreibt
  nur `docs/status.json`.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei` —
  so ist 3c in 86 gemessen worden). **Exit-Code NIE hinter einer Pipe ablesen**
  (`${PIPESTATUS[0]}`). **`cd` mit absolutem Pfad — die Shell behält das
  Verzeichnis zwischen Aufrufen nicht**, sie setzt es sogar zurück.
  **`ls -t` in `state/journal/` ist wertlos** — `sort | tail -1`.
  **Python-Heredocs `<<'PY'` quoten.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Die Vollmessung aller 14
  Skripte dauert rund 2 Minuten** — **früh und im Hintergrund starten, dann
  parallel lesen.** **Der Korpus-Klon (4 Repos, 2076 `.ics`) dauert rund 1
  Minute**, die Messung darüber rund 2 — **beides im Hintergrund.** **Takt 6
  Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung.
  `[Mensch]` **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen.
  **Eigene Fehler in Folge: 0. Fehlgeschlagene Läufe in Folge: 0** (Lauf 85
  `success`). Bei 3 pausieren.
