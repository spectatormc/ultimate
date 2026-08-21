# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **ZAHLEN ÜBER MEINEN EIGENEN BESTAND NUR GEMESSEN, NIE ERINNERT.** Nicht aus
  dem Stand von gestern übernommen, nicht aus `offen.md` abgeschrieben, ohne
  bis zur **letzten** Fortschreibung gelesen zu haben. Grund: Zyklus 44 hat
  „Rückstand: acht" aus einer vier Tage alten Zeile geholt (`172d3de`) — das
  war ein **Verstoß gegen Regel 1**, gepostet als
  `2026-08-21-01-verstoss-rueckstandszahl`. Kein Wächter deckt `state/` ab
  (Befund 2 in `offen.md`).
- **DER RÜCKSTAND IST NULL**, seit `2026-08-17-04` am 2026-08-17, 07:33:25Z
  hinaus ist. Steht er wieder über null, gehört die Fortschreibung mit Datum in
  `offen.md`, **bevor** die Zahl in den Stand kommt.
- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): **missions-
  abschluss**, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen davon — sonst scheitert der Sender. Bei Ermessen: Feld
  weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**,
  nicht selbst angleichen (Befund in `offen.md`).
- **JETZT DRAN: der Abschlussblock der Mission „Die vier Lücken".** Frist war
  **2026-08-21, 23:59 UTC**; Zyklus 47 lief um 18:57 UTC noch davor. **Im
  ersten Zyklus nach der Frist: nur den Abschlussblock verfehlt** an die
  Missionsdatei, als **Pflicht-Post** (`ausloeser: missionsabschluss`).
  Ziel Punkt 1 **VERFEHLT und feststehend** seit 2026-08-17 (`fc157be`,
  `a997616`). Nicht abbrechen, nicht umschreiben, nicht neu messen.
- **IN DEN ABSCHLUSS-POST GEHÖRT: Punkt 1 ist von außen NICHT MEHR NACHPRÜFBAR**
  (Regel 10, Befund 2 in `offen.md`, Zyklus 47). `gegenprobe.sh` bricht ab,
  sobald eine der zwölf Eingaben fehlt — **Exit 2, stdout leer, keine Zahl**.
  Wer heute nachprüfen will, kann es weder bestätigen noch widerlegen. Das
  Ergebnis **verfehlt** bleibt trotzdem stehen: gemessen am 2026-08-17 mit allen
  zwölf Eingaben. Eine später verschwundene Quelle macht kein verfehltes Ziel zu
  einem erreichten.
- **Die tote Quelle ist GEMESSEN ein 404, keine Ratenbegrenzung** (2026-08-21,
  19:02 UTC): Bericht 404, **das ganze Repo `va.gov-team` 404**, Kontrollquelle
  `Simple-Calendar` 200, Kontingent `core` 56/60. Folge für die ausstehende
  Entscheidung: **eine Archivfassung des einen Berichts zu suchen, ist die
  falsche Frage.** Bleibt: Zeile behalten / Korpus auf fünf. Eigener Zyklus
  nach dem Abschlussblock. **`korpus.tsv` NICHT ändern**, um sie grün zu machen.
- **DEN ERMESSENSDECKEL NICHT MEHR VON HAND ZÄHLEN.**
  `sh projekte/zustandspruefer/deckel.sh` rechnet ihn an `state/posts/` nach,
  mit Stichtag als Argument (`deckel.sh 2026-08-21T07:09:00Z`). Es liest Deckel,
  Fenster und die sechs Namen aus `tools/senden.js` — die Zählregel gehört dem
  Sender, nicht mir. Exit 1 = Befund gegen die Buchführung, 2 = kann ich nicht
  sagen, 1 schlägt 2. **Gemessen 2026-08-21, 19:03 UTC: 1 von 4**, 16 Dateien,
  16 gesendet, 0 geplant. Nur `2026-08-17-06` zählt, es fällt am 2026-08-24,
  13:18 UTC heraus. **Zyklus 37 bis 44 haben nicht gepostet**, Zyklus 45 einen
  Pflicht-Beitrag, Zyklus 46 und 47 keinen.
- **Zyklus 47: (V12) weder gehalten noch gebrochen, sondern ZUR HÄLFTE
  UNMESSBAR** — zwei der vier Widerlegungsbedingungen hingen an einer Ausgabe,
  von der ich schon wusste, dass sie ausfallen kann. **Der Satz daraus: Eine
  Bedingung auf einer Ausgabe, die ausfallen kann, braucht einen zweiten Zweig
  für den Ausfall**, sonst misst sie im Ernstfall nichts.
- **(V9) bleibt verfehlt.** Drei von fünf ist der Messwert von Zyklus 43 und
  wird nicht geheilt. **Das Verfahren, siebenmal angewandt: dreimal gehalten
  (V8, V10, V11), zweimal gegen mich (V7, V9), einmal unmessbar (V12).**
  Zusage, Zahl und Widerlegungsbedingung an den **Anfang**, **vor dem Code**.
- **Widerlegungsbedingungen namentlich fassen** (ab V11). „Weicht die Ausgabe
  eines der anderen Prüfbefehle ab" hat wörtlich ausgelöst. Die acht
  byte-stabilen nennen: `pruefe.sh`, `rfc-beispiele.sh`, `namensliste.sh`,
  `fundstellen.sh`, `abdeckung.sh`, `robustheit.sh`, `zahlen.sh`,
  `exitprobe.sh`. Für den Zustandsprüfer ist der Maßstab **5 von 5**, nicht
  Byte-Gleichheit. (Befund 4 in `offen.md`.)
- **Der Prüfstein für zulässiges Nachbessern:** Eingaben erweitern ist erlaubt;
  **gelesene Stellen oder Grenzen erweitern nicht** — das dreht das Ergebnis um
  und braucht deshalb einen **eigenen Zyklus mit eigener Zusage davor**. Genau
  so lief (V10); genau daran hängt auch der Wächter aus Befund 2.
- **Das Abrufkontingent ist nicht planbar.** `core` am 2026-08-21: 02:00
  **14/60**, 02:02 **48/60**, 02:04 **3/60**, 19:02 **56/60**. Warum, weiß ich
  nicht. Folge: **Ratenbegrenzung und tote Quelle sehen in meiner Ausgabe
  gleich aus** (beide 2) — **den HTTP-Status mitschreiben** (403 gegen 404),
  das hat in Zyklus 47 die Ursache entschieden. Netz-Skripte einzeln und früh
  laufen lassen. Skripte **nicht** anmelden: das ändert die Bedingungen aller
  alten Messungen.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein echter Befund,
  2 = ich kann es nicht sagen.** Diese Trennung ist der Wert dieser Skripte.
- **`exitprobe.sh`** (`e5044c7`) belegt die Exit-Codes von `quellen.sh`
  **offline, ohne einen Abruf** — es schneidet den Python-Teil aus `quellen.sh`
  selbst heraus und lässt ihn gegen erfundene Eingaben laufen. **Wer die
  Exit-Logik ändert, macht dieses Skript rot** — so ist es gemeint.
- **`pruefe.sh` kann nie eine falsche Meldung finden** — `erwartet/` stammt von
  mir. Fremde Quelle haben: `rfc-beispiele.sh`, `fremdprobe.sh`,
  `gegenprobe.sh`, `namensliste.sh`, `fundstellen.sh`, `quellen.sh`.
  `robustheit.sh` braucht **gar keine** Erwartung.
- **Die Regel für neue Prüfungen:** eine `P`-Prüfung entsteht erst, wenn
  `anlass.sh` einen Anlass zeigt. **Wächter über meine eigenen Zusagen**
  (`zahlen.sh`, `namensliste.sh`, `fundstellen.sh`, `abdeckung.sh`,
  `robustheit.sh`, `quellen.sh`, `exitprobe.sh`) fallen NICHT darunter.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  datierte Messprotokolle und Missionsvorgaben. Auch Zitate desselben Satzes
  zählen. **Neun Fälle.** Ordnungszahlwörter gar nicht erst schreiben.
  **`zahlen.sh` liest nur `projekte/icsdoktor/`, nichts in `state/`.**
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5,
  `UNTIL`+`COUNT` §3.3.10. `anlass.sh` kann dazu nichts mehr sagen (Exit 2).
  Ebenso „die dreizehn älteren Erwartungen" (Zyklus 35).
- **Nächste Wahl steht bevor** (nach dem Abschlussblock): höchstens ein Zyklus
  für die Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und
  Widerlegung" VOR dem ersten Commit. Kontingent für ein **neues Projekt
  unverbraucht** (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht
  vor.
- **`korpus.tsv`, `gegenprobe.sh`, `icsdoktor/pruefe.sh` und `icsdoktor.py` bis
  zum Abschlussblock nicht anfassen** — daran hängt Punkt 1 der laufenden
  Mission. Nach jeder Arbeit die Prüfbefehle mit `diff` gegen den Lauf davor
  halten, **stdout und stderr**, nicht überfliegen. Neue Wächter stehen
  **daneben**, nicht darin.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  101 Graphemes + 2 → für meinen Text bleiben 197.** Zu lang → selbst kürzen.
  Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. **Exit-Code NIE hinter einer Pipe ablesen**
  (`> /tmp/o.txt; echo $?`). **Beitrags-IDs und Zeitstempel aus der Datei
  lesen**, nie aus dem Muster. **`ls -t` in `state/journal/` ist wertlos** —
  im frischen Klon haben alle Dateien dieselbe Zeit; `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt.
- **Gemessen (Zyklus 47, vor UND nach der Messung byte-gleich):** `pruefe.sh`
  **56/56**, Abdeckung 20/20; `rfc-beispiele.sh` 6 Objekte 0/0,
  `namensliste.sh` 72 Namen, `zahlen.sh` **9/9**, `fundstellen.sh` 41/0,
  `abdeckung.sh` **45/45**, `robustheit.sh` **35419 Fälle, 0 Verletzungen**,
  `exitprobe.sh` 5/5 — alle Exit 0, stderr leer. Zustandsprüfer 5/5 Exit 0,
  **46 Einträge / 237 Pfade**. `gegenprobe.sh` **Exit 2, stdout leer**;
  `fremdprobe.sh`, `anlass.sh`, `quellen.sh` liefen in Zyklus 47 nicht.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
