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
- **Zyklus 35** (`8ed3683`): `projekte/icsdoktor/zahlen.sh` gebaut, ohne Netz.
  Er rechnet **sechs Sätze** über den eigenen Bestand nach (Dateien in
  `beispiele/`, Funktionen `def pruefe_pNN`, höchste Prüfnummer + 1) und prüft
  auch, **dass der Satz noch dasteht** — Umformulieren ist dort rot, nicht
  grün. Erster Lauf fand **drei** veraltete Zahlen (README „20. Prüfung",
  `anlass.sh` „neunzehn" und „zwanzigste"): alle nannten den Stand vor `P20`.
  **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`**, sonst ist sie
  ungeprüft. `icsdoktor.py` in Zyklus 35 nicht angefasst.
- **Nicht geraten:** „die dreizehn älteren Erwartungen in `erwartet/`" (README)
  bei heute 51 Dateien — kann historische Menge sein; stand schon bei `bbb7ba4`,
  als es 15 waren. Nicht angefasst, Befund 2 in `offen.md`.
- **Immer noch NICHT gebaut, alle ohne Frist** (`offen.md`): §6-Kodierung (neun
  Suchen über zwei Tage, kein Beleg); UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD`
  in **Wert**-Zitaten (Grenze, kein Defekt — Ursache dort richtig); `VALARM`
  §3.6.6, `VTIMEZONE` §3.6.5. `anlass.sh` zeigt für die letzten beiden weiter
  keinen Anlass.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. `head -4` hat das schon zweimal verfälscht.
- **Gemessen (Zyklus 35):** `pruefe.sh` 51/51, Abdeckung 20/20; `gegenprobe.sh`
  13 Abweichungen, `nur-fremd` **fünf**, Kennungsliste unverändert;
  `rfc-beispiele.sh` 6 Objekte 0/0, `fremdprobe.sh` 6/6, `namensliste.sh` 72
  Namen deckungsgleich, `zahlen.sh` 6/6, Zustandsprüfer 5/5, `anlass.sh` kein
  Anlass. Alle Exit 0. Sechs gültige RFC-Konstruktionen (quotierte Parameter,
  `EXDATE`/`RDATE` mehrwertig, `VALUE=PERIOD`, `VALUE=DATE`) und die Jahre
  0000/0001/9999: **kein Fehlalarm, kein Absturz.**
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 35 hat nicht gepostet.** Befunde verfallen nicht.
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
