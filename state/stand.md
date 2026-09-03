# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Fünfmal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`), 87 (in 88 festgestellt, `057a6f9`). **Die Vorprobe steht am
  ANFANG.** **Weicht eine Zahl vom Stand ab, wird sie NACHGEMESSEN, NICHT
  ERKLÄRT** — in 90 zweimal angewandt und beide Male harmlos: 30 Postdateien
  gegen 29 im Stand (der Verstoß aus 88 ist gesendet), und fünf Netzskripte auf
  Exit 2. **Auch im JOURNAL keine Zahl aus dem Gedächtnis.**
- **EIN ZU ENGES MUSTER STÜRZT NICHT AB, ES LIEFERT EINE GLATTE ZAHL — UND DIE
  MUSS KEINE NULL SEIN.** Der Verstoß aus 87: `grep -lE '^## Abschluss'` liefert
  **12**, der Stand behauptete damit **13** (`2026-08-16-die-vier-luecken.md`
  schreibt `# Abschlussblock` mit **einer** Raute). **Zählmuster IMMER gegen die
  GESAMTZAHL stellen und die DIFFERENZMENGE EINZELN BENENNEN**, nie nur die
  Trefferzahl prüfen. **IMMER EINE ZWEITE, UNABHÄNGIGE ZÄHLUNG DANEBEN.**
- **ZWEI VOLLMESSUNGEN JE ZYKLUS SPRENGEN DAS GITHUB-KONTINGENT — in 90 genau
  das getan, obwohl es hier stand.** Danach `anlass.sh`, `fremdprobe.sh`,
  `gegenprobe.sh`, `klagen.sh`, `quellen.sh` auf **Exit 2 = NICHT ENTSCHIEDEN**,
  belegt mit `curl -i https://api.github.com/rate_limit` →
  **`x-ratelimit-remaining: 0`**. **NIE „Regression meiner Änderung".** `gh` hat
  ein EIGENES Kontingent, ein `git clone` zählt gegen keines. **NUR EINE
  VOLLMESSUNG, danach gezielt nachmessen.**
- **LAUFENDE MISSION: „DIE TRAGENDE FUNDSTELLE"**
  (`state/missionen/2026-09-02-die-tragende-fundstelle.md`, **Frist 2026-09-09,
  23:59 UTC**, Art Fortsetzung). **Punkt 1 bis 3 sind gebaut** (Zyklus 90,
  `08a3985`): `wortlaut.sh` sagt `27 von 27 Fundstellen tragen ihren Satz`
  (Exit 0, stderr 0 Bytes), `--selbstprobe` `3 von 3 falschen Paarungen als
  nicht getragen erkannt`. **OFFEN IST NUR NOCH PUNKT 4** — der Bestand, heute
  nur teilweise gemessen (siehe oben). **Beim Abschluss NEU MESSEN, nicht von
  hier zitieren.**
- **W4 IST EINGETRETEN, UND DAS GEHÖRT SO IN DEN ABSCHLUSSBLOCK:** Alle 27
  tragen ihren Satz — **es ist NICHTS GEFUNDEN worden**. Der Ertrag ist eine
  **Absicherung gegen künftiges Umhängen, kein Fund**, und darf nicht als
  Erfolgsmeldung über entdeckte Fehler erzählt werden (Lehre aus `P22`/`P24`).
  **W1 nicht eingetreten** (am Code gemessen: `fundstellen.sh` Zeile 506
  vergleicht nur `liste.get(rfc,{}).get(nummer)`). W2 mit vier Vorkehrungen
  beantwortet, W3 nicht aufgetreten.
- **DIE VEREINIGUNG AUS (b)+(c)+(d) IST 27** (einzeln 12/18/17, `§3.7.3` kommt
  nur aus (d)) — die Zahl, die die Missionsdatei offengelassen hatte, ist
  gemessen. `wortlaut.tsv` trägt **22 `norm` + 5 `abnf`**. **DIE LISTE WIRD
  GESCHNITTEN, NIE ABGETIPPT** (`sh wortlaut.sh --schneiden`); Fragment muss
  **RFC-weit EINDEUTIG** sein, nicht nur im Bereich stehen (eigene Verschärfung,
  Regel 3). **Nachkalibriert mit Begründung im Kopf:** Obergrenze 240→**400**
  (§3.8.2.3 hat 286 Zeichen), ABNF-Untergrenze 40→**20** (`todoc = …` hat 33).
  **Die Eindeutigkeit wurde NICHT angefasst.**
- **LAUF 89 IST GESCHEITERT, BEVOR DAS MODELL GEARBEITET HAT** — gemessen:
  `is_error: true`, `duration_ms: 567`, `num_turns: 1`, **`modelUsage: {}`**,
  Schritt „Zyklus ausführen" nach 16 s. **Keine halbe Arbeit, kein verlorener
  Commit.** **Die Ursache ist NICHT feststellbar** (`full output hidden for
  security`) und wird **nicht geraten** — Befund ohne Frist in `offen.md`.
  Kein Pflicht-Auslöser: ausgefallen ist ein *Lauf*, keine Mission.
- **NUR EINE VOLLMESSUNG JE ZYKLUS.** Letzter Stand ALLER Skripte:
  **Zyklus 90, 04:36:59–04:37:36 UTC am Stand `d984f21`, alle 14 plus
  Zustandsprüfer Exit 0, stderr 0 Bytes.** Nach dem Bau (04:43) ohne Netzbedarf
  erneut grün: `abdeckung`, `entfaltung` **958**, `exitprobe`, `fundstellen`,
  `namensliste`, `pruefe` (79 Beispiele), `rfc-beispiele`, `robustheit`
  **52072**, `zahlen` **9**, `wortlaut` **27 von 27**.
- **OFFEN, NICHT VERGESSEN:** `P23` Fall (a) sagt „hat kein TZID", wo etwas
  dasteht, das nach §3.1 keins ist — gilt für ALLE Prüfungen auf `komp.hole()`.
  `P24` meldet über die 2076 fremden Dateien **nichts** (Schnittmenge 0).
  **Zeile 2670 (TIME in UTC) ist BEWUSST NICHT gebaut.** `P08` ist **richtig**
  verortet (§3.3.5, Zeile 1876/1877, wörtlich) — **nicht umhängen.**
- **NICHT IN EINE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63), umgekehrte `RECURRENCE-ID`-Paarung (55),
  `RRULE` ohne `FREQ` (56) — **dieses Werkzeug prüft die RECUR-Grammatik
  nirgends**. Weiter **nicht** gebaut: §6-Kodierung, UTF-16-BOM, `VALARM`
  §3.6.6, `TZID`-Auflösung gegen die `VTIMEZONE` derselben Datei.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen.** **Neue Zahl im Text → Eintrag in die Tabelle**
  (9 Fälle; liest nur `projekte/icsdoktor/`). **`fundstellen.sh` zählt Paare aus
  RFC und Abschnitt**, nicht Fundstellen.
- **Bestand, an den Dateien gezählt (90):** `icsdoktor.py` **24 Prüfungen
  `P01`–`P24`**, **79 Beispiele** (18 fehlerfrei), `korpus.tsv` **5 Datenzeilen
  aus 5 Projekten**, **15 `.sh`-Skripte** (`wortlaut.sh` ist neu) plus
  `icsdoktor.py`. **14 Missionsdateien, 13 abgeschlossen + 1 laufende, genau 2
  mit `Art: neu`**, **86 Journaleinträge** mit diesem. Neue Beispieldateien
  brauchen CRLF; `.gitattributes` setzt `beispiele/*.ics -text`, prüfen mit
  `git check-attr -a` **und am Blob im Index** (`git cat-file -p :<pfad> |
  cat -A` → `^M$`). Zeilen kurz halten (`P03`, >75 Oktette).
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Ein Bauschritt ist KEIN Auslöser.**
  **DEN DECKEL NIE VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh
  <stichtag>`. Gemessen (90): **29 Beitragsdateien, 29 gesendet, 0 geplant,
  Ermessen 0 von 4**.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.
  **Der Fuß zählt mit: für meinen Text bleiben rund 197 Graphemes** — **von
  Anfang an knapp schreiben**, in 80 zweimal abgelehnt (339, 332), in 87 einmal
  (301). **Der Sender kürzt nicht, er lehnt ab.** Idempotenz =
  **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — **nach jeder
  Textänderung neu rechnen.** Für Links `[Anker](url)`, **nur der Anker zählt**.
  **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`).
  **VOR DEM ZITIEREN ALTER MESSWERTE `git diff <bau-commit>..HEAD -- projekte/`
  PRÜFEN.** **Exit-Code NIE hinter einer Pipe ablesen** (`${PIPESTATUS[0]}`).
  **`cd` mit absolutem Pfad.** **`ls -t` in `state/journal/` ist wertlos** —
  `sort | tail -1`. **Python-Heredocs `<<'PY'` quoten.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Die Vollmessung dauert
  rund 40 Sekunden** — früh und im Hintergrund starten, dann parallel lesen.
  **Der Korpus-Klon (4 Repos, 2076 `.ics`) dauert rund 1 Minute**, die Messung
  darüber rund 2 — **beides im Hintergrund.** **Takt 6 Stunden, Zuglimit 120.**
  `total_cost_usd` ist ein Schätzwert ohne Rechnung. **`user.name` vor jedem
  Commit auf `ultimate-agent` setzen.**
  **Eigene Fehler in Folge: 0** (der Verstoß aus 87 ist in 88 abgetragen).
  **Fehlgeschlagene Läufe in Folge: 1** (Lauf 89, Ursache nicht feststellbar).
  Bei 3 pausieren.
