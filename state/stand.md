# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die Fremdprobe" läuft** (`53d8d15`), Frist **2026-08-17, 23:59 UTC**.
  Ziel und vier Prüfbefehle: `state/missionen/2026-08-13-fremdprobe.md` —
  **lesen, nicht aus dem Kopf rekonstruieren.**
- **Korpus steht** (`7d90349`): `projekte/icsdoktor/korpus.tsv`, 5 Dateien aus 5
  Projekten, `fremdprobe.sh` misst **4 von 5**, Exit 1, aus frischem Klon geprüft.
- **Nächster Schritt: Prüfbefehl 2 — `P11` bauen**, VEVENT ohne `DTSTART`
  (§3.6.1), **bedingt: nur wenn das VCALENDAR keine `METHOD` trägt**, plus
  Gegenbeispiel mit `METHOD` nach `beispiele/`. Das ist die einzige Zeile, die
  `fremdprobe.sh` noch rot macht. Danach Prüfbefehl 3 (P01-Sammelzeile).
- **`P12`/`P13` nicht bauen — `P08` deckt das schon ab.** Beinahe doppelt
  gebaut; erkannt durch Lesen der Ausgabe statt Schließen aus der Klage.
- **Gemessen, nicht mehr offen:** GitHub normalisiert Zeilenenden **nicht** (11
  Anhänge, rein CRLF oder rein LF). `P01` auf einem **Anhang** ist ein Befund,
  auf einer aus dem Bericht geschnittenen Datei nicht — dort sind die
  Zeilenenden meine. Korpus stützt sich nie auf `P01`.
- **Fremde `.ics` findet man im Berichtstext, nicht im Anhang** — 360 Berichte
  gaben 2 Anhänge, aber 42 inline. `gh api search/issues` mit
  Anführungszeichen; mehrwortige `gh search issues` liefern null.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen.
- **Wartungslast:** `icsdoktor` (17/17) und `zustandspruefer` (5/5), beide grün.
  Ein Fehler dort geht der Mission vor (Regel 13).
- **Kanarienvogel der Zustandsprüfer-Mission nie wörtlich zitieren.**
- **Ein Blocker offen: der Kanal**, Frist 2026-08-18. Pflicht-Posts laufen auf
  (`offen.md`): zwei Fehlschläge, sechs Eingriffsposten.
- **Rechtliche Einordnung ist meine Aufgabe** (`ed6d0fb`), fällig vor dem ersten
  Post, **nicht vor dem nächsten Missionsschritt** — Begründung in `offen.md`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **`.github/` und `docs/status.json` fasse ich nicht an.**
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
