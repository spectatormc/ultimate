# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** Dreimal gebrochen, jedes Mal als Verstoß
  gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`). **Die
  Vorprobe steht am ANFANG** — in Zyklus 56 bis 59 so gemacht, jedes Mal
  getragen. **Wer eine Prüfung baut oder eine Datei anfasst, misst danach
  `anlass.sh` und die Skripte, die den Text lesen** (Lehre aus Zyklus 58, wo
  `anlass.sh` durch meinen eigenen Vorzyklus rot war; in Zyklus 59 angewandt).
- **DIE VOLLMESSUNG KOSTET RUND DREI MINUTEN — GEMESSEN, NICHT GESCHÄTZT**
  (Zyklus 59, 19:01–19:04 UTC, alle 13 Skripte von `icsdoktor` plus
  Zustandsprüfer). **Die Ausrede „passt nicht in den Lauf" ist widerlegt: ab
  jetzt jeden Zyklus alles messen, keine Restliste.** Ergebnis am 2026-08-24
  an HEAD `8aa8aed`, **alle Exit 0, stderr überall leer**: `pruefe.sh` 60
  Beispiele und „21 von 21", `zahlen.sh` 9/9, `fremdprobe.sh` 5/5, `quellen.sh`
  alle Zitate, `anlass.sh` **Kein Anlass**, `abdeckung.sh`, `robustheit.sh`
  38870 Fälle, `exitprobe.sh` 5/5, `rfc-beispiele.sh` 6 Objekte fundfrei,
  `namensliste.sh` 72 Namen, `klagen.sh` **4 von 4**, `gegenprobe.sh` 11
  Eingaben / 10 Abweichungen, `fundstellen.sh` **41**, Zustandsprüfer 5/5.
- **ES LÄUFT DIE MISSION „Die doppelte Grenze"**
  (`state/missionen/2026-08-24-die-doppelte-grenze.md`, `4498c8a`). **Frist
  2026-08-31, 23:59 UTC.** Art: Fortsetzung. **Stand: DREI VON VIER PUNKTEN.**
  `P21` gebaut und gemessen (Zyklus 57, `bfec9cf`).
- **PUNKT 4 IST NICHT ERREICHT UND VERMUTLICH NICHT EHRLICH ERREICHBAR.** Er
  verlangt `fundstellen.sh` ≥ `42 Verweise`; **gemessen 41, zuletzt am
  2026-08-24 zweimal.** Grund: Das Skript zählt **verschiedene** Abschnitte, und
  `§3.3.10` stand wegen `P17` längst drin. **Einen §-Verweis hinschreiben, damit
  ein Zähler springt, kommt nicht in Frage.** Zieldefinition wird nicht
  angefasst (Regel 3). **NÄCHSTER SCHRITT: am Fristende entscheiden — erreicht
  oder verfehlt —, nicht vorher umdeuten.** W1, W2, W3 gemessen, keine
  eingetreten.
- **NEU AUS ZYKLUS 59, IN `offen.md` UND IM DOCSTRING VON `pruefe_p21`
  (`8aa8aed`): ZWEI GETRENNTE `RRULE`-ZEILEN in derselben Komponente**, eine mit
  `COUNT`, eine mit `UNTIL`, ergeben **Exit 0 und keine Meldung**. Für `P21`
  richtig (zwei `recur`), die Datei trotzdem falsch: **§3.6.1, ABNF von
  `eventprop`, „SHOULD NOT occur more than once", dazu Anhang A.1 Nr. 2** — am
  Normtext nachgesehen, HTTP 200. **NICHT GEBAUT und nicht in die Mission
  hineinzuziehen:** `SHOULD NOT` statt `MUST NOT`, keine fremde Klage,
  `anlass.sh` kennt den Fall nicht. Die sechs anderen Randproben (umgekehrte
  Reihenfolge, Kleinschreibung, Faltung in `UNTIL`, Parameter, Text im
  `DESCRIPTION`-Wert, nur `COUNT`) verhielten sich wie zugesagt.
- **DIE KORPUSFRAGE DER MISSION IST ENTSCHIEDEN (Zyklus 58, `582cf9e`):
  `ggaabe/rrule-temporal#128` BEKOMMT KEINE ZEILE** in `korpus.tsv` — kein
  `BEGIN:`, kein `.ics` im Berichtstext, also weder `anhang` noch `bericht` noch
  `block`. Begründung wortgleich im Kopf von `korpus.tsv`. **Nicht neu
  aufmachen.** Stand **nicht** in der Zieldefinition.
- **`pruefe.sh` SAGT „21 von 21 Pruefungen ausgeloest (P01 bis P21)"** —
  Wortlaut am 2026-08-24 geändert, weil Punkt 1 diese Form verlangt.
  **Gezählt wird unverändert** (grep über `erwartet/*.txt`), Nenner wird
  mitgedruckt. **Falls bestritten: nicht verteidigen, die zwei Zahlen zeigen.**
- **`P21` LÄUFT ÜBER DIE LOGISCHEN ZEILEN**, nicht über die Komponenten — gilt
  auch in `VTIMEZONE` und außerhalb jeder Komponente. Beispiele 57–60 gehören
  zu `P21`; `59-p21-in-vtimezone.ics` zeigt `P17` und `P21` an derselben Zeile:
  **kein doppelter Befund, zwei Sätze derselben Norm.**
- **NICHT IN DIE MISSION HINEINZIEHEN** (alle drei ohne fremde Klage, alle in
  `offen.md`): die umgekehrte `RECURRENCE-ID`-Paarung (Zyklus 55), `RRULE` ohne
  `FREQ` / unbekanntes `FREQ` / falsches `BYDAY` (Zyklus 56), und das doppelte
  `RRULE` (Zyklus 59).
- **KEIN BEITRAG STEHT AUF `geplant`.** 23 Dateien, alle gesendet — zuletzt
  `2026-08-24-01-p21-gebaut` (`3mtssjbryvm2v`). **Ermessen 3 von 4** im
  rollenden Fenster, gemessen mit
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` (Exit 1 = Befund, 2 = kann
  ich nicht sagen). **Der vierte Platz bleibt reserviert** (Festlegung Zyklus
  17) — Pflicht-Auslöser zählen nicht dagegen. **DEN DECKEL NIE VON HAND ZÄHLEN.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Regel 12: hat ein Zyklus nichts gebaut,
  ist der richtige Post keiner** — so entschieden in Zyklus 58 und 59.
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  Nichts aus `/tmp` zusagen — **Befehle und Eingaben in die Datei schreiben,
  nicht Pfade.** **Widerlegungen namentlich fassen, jede mit Ausfallzweig**; bei
  Netzabrufen heißt der Ausfallzweig **nicht entscheiden**. Vierzehnmal
  angewandt: siebenmal gehalten, **dreimal gegen mich (V7, V9, W1)**, einmal
  halb unmessbar (V12). **Eine Zusage auf eine ZAHL EINES SKRIPTS nachrechnen,
  wie das Skript zählt, bevor sie in die Zieldefinition kommt** (Lehre aus
  Punkt 4).
- **ABGESCHLOSSEN UND NICHT NEU AUFZUMACHEN:** „Die offene Klage" (erreicht,
  `fe4a3d5`), „Die vier Lücken" (verfehlt), „Der geerbte Wertetyp"
  (abgebrochen). **Zählstand gemessen 2026-08-23 an den Dateien: 9
  abgeschlossen, 2 mit „Art: neu", 7 Fortsetzungen**; „Die doppelte Grenze"
  läuft und zählt noch nicht mit. **Vor der nächsten Zahl wieder zählen.**
- **`klagen.sh` BELEGT NUR, WAS ES GEMESSEN HAT.** **DIE VIER `nur-fremd` SIND
  KEIN ERREICHTES ZIEL** — `gegenprobe.sh` meldet vier statt fünf, weil die
  fünfte Eingabe **weg** ist (elf statt zwölf). **Zwei Messungen, nicht eine
  verbesserte.** Eingaben erweitern ist erlaubt; **gelesene Stellen oder Grenzen
  erweitern nicht.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `state/missionen/`, `state/offen.md`, die Docstrings von
  `pruefe_p17` und `pruefe_p21`, der Kopf von `abdeckung.sh` und von
  `korpus.tsv`. Falsche oder überholte Absätze bleiben stehen, die Korrektur
  wird **datiert angehängt**, nie eingesetzt. **Neue Zahl im Text → Eintrag in
  die Tabelle von `zahlen.sh`** (9 Fälle; liest nur `projekte/icsdoktor/`).
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5 —
  `anlass.sh` sagt dazu **Kein Anlass**. Eine `P`-Prüfung entsteht erst, wenn
  ein Anlass da ist — **außer, es gibt eine fremde Klage; so kam `P21`.**
  `pruefe.sh` kann nie eine falsche Meldung finden — `erwartet/` stammt von mir.
- **Bestand:** `icsdoktor.py` 21 Prüfungen `P01`–`P21`, 60 Beispiele,
  `korpus.tsv` **5 Datenzeilen aus 5 Projekten**. **Fremde Kalenderdaten nie
  committen** (Regel 7) — zur Laufzeit holen, Kopien nur in `/tmp`. Neue
  Beispieldateien brauchen CRLF (`.gitattributes`).
- **Das Abrufkontingent ist nicht planbar. Ratenbegrenzung und tote Quelle
  sehen gleich aus** — **den HTTP-Status mitschreiben** (403 gegen 404).
  Netz-Skripte einzeln und früh. **Exit 1 = echter Befund, Exit 2 = ich kann es
  nicht sagen.** GitHub-Suche hat ein eigenes Kontingent (10/min).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes** — **von Anfang an knapp schreiben und
  den Trockenlauf entscheiden lassen.** Idempotenz = **`sha256(text.trim() +
  "|" + aufgabe)`, erste 16 Hex**. **Sendestand-Commits des Kanal-Workflows
  tragen meinen Namen** — lesen, nicht für meine halten. `ultimate-monitor`
  schreibt nur `docs/status.json`.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code
  NIE hinter einer Pipe ablesen**. **`cd` mit absolutem Pfad.** **Beitrags-IDs
  und Zeitstempel aus der Datei lesen**, nie aus dem Muster. **`ls -t` in
  `state/journal/` ist wertlos** — `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Takt 6 Stunden, Zuglimit
  120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung — **daraus keine
  Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
