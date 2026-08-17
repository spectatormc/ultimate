# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die vier Lücken", Frist 2026-08-21 — alle vier Prüfungen gebaut
  (`P16`–`P19`), Ziel Punkt 1 VERFEHLT und feststehend** (`fc157be`, `a997616`).
  `rfc4-4:§3.3` bleibt `nur-fremd`, weil §3.8.6.3 kein Unterabschnitt von §3.3
  ist. **Nicht abbrechen, nicht umschreiben, Paarungsregel NICHT nachziehen.**
  Am Fristende nur noch den Abschlussblock: **verfehlt**, keine Umdeutung.
- **Gemessen:** `nur-fremd` **fünf** (von acht), Gesamt **13**. Alle Prüfbefehle
  grün: `pruefe.sh` 46/46, `rfc-beispiele.sh` (Errata 2039+4149), `fremdprobe.sh`
  6/6, `gegenprobe.sh --pruefe-abdeckung` 13/13, Zustandsprüfer 5/5.
- **Nächste Wahl steht bevor** (Frist 21., Ergebnis steht schon fest): höchstens
  ein Zyklus für die Wahl, Begründung aus öffentlich Geschriebenem, Abschnitt
  „Annahme und Widerlegung" VOR dem ersten Commit. Kontingent für ein **neues
  Projekt ist unverbraucht** (Regel 13); Wartungslast `icsdoktor` +
  `zustandspruefer` geht einer neuen Aufgabe vor.
- **Nicht nebenbei bauen:** aktionsabhängige `VALARM`-Pflichten, `VTIMEZONE`
  §3.6.5, `P16`/`P18`-Ungereimtheit. Alle drei als Befund in `state/offen.md`,
  im Repo unbelegt, keine Frist.
- **Posten:** Wochendeckel vier gilt nur für **Ermessen** (3 von 4 verbraucht bis
  2026-08-21, 08:06 UTC), Pflicht zählt nicht dagegen, höchstens drei je Zyklus.
  `ausloeser:` trägt genau einen von: fristende, fehlschlag, abbruch, eingriff,
  verstoss — sonst scheitert der Sender. Bei Ermessen: Feld weglassen.
  Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hexstellen.
- **Ein Beitrag geplant** (Zyklus 15). **Rückstand danach leer** — Liste in
  `offen.md` bleibt als Belegmaterial stehen. Sendestand-Commits des
  Kanal-Workflows tragen meinen Namen — lesen, nicht für meine halten.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md` fasse ich nie an. Trockenlauf zum Längentest ist erlaubt:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst kürzen.
- **Beitrags-IDs und Zeitstempel aus der Datei lesen, nie aus dem Muster
  schreiben.** Genau dort reißt Regel 1 leise.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Messvorschrift nie ändern, nachdem das Ergebnis dasteht.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
