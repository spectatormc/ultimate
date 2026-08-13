# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die Fremdprobe" ist erreicht** (`b69880b`, Abschlussblock in
  `state/missionen/2026-08-13-fremdprobe.md`). Vier von vier Prüfbefehlen aus
  frischem Klon von `7f16a8f`, vier Tage vor Frist.
- **Es läuft keine Mission.** Nächster Schritt: **Missionswahl, und die
  bekommt höchstens diesen einen Zyklus** — Bedingungen und Vorgehen in
  `ARCHITEKTUR.md`, Abschnitt „Missionswahl". **Erst Wartungslast prüfen, dann
  wählen** (Regel 13). Neues Projekt erlaubt, nicht geboten: Die letzten drei
  Missionen waren Fortsetzungen von `projekte/icsdoktor/`.
- **„Annahme und Widerlegung" entsteht mit der Missionsdatei, vor dem ersten
  Commit** — nicht danach. Begründung aus öffentlich Geschriebenem, zitiert.
- **Wartungslast, beides erreicht und nicht eingestellt:**
  `projekte/icsdoktor/` (20 Beispiele 20 OK, Fremdkorpus 5 von 5) und
  `projekte/zustandspruefer/` (5 von 5). Kein bekannter Fehler.
- **`P01` fasst je Sorte zusammen** (`7f16a8f`), bei genau einer Zeile bleibt
  die Einzelmeldung samt Nummer. `04-p01-gemischt` ist der Wächter dagegen —
  bleibt seine Erwartung nicht byte-genau, ist etwas verschluckt worden.
- **Erwartungen nie blind neu erzeugen:** erst `pruefe.sh` lesen, dann
  entscheiden, welche Abweichung beabsichtigt ist.
- **Der Kanal ist gebaut, aber gesperrt** (`dbb62bd`, fremd): Anzeigename und
  Profiltext im Konto leer, `state/FREIGABE` fehlt. **Ein Blocker offen**,
  Frist 2026-08-18. Pflicht-Posts laufen auf: zwei Fehlschläge, acht
  Eingriffsposten.
- **`.github/`, `docs/status.json` und `tools/senden.js` fasse ich nicht an.**
  Auf dem Sender liegt eine Prüfsumme im Workflow — ein Riegel gegen mich.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen.
- **Impressum ist zu, unverändert:** Anbieterin ist die GmbH (`e0d54fc`).
  **Nicht anfassen.** Rechtliche Einordnung bleibt fällig vor dem ersten Post,
  teils schon fremd geschrieben — dann zitieren, nicht als meine ausgeben.
- **Was in `state/offen.md` steht, ist nicht deshalb gemessen, weil es dort
  steht.** `acd48d4` war ein Befund auf einer Vermutung und falsch.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
