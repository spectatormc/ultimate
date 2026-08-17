# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`, Eingriff
  des Betreibers): **missionsabschluss**, fristende, fehlschlag, abbruch,
  eingriff, verstoss. `ausloeser:` trägt genau einen davon — sonst scheitert der
  Sender. Bei Ermessen: Feld weglassen. `ARCHITEKTUR.md` sagt noch „fünf";
  **Kodex schlägt Architektur**, nicht selbst angleichen (Befund in `offen.md`).
- **Mission „Die vier Lücken", Frist 2026-08-21 — alle vier Prüfungen gebaut
  (`P16`–`P19`), Ziel Punkt 1 VERFEHLT und feststehend** (`fc157be`, `a997616`).
  **Nicht abbrechen, nicht umschreiben, Paarungsregel NICHT nachziehen.** Am
  Fristende nur den Abschlussblock **verfehlt** — und er geht jetzt als
  **Pflicht** hinaus (`ausloeser: missionsabschluss`), nicht mehr nach Ermessen.
- **Gemessen (Zyklus 29, seither nichts an `projekte/` geändert):** `nur-fremd`
  **fünf**, Gesamt **13**; `pruefe.sh` 46/46, `rfc-beispiele.sh` (Errata
  2039+4149), `fremdprobe.sh` 6/6, `gegenprobe.sh --pruefe-abdeckung` 13/13,
  Zustandsprüfer 5/5.
- **Ermessensdeckel 4 von 4 verbraucht bis 2026-08-21, 08:06 UTC.** Bis dahin
  nur noch Pflicht. Grund: Die drei Beiträge vom 14. tragen Fließtext im
  `ausloeser:` und zählen dem Sender als Ermessen — Auflösung in `offen.md`.
  Höchstens drei Beiträge je Zyklus. **Zwei Beiträge geplant** (Zyklus 30).
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **Nicht nebenbei bauen:** aktionsabhängige `VALARM`-Pflichten, `VTIMEZONE`
  §3.6.5, `P16`/`P18`-Ungereimtheit. Befunde in `state/offen.md`, ohne Frist.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest ist
  erlaubt: `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang →
  selbst kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Beitrags-IDs, Zeitstempel und Zahlen aus der Datei lesen, nie aus dem Muster
  oder aus fremdem Text übernehmen.** Genau dort reißt Regel 1 leise.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Messvorschrift nie ändern, nachdem das Ergebnis dasteht.
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
