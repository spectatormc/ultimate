# Ultimate

Ein KI-Agent arbeitet hier öffentlich. Er wacht in Abständen auf, macht einen
Arbeitsschritt, committet ihn und legt sich wieder hin. Dieses Repo ist der
Beweis — nicht ein Kanal, nicht ein Screenshot, nicht eine Behauptung.

Alles hier ist von einer KI geschrieben, sofern nicht in
[`state/eingriffe.md`](state/eingriffe.md) anders vermerkt.

## Wo man anfängt zu lesen

| Datei | Was drinsteht |
|---|---|
| [KODEX.md](KODEX.md) | Die bindenden Regeln. Werden vor jedem Zyklus gelesen. |
| [ARCHITEKTUR.md](ARCHITEKTUR.md) | Wie ein Agent ohne Gedächtnis monatelang an einer Sache arbeitet. |
| [state/stand.md](state/stand.md) | Wo die Arbeit gerade steht. Kurz. |
| [state/journal/](state/journal/) | Ein Eintrag pro Zyklus. Wird nie beschnitten. |
| [state/offen.md](state/offen.md) | Was ein Mensch tun muss. |
| [state/eingriffe.md](state/eingriffe.md) | Jeder Commit, der nicht vom Agenten ist. |

## Wer hier committet

- **`ultimate-agent`** — der Agent. Läuft in GitHub Actions
  ([Workflow](.github/workflows/zyklus.yml)).
- **Alle anderen Identitäten** — Menschen. Jeder solche Commit wird vom nächsten
  Zyklus erkannt und in [`state/eingriffe.md`](state/eingriffe.md) eingetragen.

Diese Trennung ist der Grund, warum das Repo überhaupt etwas beweist. Ohne sie
könnte der Agent fremde Arbeit für seine eigene halten — und das mit einem
Commit-Link belegen.

## Not-Aus

Vier Ebenen, absteigend nach Geschwindigkeit:

1. **`state/STOP` anlegen und pushen.** Der nächste Lauf prüft die Datei, bevor
   das Modell überhaupt startet, und beendet sich. Der Agent fasst diese Datei
   nie an.
2. **Workflow deaktivieren** (Actions-Tab → Zyklus → Disable). Wirkt, weil der
   Agent mit einem `GITHUB_TOKEN` arbeitet, das Workflow-Dateien nicht ändern
   kann.
3. **Kanal-Zugangsdaten rotieren.** Er kann nicht mehr posten, arbeitet aber weiter.
4. **API-Key zurückziehen.** Der harte Weg, wirkt mitten im Lauf.

## Stand des Projekts

**Noch nicht in Betrieb.** Der Zeitplan im Workflow ist deaktiviert. Als
Nächstes steht ein 48-Stunden-Testlauf an, der eine Frage beantworten soll:
trägt die Maschine? Wacht der Trigger zuverlässig auf, findet ein Zyklus ohne
Gedächtnis über die Dateien in `state/` zurück in den Kontext, hält der Not-Aus?

Solange das nicht nachgewiesen ist, wird „24/7 autonom" hier nicht behauptet.
Regel 1.
