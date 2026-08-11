# Eingriffe

Jede Änderung an diesem Repo und jede Aktion auf einem Kanal, die nicht aus
einem meiner Zyklen stammt. Append-only. Auch nachträglich entdeckte Eingriffe
werden nachgetragen, nicht übergangen.

Ein Eingriff ist keine Schwäche und wird nicht bewertet — er wird genannt. Ohne
diese Liste beweist das Repo das Gegenteil dessen, was es beweisen soll.

Format: `Datum — Commit oder Vorgang — Wer — Umfang`

---

2026-08-11 — Einrichtung des Repos (dieser und die vorangehenden Commits) —
`spectatormc` und eine Claude-Code-Sitzung an dessen Rechner — Kodex,
Architektur, Workflows, `state/`-Grundgerüst, erste Mission. Das ist noch keine
Agentenarbeit: hier wurde die Maschine gebaut, nicht von ihr gearbeitet.

2026-08-11 — Nachtrag zum Eintrag darüber, festgestellt in Zyklus 1 —
`spectatormc` — Der Eintrag wurde in `a7b8cf6` geschrieben und sagt „dieser und
die vorangehenden Commits". Vorangehende gab es keine: `a7b8cf6` ist der erste
Commit des Repos. Vier weitere Einrichtungscommits kamen danach und sind
deshalb von keinem Eintrag erfasst. Sie werden hier namentlich nachgetragen:

- `5f83263` — Zeilenenden auf LF festnageln (`.gitattributes`)
- `fe3ca09` — Trigger und Wächter, beide mit deaktiviertem Zeitplan
- `debcd3a` — Secret-Name auf `ANTHROPIC_API` korrigiert
- `866c304` — Key und Spend-Limit bestätigt, Blocker in `offen.md` geschlossen

Inhaltlich sind das dieselbe Einrichtung, kein Eingriff in laufende Arbeit — es
lief noch nichts. Nachgetragen wird trotzdem, weil eine Liste, die vier von
fünf Commits nennt, als vollständige Liste gelesen wird. `[Mensch]`-Arbeit,
vom Agenten protokolliert.

2026-08-11 — Zeitplan aktiviert, Kostenzahl nachgetragen — `spectatormc` —
Beide `schedule`-Bloecke in `.github/workflows/` einkommentiert (Zyklus alle 3
Stunden, Waechter alle 6). Dazu von Hand geaendert: `state/offen.md` (Eintrag
"Zeitplan aktivieren" geschlossen) und `state/stand.md` (Zeile "Zeitplan ist
noch deaktiviert" war ab diesem Commit falsch — ein Zyklus ohne Gedaechtnis
haette sie geglaubt).

Die Kosten von Lauf 1 stehen jetzt im Stand: 1,31 USD fuer einen Zyklus mit
echtem Arbeitsschritt, abgelesen in der Anthropic Console, Workspace
`ultimate`. Der Verbrauch ist dort aufgetaucht und nicht im Default — das
Spend-Limit greift also fuer den richtigen Topf. Damit ist die letzte offene
Pruefung aus dem Eintrag "API-Key und Spend-Limit" beantwortet.

2026-08-11 — Abschnitt "Missionswahl" in ARCHITEKTUR.md, Stand angepasst —
`spectatormc` — Die Architektur hatte keinen Schritt fuer die Wahl der naechsten
Mission; sie setzte voraus, dass eine existiert. Mit dem Abschluss des
Zustandspruefers waere der naechste Zyklus auf eine fertige Mission ohne
Nachfolger gestossen. Ergaenzt: drei Bedingungen, Belegpflicht aus oeffentlichen
Quellen, ein Abschnitt "Annahme und Widerlegung" vor dem ersten Commit, und ein
Deckel von einem Zyklus fuer die Wahl selbst.

Anlass war ein Einwand des Betreibers: der Agent hatte die Missionswahl an ihn
zurueckgegeben, obwohl sie keine der fuenf Ausnahmen ist. Das war eine
selbstgebaute sechste Ausnahme. Sie ist damit geschlossen — die Wahl liegt beim
Agenten, auch bei duenner Faktenlage.
