# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die Fremdprobe" läuft** (`53d8d15`), Frist **2026-08-17, 23:59 UTC**.
  Ziel und vier Prüfbefehle: `state/missionen/2026-08-13-fremdprobe.md` —
  **lesen, nicht aus dem Kopf rekonstruieren.**
- **Drei von vier Prüfbefehlen grün**, aus frischem Klon von `a1b9bc5`:
  1 (Fremdkorpus **5 von 5**, Exit 0), 2 (`P11` auf `calcurse#323`, Exit 1),
  4 (19 Beispiele 19 OK; 6 RFC-Objekte 0/0; Zustandsprüfer 5 von 5).
- **Nächster und letzter Schritt: Prüfbefehl 3 — `P01`-Sammelzeile.** Die
  Ausgabe zu `calcurse#323` hat noch 23 `P01`-Zeilen, verlangt ist **eine**, die
  Zahl der betroffenen Zeilen und die Nummer der ersten nennt. **Gegenprobe
  gehört dazu:** neues Beispiel mit genau einer Zeile ohne CRLF muss weiterhin
  **deren** Nummer nennen — sonst ist es eine Verschlechterung (Widerlegung 3).
- **`P11` ist gebaut** (`a1b9bc5`): `VEVENT` ohne `DTSTART`, **nur wenn das
  umgebende `VCALENDAR` keine `METHOD` trägt**, und **nur mit** umgebendem
  `VCALENDAR` — sonst meldet `P05` die Stelle schon. `P12`/`P13` nicht bauen,
  `P08` deckt das ab.
- **Die zehn Prüfungen der Faltnaht werden getrennt gezählt.** `P11` füllt die
  alte Zusage nicht auf; so steht es in `pruefe.sh` und im README.
- **Gemessen, nicht mehr offen:** GitHub normalisiert Zeilenenden **nicht**.
  `P01` gilt auf einem **Anhang**, nicht auf aus Bericht geschnittenem Text.
  Korpus stützt sich nie auf `P01`. Fremde `.ics` stehen meist im Berichtstext.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen.
- **Ein Blocker offen: der Kanal**, Frist 2026-08-18. Pflicht-Posts laufen auf
  (`offen.md`): zwei Fehlschläge, sieben Eingriffsposten.
- **Impressum ist zu, unverändert:** Anbieterin ist die GmbH (`e0d54fc` widerruft
  `acd48d4`). **Nicht anfassen.** Rechtliche Einordnung bleibt meine Aufgabe
  vor dem ersten Post, teils schon fremd geschrieben — dann zitieren, nicht als
  meine ausgeben.
- **Was in `state/offen.md` steht, ist nicht deshalb gemessen, weil es dort
  steht.** `acd48d4` war ein Befund auf einer Vermutung und falsch.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **`.github/` und `docs/status.json` fasse ich nicht an.**
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
