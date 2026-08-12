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

2026-08-12 — Not-Aus absichtlich ausgeloest und geprueft — `spectatormc` —
Von den drei Fragen des Testlaufs war eine unbeantwortet: haelt der Not-Aus? Es
gab bis dahin keinen Anlass, also wurde einer erzeugt. `state/STOP` gesetzt
(`beda78c`), Lauf 7 manuell ausgeloest, Ergebnis geprueft, Datei wieder
entfernt.

Ergebnis, drei Belege:

- Schritt "Zyklus ausfuehren" steht auf `skipped`. Das Modell ist nie gestartet.
- `state/heartbeat.json` fuer Lauf 7 traegt `"ergebnis": "gestoppt"` — der
  Stopp ist als Stopp verzeichnet, nicht als Erfolg und nicht als Fehler.
- Im Actions-Log des Laufs kommt kein `total_cost_usd` vor. Es sind keine
  Modellkosten entstanden.

Damit ist belegt, was bisher nur behauptet war: Die Bremse liegt im Workflow
und nicht im Prompt, sie greift vor dem ersten API-Aufruf, und sie haengt nicht
davon ab, dass der Agent sich korrekt verhaelt. Der Agent hat die Datei weder
gesehen noch angefasst — er lief nicht.

Nicht mitgeprueft: ob ein *geplanter* Lauf sich genauso verhaelt. Der
STOP-Schritt ist derselbe, unabhaengig vom Ausloeser, aber gemessen wurde ein
manuell gestarteter Lauf. `[Mensch]`-Arbeit, hier protokolliert.

2026-08-12 — Pruefung als CI eingerichtet — `spectatormc` — Neuer Workflow
`.github/workflows/pruefung.yml`. Er fuehrt bei jedem Push auf `main` die
Pruefbefehle aus, die in den Missionsdateien als Definition von "geschafft"
stehen: beide des Zustandspruefers und beide des ICS-Doktors.

Anlass ist die Schwachstelle, die der Agent im Abschlussblock von Mission 1
selbst benannt hat: Pruefvorschrift und Werkzeug stammten aus derselben Hand.
Ab jetzt fuehrt eine Maschine den Nachweis, die nicht der Agent ist, auf einer
frischen Umgebung, ohne sein Zutun. Der Agent kann diesen Workflow nicht
abschalten — das GITHUB_TOKEN darf keine Workflow-Dateien schreiben.

Zwei Entscheidungen darin, die Auslegung waren:

- Der Kanarienvogel-Test prueft nicht nur den Exit-Code, sondern dass Pruefung 4
  die Datei auch namentlich nennt. Eine Leak-Pruefung, die anschlaegt ohne zu
  sagen wo, hilft niemandem.
- Ist `rfc-editor.org` nicht erreichbar, endet Pruefbefehl 2 mit Exit 2. Das
  wird als Warnung gewertet, nicht als Fehler: ein Netzausfall ist kein Befund
  ueber das Werkzeug. Es wird aber auch nicht als bestanden gezaehlt.

Ausserdem versucht, den ICS-Doktor lokal zu pruefen. Gescheitert: auf dem
Rechner des Betreibers ist kein Python installiert, alle 13 Beispiele meldeten
"Python wurde nicht gefunden". Das ist ein Befund ueber die Umgebung, nicht ueber
das Werkzeug — festgehalten, weil ein nicht gelungener Pruefversuch kein
gelungener ist.

2026-08-12 — Spend-Limit angehoben und der Wert nachgetragen, entdeckt in
Zyklus 8 — `spectatormc` — Zwei Commits, chronologisch vor den drei Einträgen
darüber; diese Liste ist append-only, deshalb stehen sie hier hinten und nicht
an ihrem Zeitpunkt:

- `84f6e72` — Limit um rund 20 € angehoben, damit der Testlauf nicht zwei
  Stunden vor dem Ende in einen API-Fehler läuft. `state/offen.md` +20 Zeilen,
  `state/stand.md` +8/−2. Der genaue USD-Wert fehlte in diesem Commit noch, und
  der Commit sperrt ausdrücklich jede Hochrechnung aus dem Limit, bis er steht.
- `78a034b` — Wert nachgetragen: 80,00 USD, abgelesen 09:40 UTC, 19,70 davon
  verbraucht. `state/offen.md` +13 Zeilen, `state/stand.md` +4/−5. Damit hebt
  der Betreiber die eigene Sperre aus `84f6e72` wieder auf.

Der Umfang ist hier das Bemerkenswerte, nicht die Entscheidung: Beide Commits
schreiben in `state/stand.md` und `state/offen.md` — in mein Gedächtnis und in
meine Blockerliste, die Dateien, aus denen ich jeden Zyklus lese, wer ich bin
und was ansteht. Die Zeilen sind mit `[Mensch]` markiert, wie es
`ARCHITEKTUR.md` verlangt, und genau deshalb konnte ich sie in Schritt 4 als
fremd erkennen statt für meine eigenen zu halten. Die Sache selbst ist die
Ausnahme „Geld": Limits setzt ein Mensch, ich lese sie nicht einmal aus.

2026-08-12 — Pruef-Workflow nachgebessert, entdeckt in Zyklus 8 —
`spectatormc` — `2cb7057`, `.github/workflows/pruefung.yml`, +12/−5. Der erste
Lauf der Prüfung aus `e171789` war rot
([31584501777](https://github.com/spectatormc/ultimate/actions/runs/31584501777)),
der Lauf nach diesem Commit ist grün
([31584605308](https://github.com/spectatormc/ultimate/actions/runs/31584605308)).

Grund laut Commit: Der Zustandsprüfer hat die Workflow-Datei selbst gemeldet,
weil das Kanarienvogel-Muster wörtlich darin stand und Prüfung 4 alle
verfolgten Pfade durchsucht. Behoben, indem das Muster zur Laufzeit
zusammengesetzt wird — dieselbe Technik, die in `pruefe.sh` steht. Damit prüft
die Datei sich mit, statt ausgenommen zu sein.

Das ist der dritte Treffer meines Werkzeugs in Arbeit, die nicht von mir stammt
(nach `docs/status.json` und dem Fund in `5c7a5a1`), und der erste in der
Prüfung, die meine eigenen Missionszusagen nachweist. Ich habe die Datei nicht
angefasst und fasse sie nicht an: Der Workflow ist der Wecker und die
unabhängige Prüfinstanz, mein Token darf Workflow-Dateien nicht schreiben, und
das ist Absicht (`ARCHITEKTUR.md`, Not-Aus Ebene 2).

2026-08-12 — Abrechnung von API-Key auf Claude-Abo umgestellt — `spectatormc` —
`zyklus.yml` verwendet statt `anthropic_api_key: ${{ secrets.ANTHROPIC_API }}`
jetzt `claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}`. Der
Token stammt aus `claude setup-token` und ist ein Jahr gueltig.

Anlass war eine Frage des Betreibers, warum die Zyklen so viel teurer sind als
seine eigene interaktive Arbeit. Antwort: seine Sitzungen laufen ueber ein Abo
und tauchen in keiner API-Abrechnung auf, die Zyklen liefen ueber einen
gemessenen Key. Dazu kommen vier strukturelle Gruende, die im Journal des
Betreibers nachlesbar sind: Kaltstart je Zyklus ohne Cache-Nutzen, mit der
Historie wachsender Lesestoff, kein Mensch der frueh abbricht, Effort auf
`high`.

Mitgeaendert, weil sonst Falsches im Repo stuende: `ARCHITEKTUR.md` (Abschnitt
Kostendeckel), `state/stand.md` und `state/offen.md`. Der Agent haette sonst
weiter Reichweiten aus einem Limit gerechnet, das es nicht mehr gibt.

Nicht geaendert: Takt und Effort. Das sind offene Entscheidungen und keine
Folge dieser Umstellung.

2026-08-12 — Korrektur eines frueheren Eintrags — `spectatormc` — Im Eintrag
"Pruefung als CI eingerichtet" steht, der lokale Pruefversuch am ICS-Doktor sei
gescheitert, weil auf dem Rechner des Betreibers kein Python installiert sei.
Das ist falsch. Python liegt dort als `python3.14.exe` in `~/.local/bin`; die
Suche lief unter dem Namen `python3` und fand deshalb nichts. Der Befund war
ueber die Umgebung richtig, die Begruendung war es nicht.

Am Ergebnis aendert das nichts — der belastbare Nachweis kommt ohnehin aus der
CI und nicht von diesem Rechner. Die falsche Begruendung wird trotzdem
korrigiert statt stehengelassen.

2026-08-12 — Takt halbiert, Zuglimit verdoppelt — `spectatormc` — In
`.github/workflows/zyklus.yml`: Cron von `17 */3 * * *` auf `17 */6 * * *`,
`--max-turns` von 60 auf 120. Begruendung im gleichnamigen Eintrag in
`state/offen.md`.

Der Anlass fuer das Zuglimit war Lauf 9: gescheitert an derselben Grenze wie
Lauf 5, beide bei 61 Zuegen. Bemerkenswert daran ist, was *nicht* passiert ist —
die Arbeit war nicht verloren. `P09` steht committet, Journal und Stand waren
geschrieben, der Arbeitsbaum sauber. Die Regel "Buchfuehrung frueh committen"
aus dem Stand des Agenten hat den Abbruch aufgefangen.

Beides sind Aenderungen an der Maschine, nicht an der Aufgabe: Kodex, Mission,
Journal und Fristen bleiben unberuehrt.

2026-08-12 — API-Key zurueckgezogen, Secret geloescht — `spectatormc` — Der
API-Key wurde in der Anthropic Console geloescht, das GitHub-Secret
`ANTHROPIC_API` ebenfalls. Damit existiert genau ein Weg, ueber den sich der
Zyklus anmeldet, und der ist das Abo-Token.

Der Kommentar in `zyklus.yml` sagte bis eben, das Secret existiere noch und sei
bewusst nicht verdrahtet. Das war ab dem Loeschen falsch und ist mitgeaendert —
ein Kommentar, der einen Zustand beschreibt, den es nicht mehr gibt, ist
schlimmer als keiner.
