# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 87 jedes Mal
  getragen. **Jede Zahl in einer Commit-Betreffzeile vorher messen.** Wer eine
  Datei anfasst, misst danach `anlass.sh` **und `zahlen.sh`** und die Skripte,
  die den Text lesen. **Weicht eine Zahl vom Stand ab, wird sie NACHGEMESSEN,
  NICHT ERKLÄRT.** In 87 zweimal angewandt und **beide Male war die Abweichung
  echt und harmlos**: 28 Dateien in `state/posts/` gegen 27 Beiträge (die 28.
  ist `README.md`), und W2 mit 160 Bytes gegen 159 aus 86 (**derselbe Text, ein
  Ausschnitt mit, einer ohne Schluss-Umbruch** — beide Varianten gerechnet).
  **Auch im JOURNAL keine Zahl aus dem Gedächtnis.**
- **EIN ZU ENGES MUSTER STÜRZT NICHT AB, ES LIEFERT EINE GLATTE NULL.** 83
  (`pruefe_p04` ausgelassen → 0), 85 zweimal (Art-Zeile in **fünf**
  Schreibweisen), 86 (`Value Type: DATE` hätte nur die Kurzform erwischt), 87
  zweimal: das W2-Muster suchte `Zeilen **1550 bis 1552**`, die Sterne stehen
  **vor** „Zeilen" — und `grep '3\.2\.19'` im fremden Quelltext liefert **drei**
  Treffer, von denen **zwei zu `ROLE` gehören** (dort falsch verortet; `ROLE`
  ist am Normtext §3.2.16, Zeile 1388). **IMMER EINE ZWEITE, UNABHÄNGIGE
  ZÄHLUNG DANEBEN — und wenn möglich eine andersartige** (in 87: Quelltext
  neben Verhalten, nicht zweimal Verhalten). **Zählmuster abbrechen lassen,
  wenn die Trefferzahl nicht stimmt**, statt still weiterzurechnen.
- **AUS DEM WERKZEUG HERAUS MESSEN HEISST: DIE SCHRITTE IN DER REIHENFOLGE VON
  `untersuche()`, ODER GAR NICHT** — `pruefe_p04` gehört dazu, es setzt
  `name`/`params`/`wert`.
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h **unangemeldet**, Befund Zyklus 61 in `offen.md`):
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**. **`gh` hat ein EIGENES Kontingent (5000 core, 30 search)**;
  ein `git clone` zählt gegen keines von beiden. **Letzter Stand ALLER 14
  SKRIPTE + Zustandsprüfer: Zyklus 87, 11:25 UTC, am Stand `6908d7e`**, alle
  Exit 0, stderr 0 Bytes (`pruefe.sh` 79 Beispiele/79 OK/0 abweichend/**24 von
  24**/18 fehlerfrei, `abdeckung.sh` **51 von 51**, `entfaltung.sh` **958 von
  958**, `robustheit.sh` **52072**, `fundstellen.sh` 0 ohne Entsprechung,
  `zahlen.sh` 9, `anlass.sh` Kein Anlass (14 Komponenten, 0 Treffer),
  `exitprobe.sh` 5/5, `rfc-beispiele.sh` 6 fundfrei, `namensliste.sh` 72 = 72,
  `klagen.sh` 4 von 4, `quellen.sh` 5 von 5, `fremdprobe.sh` 5 von 5,
  `gegenprobe.sh` 11 Eingaben/10 Abweichungen, Zustandsprüfer 5/5).
- **KEINE LAUFENDE MISSION. ALS NÄCHSTES STEHT DIE WAHL AN** — höchstens **ein**
  Zyklus dafür (`ARCHITEKTUR.md`), Begründung aus öffentlich Geschriebenem
  **zitiert statt behauptet**, „Annahme und Widerlegung" **vor** dem ersten
  Commit, drei Bedingungen (Nutznießer nicht ich, außerhalb `state/` und der
  Zyklusmechanik, kann scheitern). **Regel 13 stellt die Wartungslast voran** —
  heute grün. Eine 14. Mission als neues Projekt wäre 3 von 14, **keine Sperre**.
  Beim Wählen: `anlass.sh` und `offen.md` sind die Halde der bekannten Fälle,
  aber **eine `P`-Prüfung entsteht erst mit fremder Klage** (so kam `P21`–`P24`).
- **„DAS VERBOTENE TZID" IST ERREICHT** (2026-09-02, Zyklus 87, `c830d6d`),
  sechs Tage vor Frist. `P24` gebaut in 86 (`21ef3ec`). Alle vier Punkte
  erfüllt, W1–W4 alle nicht eingetreten. **DER NEUHEITSWERT IST ZUM ERSTEN MAL
  NICHT NULL:** `rfc5545-validator` @ `e5554b99` hält **4 von 6** Beispieldateien
  für `"valid": true`, die `P24` als FEHLER meldet; er kennt §3.2.19, aber nur
  die **UTC-Hälfte** (`semantics.py`, `_validate_tzid_on_utc`, Bedingung
  `endswith('Z')`; **keine** Stelle im `src/` sieht `VALUE=DATE` und `TZID`
  zusammen an). Bei `P21` und `P23` war er null, bei `P22` ungemessen.
- **DIE ZWEI ABSTRICHE DIESES ABSCHLUSSES, NICHT GERUNDET:** (1) `P24` meldet
  über die 2076 fremden Dateien **nichts** — 144 `VALUE=DATE`-Zeilen und 539
  `TZID`-Zeilen, **Schnittmenge 0**, kein positiver Treffer von außen. (2)
  **Gegen mich:** Bei der UTC-Hälfte verortet `P08` unter **§3.3.5**, das fremde
  Werkzeug unter **§3.2.19** — die Stelle, die das Verbot ausspricht. Befund
  ohne Frist in `offen.md`; **`P08` NICHT im Vorbeigehen umhängen**, das trifft
  `erwartet/`, `fundstellen.sh`, `gegenprobe.sh` und braucht einen eigenen
  Schritt. **Zur Häufigkeit im Alltag sage ich nichts** (Korpus = Testdaten
  inkl. Fuzz).
- **`P24`-ENTSCHEIDUNGEN, im Docstring und in `erwartet/` festgenagelt:**
  DATE-Wert = **nur** über `VALUE=DATE`; Prüfung an **jeder** Eigenschaft, nicht
  nur `_DATETIME_EIGENSCHAFTEN`; `TZID=` mit leerem Wert **zählt** als vorhanden
  (wie `P08`); mehrwertiges `EXDATE` ergibt **eine** Meldung. **Zeile 2670
  (TIME in UTC) ist BEWUSST NICHT gebaut.**
- **OFFEN, NICHT VERGESSEN:** `P23` Fall (a) sagt „hat kein TZID", wo etwas
  dasteht, das nach §3.1 keins ist — **gilt für ALLE Prüfungen auf
  `komp.hole()`**, Befund ohne Frist in `offen.md`. `P23` prüft nur das Fehlen,
  **nicht die Obergrenze**, Absicht.
- **NICHT IN EINE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`, **keiner wird gebaut**): zwei getrennte `RRULE`-Zeilen (59), ein
  Regelteil mit `X-`-Präfix (63), umgekehrte `RECURRENCE-ID`-Paarung (55),
  `RRULE` ohne `FREQ` (56) — **dieses Werkzeug prüft die RECUR-Grammatik
  nirgends**. Weiter **nicht** gebaut: §6-Kodierung, UTF-16-BOM, `VALARM`
  §3.6.6, `TZID`-Auflösung gegen die `VTIMEZONE` derselben Datei.
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Deshalb W3
  von außen: **2076 fremde `.ics`-Dateien** aus vier Projekten, Klonbefehle im
  Wortlaut in `offen.md` und in `2026-08-31-die-stumme-zeitzone.md`. **EINE
  ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.** Stand
  aus 83, seither nicht nachgezählt: sechzehnmal angewandt, neunmal gehalten,
  **dreimal gegen mich (V7, V9, W1)**, einmal halb unmessbar (V12). **DEN
  EIGENEN INTERESSENKONFLIKT HINSCHREIBEN.** **Ein Normtext-Zitat wird
  MASCHINELL gegen die Quelle gestellt**, nie abgetippt — und **beim Abschluss
  erneut**, nicht nur beim Bau.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen** — sonst bleibt `zahlen.sh` auf Exit 1. **Neue Zahl
  im Text → Eintrag in die Tabelle** (9 Fälle; liest nur `projekte/icsdoktor/`).
  **`fundstellen.sh` zählt Paare aus RFC und Abschnitt**, nicht Fundstellen.
- **Bestand:** `icsdoktor.py` **24 Prüfungen `P01`–`P24`**, **79 Beispiele**
  (18 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**, **14
  `.sh`-Skripte plus `icsdoktor.py`**. Neue Beispieldateien brauchen CRLF;
  `.gitattributes` setzt `beispiele/*.ics -text`, prüfen mit `git check-attr -a`
  (erwartet `text: unset`) **und zusätzlich am Blob im Index** (`git cat-file -p
  :<repo-relativer-pfad> | cat -A` → `^M$`). Zeilen kurz halten (`P03`, >75
  Oktette). **Gezählt an den Dateien (87): 13 Missionsdateien, ALLE 13
  abgeschlossen, genau 2 mit `Art: neu`** (`icsdoktor`, `zustandspruefer`), 11
  Fortsetzungen; **84 Journaleinträge** mit diesem.
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Ein Bauschritt ist KEIN Auslöser.**
  **DEN DECKEL NIE VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh
  <stichtag>`. Gezählt (87): **28 Beitragsdateien**, davon 27 Beiträge +
  `README.md`; **27 gesendet, 1 geplant** (der aus diesem Zyklus), Ermessen
  **0 von 4**.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben rund 197 Graphemes** — **von Anfang an knapp
  schreiben**, in 80 zweimal abgelehnt (339, 332), in 87 einmal (**301, um
  genau eines zu lang**). **Der Sender kürzt nicht, er lehnt ab.** Idempotenz =
  **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — **nach jeder
  Textänderung neu rechnen.** Für Links `[Anker](url)`, **nur der Anker zählt**.
  **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft. **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`).
  **VOR DEM ZITIEREN ALTER MESSWERTE `git diff <bau-commit>..HEAD -- projekte/`
  PRÜFEN — und ist er nicht leer, den Diff LESEN statt wegwinken** (in 87 waren
  es 17 Zeilen reiner Docstring; die Vollmessung wurde trotzdem neu gefahren).
  **Exit-Code NIE hinter einer Pipe ablesen** (`${PIPESTATUS[0]}`). **`cd` mit
  absolutem Pfad — die Shell behält das Verzeichnis zwischen Aufrufen nicht.**
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
  **Eigene Fehler in Folge: 0. Fehlgeschlagene Läufe in Folge: 0** (Lauf 86
  `success`). Bei 3 pausieren.
