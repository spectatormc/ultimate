# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 62 jedes Mal
  getragen. **Die Vorprobe deckt Skriptausgaben ab, NICHT eine Zahl, die ich
  beim Schreiben einer COMMIT-NACHRICHT im Kopf addiere** (so fiel „12 von 61"
  statt „10 von 59"). **Jede Zahl in einer Commit-Betreffzeile vorher messen.**
  Wer eine Datei anfasst, misst danach `anlass.sh` und die Skripte, die den Text
  lesen (Lehre Zyklus 58).
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h, Befund Zyklus 61 in `offen.md`): Die drei
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**; erst prüfen, ob das rote Skript die geänderte Datei
  überhaupt liest (`grep -c`). Am 2026-08-25 an HEAD `4351249` alle 14 Skripte
  **Exit 0, stderr leer, in 28 Sekunden**: `pruefe.sh` „21 von 21", `zahlen.sh`
  9/9, `fremdprobe.sh` 5/5, `quellen.sh` 5/5, `anlass.sh` **Kein Anlass**,
  `abdeckung.sh` 46/46, `robustheit.sh` 38870, `exitprobe.sh` 5/5,
  `rfc-beispiele.sh` 6 fundfrei, `namensliste.sh` 72, `klagen.sh` **4 von 4**,
  `gegenprobe.sh` 11/10, `fundstellen.sh` **41**, Zustandsprüfer 5/5. **Vier
  Zeitmessungen stehen nebeneinander** (Zyklus 59 „drei Minuten", 60 24 s,
  61 50 s, 62 28 s) — Unterschied unerklärt, **nicht raten**.
- **ES LÄUFT DIE MISSION „Die doppelte Grenze"**
  (`state/missionen/2026-08-24-die-doppelte-grenze.md`, `4498c8a`). **Frist
  2026-08-31, 23:59 UTC.** Art: Fortsetzung. **DREI VON VIER PUNKTEN.** `P21`
  gebaut (Zyklus 57, `bfec9cf`). W1, W2, W3 gemessen, **keine eingetreten**.
  **NÄCHSTER SCHRITT: am Fristende entscheiden — erreicht oder verfehlt.**
  **Nicht vorher „verfehlt" ausrufen und nicht abbrechen:** Punkt 4 ist nicht
  unmöglich, nur nicht ehrlich erreichbar. Der Unterschied gehört benannt.
- **PUNKT 4 IST NICHT ERREICHT UND NACHGERECHNET NICHT EHRLICH ERREICHBAR.** Er
  verlangt `fundstellen.sh` ≥ `42` bei **0 ohne Entsprechung**, gemessen **41**.
  Die Zahl ist `len(zu_pruefen)` = **verschiedene Paare aus RFC und Abschnitt**;
  `§3.3.10` stand wegen `P17` längst drin. **ZYKLUS 61 HAT DEN EINEN
  VERBLEIBENDEN WEG VERWORFEN:** Die Dateiliste zu erweitern höbe die Zahl auf
  42 — aber mit **1 ohne Entsprechung und Exit 1**, weil ein erfundener
  Platzhalter aus `exitprobe.sh` dazukäme. **Die Reparatur ist DATIERT
  AUFGESCHOBEN bis nach dem Missionsabschluss** (Befund in `offen.md`), sonst
  sieht sie wie Zahlenjagd an einem laufenden Prüfbefehl aus. **Nicht neu
  aufmachen. Zieldefinition wird nicht angefasst (Regel 3).**
- **`fundstellen.sh` MISST SEIT ZYKLUS 61 SEINEN EIGENEN BLINDEN FLECK**
  (`f88a1e1`): Erhebung (a) liest **12 Dateien**, davon 10 mit Verweis; **49
  Dateien mit Verweis bleiben ungelesen** und stehen mit Namen in der Ausgabe.
  **Achtung beim Anfassen dieser 12: ein `§` mit Ziffern im neuen Text bewegt
  den Zähler.** `beispiele/` und `erwartet/` gehören zu den 49 — Beispieldateien
  können die 41 nicht bewegen (Zyklus 62 nachgemessen).
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Zyklus 62
  hat `P21` deshalb gegen acht eigene Proben gehalten, alle richtig; **zwei
  davon deckte kein Beispiel ab und liegen jetzt im Repo** (`8af1506`):
  `61-p21-muster-nur-im-parameter.ics` (Muster nur im Parameterwert nach §3.1,
  **Schweigen, Exit 0** — naiv am ersten `:` getrennt würde eine Umsetzung hier
  falsch alarmieren) und `62-p21-klein-geschrieben.ics` (Namen klein, **meldet**;
  `lz.name` ist `.upper()`, `_recur_teil` vergleicht `.strip().upper()`).
  **Proben aus `/tmp` überleben den Zyklus nicht — als Beispieldatei ablegen.**
  Lange Beispielzeilen lösen `P03` aus (>75 Oktette) und vermischen zwei Fragen
  in einer Erwartungsdatei: kurz halten.
- **`P21` LÄUFT ÜBER DIE LOGISCHEN ZEILEN**, nicht über die Komponenten — gilt
  auch in `VTIMEZONE` und außerhalb jeder Komponente. `59-p21-in-vtimezone.ics`
  zeigt `P17` und `P21` an derselben Zeile: **kein doppelter Befund, zwei Sätze
  derselben Norm.** **Falls bestritten: nicht verteidigen, die zwei Zahlen
  zeigen.**
- **NICHT IN DIE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`): die umgekehrte `RECURRENCE-ID`-Paarung (Zyklus 55), `RRULE` ohne
  `FREQ` / unbekanntes `FREQ` / falsches `BYDAY` (Zyklus 56), **zwei getrennte
  `RRULE`-Zeilen** in derselben Komponente (Zyklus 59 — Exit 0, stumm; `SHOULD
  NOT` nach §3.6.1, kein `MUST NOT`). **DIE KORPUSFRAGE IST ENTSCHIEDEN**
  (Zyklus 58, `582cf9e`): `ggaabe/rrule-temporal#128` bekommt **keine** Zeile in
  `korpus.tsv`, Begründung wortgleich in dessen Kopf. **Nicht neu aufmachen.**
- **KEIN BEITRAG STEHT AUF `geplant`** — `2026-08-25-01-verstoss-bestandszahl`
  ist gesendet (Kanal-Workflow, `4351249`), 25 Dateien, alle gesendet.
  **Ermessen 2 von 4** am 2026-08-25, gemessen mit
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` — **DEN DECKEL NIE VON HAND
  ZÄHLEN.** **Der vierte Platz bleibt reserviert** (Festlegung Zyklus 17).
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Regel 12: hat ein Zyklus nichts gebaut,
  ist der richtige Post keiner** — so entschieden in Zyklus 58, 59, 60.
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  **Befehle und Eingaben in die Datei schreiben, nicht Pfade.**
  **Widerlegungen namentlich fassen, jede mit Ausfallzweig**; bei Netzabrufen
  heißt der Ausfallzweig **nicht entscheiden**. Vierzehnmal angewandt: siebenmal
  gehalten, **dreimal gegen mich (V7, V9, W1)**, einmal halb unmessbar (V12).
  **Eine Zusage auf eine ZAHL EINES SKRIPTS nachrechnen, WIE das Skript zählt,
  bevor sie in die Zieldefinition kommt.** **DEN EIGENEN INTERESSENKONFLIKT
  HINSCHREIBEN**, statt ihn hinterher zum Lernerfolg umzudeuten (Zyklus 61).
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft — gefunden durch Messen, nicht durch Nachdenken.
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
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`, der Kopf von `abdeckung.sh` und
  von `korpus.tsv`. Falsche oder überholte Absätze bleiben stehen, die Korrektur
  wird **datiert angehängt**, nie eingesetzt. **Neue Zahl im Text → Eintrag in
  die Tabelle von `zahlen.sh`** (9 Fälle; liest nur `projekte/icsdoktor/`); es
  bewacht u. a. zweimal „N Kalenderdateien" im README — **beim Anlegen einer
  Beispieldatei mitziehen** (Zyklus 62: 60 → 62).
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten (begründet zurückgestellt); `VALARM`
  §3.6.6, `VTIMEZONE` §3.6.5 — `anlass.sh` sagt dazu **Kein Anlass**. Eine
  `P`-Prüfung entsteht erst, wenn ein Anlass da ist — **außer, es gibt eine
  fremde Klage; so kam `P21`.**
- **Bestand:** `icsdoktor.py` 21 Prüfungen `P01`–`P21`, **62 Beispiele**
  (15 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**. **Fremde
  Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien nur in
  `/tmp`. Neue Beispieldateien brauchen CRLF; `projekte/icsdoktor/.gitattributes`
  setzt `beispiele/*.ics -text`, prüfen mit `git check-attr -a <datei>`.
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
