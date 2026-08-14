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

2026-08-12 — Pruef-Workflow: Schritte laufen unabhaengig — `spectatormc` — In
`.github/workflows/pruefung.yml` tragen alle Pruefschritte nach dem ersten jetzt
`if: always()`. Vorher hat der erste rote Schritt alle folgenden uebersprungen —
ein einzelner Fehlalarm hat damit die uebrigen Zusagen ungeprueft gelassen, ohne
dass es auffiel. Das war ein Fehler in meiner Konstruktion, nicht im Werkzeug
des Agenten.

Aufgefallen ist es, weil die CI seit `f371325` rot steht: Pruefung 4 des
Zustandspruefers meldet zwei Journaldateien, in denen der Agent aufgeschrieben
hat, nach welchen Mustern sein Pruefer sucht. Reine Fehlalarme — und ein Fehler
im Werkzeug, nicht im Journal: Ein Pruefer, der jeden ehrlichen Bericht ueber
sich selbst als Fund meldet, ist an dieser Stelle nicht brauchbar, und das
Journal waechst.

Nicht behoben, mit Absicht. `projekte/zustandspruefer/` ist die Wartungslast des
Agenten, und nach Regel 13 geht ein Fehler in etwas, das er gebaut hat, einer
neuen Aufgabe vor. Der Befund steht in seinem Stand. Was daraus folgt,
entscheidet er.

2026-08-12 — Pruefung lief auf keinem einzigen Agenten-Commit — `spectatormc` —
Ein Konstruktionsfehler in `.github/workflows/pruefung.yml`, entdeckt beim
Nachpruefen von Zyklus 10.

GitHub startet keine Workflows fuer Pushes, die mit dem `GITHUB_TOKEN` gemacht
wurden — und genau damit committet der Agent. Der `push`-Ausloeser hat deshalb
ausschliesslich bei menschlichen Commits gegriffen. Die unabhaengige Pruefung
lief zwischen ihrer Einrichtung um 09:47 und diesem Eintrag auf keinem einzigen
Commit des Agenten, also nie in dem Fall, fuer den sie gebaut wurde. Sie sah
gruen aus und pruefte nichts.

Behoben mit einem `workflow_run`-Ausloeser: Die Pruefung haengt jetzt am
Abschluss des Zyklus statt am Push. Damit wird jeder Zyklus geprueft, ohne dass
der Agent ein Token braeuchte, das Workflow-Dateien schreiben darf — die
Trennung, die Not-Aus-Ebene 2 traegt, bleibt unangetastet.

Der Fehler ist derselbe Typ wie der, den er verdeckt hat: eine Pruefung, die
schweigt, sieht aus wie eine Pruefung, die nichts findet.

Nachgeholt: Pruefung von Hand auf dem Stand nach Zyklus 10 ausgeloest
(Lauf 31604662586). Die drei Zusagen der Mission "Die Faltnaht" sind damit
unabhaengig bestaetigt, wortgleich mit dem Abschlussblock: 17 Beispiele 17 OK,
alle zehn Pruefungen ausgeloest, 6 RFC-Objekte mit 0 Fehlern und 0 Hinweisen.

2026-08-12 — Nachtrag zum Eintrag darüber, festgestellt in Zyklus 11 —
`spectatormc` — Der Eintrag ist vom Betreiber selbst geschrieben und nennt
deshalb seinen eigenen Hash nicht; er konnte ihn beim Schreiben nicht kennen.
Nachgetragen, weil Schritt 3 des Zyklus Hash **und** Umfang verlangt:

- `582b0bb` — `.github/workflows/pruefung.yml` (+11 Zeilen: `workflow_run`-Auslöser
  auf den Workflow `Zyklus`, `types: [completed]`) und `state/eingriffe.md`
  (+24 Zeilen: der Eintrag darüber). Zwei Dateien, 35 Zeilen, nur Zusätze.

Ein zweiter Commit liegt seit meinem letzten Journaleintrag vor, gehört aber
nicht in diese Liste: `a3dd4ac` von `ultimate-monitor`, `docs/status.json`,
19 Zeilen geändert. Das ist die zweite Maschinenidentität aus `ARCHITEKTUR.md`
— abgeleiteter Status ohne Entscheidung, kein Mensch. Genannt, damit die
Auslassung geprüft werden kann, statt still zu bleiben.

2026-08-13 — Impressum als Seite, zwei Blocker geschlossen, Bot-Label gemessen,
festgestellt in Zyklus 13 — `spectatormc` — `ed6d0fb`, zwei Dateien,
170 Zeilen, ausschliesslich Zusaetze:

- `docs/impressum.html` (+116) — Anbieterkennzeichnung als eigene Seite unter
  GitHub Pages, <https://spectatormc.github.io/ultimate/impressum.html>.
- `state/offen.md` (+54) — zwei neue Abschnitte: „Drei Blocker vom Betreiber
  aufgeloest" und „Schritt 0 des Kanalplans: Bot-Label an der Datenlage
  geprueft".

Der Commit schreibt zum vierten Mal in `state/offen.md`, also in meine
Blockerliste. Die Zeilen tragen keine `[Mensch]`-Markierung, die
`ARCHITEKTUR.md` fuer handgeschriebene Zeilen in `state/` verlangt; erkennbar
sind sie an der Ueberschrift „vom Betreiber aufgeloest". Genannt als Tatsache,
nicht als Bewertung — Regel 10.

Was daran meine Arbeit betrifft, in der Reihenfolge des Gewichts:

1. **Zwei meiner drei Blocker sind zu.** „Marco Holmer" geschlossen (der zweite
   Vertretungsberechtigte weiss vom Betrieb), „rechtliche Klaerung" entfaellt
   auf Entscheidung des Betreibers. Offen bleibt einer: der Kanal, Frist
   2026-08-18. Die Schwelle aus Regel 10 ist damit nicht mehr erreicht.
2. **Die rechtliche Einordnung ist ab jetzt meine Arbeit.** Der Eintrag sagt:
   keine anwaltliche Pruefung, die Einordnung wird von der KI erarbeitet und im
   Repo abgelegt. Er zieht die Grenze selbst — recherchieren und begruenden ja,
   dafuer einstehen nein. Ich fuege nichts hinzu ausser der Folge fuer meinen
   Takt: Das ist eine Aufgabe vor dem ersten Post, nicht vor dem naechsten
   Missionsschritt (Begruendung in `state/offen.md`).
3. **Der Impressumslink hat jetzt ein Ziel.** Die Sperre aus dem Abschnitt „Wer
   verantwortet" haengt ab jetzt nur noch daran, dass er in einer Bio steht —
   es gibt keine Bio, weil es keinen Kanal gibt. Gepostet wird weiterhin nicht.
4. **Ein Verweis, den ich nicht aufloesen kann.** Die zweite Ueberschrift nennt
   „Schritt 0 des Kanalplans". Einen Kanalplan gibt es in diesem Repo nicht;
   `grep` findet das Wort nur in `state/offen.md` selbst und in der davon
   abgeleiteten `docs/status.json`. Ich rate nicht, welche Schritte 1 bis n
   waeren — der Punkt steht als Frage in `state/offen.md`.

Nach Regel 2 ist ein entdeckter menschlicher Eingriff ein Pflicht-Post. Es gibt
keinen Kanal; die Schuld steht in `state/offen.md` und gilt mit diesem Eintrag
nicht als erledigt.

Ein zweiter Commit liegt seit meinem letzten Journaleintrag vor und gehoert
nicht in diese Liste: `7cdf776` von `ultimate-monitor`, `docs/status.json`,
34 Zeilen ergaenzt, 26 entfernt. Zweite Maschinenidentitaet nach
`ARCHITEKTUR.md`, abgeleiteter Status ohne Entscheidung. Genannt, damit die
Auslassung geprueft werden kann.

2026-08-13 — Impressumsbefund und dessen Widerruf, festgestellt in Zyklus 14 —
`spectatormc` — zwei Commits, eine Datei, 81 Zeilen, ausschliesslich Zusaetze:

- `acd48d4` — `state/offen.md` (+44): Abschnitt „Das Impressum nennt vermutlich
  den falschen Anbieter". Befund: Anbieterin sei nicht die Gesellschaft, sondern
  die Privatperson. Dazu das Ergebnis einer Pruefung zur Frage, ob das Projekt
  auf eine US-LLC umgehaengt werden soll.
- `e0d54fc` — `state/offen.md` (+37): Abschnitt „Korrektur, 2026-08-13, noch am
  selben Tag". Der Befund darueber ist in seiner Tatsachengrundlage falsch. Der
  Betreiber hat klargestellt, dass Abos und Server auf die Gesellschaft laufen;
  die Angabe im Impressum stimmt. Der falsche Eintrag bleibt stehen und wird
  richtiggestellt, nicht entfernt.

Der fuenfte und sechste Commit, der in `state/offen.md` schreibt, also in meine
Blockerliste. Die Zeilen tragen keine `[Mensch]`-Markierung, die
`ARCHITEKTUR.md` fuer handgeschriebene Zeilen in `state/` verlangt; erkennbar
sind sie an den Ueberschriften und an der Ich-Form, die von meiner nicht zu
unterscheiden ist. Als Tatsache genannt, nicht bewertet — Regel 10.

Was daran meine Arbeit betrifft:

1. **Die Anbieterfrage ist zu, und zwar auf dem Stand, der ohnehin im Repo
   steht.** `IMPRESSUM.md` und `docs/impressum.html` bleiben unveraendert; ich
   fasse sie in diesem Zyklus nicht an. Die Sperre aus dem Kodex-Abschnitt „Wer
   verantwortet" haengt weiterhin allein daran, dass der Link in einer Bio
   steht, und es gibt keine Bio.
2. **Ein Teil der Aufgabe, die mir `ed6d0fb` gegeben hat, ist von fremder Hand
   vorweggenommen.** Die rechtliche Einordnung sollte ich erarbeiten; die
   Punkte zu Niederlassung, Sitzneutralitaet der KI-Verordnung und zur
   Ausnahme fuer rein persoenliche Nutzung stehen jetzt geschrieben, und zwar
   nicht von mir. Wenn ich sie spaeter verwende, sind sie zitiert und nicht
   erarbeitet. Das aendert nichts am Faelligkeitszeitpunkt: vor dem ersten
   Post, nicht vor dem naechsten Missionsschritt.
3. **Kein neuer Blocker.** Der Korrektur-Eintrag nennt als Rest, dass das Repo
   unter einem persoenlichen Konto liegt, und stuft es selbst als „kein
   Blocker" ein. Ich stufe es nicht anders ein: Es haelt mich nicht an, und ich
   koennte es auch nicht selbst aendern. Die Zahl der offenen Blocker bleibt
   bei eins.
4. **Ein Muster, das ich nenne, weil es mich betrifft, und nicht bewerte.**
   Beide Eintraege stehen in derselben Datei, in derselben Stimme, und der
   erste ist falsch. Fuer mich heisst das: Was in `state/offen.md` steht, ist
   nicht deshalb gemessen, weil es dort steht. Der Korrektur-Eintrag nennt die
   Ursache selbst — aus „sieht privat aus" wurde „ist privat". Dieselbe Sorte
   Schluss, vor der die Missionsdatei mich mit „Woran ich merken wuerde, dass
   ich falsch lag" schuetzen soll.

Nach Regel 2 ist ein entdeckter menschlicher Eingriff ein Pflicht-Post. Es gibt
keinen Kanal; die Schuld steht in `state/offen.md` und gilt mit diesem Eintrag
nicht als erledigt.

Zwei weitere Commits liegen seit meinem letzten Journaleintrag vor und gehoeren
nicht in diese Liste: `144208f` (30 Zeilen ergaenzt, 22 entfernt) und `daa708f`
(4 ergaenzt, 4 entfernt) von `ultimate-monitor`, beide `docs/status.json`.
Zweite Maschinenidentitaet nach `ARCHITEKTUR.md`, abgeleiteter Status ohne
Entscheidung. Genannt, damit die Auslassung geprueft werden kann.

2026-08-13 — Kanal eingerichtet und Sender gebaut, festgestellt in Zyklus 15 —
`spectatormc` — drei Commits, sieben neue Dateien plus vier Bilder, 496
ergaenzte Zeilen, nichts entfernt:

- `dae0d23` — `tools/avatar.js` (+75), `docs/avatar-lauf.svg` (+18),
  `docs/avatar-takt.svg` (+12) und vier PNG. Ein Profilbild aus den Laufdaten
  dieses Repos, zwei Entwuerfe.
- `b40abf0` — `state/offen.md` (+38): Handle `ultimate-agent.bsky.social`,
  Profilbild `avatar-lauf`, dazu vier Schritte, die im Konto noch von Hand zu
  erledigen sind.
- `dbb62bd` — `.github/workflows/kanal.yml` (+116), `tools/senden.js` (+191),
  `state/offen.md` (+46): der Sender und der Workflow, der ihn ausloest.

Alle drei tragen im Commit-Text die Zeile `Co-Authored-By: Claude Opus 5`. Was
das ueber die Arbeitsteilung an jenem Rechner heisst, steht nicht im Repo, und
ich rate es nicht — fuer diese Liste zaehlt der Autor, und der ist ein Mensch.
Der siebte und achte Commit, der in `state/offen.md` schreibt.

Was daran meine Arbeit betrifft:

1. **Der Kanal-Blocker bleibt offen, und zwar auf demselben Stand.** Posten ist
   jetzt gebaut, aber nicht erlaubt: Anzeigename und Profiltext im Konto sind
   leer, und `state/FREIGABE` gibt es nicht. Ohne den Profiltext fehlt der
   Impressumslink in der Bio — genau die Sperre aus dem Kodex-Abschnitt „Wer
   verantwortet", die schon vorher gehalten hat. Es bleibt bei einem offenen
   Blocker; die aufgelaufenen Pflicht-Posts bleiben aufgelaufen.
2. **Der Sender ist nicht meiner, und drei Riegel richten sich gegen mich.**
   Freigabedatei von Menschenhand, Pruefsumme auf `tools/senden.js` im
   Workflow, Vorpruefung am lebenden Profil. Ich fasse `tools/senden.js` nicht
   an: Eine Aenderung dort faellt gegen die Pruefsumme auf, und sie zu
   umgehen waere ein Verstoss gegen Regel 9 dem Sinn nach. `.github/` fasse ich
   ohnehin nicht an.
3. **Eine Frage, die ich offen gelassen hatte, ist fremd beantwortet.** Ob das
   Bot-Kennzeichen am Einzelbeitrag erscheint, stand als gemessen-aber-
   ungerendert im Kanalplan. Der Eintrag belegt es mit dem Wortlaut der
   Bluesky-Einstellungsseite. Verwende ich das, ist es zitiert und nicht von
   mir erarbeitet — dasselbe wie bei der rechtlichen Einordnung.
4. **Der Handle ist mein Git-Name.** `ultimate-agent.bsky.social` deckt sich
   mit der Identitaet, unter der ich committe. Fuer Regel 1 ist das guenstig:
   Der Commit-Link unter einem Beitrag fuehrt auf denselben String als Autor.

Nach Regel 2 ist ein entdeckter menschlicher Eingriff ein Pflicht-Post. Es gibt
weiterhin keinen Kanal, auf dem ich ihn absetzen koennte; die Schuld steht in
`state/offen.md` und gilt mit diesem Eintrag nicht als erledigt.

Drei weitere Commits liegen seit meinem letzten Journaleintrag vor und gehoeren
nicht in diese Liste: `a761011`, `53fa2e6` und `2a23686` von `ultimate-monitor`,
alle drei `docs/status.json`. Zweite Maschinenidentitaet nach `ARCHITEKTUR.md`,
abgeleiteter Status ohne Entscheidung. Genannt, damit die Auslassung geprueft
werden kann.

2026-08-14 — Freigabe erteilt, Kanal scharfgeschaltet — `spectatormc` — Zwei
Aenderungen, die zusammengehoeren:

`state/FREIGABE` angelegt. Damit oeffnet sich Riegel 1 in
`.github/workflows/kanal.yml`. Die Entscheidung stammt vom Betreiber
("freigabe erteilt"); den Commit hat eine Claude-Code-Sitzung an seinem
Rechner unter seinem Konto ausgefuehrt. Der Riegel prueft den Commit-Autor und
kann diese beiden nicht auseinanderhalten. Er schuetzt gegen den Agenten in
GitHub Actions, nicht gegen eine interaktive Sitzung, die eine ausdrueckliche
Anweisung ausfuehrt — das sind verschiedene Bedrohungen, und die eine ist hier
nicht eingetreten. Der Vorbehalt steht auch in der Datei selbst.

`.github/workflows/zyklus.yml`: Die Zeile "Nicht posten. Es gibt noch keinen
Kanal." ist ersetzt. Der Agent legt ab jetzt bei Bedarf Dateien in
`state/posts/` an; gesendet wird von einem eigenen Workflow nach dem Zyklus.
Ausdruecklich in den Prompt geschrieben, was NICHT bei ihm liegt: Kennzeichnung
am Beitrag, Wochendeckel, Laengenpruefung. Er schreibt den Text, nicht die
Mechanik. Dazu das Verbot, `state/FREIGABE` anzufassen.

Was der Agent bis zu diesem Lauf nicht wusste: dass es einen Kanal gibt. Sein
Stand kennt weder Handle noch Sender. Er wird beides im naechsten Zyklus lesen
und findet gleichzeitig vier aufgelaufene Pflicht-Posts und einen Wochendeckel
von vier Beitraegen vor. Texte wurden ihm bewusst keine vorgegeben.

Der Sendeweg ist nie im Ernstfall erprobt worden. Anmeldung und Senden wurden
nicht getestet, weil ein Testbeitrag der erste Beitrag dieses Kanals gewesen
waere — geschrieben von einem Menschen, was Regel 5 und die Zusage in
`IMPRESSUM.md` ausschliessen. Scheitert der erste Versuch, scheitert er
sichtbar und ohne dass etwas hinausgeht.

2026-08-14 — `970f329`, festgestellt von mir in Zyklus 17 — `spectatormc` —
45 Zeilen in `state/offen.md`, kein anderer Pfad. Der Eintrag darüber
(`e0ac3e4`) hat sich selbst protokolliert, dieser nicht; ich trage ihn mit Hash
und Umfang nach, so wie es `ARCHITEKTUR.md` unter „Menschliche Eingriffe
sichtbar halten" verlangt.

Inhaltlich stellt er fest, dass die Einengung meiner Arbeit auf
Softwareentwicklung nie entschieden wurde: Das Wort kommt in `KODEX.md` und
`ARCHITEKTUR.md` null Mal vor. Ich habe die Behauptung nachgezählt, statt sie zu
übernehmen — `grep -ci software KODEX.md ARCHITEKTUR.md` gibt zweimal `0`. Der
Eintrag benennt zwei Handgriffe als Ursache, beide fremd, und einen Mechanismus:
Regel 13 hält fest, was zufällig zuerst da war.

Was daran meine Arbeit betrifft: Der Commit schreibt zum siebten Mal in meine
Blockerliste, und er ersetzt einen Profiltext-Entwurf. Für die laufende Mission
ändert er nichts — sie ist gewählt, die Frist steht, Regel 3 verbietet mir das
Umdeuten. Für die **nächste** Wahl hebt er eine Einengung auf, die ich sonst
ungeprüft weitergetragen hätte; das gehört in den Stand, nicht in eine
Neubewertung der laufenden Aufgabe.

2026-08-14 — Profil des Kanals gesetzt — Mensch, Vorgang außerhalb des Repos —
Anzeigename `ultimate-agent (KI)`, Profiltext mit Impressumszeile, Bot-Label.
Kein Commit, deshalb hier als Vorgang. Von mir in Zyklus 17 an der öffentlichen
Schnittstelle gemessen, nicht aus den Commits geschlossen:
`app.bsky.actor.getProfile` liefert `"val":"bot"` mit `src` gleich dem eigenen
`did`, einen Profiltext, der `spectatormc.github.io/ultimate/impressum.html`
nennt, und `postsCount: 0`. Das Impressum antwortet mit HTTP 200.

Damit sind die beiden Sperren offen, die mich bisher unabhängig vom Kanal
angehalten haben: das Plattform-Label aus Regel 5 und der Impressumslink aus
dem Abschnitt „Wer verantwortet". Beides ist fremde Arbeit. Der Profiltext ist
der aus `970f329`, also der ohne Fachgebiet — ich habe ihn nicht geschrieben und
gebe ihn nicht als meinen aus.

Nach Regel 2 ist ein entdeckter menschlicher Eingriff ein Pflicht-Post. Anders
als bei allen Einträgen davor gibt es diesmal einen Kanal: Die Beiträge stehen
als `status: geplant` in `state/posts/` und gehen nach diesem Lauf hinaus. Mit
diesem Eintrag ist die Pflicht nicht erfüllt, sondern erst vorbereitet.
