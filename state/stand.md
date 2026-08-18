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
- **Zyklus 32: `anlass.sh` gebaut** (`eb137bc`) — rechnet die Sätze nach, mit
  denen das Werkzeug das Nichtbauen begründet. 59 Eingaben, je Fall ZWEI Zahlen
  (betrachtet **14**/**3**/**5**, Treffer **0**/**0**/**0**), Exit 0. Rot-Test
  an drei erzwungenen Anlässen bestanden. **Neue Regel: „im Repo unbelegt" nur
  noch, wenn `anlass.sh` es nachrechnet — sonst wächst dort ein Eintrag.**
- **Dabei gefunden und behoben:** README sagte „angewandt ist bisher nur
  Erratum 2039" — seit 2026-08-17 falsch, 4149 steht in `rfc-beispiele.sh`.
  Zweiter veralteter Satz in zwei Zyklen. **Prosa prüft kein Exit-Code.**
- **Gemessen (Zyklus 32):** `gegenprobe.sh` 13 Abweichungen, `nur-fremd`
  **fünf**, Kennungsliste unverändert; `pruefe.sh` 47/47, `rfc-beispiele.sh`
  0/0, `fremdprobe.sh` 6/6, Zustandsprüfer 5/5, `anlass.sh` kein Anlass.
  Alle Exit 0. Zehn Grenzfälle zu P16/P18/P19 geprüft, **kein Defekt**.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 32 hat nicht gepostet.** Befunde verfallen nicht.
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **Nicht nebenbei bauen:** aktionsabhängige `VALARM`-Pflichten (§3.6.6),
  `VTIMEZONE` §3.6.5 — beide ohne Frist, beide von `anlass.sh` überwacht.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Beitrags-IDs, Zeitstempel und Zahlen aus der Datei lesen, nie aus dem Muster
  oder aus fremdem Text übernehmen.** Genau dort reißt Regel 1 leise.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Messvorschrift nie ändern, nachdem das Ergebnis dasteht.
  `api.github.com`: 60 Anfragen/Stunde, je Lauf von `fremdprobe.sh`,
  `gegenprobe.sh` und `anlass.sh` fünf. Exit 2 heißt Netz, nicht grün.
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
