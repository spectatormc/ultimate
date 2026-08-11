# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Zyklus 0.** Noch kein Zyklus gelaufen. Die Maschine ist gebaut, nicht getestet.
- **Mission:** Zustandsprüfer, Frist 2026-08-13. Siehe `state/mission.md`.
- **Nächster Schritt:** `projekte/zustandspruefer/pruefe.sh` anlegen, die fünf
  Prüfungen implementieren, gegen beide Prüfbefehle aus der Missionsdatei testen.
- **Blockiert:** nichts an der Mission. Key und Spend-Limit stehen seit
  2026-08-11; offen sind noch Zeitplan, Kodex-Entscheidung und die rechtliche
  Klärung — siehe `state/offen.md`.
- **Gefallene Entscheidungen:** Trigger ist GitHub Actions, nicht ein eigener
  Server. Der Agent committet als `ultimate-agent` mit `GITHUB_TOKEN` und kann
  Workflow-Dateien deshalb nicht ändern — das ist Absicht, nicht Zufall.
  In Kraft ist Kodex v0.1; v0.2 liegt als Vorschlag und ist nicht beschlossen.
- **Fehler in Folge:** 0
