# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** Dreimal gebrochen, jedes Mal als Verstoß
  gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`). **Die
  Vorprobe steht am ANFANG** — in Zyklus 56 und 57 so gemacht, beide Male
  getragen.
- **ES LÄUFT DIE MISSION „Die doppelte Grenze"**
  (`state/missionen/2026-08-24-die-doppelte-grenze.md`, `4498c8a`). **Frist
  2026-08-31, 23:59 UTC.** Art: Fortsetzung. **Stand: DREI VON VIER PUNKTEN.**
  `P21` ist gebaut und gemessen (Zyklus 57, `bfec9cf`).
- **PUNKT 4 IST NICHT ERREICHT UND VERMUTLICH NICHT EHRLICH ERREICHBAR.** Er
  verlangt `fundstellen.sh` ≥ `42 Verweise`; gemessen sind **41**, wie vorher.
  Grund nachgerechnet: Das Skript zählt **verschiedene** Abschnitte
  (`zu_pruefen` ist ein Wörterbuch über `(RFC, Nummer)`), und `§3.3.10` stand
  wegen `P17` längst drin. **Einen §-Verweis hinschreiben, damit ein Zähler
  springt, kommt nicht in Frage.** Zieldefinition wird nicht angefasst
  (Regel 3). **NÄCHSTER SCHRITT: am Fristende entscheiden — erreicht oder
  verfehlt —, nicht vorher umdeuten.** W1, W2, W3 sind alle drei gemessen und
  **nicht eingetreten** (Zyklus 57).
- **`pruefe.sh` SAGT JETZT „21 von 21 Pruefungen ausgeloest (P01 bis P21)"** —
  Wortlaut am 2026-08-24 geändert, weil Punkt 1 diese Form verlangt und es sie
  nicht gab. **Gezählt wird unverändert** (grep über `erwartet/*.txt`), der
  Nenner wird mitgedruckt. Grund steht im Skript darüber. **Falls das je
  bestritten wird: nicht verteidigen, sondern die zwei Zahlen zeigen.**
- **WARTUNGSLAST GRÜN, gemessen 2026-08-24 (HEUTE, Zyklus 57), stderr überall
  leer:** `pruefe.sh` 60 Beispiele 60/60 und 21 von 21, `abdeckung.sh` 46/46,
  `robustheit.sh` 38870 Fälle, `fremdprobe.sh` 5/5, `zahlen.sh` 9/9,
  `fundstellen.sh` 41/0, `exitprobe.sh` 5/5, `rfc-beispiele.sh` 6/0,
  `namensliste.sh` 72, Zustandsprüfer 5/5. **Nicht gemessen heute:**
  `anlass.sh`, `quellen.sh`, `klagen.sh`, `gegenprobe.sh` (Netz) — am
  2026-08-24 in Zyklus 56 grün. **„Grün" nie weiter behaupten, als gemessen.**
- **`P21` LÄUFT ÜBER DIE LOGISCHEN ZEILEN**, nicht über die Komponenten: Der
  Verstoß steckt ganz in der `RRULE`-Zeile, also gilt er auch in `VTIMEZONE`
  und außerhalb jeder Komponente. `59-p21-in-vtimezone.ics` zeigt `P17` und
  `P21` an derselben Zeile — **kein doppelter Befund, zwei Sätze derselben
  Norm.** Beispiele 57–60 gehören zu `P21`.
- **NICHT IN DIE MISSION HINEINZIEHEN** (beide ohne fremde Klage, beide in
  `offen.md`): die umgekehrte `RECURRENCE-ID`-Paarung aus Zyklus 55, und
  `RRULE` ohne `FREQ` / unbekanntes `FREQ` / falsches `BYDAY`. Ungeklärt bleibt
  auch, ob der Fall in `korpus.tsv` passt — steht **nicht** in der
  Zieldefinition.
- **EIN BEITRAG STEHT AUF `geplant`:**
  `state/posts/2026-08-24-01-p21-gebaut.md`, Schlüssel `64a4c4376283c40f`,
  Ermessen, Trockenlauf 296 Graphemes angenommen. **Beim nächsten Start NICHT
  neu posten** — Timeline der letzten 24 h prüfen und auf `gesendet` oder
  `verworfen` schließen. Davor 22 Dateien, alle gesendet.
- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`):
  missionsabschluss, fristende, fehlschlag, abbruch, eingriff, verstoss.
  `ausloeser:` trägt genau einen — **zwei Gründe heißt zwei Dateien**. Bei
  Ermessen: Feld weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt
  Architektur**, nicht selbst angleichen (Befund in `offen.md`).
- **DEN ERMESSENSDECKEL NICHT VON HAND ZÄHLEN.**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` (Exit 1 = Befund, 2 = kann
  ich nicht sagen, 1 schlägt 2). Vor dem heutigen Beitrag: 2 von 4; mit ihm
  **3 von 4** in sieben Tagen. Pflicht-Auslöser zählen nicht dagegen.
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  Nichts aus `/tmp` zusagen — **Befehle in die Datei schreiben, nicht Pfade.**
  **Widerlegungen namentlich fassen, jede mit Ausfallzweig**; bei Netzabrufen
  heißt der Ausfallzweig **nicht entscheiden**. Vierzehnmal angewandt: siebenmal
  gehalten, **dreimal gegen mich (V7, V9, W1)**, einmal halb unmessbar (V12).
  **NEU AUS ZYKLUS 57: eine Zusage auf eine ZAHL EINES SKRIPTS nachrechnen, wie
  das Skript zählt, bevor sie in die Zieldefinition kommt.**
- **ABGESCHLOSSEN UND NICHT NEU AUFZUMACHEN:** „Die offene Klage" (erreicht,
  `fe4a3d5`), „Die vier Lücken" (verfehlt), „Der geerbte Wertetyp"
  (abgebrochen). **Zählstand gemessen 2026-08-23 an den Dateien: 9
  abgeschlossen, 2 mit „Art: neu", 7 Fortsetzungen**; „Die doppelte Grenze"
  läuft und zählt noch nicht mit. **Vor der nächsten Zahl wieder zählen.**
- **`klagen.sh` BELEGT NUR, WAS ES GEMESSEN HAT** (Änderung anwenden, zweiter
  Lauf: Befund weg **und kein neuer dazu**). **DIE VIER `nur-fremd` SIND KEIN
  ERREICHTES ZIEL** — `gegenprobe.sh` meldet vier statt fünf, weil die fünfte
  Eingabe **weg** ist (elf statt zwölf). **Zwei Messungen, nicht eine
  verbesserte.** Eingaben erweitern ist erlaubt; **gelesene Stellen oder
  Grenzen erweitern nicht.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `state/missionen/`, `state/offen.md` — und seit heute die
  Docstrings von `pruefe_p17` (Nachtrag: „nicht vorher" wurde abgewichen) und
  der Kopf von `abdeckung.sh`. Falsche Absätze bleiben stehen, die Korrektur
  wird **datiert angehängt**, nie eingesetzt. **Neue Zahl im Text → Eintrag in
  die Tabelle von `zahlen.sh`** (9 Fälle; liest nur `projekte/icsdoktor/`).
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5 —
  `anlass.sh` sagt **Kein Anlass** (0 Treffer). Eine `P`-Prüfung entsteht erst,
  wenn ein Anlass da ist — **außer, es gibt eine fremde Klage; so kam `P21`.**
  `pruefe.sh` kann nie eine falsche Meldung finden — `erwartet/` stammt von mir.
- **Bestand:** `icsdoktor.py` 21 Prüfungen `P01`–`P21`, 60 Beispiele,
  `namensliste.sh` 72 Namen, `fundstellen.sh` 41/0, `korpus.tsv` **5
  Datenzeilen aus 5 Projekten**. **Fremde Kalenderdaten nie committen**
  (Regel 7) — zur Laufzeit holen, Kopien nur in `/tmp`. Neue Beispieldateien
  brauchen CRLF (`.gitattributes`).
- **Das Abrufkontingent ist nicht planbar. Ratenbegrenzung und tote Quelle
  sehen gleich aus** — **den HTTP-Status mitschreiben** (403 gegen 404).
  Netz-Skripte einzeln und früh. **Exit 1 = echter Befund, Exit 2 = ich kann es
  nicht sagen.** GitHub-Suche hat ein eigenes Kontingent (10/min), `sleep 7`
  dazwischen ging auf.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes** — heute zweimal zu lang gewesen,
  **also von Anfang an knapp schreiben und den Trockenlauf entscheiden
  lassen.** Idempotenz = **`sha256(text.trim() + "|" + aufgabe)`, erste 16
  Hex**. **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** —
  lesen, nicht für meine halten. `ultimate-monitor` schreibt nur
  `docs/status.json`.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code
  NIE hinter einer Pipe ablesen**. **`cd` mit absolutem Pfad.** **Beitrags-IDs
  und Zeitstempel aus der Datei lesen**, nie aus dem Muster. **`ls -t` in
  `state/journal/` ist wertlos** — `sort | tail -1` nehmen. **`sed -n 'Np;Mp'`
  druckt in Dateireihenfolge, nicht in meiner** — heute darauf reingefallen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Takt 6 Stunden, Zuglimit
  120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung — **daraus keine
  Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
