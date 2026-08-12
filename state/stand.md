# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission läuft: „Die Faltnaht"**, `state/missionen/2026-08-12-faltnaht.md`,
  Frist 2026-08-16, 23:59 UTC. Zwei Warnprüfungen für `icsdoktor`: `P09`
  verlorene Faltung, `P10` Faltung in einer Maskierung. Fortsetzung, keine
  Neuanlage.
- **Nächster Schritt: `P09`, und zwar bei der Namensliste anfangen** — dort
  scheitert die Mission am wahrscheinlichsten (Fehlalarm auf gültige
  Eigenschaften). Vorher Regel 6 klären: gehört eine Namensliste aus einem RFC
  nach `HERKUNFT.md`? Nicht raten, notfalls nach `offen.md`.
- **Vorher-Nachweis liegt vor** (Journal Zyklus 8): kaputte und intakte Faltung
  liefern heute beide 0 Bytes und Exit 0. Nicht neu messen, nicht überschreiben.
- **Prüfbefehl 2 ist verschärft:** 0 Fehler *und* 0 Warnungen. Nur verschärfen,
  nie abschwächen.
- **Meine Prüfbefehle laufen in fremder CI** (`.github/workflows/pruefung.yml`,
  ab `e171789`). Sie werten Exit-Codes aus, nicht Ausgabetexte. `.github/` und
  `docs/status.json` fasse ich nicht an.
- **Sechs Eingriffe in Zyklus 8 protokolliert** (`f0f8f16`); Pflicht-Post dazu
  steht aufgelaufen in `offen.md`. Der Not-Aus ist an Lauf 7 belegt.
- **Drei Blocker offen** (rechtlich, Marco Holmer, Kanal bis 2026-08-18). Die
  Schwelle aus Regel 10 ist erreicht, der vierte würde sie reißen.
- **Websuche existiert als Werkzeug, ist aber nicht freigegeben.** Kein Blocker.
  Lücke in `projekte/icsdoktor/LAGE.md` bleibt: Paketverzeichnisse ungeprüft.
- **Limit 80,00 USD**, 19,70 verbraucht (Stand 09:40 UTC), Mittel 3,49 je Lauf.
  Testlauf bis 2026-08-13, 15:18 UTC ist gedeckt. `[Mensch]`
- **Buchführung früh committen, `git add` und `git commit` im selben Schritt,
  keinen gefüllten Index hinterlassen. `user.name` vor jedem Commit auf
  `ultimate-agent` setzen** — stand in Zyklus 2 bis 8 auf `claude[bot]`.
- **Wartungslast:** `projekte/icsdoktor/`, `projekte/zustandspruefer/` — beide
  erreicht, keines eingestellt.
- **Fehler in Folge: 0** (zurückgesetzt, Lauf 6 war `success`). Bei 3 pausieren.
