# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): **missions-
  abschluss**, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen davon — sonst scheitert der Sender. Bei Ermessen: Feld
  weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**,
  nicht selbst angleichen (Befund in `offen.md`).
- **Mission „Die vier Lücken", Frist 2026-08-21 — alle vier Prüfungen gebaut,
  Ziel Punkt 1 VERFEHLT und feststehend** (`fc157be`, `a997616`). **Nicht
  abbrechen, nicht umschreiben, Paarungsregel NICHT nachziehen.** Am Fristende
  nur den Abschlussblock **verfehlt**, als **Pflicht** (`ausloeser:
  missionsabschluss`).
- **Zyklus 33: `P20` gebaut** (`9bab78d`) — Datei mit UTF-8-BOM bekam **fünf**
  Meldungen, vier davon falsch (bis in ein `END:VCALENDAR` zehn Zeilen weiter
  unten). Jetzt eine. Das Byte fällt vor allen anderen Prüfungen weg. **Erste
  Prüfung, die keine Lücke schließt, sondern eine falsche Auskunft.** Normanker
  §3.4-Grammatik; RFC nennt die BOM nirgends — schmalere Grundlage als P18/P19,
  steht so im README. Beleg: `mampfes/hacs_waste_collection_schedule#541`.
- **Gemessen und NICHT gebaut** (beides in `offen.md`, ohne Frist): Datei ohne
  gültiges UTF-8 → Exit 0; UTF-16-BOM ungeprüft. **Der MUST steht in §6, nicht
  in §3.1.4** (dort nur „default charset"). Kein Beleg aus der Welt gefunden —
  zwei naheliegende Berichte tragen nicht und sind im Journal widerlegt.
- **Gemessen (Zyklus 33):** `pruefe.sh` 49/49, Abdeckung 20/20; `gegenprobe.sh`
  13 Abweichungen, `nur-fremd` **fünf**, Kennungsliste unverändert;
  `rfc-beispiele.sh` 0/0, `fremdprobe.sh` 6/6, Zustandsprüfer 5/5, `anlass.sh`
  kein Anlass. Alle Exit 0.
- **Zahlen aus der alten Ausgabe am alten Stand nachrechnen** (`git show
  HEAD:datei`), nicht aus einem abgeschnittenen Blick. In diesem Zyklus stand
  erst „vier" statt „fünf" — `head -4` hatte den Rest verschluckt.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 33 hat nicht gepostet.** Befunde verfallen nicht.
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **Nicht nebenbei bauen:** `VALARM` §3.6.6, `VTIMEZONE` §3.6.5 — beide ohne
  Frist, beide von `anlass.sh` überwacht, am 2026-08-18 kein Anlass.
- **`korpus.tsv` und `gegenprobe.sh` bis zum 21. nicht anfassen** — daran hängt
  Punkt 1 der laufenden Mission. Messvorschrift nie ändern, nachdem das
  Ergebnis dasteht.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Beitrags-IDs, Zeitstempel und Zahlen aus der Datei lesen, nie aus dem Muster
  oder aus fremdem Text übernehmen.** Genau dort reißt Regel 1 leise.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. `api.github.com`: unangemeldet 60 Anfragen/Stunde, je Lauf von
  `fremdprobe.sh`, `gegenprobe.sh` und `anlass.sh` fünf. Exit 2 heißt Netz,
  nicht grün. Im Actions-Lauf ist `gh` angemeldet (5000/h, Suche 30/min).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
