# 2026-08-11 — Einrichtung

**Kein Zyklus.** Dieser Eintrag ist von Hand geschrieben, damit der erste echte
Zyklus etwas findet, an das er anknüpfen kann. `[Mensch]`

## Was gebaut wurde

- `KODEX.md` (v0.1, in Kraft) und `KODEX-v0.2-vorschlag.md` (nicht beschlossen).
- `ARCHITEKTUR.md` — Ablauf, Gedächtnis, Geheimnisse, Idempotenz beim Posten,
  Lebenszeichen, Not-Aus.
- `.github/workflows/zyklus.yml` — Trigger. Zeitplan deaktiviert.
- `.github/workflows/waechter.yml` — Lebenszeichen-Prüfer. Zeitplan deaktiviert.
- `state/` mit Stand, Mission, Journal, Offen, Eingriffe, Betreiber.
- Erste Mission: Zustandsprüfer, Frist 2026-08-13.

## Entscheidungen, die den nächsten Zyklus binden

**Vier Aufgaben liegen beim Harness, nicht beim Modell:** Repo holen,
`state/STOP` prüfen, Zyklen serialisieren, Lebenszeichen schreiben. Ein Not-Aus,
der im Prompt steht, wirkt nur, solange das Modell ihn befolgt — deshalb steht
er nicht im Prompt.

**Der Agent arbeitet mit `secrets.GITHUB_TOKEN`, nicht als Claude-GitHub-App.**
Die App hat Schreibrechte auf Workflow-Dateien und könnte damit ihren eigenen
Wecker ändern; das `GITHUB_TOKEN` kann das per GitHub-Regel nicht. Not-Aus-Ebene
2 hält damit technisch statt nur per Zusage.

**`state/heartbeat.json` schreibt der Workflow, nicht der Agent.** Sonst gibt es
genau dann kein Lebenszeichen, wenn eines gebraucht würde.

## Was offen bleibt

Vier Einträge in `state/offen.md`. Ohne API-Key und Spend-Limit läuft kein
Zyklus, und das ist die richtige Reihenfolge: Die Kostenzahl kennt man vor dem
Testlauf nicht, aber der Deckel muss vor dem Testlauf stehen.

Der Wächter läuft auf derselben Infrastruktur wie der Zyklus. Er fängt den
häufigen Ausfall, nicht den seltenen. Bekannte Lücke, benannt statt kaschiert.
