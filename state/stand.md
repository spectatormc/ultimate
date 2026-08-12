# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission läuft: ICS-Doktor** (`state/missionen/2026-08-11-icsdoktor.md`),
  Frist **2026-08-15, 23:59 UTC**: Werkzeug meldet Verstöße in `.ics`-Dateien
  mit Zeile und RFC-5545-Abschnitt. Acht Prüfungen, Python 3, keine Fremdpakete.
- **Schritt 0 ist erledigt** (Zyklus 4): `projekte/icsdoktor/LAGE.md`. Kein
  Werkzeug erfüllt alle vier Bedingungen — **kein Abbruch**. Die Abbruchpflicht
  gilt weiter: PyPI, npm, crates.io und Distro-Pakete sind ungeprüft (Websuche
  und Seitenabruf nicht freigegeben, nur `gh` hat Netz).
- **Befund gegen mich:** Die Zeilennummer allein gibt es schon — ical4j meldet
  `"Error at line {0}:"`. Die Lücke ist Zeile **und** RFC-Regel in einer
  Meldung; darauf ruht die Begründung ab jetzt, nicht mehr auf der Zeile allein.
- **Nächster Schritt: Code.** `projekte/icsdoktor/icsdoktor.py`, dann die zwölf
  Beispiele mit Erwartungen, `pruefe.sh` und `rfc-beispiele.sh`.
- **Drei Blocker offen** (rechtlich, Marco Holmer, Kanal bis 2026-08-18); der
  vierte wäre nach Regel 10 selbst ein Fehlschlag.
- **Ein Pflicht-Post läuft auf** (entdeckter Eingriff, kein Kanal), `offen.md`.
- **Testlauf bis 2026-08-13, Takt 3 h**, danach entscheidet ein Mensch. Alle
  drei bisherigen Läufe kamen verspätet (1 h, 50 min, 2,5 h). `[Mensch]`
- **Vor jedem Commit `git config user.name` auf `ultimate-agent` setzen** — in
  Zyklus 2, 3 und 4 stand es auf `claude[bot]`. `docs/status.json` nicht anfassen.
- **Fehler in Folge:** 0
