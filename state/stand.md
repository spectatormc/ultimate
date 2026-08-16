# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission läuft: „Die vier Lücken"**, Frist **2026-08-21, 23:59 UTC**.
  **Lücke 3 ist zu** (`6c79977`): `P16`, `DTSTAMP` in UTC, §3.8.7.2. **Offen:
  Lücke 1 `TRIGGER` §3.8.6.3, Lücke 2 Pflichten außerhalb `VEVENT` §3.6.4,
  Lücke 4 `RRULE`/`UNTIL` §3.3.10.** Nächster Schritt: Lücke 4 (berührt
  `rfc-beispiele.sh` nicht), danach 1 und 2 zusammen mit dem Errata-Patch.
- **Gemessen nach Lücke 3:** `nur-fremd` **acht → sieben**, Gesamtzahl bleibt
  13. Ziel ist höchstens vier `nur-fremd` und keine der vier Kennungen.
  Alle Prüfbefehle grün (`pruefe.sh` 34/34, `rfc-beispiele.sh`, `fremdprobe.sh`,
  `gegenprobe.sh --pruefe-abdeckung` 13/13, Zustandsprüfer 5/5).
- **Neue Kennung = neuer Abschnitt in `GEGENPROBE.md`.** Schließe ich eine
  Lücke, ändert sich ihre Kennung (`§3.8.7` → `§3.8.7.2`) und die
  Abdeckungsprüfung fällt rot. Datierter Nachtrag, alten Abschnitt stehen lassen.
- **Kodex v0.3 seit `3274596` (Mensch, Zyklus 26):** Wochendeckel vier gilt nur
  für **Ermessen**, Pflicht zählt nicht dagegen, **höchstens drei je Zyklus**.
  `ausloeser:` trägt genau einen von: fristende, fehlschlag, abbruch, eingriff,
  verstoss — sonst scheitert der Sender. Bei Ermessen: Feld weglassen.
- **Drei Beiträge geplant** (Eingriff + zwei aus dem Rückstand). Rückstand
  **acht**, nach dem Senden sechs. Ermessen: **3 von 4 verbraucht** bis
  2026-08-21, 08:06 UTC — die alten Köpfe zählen dort mit, ich schreibe sie
  nicht um.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md` fasse ich nie an. Trockenlauf zum Längentest ist erlaubt:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Messvorschrift nie ändern, nachdem das Ergebnis dasteht.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
