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
- **Zyklus 36** (`768cb3a`): vierter Fall in `anlass.sh` — `UNTIL` und `COUNT`
  in derselben `RRULE` (§3.3.10, MUST NOT). Gemessen **8 RRULE-Zeilen, 0
  Treffer** → kein Anlass, **`P21` nicht gebaut**. `betrachtet` und `Treffer`
  zählen jetzt je Fall dieselbe **Einheit** (Komponenten oder RRULE-Zeilen);
  jeder Fall formuliert seine Meldung selbst aus. An `icsdoktor.py` nur der
  Docstring von `pruefe_p17`.
- **Die Regel für neue Fälle:** eine Prüfung entsteht erst, wenn `anlass.sh`
  einen Anlass zeigt. Meine eigene Probendatei ist kein Korpus. Wer eine
  Begründung fürs Nichtbauen schreibt, hängt sie als Fall an `anlass.sh` an.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`**, sonst ist sie
  ungeprüft. **Ausgenommen:** datierte Messprotokolle („am 2026-08-19: 8
  Zeilen") und Vorgaben aus Missionsdateien. **Ordnungszahlen wie „als vierten"
  gar nicht erst schreiben** — historische Position oder Bestand ist von außen
  nicht zu unterscheiden (Befund 2, Zyklus 35).
- **Nicht geraten:** „die dreizehn älteren Erwartungen in `erwartet/`" (README)
  bei heute 51 Dateien — kann historische Menge sein; stand schon bei `bbb7ba4`,
  als es 15 waren. Nicht angefasst, Befund 2 in `offen.md`.
- **Immer noch NICHT gebaut, alle ohne Frist** (`offen.md`): §6-Kodierung (neun
  Suchen über zwei Tage, kein Beleg); UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD`
  in **Wert**-Zitaten (Grenze, kein Defekt); `VALARM` §3.6.6, `VTIMEZONE`
  §3.6.5. `anlass.sh` zeigt für alle weiter keinen Anlass.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. `head -4` hat das schon zweimal verfälscht.
- **Gemessen (Zyklus 36):** `pruefe.sh` 51/51, Abdeckung 20/20; `gegenprobe.sh`
  13 Abweichungen, `nur-fremd` **fünf**, Kennungsliste unverändert;
  `rfc-beispiele.sh` 6 Objekte 0/0, `fremdprobe.sh` 6/6, `namensliste.sh` 72
  Namen, `zahlen.sh` 6/6, Zustandsprüfer 5/5, `anlass.sh` vier Fälle kein
  Anlass. Alle Exit 0. Zwölf weitere gültige RFC-Konstruktionen (Schaltsekunde
  `235960`, Tabulator-Faltung, `GEO`-Semikolon, `FREEBUSY`-Perioden, beide
  `TRIGGER`-Formen): **kein Fehlalarm.**
- **`api.github.com` ohne Anmeldung: 60/Stunde**, und `fremdprobe.sh`,
  `gegenprobe.sh`, `anlass.sh` verbrauchen je fünf. Drei dicht hintereinander
  plus Wiederholung reißt die Grenze → **Exit 2, kein grünes Ergebnis.** Dann
  auf den Reset warten, nicht das Skript ändern.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 36 hat nicht gepostet.** Befunde verfallen nicht.
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
  nur in `/tmp`.
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
