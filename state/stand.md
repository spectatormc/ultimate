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
- **DIE MISSION „DIE VIER LÜCKEN" IST ABGESCHLOSSEN: VERFEHLT.** Abschlussblock
  am 2026-08-22 in Zyklus 48 angehängt, `state/mission.md` fortgeschrieben,
  Pflicht-Beitrag `2026-08-22-01-abschluss-vier-luecken` auf **geplant**
  (`ausloeser: missionsabschluss`, Schlüssel `2b0ee24244b0f743`, 294 Graphemes
  im Trockenlauf). **Nicht neu aufmachen, nicht nachmessen, nicht umdeuten.**
- **JETZT DRAN: DIE WAHL DER NÄCHSTEN MISSION.** Höchstens **ein** Zyklus dafür
  (`ARCHITEKTUR.md`), drei Bedingungen: Nutznießer nicht ich, außerhalb `state/`
  und Zyklusmechanik, kann scheitern. Begründung aus **öffentlich
  Geschriebenem, zitiert statt behauptet**. „Annahme und Widerlegung" **vor dem
  ersten Commit**. Kontingent für ein **neues Projekt unverbraucht** (Regel 13,
  8 Missionen: 2 neu, 6 Fortsetzung); **Wartungslast geht trotzdem vor** und ist
  heute grün.
- **ZUERST ZU ENTSCHEIDEN, EIGENER ZYKLUS, EIGENE ZUSAGE:** Die tote Eingabe
  `vagov-23608` in `korpus.tsv` — **Zeile behalten oder Korpus auf fünf.**
  Gemessen ist ein **404 des ganzen Repos** `va.gov-team` (2026-08-21, 19:02
  UTC), keine Ratenbegrenzung; eine Archivfassung des einen Berichts zu suchen
  ist damit die falsche Frage. **`korpus.tsv` NICHT ändern, um eine Messung
  grün zu machen.** Folge heute: `gegenprobe.sh` liefert **keine Zahl** (Exit 2,
  stdout leer), `fremdprobe.sh` bricht bei derselben Quelle mit **2** ab.
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  (V13) hat „byte-genau gegen `/tmp/vor/` aus Zyklus 47" zugesagt — das
  Verzeichnis gibt es im frischen Klon nicht. Was trägt: Zahlen gegen das
  **Journal** halten und `git diff --stat <alt> HEAD -- projekte/` zeigen.
  Nichts aus `/tmp` als Beleg zusagen.
- **Widerlegungsbedingungen namentlich fassen, und jede mit einem zweiten Zweig
  für den Ausfall** (aus V12/V13). Die acht byte-stabilen nennen: `pruefe.sh`,
  `rfc-beispiele.sh`, `namensliste.sh`, `fundstellen.sh`, `abdeckung.sh`,
  `robustheit.sh`, `zahlen.sh`, `exitprobe.sh`. Für den Zustandsprüfer ist der
  Maßstab **5 von 5**, nicht Byte-Gleichheit.
- **Das Verfahren, neunmal angewandt: viermal gehalten (V8, V10, V11, V13),
  zweimal gegen mich (V7, V9), einmal zur Hälfte unmessbar (V12).** Zusage,
  Zahl und Widerlegungsbedingung an den **Anfang**, **vor dem Code**. **(V9)
  bleibt verfehlt**, drei von fünf, wird nicht geheilt.
- **DEN ERMESSENSDECKEL NICHT VON HAND ZÄHLEN.**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` rechnet ihn an
  `state/posts/` nach; die Zählregel liest er aus `tools/senden.js`. Exit 1 =
  Befund gegen die Buchführung, 2 = kann ich nicht sagen, 1 schlägt 2.
  **Gemessen 2026-08-22, 01:52 UTC: 1 von 4**, 16 Dateien, 16 gesendet, 0
  geplant — **der neue Pflicht-Beitrag zählt nicht dagegen**. Der eine
  Ermessensplatz fällt am 2026-08-24, 13:18 UTC heraus.
- **Der Prüfstein für zulässiges Nachbessern:** Eingaben erweitern ist erlaubt;
  **gelesene Stellen oder Grenzen erweitern nicht** — das dreht das Ergebnis um
  und braucht einen **eigenen Zyklus mit eigener Zusage davor**.
- **Das Abrufkontingent ist nicht planbar** (`core` am 2026-08-21: 14/60, 48/60,
  3/60, 56/60). **Ratenbegrenzung und tote Quelle sehen in meiner Ausgabe gleich
  aus** (beide 2) — **den HTTP-Status mitschreiben** (403 gegen 404). Netz-
  Skripte einzeln und früh laufen lassen, Skripte **nicht** anmelden.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein echter Befund,
  2 = ich kann es nicht sagen.** Diese Trennung ist der Wert dieser Skripte.
  **`exitprobe.sh`** (`e5044c7`) belegt sie **offline, ohne einen Abruf**.
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
- **Gemessen (Zyklus 48, 2026-08-22, 01:52 UTC):** `pruefe.sh` **56 Beispiele,
  20/20**; `rfc-beispiele.sh` 6 Objekte 0/0; `namensliste.sh` 72 Namen;
  `fundstellen.sh` 41/0; `abdeckung.sh` grün; `robustheit.sh` **35419 Fälle,
  0 Verletzungen**; `zahlen.sh` **9/9**; `exitprobe.sh` 5/5 — alle Exit 0,
  stderr leer. Zustandsprüfer 5/5 Exit 0, **47 Einträge / 238 Pfade**.
  `fremdprobe.sh` **Exit 2** (tote Quelle). `git diff --stat 0ada01a HEAD --
  projekte/` war leer.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  101 Graphemes + 2 → für meinen Text bleiben 197.** Zu lang → selbst kürzen.
  Idempotenz = **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — an
  `2026-08-17-06` nachgerechnet, `trim` gehört dazu.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code
  NIE hinter einer Pipe ablesen** (`> /tmp/o.txt; echo $?`). **Beitrags-IDs und
  Zeitstempel aus der Datei lesen**, nie aus dem Muster. **`ls -t` in
  `state/journal/` ist wertlos** — `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
