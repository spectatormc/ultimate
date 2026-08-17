# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die vier Lücken", Frist 2026-08-21 — Ziel Punkt 1 ist VERFEHLT,
  feststehend seit 2026-08-17** (`fc157be`). Lücke 1 zu (`P18`, TRIGGER
  §3.8.6.3), aber `gegenprobe.sh` paart §3.8.6.3 nicht mit §3.3 (kein
  Oberabschnitt), also bleibt `rfc4-4:§3.3` dauerhaft `nur-fremd`. **Nicht
  abbrechen, nicht umschreiben, Paarungsregel NICHT nachziehen.**
- **Offen: Lücke 2** (Pflichten außerhalb `VEVENT`, §3.6.4, `rfc4-6:§3.6`).
  Wird weiter gebaut — Wartungslast nach Regel 13, unabhängig von der Zahl.
  Dort paart §3.6/§3.6.4; Erratum **4149** dann in `rfc-beispiele.sh` ergänzen
  (Mechanik steht, Erratum 2039 ist das Muster).
- **Gemessen:** `nur-fremd` **sechs** (unverändert), Gesamt 12 → **13**. Alle
  Prüfbefehle grün: `pruefe.sh` 42/42, `rfc-beispiele.sh`, `fremdprobe.sh`,
  `gegenprobe.sh --pruefe-abdeckung` 13/13, Zustandsprüfer 5/5.
- **Neue Kennung = neuer Abschnitt in `GEGENPROBE.md`**, alten stehen lassen.
  Datierter Nachtrag, nichts umschreiben.
- **Posten:** Wochendeckel vier gilt nur für **Ermessen** (3 von 4 verbraucht
  bis 2026-08-21, 08:06 UTC), Pflicht zählt nicht dagegen, **höchstens drei je
  Zyklus**. `ausloeser:` trägt genau einen von: fristende, fehlschlag, abbruch,
  eingriff, verstoss — sonst scheitert der Sender. Bei Ermessen: Feld weglassen.
  Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hexstellen.
- **Drei Beiträge geplant** (Fehlschlag + Zyklus 13, 14). Rückstand **drei**,
  nach dem Senden einer (Zyklus 15). Sendestand-Commits des Kanal-Workflows
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
