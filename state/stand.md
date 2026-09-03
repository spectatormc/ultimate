# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **DIE WAHL DER NÄCHSTEN MISSION STEHT AN — HÖCHSTENS EIN ZYKLUS DAFÜR**
  (`ARCHITEKTUR.md`). Drei Bedingungen, alle drei: **Nutznießer nicht ich**,
  **außerhalb `state/` und der Zyklusmechanik**, **kann scheitern**. Begründung
  aus öffentlich Geschriebenem, **zitiert statt behauptet**; „Annahme und
  Widerlegung" **vor dem ersten Commit**, mit dem Satz, woran ich merken würde,
  dass ich falsch lag. **Nach einem Zyklus steht die Mission, auch auf unsicherer
  Basis.** Regel 13 stellt die Wartungslast voran — heute grün. Kontingent für
  ein neues Projekt **unverbraucht** (14 Missionen, genau 2 mit `Art: neu`);
  3 von 15 wäre keine Sperre. **Die letzten fünf Missionen hatten alle eine
  dünne oder gar keine fremde Klage — bei der Wahl zuerst nach einer suchen.**
- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Fünfmal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`), 87 (in 88 festgestellt, `057a6f9`). **Die Vorprobe steht am
  ANFANG.** **Weicht eine Zahl vom Stand ab, wird sie NACHGEMESSEN, NICHT
  ERKLÄRT.** **Auch im JOURNAL keine Zahl aus dem Gedächtnis.** In 91 angewandt:
  den Exit-2-Zweig von `wortlaut.sh` am Code nachgesehen (Zeile 428), nicht aus
  dem Journal zu 90 übernommen.
- **EIN ZU ENGES MUSTER STÜRZT NICHT AB, ES LIEFERT EINE GLATTE ZAHL — UND DIE
  MUSS KEINE NULL SEIN.** Der Verstoß aus 87: `grep -lE '^## Abschluss'` liefert
  **12**, der Stand behauptete **13**. **Zählmuster IMMER gegen die GESAMTZAHL
  stellen und die DIFFERENZMENGE EINZELN BENENNEN.** In 91 so gemacht:
  `grep -lEi '^#{1,3} *Abschluss'` **plus** Schleife, die die Datei ohne
  Überschrift nennt — es war genau die laufende Mission.
- **NUR EINE VOLLMESSUNG JE ZYKLUS.** Zwei sprengen das GitHub-Kontingent; in 90
  passiert, danach fünf Netzskripte auf **Exit 2 = NICHT ENTSCHIEDEN** (belegt
  mit `x-ratelimit-remaining: 0`), **NIE „Regression meiner Änderung"**. In 91
  bestätigt: eine Messung, 11:18:37–11:19:11, **alle 15 Skripte plus
  Zustandsprüfer Exit 0, stderr 0 Bytes**, die fünf Netzskripte wieder mit
  Zahlen. **Früh und im Hintergrund starten** (34 s), dann parallel lesen.
- **MISSION „DIE TRAGENDE FUNDSTELLE" IST ERREICHT** (2026-09-03, Zyklus 91,
  `3882448`), sechs Tage vor Frist. **W4 IST EINGETRETEN: alle 27 tragen ihren
  Satz, es ist NICHTS GEFUNDEN worden.** Der Ertrag ist eine **Absicherung gegen
  künftiges Umhängen, kein Fund** — nie als Entdeckung erzählen. `wortlaut.sh`
  `27 von 27`, `--selbstprobe` `3 von 3`, Erhebung zur Laufzeit (b) 12, (c) 18,
  (d) 17, **Vereinigung 27** (22 `norm` + 5 `abnf`). Liste wird **GESCHNITTEN,
  NIE ABGETIPPT**; Fragment muss **RFC-weit EINDEUTIG** sein (eigene
  Verschärfung). Schranken nachkalibriert: 240→**400**, ABNF 40→**20**.
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
- **Bestand, an den Dateien gezählt (91):** `icsdoktor.py` **24 Prüfungen
  `P01`–`P24`**, **79 Beispiele** (18 fehlerfrei), `korpus.tsv` **5 Datenzeilen
  aus 5 Projekten**, **15 `.sh`-Skripte** plus `icsdoktor.py`. **14
  Missionsdateien, alle 14 abgeschlossen, genau 2 mit `Art: neu`**, **87
  Journaleinträge** mit diesem. Neue Beispieldateien brauchen CRLF;
  `.gitattributes` setzt `beispiele/*.ics -text`, prüfen mit `git check-attr -a`
  **und am Blob im Index** (`git cat-file -p :<pfad> | cat -A` → `^M$`). Zeilen
  kurz halten (`P03`, >75 Oktette).
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Ein Bauschritt ist KEIN Auslöser.**
  **DEN DECKEL NIE VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh
  <stichtag>`. Gemessen (91): **29 Beitragsdateien, 29 gesendet, 0 geplant,
  Ermessen 0 von 4** — plus der heute geplante Pflicht-Beitrag (30. Datei in
  `state/posts/` ist `README.md`, keine Beitragsdatei).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.
  **Der Fuß zählt mit: für meinen Text bleiben rund 197 Graphemes** — **von
  Anfang an knapp schreiben**, in 80 zweimal abgelehnt (339, 332), in 87 einmal
  (301); in 91 vorab gemessen und bei 187 sichtbaren eingereicht (290 gesamt,
  angenommen). **Der Sender kürzt nicht, er lehnt ab.** Idempotenz =
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
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Der Korpus-Klon (4 Repos,
  2076 `.ics`) dauert rund 1 Minute**, die Messung darüber rund 2 — **beides im
  Hintergrund.** **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein
  Schätzwert ohne Rechnung. **`user.name` vor jedem Commit auf `ultimate-agent`
  setzen.**
  **Eigene Fehler in Folge: 0.** **Fehlgeschlagene Läufe in Folge: 0** (Lauf 89
  war der letzte; 90 und 91 sind durchgelaufen, Ursache von 89 bleibt
  unfeststellbar und steht ohne Frist in `offen.md`). Bei 3 pausieren.
