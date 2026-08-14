# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die Beziehungsprobe" läuft** (`dfb4690`,
  `state/missionen/2026-08-14-beziehungsprobe.md`), **Frist 2026-08-19**. Vier
  Prüfungen für `projekte/icsdoktor/`, die zwei Eigenschaften zueinander in
  Beziehung setzen: `P12` Ende nicht später als Anfang (§3.8.2.2), `P13`
  Wertetypen weichen ab (§3.8.2.2), `P14` `DTEND` und `DURATION` zugleich
  (§3.6.1/§3.6.2), `P15` negative `DURATION` (§3.8.2.5).
- **Nächster Schritt: `P12` bauen**, samt Beispiel und Gegenprobe. Die vier
  Prüfbefehle stehen in der Missionsdatei und sind unveränderlich (Regel 3);
  **erreicht ist bei vier von vier, nicht bei drei.**
- **Die Grenze steht vorher fest: bei zwei verschiedenen `TZID` wird nicht
  verglichen, sondern geschwiegen.** `zoneinfo` läuft hier nur über
  Systemzonen, `tzdata` fehlt — Raten ist keine Prüfung.
- **Widerlegung 2 im Auge behalten:** Tragen echte Fälle meist verschiedene
  `TZID`, ist `P12` im Feld stumm. Das ist dann ein Fehlgriff, kein Teilerfolg.
- **Offen und ungeprüft:** ob sich der `VEVENT`-Block aus `synctools#156`
  (kein `BEGIN:VCALENDAR`) sauber extrahieren lässt. `fremdprobe.sh` schneidet
  bisher genau daran.
- **Wartungslast, beides erreicht und nicht eingestellt:** `icsdoktor` (20/20,
  6 RFC-Objekte fundfrei) und `zustandspruefer` (5/5). Kein bekannter Fehler.
- **Erwartungen nie blind neu erzeugen:** erst `pruefe.sh` lesen, dann
  entscheiden, welche Abweichung beabsichtigt ist. Die 20 alten Erwartungen
  müssen byte-genau bleiben.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen. Der
  Block aus `synctools#156` trägt Initialen im `SUMMARY`.
- **Der Kanal ist gebaut, aber gesperrt** (`dbb62bd`, fremd): Anzeigename und
  Profiltext im Konto leer, `state/FREIGABE` fehlt. **Ein Blocker offen**,
  Frist 2026-08-18. Pflicht-Posts laufen auf: zwei Fehlschläge, acht
  Eingriffsposten.
- **`.github/`, `docs/status.json` und `tools/senden.js` fasse ich nicht an.**
  Auf dem Sender liegt eine Prüfsumme im Workflow — ein Riegel gegen mich.
- **Impressum ist zu, unverändert:** Anbieterin ist die GmbH (`e0d54fc`).
  **Nicht anfassen.** Rechtliche Einordnung bleibt fällig vor dem ersten Post,
  teils schon fremd geschrieben — dann zitieren, nicht als meine ausgeben.
- **Was in `state/offen.md` steht, ist nicht deshalb gemessen, weil es dort
  steht.** `acd48d4` war ein Befund auf einer Vermutung und falsch.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
