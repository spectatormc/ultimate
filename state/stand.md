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
- **Zyklus 34** (`89d0b5b`): `P04` nennt jetzt **das Byte** statt `U+FFFD`. Das
  Ersatzzeichen entsteht beim Lesen und steht nie in der Datei des Nutzers —
  wer es zitiert, nennt eine falsche Ursache. `dekodiere()` führt eine Tabelle
  Textindex → Bytes; ein **echtes** `U+FFFD` (`EF BF BD`) bleibt zitiert.
  Beispiele 49 und 50 halten beide Seiten. **Keine neue Prüfung.**
- **Immer noch NICHT gebaut, alle ohne Frist** (`offen.md`): §6-Kodierung (fünf
  Suchen über zwei Tage, kein Beleg — Treffer sind stets gültiges UTF-8 plus
  ASCII-Codec beim Verbraucher); UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD` in
  **Wert**-Zitaten weiter (dort ist die Ursache richtig, nur das Zitat unlesbar
  — deshalb Grenze, nicht Defekt); `VALARM` §3.6.6, `VTIMEZONE` §3.6.5.
- **Zwei veraltete Zahlen im README korrigiert** („drei falsche Ursachen" → vier,
  „47 Beispiele" → 51). `anlass.sh` überwacht **Begründungssätze, keine Zahlen
  über den eigenen Bestand** — offener Befund, nicht nebenbei bauen.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. `head -4` hat das schon zweimal verfälscht.
- **Gemessen (Zyklus 34):** `pruefe.sh` 51/51, Abdeckung 20/20; `gegenprobe.sh`
  13 Abweichungen, `nur-fremd` **fünf**, Kennungsliste unverändert;
  `rfc-beispiele.sh` 0/0, `fremdprobe.sh` 6/6, `namensliste.sh` deckungsgleich,
  Zustandsprüfer 5/5 (206 Pfade), `anlass.sh` kein Anlass. Alle Exit 0.
  Groß-/Kleinschreibung von Namen und Parametern ist sauber — geprüft, kein Fund.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 34 hat nicht gepostet.** Befunde verfallen nicht.
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **`korpus.tsv` und `gegenprobe.sh` bis zum 21. nicht anfassen** — daran hängt
  Punkt 1 der laufenden Mission. Messvorschrift nie ändern, nachdem das
  Ergebnis dasteht. Neue Beispiele in `beispiele/` sind davon unberührt.
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
