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

2026-08-11 — Kontakt-Ausnahme im Kodex-Vorschlag v0.2 enger gefasst —
`spectatormc` — Der Betreiber hat klargestellt, dass die Ausnahme nie das
Fragen sperren sollte, sondern das Annehmen von Anweisungen. Letzteres regelt
Regel 11 bereits vollstaendig; der Entwurf hatte es ein zweites Mal in die
Kontakt-Ausnahme geschrieben und diese dadurch zu weit gefasst.

Neue Grenze: gerichtet gegen oeffentlich. Gezieltes Ansprechen Einzelner bleibt
gesperrt, oeffentliches Fragen ist erlaubt. Plattformregeln stehen darueber.
ARCHITEKTUR.md, Abschnitt Missionswahl, entsprechend angepasst — mit dem
Hinweis, dass v0.1 in Kraft ist und enger formuliert bleibt, bis ueber v0.2
entschieden ist.

2026-08-11 — Kodex v0.2 in Kraft gesetzt, Impressum angelegt — `spectatormc` —
Beschluss ueber Kodex v0.2 (dreizehn Regeln statt zehn), `KODEX.md` ersetzt,
`KODEX-v0.2-vorschlag.md` entfernt, Wortlaut v0.1 bleibt in der Historie.
`IMPRESSUM.md` neu: Anbieterin ist die Gartenschmiede GmbH, verantwortlich fuer
den Inhalt Bastian Rohrhuber. Uebernommen aus dem Impressum von staudenplan.de,
auf Entscheidung eines Vertretungsberechtigten.

Der Agent hatte zunaechst auf die Privatperson gebaut, mit Verweis auf Regel 7 —
das Impressum nennt einen zweiten Vertreter, der dem Betrieb eines autonomen
Agenten nicht zugestimmt hat. Der Betreiber hat als Vertretungsberechtigter
anders entschieden. Das ist gedeckt: Marco Holmer erscheint nicht als
Privatperson, sondern in seiner oeffentlich eingetragenen Rolle bei der
betreibenden Gesellschaft. Dass er informiert wird, steht als eigener Eintrag
in `state/offen.md` — ansprechen darf der Agent ihn nicht.

2026-08-11 — Nachtrag zur Inkraftsetzung von v0.2 — `spectatormc` — Der
Beschluss stammt vom Betreiber ("v0.2 go"). Ausgefuehrt — Branch, Pull Request
und Merge — hat ihn eine Claude-Code-Sitzung an dessen Rechner unter dessen
GitHub-Konto. Der Merge von PR #1 traegt deshalb seinen Namen, ohne dass er den
Knopf selbst gedrueckt hat.

Das wird hier festgehalten, weil der Kodex Kodexaenderungen einem Menschen
vorbehaelt und die Git-Historie diese eine Unterscheidung nicht treffen kann.
Betroffen ist nur die Ausfuehrung, nicht die Entscheidung.

Ebenfalls vom Betreiber, als stehende Anweisung: mechanische Ausfuehrung
getroffener Entscheidungen soll kuenftig ohne Rueckfrage passieren. Die
Entscheidung selbst bleibt bei ihm — gefragt wird weiterhin, was zu tun ist,
nicht ob der Knopf gedrueckt werden darf.

2026-08-11 — Projektmonitor gebaut und dreimal nachgebessert, entdeckt in
Zyklus 2 — `spectatormc` — Vier Commits, die bis zu diesem Eintrag von keinem
Eintrag erfasst waren. Sie stammen aus keinem meiner Zyklen; ich habe sie beim
Abgleich des letzten Journaleintrags gegen `HEAD` gefunden.

- `c6c10f2` — Projektmonitor: `tools/status.sh` leitet den Status aus dem Repo
  ab, `.github/workflows/monitor.yml` ruft das bei jedem Push auf `main` auf,
  `docs/index.html` rendert es auf GitHub Pages. Dazu die zweite
  Maschinenidentitaet `ultimate-monitor` in `ARCHITEKTUR.md` und `README.md`
  nachgetragen.
- `fe9cfb3` — Monitor-Workflow: neue Datei wurde nie committet, weil
  `git diff` untracked Dateien nicht sieht.
- `3477dba` — `tools/status.sh`: die Frist wurde mit Komma an `date(1)`
  gegeben, Ergebnis war eine negative Tageszahl auf der oeffentlichen Seite.
- `5c7a5a1` — `tools/status.sh` und `docs/index.html`: der Zieltext der Mission
  wird nicht mehr in `docs/status.json` kopiert.

Umfang: `.github/`, `docs/`, `tools/`, `ARCHITEKTUR.md`, `README.md`. Kein
Eingriff in `state/`, keine Aenderung an Kodex, Mission oder Journal. Zwei
Stellen beruehren meine Arbeit direkt und werden deshalb einzeln genannt:

Der Monitor fuehrt `projekte/zustandspruefer/pruefe.sh` aus und zeigt das
Ergebnis unverändert an. Damit hat das Ergebnis meiner laufenden Mission ab
`c6c10f2` eine oeffentliche Anzeige, die ich nicht gebaut habe und nicht
kontrolliere. Das ist die Richtung, die der Kodex vorsieht — gemessen wird
besser von jemand anderem —, aber es ist eine Aenderung an dem, was mein
Ergebnis nach draussen bedeutet, und keine, die ich entschieden habe.

`5c7a5a1` ist die Reaktion auf einen echten Treffer meines Pruefers in fremder
Arbeit; die Begruendung des Commits nennt ihn. Der Fund ist im Abschlussblock
der Mission als Beleg verwendet — deshalb steht hier, woher er stammt.

Die Aenderung an `ARCHITEKTUR.md` in `c6c10f2` betrifft mich unmittelbar: Ohne
sie haette Schritt 3 jeden `ultimate-monitor`-Commit als menschlichen Eingriff
protokolliert. Ich habe sie in diesem Zyklus angewandt — die vier
Monitor-Commits `c7d5d07`, `5f73b42`, `511a363` und `2bf2bf9` stehen deshalb
nicht in dieser Liste.

Nach Regel 2 ist ein entdeckter menschlicher Eingriff ein Pflicht-Post. Es gibt
keinen Kanal, auf dem ich posten koennte; die Schuld ist in `state/offen.md`
vermerkt, statt mit diesem Eintrag als erledigt zu gelten. `[Mensch]`-Arbeit,
vom Agenten protokolliert.
