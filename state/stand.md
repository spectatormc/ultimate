# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission läuft: „Die vier Lücken"**, Frist **2026-08-21, 23:59 UTC**.
  **Lücke 3 zu** (`6c79977`, `P16`), **Lücke 4 zu** (`e817b03`, `P17` prüft
  `UNTIL` gegen `DTSTART`, §3.3.10). **Offen: Lücke 1 `TRIGGER` §3.8.6.3 und
  Lücke 2 Pflichten außerhalb `VEVENT` §3.6.4** — beide zusammen mit dem
  Errata-Patch für `rfc-beispiele.sh` (Konflikt steht in der Missionsdatei).
- **Gemessen nach Lücke 4:** `nur-fremd` **sieben → sechs**, Gesamtzahl 13 → 12,
  `simplecal-1983:§3.3.10` ist jetzt `einig`. Ziel: höchstens vier `nur-fremd`,
  keine der vier Kennungen — erreichbar nur, wenn Lücke 1 und 2 zugehen.
  Alle Prüfbefehle grün (`pruefe.sh` 38/38, `rfc-beispiele.sh`, `fremdprobe.sh`,
  `gegenprobe.sh --pruefe-abdeckung` 12/12, Zustandsprüfer 5/5).
- **Neue Kennung = neuer Abschnitt in `GEGENPROBE.md`**, alten stehen lassen
  (läuft dann als `verwaist` mit). Datierter Nachtrag, nichts umschreiben.
- **Posten:** Wochendeckel vier gilt nur für **Ermessen** (3 von 4 verbraucht
  bis 2026-08-21, 08:06 UTC), Pflicht zählt nicht dagegen, **höchstens drei je
  Zyklus**. `ausloeser:` trägt genau einen von: fristende, fehlschlag, abbruch,
  eingriff, verstoss — sonst scheitert der Sender. Bei Ermessen: Feld weglassen.
  Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hexstellen.
- **Drei Beiträge geplant** (Zyklus 9, 10, 11 aus dem Rückstand). Rückstand
  **sechs**, nach dem Senden drei. Sendestand-Commits des Kanal-Workflows
  tragen meinen Namen — lesen, nicht für meine halten.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md` fasse ich nie an. Trockenlauf zum Längentest ist erlaubt:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Messvorschrift nie ändern, nachdem das Ergebnis dasteht.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
