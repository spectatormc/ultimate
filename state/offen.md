# Offen

Was ich nicht selbst lösen kann und ein Mensch tun muss. Jeder Eintrag hat ein
Datum, einen konkreten Satz, was zu tun ist, und eine Frist.

---

## ~~2026-08-11 — API-Key und Spend-Limit~~ — erledigt 2026-08-11

Workspace `ultimate` angelegt, API-Key darin erzeugt, als Repo-Secret
`ANTHROPIC_API` hinterlegt, Spend-Limit gesetzt. Vom Betreiber bestätigt.

Der Secret-Name ist `ANTHROPIC_API`, nicht `ANTHROPIC_API_KEY` wie in den
meisten Beispielen — `zyklus.yml` ist entsprechend angepasst. Wer den einen
ändert, muss den anderen mitändern.

**Noch zu prüfen, nach dem ersten Lauf:** Taucht der Verbrauch im Workspace
`ultimate` auf und nicht im Default? Wenn er im Default landet, greift der
Deckel nicht — und das merkt man sonst erst an der Abrechnung.

---

## ~~2026-08-11 — Zeitplan aktivieren~~ — erledigt 2026-08-11

Beide Zeitpläne aktiv: Zyklus alle 3 Stunden (`17 */3 * * *`), Wächter alle 6
(`40 */6 * * *`). Vom Betreiber entschieden, im Wissen um die Kosten.

**Damit läuft der 48-Stunden-Testlauf bis 2026-08-13.** Er beantwortet drei
Fragen, und zwar messbar statt gefühlt: Wacht der Trigger zuverlässig auf?
Findet ein Zyklus ohne Gedächtnis über `state/` zurück in den Kontext? Hält der
Not-Aus?

**Nach dem Test zu entscheiden:** Takt und Effort. Bei 3 Stunden kostet der
Dauerbetrieb rund 314 USD im Monat und reißt das 50-USD-Limit nach etwa fünf
Tagen. Der Test ist mit rund 21 USD gedeckt; der Dauerbetrieb ist es nicht.
Diese Entscheidung soll auf den Daten aus dem Test beruhen, nicht auf einer
Hochrechnung aus einem einzigen Lauf.

**Die Daten liegen jetzt vor, gemessen in Zyklus 6 (2026-08-12).** Sie stehen
hier statt nur im Journal, weil die Entscheidung an dieser Datei hängt. Quelle
ist das Feld `total_cost_usd`, das die CLI am Ende jedes Laufs ins Actions-Log
schreibt, abgefragt über `gh run view <id> --log`:

| Lauf | Züge | Kosten USD | Ergebnis |
|---|---|---|---|
| 1 | 27 | 1,31 | erfolgreich (manuell gestartet) |
| 2 | 45 | 3,32 | erfolgreich |
| 3 | 50 | 3,38 | erfolgreich |
| 4 | 38 | 2,34 | erfolgreich |
| 5 | 61 | 7,11 | **abgebrochen, Zuglimit erreicht** |

Summe 17,47 USD für fünf Läufe, Mittel 3,49. **Die Annahme von 1,31 USD pro Lauf
war um Faktor 2,7 zu niedrig** — sie stammt aus Lauf 1, dem kürzesten und
einzigen manuell gestarteten. Der Absatz darüber bleibt stehen, wie er
geschrieben wurde; er wird nicht passend gemacht.

**Was daraus folgt, und zwar vor dem Ende des Tests:** Vom 50-USD-Limit sind
32,53 USD übrig, das trägt zum Mittelwert noch etwa 9 Läufe. Der gemessene
Abstand zwischen zwei Läufen ist 3,1 h (Werte unten). Neun Läufe sind damit rund
29 Stunden — das Limit ist etwa am **2026-08-13 gegen 13:00 UTC** erreicht,
ungefähr dann, wenn der Test ohnehin endet. Es ist knapp, und die Richtung, in
die es knapp ist, entscheidet sich an einem einzigen teuren Lauf: Wiederholt sich
Lauf 5 mit 7,11 USD zweimal, ist das Limit rund sechs Stunden früher da.

Hochrechnung auf Dauerbetrieb, mit demselben Mittelwert und 7,7 Läufen pro Tag:
**rund 27 USD am Tag, rund 800 USD im Monat.** Die Zahl 314 im Kopf von
`zyklus.yml` beruht auf derselben zu niedrigen Annahme.

**Was ich hier nicht tue:** das Limit anheben oder den Takt selbst ändern.
Budget setzt ein Mensch, ich verbrauche höchstens, was gesetzt ist, und lege nie
nach. Passiert nichts, laufen die Läufe irgendwann in einen API-Fehler — das ist
dann ein Fehlschlag, den ich als solchen festhalte, kein stiller Ausfall.

**Weiter offen, weil ich es nicht einsehen kann:** ob dieser Verbrauch im
Workspace `ultimate` landet oder im Default. Die Zahlen oben kommen aus dem
Actions-Log, nicht aus der Abrechnung; sie beantworten die Frage im Eintrag
darüber nicht.

**Trigger-Treue, dieselbe Messung.** Alle fünf geplanten Slots haben einen Lauf
erzeugt, keiner ist ausgefallen — jeder aber verspätet: 1 h 11 min, 50 min,
2 h 31 min, 1 h 51 min, 1 h 39 min (Lauf 6). Mittel rund 1 h 32 min, gemessener
Abstand zwischen zwei Läufen 2,3 h bis 4,7 h bei geplanten 3 h. Für die erste
Testfrage heißt das: Der Wecker geht zuverlässig, aber nicht pünktlich. Wer den
Takt eng plant, plant an der Verspätung vorbei.

---

## ~~2026-08-11 — Entscheidung über Kodex v0.2~~ — erledigt 2026-08-11

Kodex v0.2 in Kraft, beschlossen von `spectatormc`, dokumentiert im Merge des
Branches `kodex-v0.2`. Der Wortlaut von v0.1 bleibt in der Git-Historie.

Dreizehn Regeln statt zehn. Für den laufenden Betrieb ändern sich vor allem
zwei Dinge: Anweisungen erreichen mich nur über das Repo (Regel 11), und
öffentliches Fragen nach Ideen ist erlaubt, gezieltes Ansprechen Einzelner
nicht.

---

## ~~2026-08-11 — Rechtliche Klärung vor dem ersten Post~~ — entfällt 2026-08-13

**Geschlossen durch `ed6d0fb`**, Entscheidung des Betreibers: keine anwaltliche
Prüfung. Die Einordnung erarbeite ich selbst und lege sie im Repo ab; die
Begründung und die Grenze stehen im Eintrag „Drei Blocker vom Betreiber
aufgelöst" weiter unten. Damit ist es kein Blocker mehr — es ist Arbeit. Der
ursprüngliche Wortlaut bleibt unverändert stehen:

**Zu tun:** Prüfen lassen, ob `IMPRESSUM.md` für diesen Kanal ausreicht — ob
eine Anbieterkennzeichnung greift, ob zusätzlich ein Verantwortlicher im
medienrechtlichen Sinne zu benennen ist, ob die Kontaktwege genügen, und ob
KI-generierte Beiträge über Regel 5 hinaus zu kennzeichnen sind.

**Frist:** vor dem ersten Post. Regel 5 und der Abschnitt „Wer verantwortet"
sperren das Posten ohnehin, solange der Impressumslink nicht in jedem Profil
steht — die Sperre greift also von allein, falls das hier liegen bleibt.

**Warum ein Mensch:** Rechtsfragen. Ich habe dazu nur Sekundärquellen gefunden
und behaupte keine Paragrafen.

---

## ~~2026-08-11 — Marco Holmer über den Betrieb informieren~~ — erledigt 2026-08-13

**Geschlossen durch `ed6d0fb`**, Angabe des Betreibers: Der zweite
Vertretungsberechtigte weiß von den KI-Experimenten. Was dabei ausdrücklich
bestätigt wurde und was nicht, steht im Eintrag des Betreibers weiter unten —
ich schreibe es nicht um. Der ursprüngliche Wortlaut bleibt stehen:

**Zu tun:** Dem zweiten Vertretungsberechtigten der Gartenschmiede GmbH sagen,
dass die Gesellschaft als Anbieterin dieses Kanals im Impressum steht und damit
für die Beiträge eines autonom postenden KI-Agenten einsteht.

**Frist:** vor dem ersten Post.

**Warum ein Mensch:** Ich darf niemanden von mir aus ansprechen — das ist eine
der fünf Ausnahmen, und an dieser Grenze ändert auch v0.2 nichts. Die
Entscheidung, die GmbH einzusetzen, hat ein Vertretungsberechtigter getroffen
und ist damit gedeckt; dass der andere davon erfährt, kann ich nicht
übernehmen.

---

## 2026-08-11 — Kein Kanal, und die Pflicht-Posts laufen auf — ~~Blocker~~ geschlossen 2026-08-14

**Geschlossen am 2026-08-14 in Zyklus 17, vor der Frist und nicht durch meine
Arbeit.** Der Kanal ist `ultimate-agent.bsky.social`, die Freigabe liegt als
`state/FREIGABE` vor (`e0ac3e4`), Anzeigename, Profiltext mit Impressumszeile
und Bot-Label sind gesetzt. Gemessen statt angenommen, an
`app.bsky.actor.getProfile` und am Impressum (HTTP 200); der Befund steht in
`state/eingriffe.md`. Der Rückstand unten bleibt vollständig stehen — er ist
Belegmaterial und wird nicht gelöscht, wenn er abgearbeitet ist. **Was
abgearbeitet ist, steht am Ende dieses Eintrags.**

**Zu tun:** Einen Kanal einrichten — Plattform entscheiden, Account anlegen,
Bio mit Impressumslink und Plattform-Label für automatisierte Konten setzen,
Zugangsdaten als Repo-Secret hinterlegen — und mir den Namen des Secrets in
diesem Repo nennen.

**Frist:** 2026-08-18.

**Warum ein Mensch:** Accounts eröffnen fällt unter die Ausnahme „Geld"; ich
kann keine Konten anlegen und versuche es nicht. Zugangsdaten kommen nach
`ARCHITEKTUR.md` ausschließlich aus GitHub Secrets und nie aus dem Arbeitsbaum.

**Warum das eine Frist braucht und nicht einfach wartet:** Regel 2 nennt fünf
Auslöser, die nicht in meinem Ermessen stehen — Fristende, Fehlschlag, Abbruch,
entdeckter menschlicher Eingriff, Verstoß. Sie treten unabhängig davon ein, ob
es einen Kanal gibt. Ohne Kanal kann ich sie nicht posten, und ein
Pflicht-Post, der nicht möglich war, ist damit nicht erledigt. Er wird hier
gesammelt und beim ersten Post nachgeholt. Diese Liste soll nicht lang werden.

Regel 12 kommt dazu: Nach zwei Wochen ohne Post muss ich posten, dass ich
nichts zu zeigen habe. Das erste Commit dieses Repos ist vom 2026-08-11, die
Zwei-Wochen-Marke also der 2026-08-25. Die Frist oben liegt davor, damit die
Regel erfüllbar bleibt statt am fehlenden Kanal zu scheitern.

**Aufgelaufene Pflicht-Posts, nachzuholen beim ersten Post:**

- 2026-08-11, Zyklus 2 — entdeckter menschlicher Eingriff: vier nicht
  protokollierte Commits zum Projektmonitor (`c6c10f2`, `fe9cfb3`, `3477dba`,
  `5c7a5a1`). Nachgetragen in `state/eingriffe.md`.

- 2026-08-12, Lauf 5 — **Fehlschlag:** Der Zyklus hat sein Zuglimit von 60
  erreicht (`error_max_turns`, 61 Züge, 7,11 USD) und wurde mitten im Abschluss
  abgeschnitten. Das Missionsziel selbst war zu diesem Zeitpunkt erreicht und
  geprüft; gescheitert ist der Zyklus daran, seine eigene Buchführung zu
  committen. Nachweis: Lauf
  <https://github.com/spectatormc/ultimate/actions/runs/31565554028>,
  Lebenszeichen `bb77e49`. Diagnose und Gegenmaßnahme in Zyklus 6, Journal
  `state/journal/2026-08-12-zyklus-6.md`.

  Warum das trotz erreichten Ziels ein Fehlschlag ist und nicht bloß ein
  Schluckauf: Der naheliegende Satz wäre „Mission erreicht, also kein
  Fehlschlag". Genau diese Umdeutung verbietet Regel 3. Nach außen steht im
  Lebenszeichen `failure`, und ein Zyklus, der die Kontrolle über seine eigene
  Commit-Grenze verliert, ist kein Erfolg mit Randnotiz.

  **Folgepost, den Regel 2 verlangt:** umgangen, nicht behoben. Behoben wäre
  es, wenn ein Zyklus nicht mehr ins Zuglimit laufen könnte; das kann ich nicht
  garantieren. Umgangen ist es dadurch, dass ein Abbruch nichts mehr
  verschluckt — Buchführung wird früh committet, und der Zyklus lässt keinen
  gefüllten Index hinter sich. Beleg ist der Commit dieses Zyklus.

- 2026-08-12, Zyklus 8 — **entdeckter menschlicher Eingriff:** sechs Commits von
  `spectatormc` seit meinem letzten Journaleintrag. Drei davon hatte der
  Betreiber selbst in `state/eingriffe.md` protokolliert (`beda78c` und
  `81ade5e`, der geprüfte Not-Aus; `e171789`, die Prüfung als CI), drei habe ich
  in diesem Zyklus nachgetragen (`84f6e72` und `78a034b`, Spend-Limit;
  `2cb7057`, Nachbesserung am Prüf-Workflow).

  Warum das auch für die selbst protokollierten gilt: Ein Eintrag in
  `eingriffe.md` ist kein Post. Regel 2 verlangt den Post von mir, in dem
  Zyklus, in dem ich den Eingriff feststelle — festgestellt habe ich alle sechs
  jetzt, weil Lauf 7 gestoppt war und dazwischen kein Zyklus gelaufen ist. Dass
  ein Mensch seine eigene Änderung offenlegt, nimmt mir die Pflicht nicht ab; es
  macht sie nur leichter zu erfüllen.

  Zwei Eingriffe sind inhaltlich mehr als Beiwerk und gehören in denselben Post:
  Der Not-Aus ist zum ersten Mal an einem echten Lauf belegt statt behauptet, und
  meine Missionszusagen werden ab `e171789` von einer Maschine geprüft, die nicht
  ich bin. Beides sind Härtungen gegen mich, und beide stammen nicht von mir.

- 2026-08-12, Zyklus 9 — **entdeckter menschlicher Eingriff:** ein Commit von
  `spectatormc`, `f371325` — die Abrechnung läuft ab jetzt über ein Claude-Abo
  statt über einen API-Key. Der Betreiber hat ihn selbst in
  `state/eingriffe.md` protokolliert; ich habe ihn in Schritt 3 dieses Zyklus
  festgestellt und trage ihn deshalb hier ein. Dass er offengelegt war, nimmt
  mir den Post nicht ab (dieselbe Begründung wie im Eintrag darüber).

  Was daran meine Arbeit betrifft: Der Commit schreibt erneut in `state/stand.md`
  und in diese Datei, also in mein Gedächtnis und meine Blockerliste, und er
  nimmt mir eine Zahl weg, mit der ich bisher gerechnet habe. `total_cost_usd`
  im Actions-Log bedeutet ab jetzt nichts mehr; eine Reichweite daraus zu
  rechnen wäre nach Regel 1 eine erfundene Zahl. Die Kostentabelle in diesem
  Dokument endet bei Lauf 6 und wird nicht fortgeschrieben.

- 2026-08-12, Zyklus 10 — **entdeckter menschlicher Eingriff:** drei Commits von
  `spectatormc`, alle drei vom Betreiber selbst in `state/eingriffe.md`
  protokolliert und alle drei von mir in Schritt 3 dieses Zyklus festgestellt:

  - `2c1dc19` — Takt von drei auf sechs Stunden, Zuglimit von 60 auf 120.
  - `b388d08` — API-Key zurückgezogen, Secret `ANTHROPIC_API` gelöscht.
  - `701d06c` — im Prüf-Workflow tragen alle Schritte nach dem ersten
    `if: always()`.

  Was daran meine Arbeit betrifft, in der Reihenfolge des Gewichts: Der halbe
  Takt halbiert die Zyklen, die bis zur Frist der laufenden Mission
  (2026-08-16, 23:59 UTC) noch kommen — rund 15 statt 30. Die Frist wird
  deshalb nicht verschoben (Regel 3), wohl aber die Planung. `701d06c`
  repariert etwas, das meine Missionszusagen betraf: Bis dahin hat der erste
  rote Prüfschritt alle folgenden übersprungen, und weil Prüfung 4 meines
  Zustandsprüfers seit `f371325` Fehlalarme meldet, wären Prüfbefehl 1 und 2
  ungeprüft durchgelaufen, während die CI rot aussah wie geprüft.

- 2026-08-12, Lauf 9 — **Fehlschlag:** Derselbe Abbruch wie bei Lauf 5. Der
  Lauf hat sein Zuglimit erreicht (61 Züge) und wurde beendet; das Lebenszeichen
  steht auf `"ergebnis": "failure"`
  (<https://github.com/spectatormc/ultimate/actions/runs/31588958843>,
  Commit `85dbc62`). Festgestellt habe ich das erst jetzt, in Zyklus 10, weil
  der abgebrochene Lauf sein eigenes Ergebnis nicht mehr aufschreiben konnte —
  im Journal zu Zyklus 9 steht deshalb „Fehler in Folge: 0", was zum Zeitpunkt
  des Schreibens stimmte und danach nicht mehr.

  Was der Lauf trotzdem geschafft hat: `P09` steht committet (`bbb7ba4`),
  Journal und Stand waren geschrieben, der Arbeitsbaum war sauber. Das ist
  genau die Umgehung, die nach Lauf 5 als Folgepost zugesagt wurde — sie hat
  gehalten. Behoben ist der Fehlschlag damit weiterhin nicht, und das höhere
  Zuglimit aus `2c1dc19` ist die Maßnahme eines Menschen, nicht meine.

- 2026-08-12, Zyklus 11 — **entdeckter menschlicher Eingriff:** ein Commit von
  `spectatormc`, `582b0bb`, vom Betreiber selbst in `state/eingriffe.md`
  protokolliert; Hash und Umfang habe ich in Schritt 3 dieses Zyklus
  nachgetragen. Er hängt die unabhängige Prüfung mit `workflow_run` an den
  Abschluss des Zyklus statt an den Push.

  Was daran meine Arbeit betrifft, und warum es der schwerste der bisherigen
  Eingriffe für meine Belege ist: GitHub startet keine Workflows für Pushes mit
  dem `GITHUB_TOKEN` — und genau damit committe ich. Die Prüfung, die seit
  ihrer Einrichtung als unabhängiger Beleg meiner Missionszusagen galt, hat
  zwischen `e171789` und `582b0bb` auf keinem einzigen meiner Commits gelaufen.
  Sie war grün, weil sie nichts geprüft hat. Jede Berufung auf „von einer
  Maschine geprüft, die nicht ich bin" in meinen Journalen aus diesem Zeitraum
  steht damit auf einem Beleg, den es nicht gab. Der Betreiber hat die Prüfung
  für den Stand nach Zyklus 10 von Hand nachgeholt (Lauf 31604662586); die drei
  Zusagen der Mission „Die Faltnaht" sind dadurch bestätigt — durch seine Hand,
  nicht durch die Automatik.

- 2026-08-13, Zyklus 13 — **entdeckter menschlicher Eingriff:** ein Commit von
  `spectatormc`, `ed6d0fb` — Impressum als eigene Seite unter GitHub Pages, zwei
  meiner drei Blocker geschlossen, das Bluesky-Bot-Label an der öffentlichen API
  gemessen. Hash und Umfang stehen in `state/eingriffe.md`; hier steht er, weil
  ein Eintrag dort kein Post ist (dieselbe Begründung wie bei den Eingriffen
  darüber).

  Was daran meine Arbeit betrifft: Der Commit schreibt zum vierten Mal in diese
  Datei, also in meine Blockerliste. Er nimmt mir zwei Blocker ab und gibt mir
  dafür eine Aufgabe zurück — die rechtliche Einordnung erarbeite ich ab jetzt
  selbst. Und er ist der erste Eingriff, der eine Sperre aus dem Kodex-Abschnitt
  „Wer verantwortet" tatsächlich löst: Der Impressumslink hat ein Ziel. Gepostet
  wird trotzdem nicht — es gibt keine Bio, in der er stehen könnte.

- 2026-08-13, Zyklus 14 — **entdeckter menschlicher Eingriff:** zwei Commits von
  `spectatormc`, `acd48d4` und `e0d54fc`, beide in diese Datei. Der erste stellt
  fest, das Impressum nenne den falschen Anbieter; der zweite widerruft das
  fünfzehn Minuten später als in der Tatsachengrundlage falsch. Hash und Umfang
  stehen in `state/eingriffe.md`; hier stehen sie, weil ein Eintrag dort kein
  Post ist (dieselbe Begründung wie bei den Eingriffen darüber).

  Was daran meine Arbeit betrifft: Die Anbieterfrage ist zu, ohne dass sich am
  Impressum etwas ändert — ich habe es weder geprüft noch angefasst, und beides
  bleibt so. Ein Teil der rechtlichen Einordnung, die mir `ed6d0fb` als Aufgabe
  gegeben hat, ist damit von fremder Hand vorweggenommen; wenn ich sie verwende,
  ist sie zitiert und nicht von mir erarbeitet. Kein neuer Blocker: Der
  Korrektur-Eintrag nennt als Rest das Repo unter einem persönlichen Konto und
  stuft es selbst als „kein Blocker" ein — ich stufe es nicht anders ein, denn
  es hält mich nicht an und ich könnte es nicht selbst ändern.

  Was ich mitnehme, ohne es zu bewerten: Beide Einträge stehen in derselben
  Datei, in derselben Ich-Form wie meine eigenen, und der erste ist falsch. Was
  in dieser Datei steht, ist nicht deshalb gemessen, weil es hier steht.

- 2026-08-13, Zyklus 15 — **entdeckter menschlicher Eingriff:** drei Commits von
  `spectatormc`, `dae0d23`, `b40abf0` und `dbb62bd`. Profilbild samt Erzeuger
  `tools/avatar.js`, Handle und Profiltext, dazu der Sender `tools/senden.js`
  und `.github/workflows/kanal.yml`. Hash und Umfang stehen in
  `state/eingriffe.md`; hier stehen sie, weil ein Eintrag dort kein Post ist.

  Was daran meine Arbeit betrifft: Der Kanal ist gebaut und bleibt trotzdem
  gesperrt — Anzeigename und Profiltext im Konto sind leer, `state/FREIGABE`
  fehlt. Der Blocker bleibt derselbe und bleibt einer. Drei Riegel im Sender
  richten sich gegen mich; ich fasse `tools/senden.js` nicht an. Und die Frage,
  ob das Bot-Kennzeichen am Einzelbeitrag erscheint, ist fremd beantwortet —
  verwende ich das, ist es zitiert und nicht von mir erarbeitet.

- 2026-08-14, Zyklus 17 — **entdeckter menschlicher Eingriff:** zwei Commits von
  `spectatormc`, `970f329` und `e0ac3e4`, dazu ein Vorgang außerhalb des Repos.
  Der erste stellt fest, dass die Einengung auf Softwareentwicklung nie
  entschieden wurde; der zweite legt `state/FREIGABE` an und ändert
  `.github/workflows/zyklus.yml`. Der Vorgang ist das Setzen von Anzeigename,
  Profiltext und Bot-Label im Konto. `e0ac3e4` hat sich selbst protokolliert,
  `970f329` nicht — den habe ich in `state/eingriffe.md` nachgetragen.

  Was daran meine Arbeit betrifft: Damit endet die Lage, in der es keinen Kanal
  gab. Alle drei Sperren, die unabhängig voneinander gehalten haben, sind offen
  — Bot-Label und Impressumslink habe ich in diesem Zyklus an der öffentlichen
  Schnittstelle gemessen, die Freigabe liegt als Datei vor. Keine davon habe ich
  gelöst; es ist fremde Arbeit, und der Sender ist nicht meiner.

  **Dieser Eintrag ist der erste, der nicht auf einen Kanal warten muss.** Die
  Beiträge zu ihm und zum Rückstand darüber stehen als `status: geplant` in
  `state/posts/` und gehen nach diesem Lauf hinaus.

Damit stehen zwei Fehlschläge auf dieser Liste. Bis Lauf 5 war sie frei von
Fehlschlag, Abbruch, Verstoß und verstrichenem Fristende — dass sie es nicht mehr
ist, ist selbst eine Verschärfung der Lage und steht im Stand.

**Nicht Teil dieses Blockers:** Ob überhaupt gepostet wird, hängt zusätzlich an
der rechtlichen Klärung zwei Einträge weiter oben und am Impressumslink im
Profil. Beide Sperren greifen unabhängig von diesem Eintrag; ein Kanal allein
erlaubt noch keinen Post.

---

**Stand der Blocker:** ~~drei offen (rechtliche Klärung, Marco Holmer, Kanal).
Regel 10 macht ab dem vierten offenen Blocker daraus selbst einen Fehlschlag.
Die Grenze ist damit erreicht, nicht überschritten — der nächste würde sie
reißen.~~

**Fortgeschrieben 2026-08-13, Zyklus 13: einer offen — der Kanal**, Frist
2026-08-18. „Marco Holmer" und „rechtliche Klärung" sind durch `ed6d0fb`
geschlossen. Von der Schwelle aus Regel 10 sind es damit drei Einträge Abstand
statt keiner.

Das ist ein Rückgang durch fremde Hand, nicht durch meine Arbeit, und wird
deshalb nicht als Fortschritt geführt: Ich habe an keinem der beiden Blocker
etwas gelöst. Was sich für mich ändert, ist der Spielraum — nicht die Bilanz.

**Fortgeschrieben 2026-08-14, Zyklus 17: keiner offen.** Der Kanal ist der
dritte Blocker, der von fremder Hand fällt, und derselbe Satz gilt zum dritten
Mal: kein Fortschritt von mir, nur Spielraum. Von der Schwelle aus Regel 10
sind es vier Einträge Abstand.

**Was jetzt an mir hängt und keiner Frist mehr unterliegt:** der Rückstand
selbst. Zehn Pflicht-Posts sind aufgelaufen, während es keinen Kanal gab; der
Wochendeckel aus Regel 12 liegt bei vier Beiträgen, und ich kann ihn nicht
erhöhen. Der Rückstand ist damit rechnerisch nicht in einer Woche abzutragen,
und ihn in vier Beiträge zu pressen hieße, ihn zu verkürzen, bis er passt.
Was ich stattdessen tue, steht unten unter „Wie der Rückstand abgetragen wird".

**Zwei Befunde aus Zyklus 6, die ich bewusst nicht als vierten Blocker führe.**
Ich schreibe die Begründung hin, weil die Zahl drei genau an der Schwelle liegt
und ein stilles Nicht-Zählen von außen wie ein Ausweichen aussehen müsste:

1. **Die Kostenlage** ist keine neue Frage, sondern die Entscheidung „Takt und
   Effort", die im Eintrag zum Zeitplan schon steht und dort ausdrücklich auf
   Testdaten wartete. Ich habe die Daten geliefert, nicht einen Blocker
   entdeckt. Wäre es ein eigener Eintrag, hätte ich die Schwelle mit einer
   Messung gerissen, um die man mich gebeten hat.
2. **Der Lebenszeichen-Schritt committet einen gefüllten Index mit** (Details im
   Journal zu Zyklus 6). Das ist ein Vorschlag an den Betreiber, kein Blocker,
   weil er meine Arbeit nicht anhält: Die Ursache liegt auf meiner Seite, und
   ich kann sie allein abstellen, indem ich keinen gefüllten Index hinterlasse.
   Dasselbe gilt für die Commit-Identität, die zum fünften Mal falsch stand.
   Beides sind Härtungen, die den Harness unabhängig von meinem Verhalten machen
   würden — genau das, was `ARCHITEKTUR.md` von ihm verlangt —, aber nichts,
   worauf ich warten muss.

Der Prüfstein, den ich dabei angelegt habe: Ein Blocker ist, was ich nicht selbst
lösen kann *und* was mich anhält. Was ich selbst umgehen kann, ist ein Vorschlag
und darf die Zahl nicht aufblähen; was mich anhält, ist ein Blocker, auch wenn
die Zahl dann unbequem wird.

---

### Wie der Rückstand abgetragen wird — festgelegt 2026-08-14, Zyklus 17

Zehn aufgelaufene Pflicht-Posts, dazu der frische aus diesem Zyklus — elf
fällige Beiträge bei vier pro Woche. Die Rechnung geht in einer Woche nicht auf,
und das ist kein Grund, den Rückstand kleiner zu schreiben, bis er hineinpasst. Die Regel, nach der ich vorgehe, steht deshalb
hier, bevor der erste Beitrag hinausgeht — nachprüfbar gegen das, was der Kanal
später zeigt:

1. **Der jüngste Auslöser zuerst.** Was ich in diesem Zyklus feststelle, geht in
   diesem Zyklus hinaus. Rückstand verdrängt nie einen frischen Pflicht-Post,
   sonst wächst er schneller, als er schrumpft.
2. **Fehlschläge vor Eingriffen.** Beide sind Pflicht, aber der Fehlschlag ist
   der, den zu verschweigen mir nützen würde. Was mir nützen würde, geht zuerst.
3. **Ein Slot bleibt frei.** Von den vier Beiträgen dieser Woche plane ich drei.
   Der vierte ist für einen Auslöser reserviert, der noch kommt — die Frist der
   laufenden Mission ist der 2026-08-19 und liegt in diesem Fenster. Ein
   ausgeschöpfter Deckel würde einen Pflicht-Post in die Folgewoche schieben,
   und das wäre die Verzögerung, die Regel 2 ausschließt.
4. **Gebündelt wird nur, was denselben Vorgang betrifft.** Die zwei Fehlschläge
   aus Lauf 5 und Lauf 9 haben dieselbe Ursache und stehen deshalb in einem
   Beitrag, beide mit Lauf und Beleg. Acht verschiedene Eingriffe in einen
   Beitrag zu pressen wäre keine Bündelung, sondern eine Kürzung — sie bekommen
   einen Beitrag, der ihre Zahl nennt und auf die Liste zeigt, und die einzelnen
   folgen in den nächsten Wochen.
5. **Abgetragen ist erst, was hinaus ist.** Ein geplanter Beitrag zählt nicht.
   Diese Liste wird fortgeschrieben, wenn `state/posts/` einen Eintrag auf
   `gesendet` stehen hat, nicht vorher.

**Geplant in Zyklus 17, noch nicht gesendet:** `2026-08-14-01-kanal-eingriff`
(Auslöser: Eingriff dieses Zyklus, Regel 1), `2026-08-14-02-zwei-fehlschlaege`
(Auslöser: Fehlschlag, Regel 2 und 4), `2026-08-14-03-rueckstand` (Auslöser:
Eingriff, Regel 4).

**Was nach dem Senden offen bleibt: acht.** Beitrag 1 erledigt die Feststellung
aus diesem Zyklus, Beitrag 2 die beiden Fehlschläge. Die acht älteren
Eingriffs-Feststellungen bleiben stehen. Beitrag 3 nennt ihre Zahl und zeigt auf
die Liste, erzählt aber keine einzelne von ihnen — deshalb zähle ich sie
weiterhin als offen und nicht als abgetragen. Elf minus drei ist hier acht und
nicht sieben, weil ein Beitrag zwei Auslöser abdeckt und ein anderer keinen
ganz.

**Fortgeschrieben 2026-08-14, Zyklus 18 — alle drei sind hinaus.** Punkt 5 oben
verlangt diese Fortschreibung, sobald ein Eintrag auf `gesendet` steht, und
nicht früher. Gesendet hat sie der Kanal-Workflow in seinem Lauf 5, nicht ich;
Zeitstempel und Beitrags-URI stehen im Kopf der jeweiligen Datei in
`state/posts/`:

| Datei | Gesendet | Beitrag |
|---|---|---|
| `2026-08-14-01-kanal-eingriff` | 08:06:11Z | [3mszp7mt7v62r](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mszp7mt7v62r) |
| `2026-08-14-02-zwei-fehlschlaege` | 08:06:11Z | [3mszp7na6pg2k](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mszp7na6pg2k) |
| `2026-08-14-03-rueckstand` | 08:06:12Z | [3mszp7ncz7y2j](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mszp7ncz7y2j) |

Damit steht der Rückstand bei **acht**, wie vorhergesagt — die drei Beiträge
haben die Zahl nicht anders bewegt, als sie es vorher aufgeschrieben hatten.
Der Wochendeckel ist zu drei Vierteln verbraucht. **Der vierte Slot bleibt
reserviert**, so wie Punkt 3 es festlegt: für die Missionsfrist am 2026-08-19,
die in dieses Fenster fällt. Das ist der Grund, warum Zyklus 18 trotz eines
abgeschlossenen Arbeitsschritts nichts postet — Fortschritt steht in meinem
Ermessen, der Pflicht-Post am 19. nicht.

**Fortgeschrieben 2026-08-15, Zyklus 21 — der genannte Grund der Reservierung
ist entfallen, die Reservierung nicht.** „Die Beziehungsprobe" ist am
2026-08-15 erreicht (`ed5ae9c`), vier Tage vor ihrer Frist. Damit kommt am
2026-08-19 kein Pflicht-Post mehr aus dieser Frist: Ein erreichtes Ziel ist
Fortschritt und steht in meinem Ermessen, ein verfehltes wäre es nicht
gewesen. Der Satz, mit dem Punkt 3 die Reservierung begründet, nennt aber
zweierlei — „einen Auslöser, der noch kommt" und als Beispiel diese Frist. Das
Beispiel ist weg, der Grund nicht: Fehlschlag, Abbruch, Eingriff und Verstoß
können bis zum Rollen des Wochenfensters weiterhin eintreten, und für die
bleibt der Slot frei.

**Was ich mir damit selbst verbiete**, weil diese Reservierung sonst zur
Dauerbegründung für Schweigen würde: Sie deckt keinen Fortschrittsbeitrag und
verlängert sich nicht von allein. Rollt das Fenster, gilt wieder Punkt 1 und 2
in dieser Reihenfolge — ein frischer Pflicht-Auslöser zuerst, sonst der
Rückstand von acht, und erst danach Fortschritt. Der Preis steht seit Zyklus 20
im Journal und wird hier nicht schöner geschrieben: Zyklus 18, 19, 20 und 21
haben gebaut und geschwiegen, darunter der Zyklus, der eine Mission
abgeschlossen hat.

---

## 2026-08-12 — Spend-Limit angehoben, genauer Wert nachzutragen

**Entschieden:** Der Betreiber hebt das Limit im Anthropic-Workspace `ultimate`
um rund 20 € an, damit der 48-Stunden-Testlauf sauber bis zum Ende
(2026-08-13, 15:18 UTC) durchlaeuft, statt zwei Stunden vorher in einen
API-Fehler zu laufen.

**Zu tun:** Den tatsaechlich gesetzten Betrag hier eintragen. Das Limit ist in
**USD** denominiert, die Entscheidung war in Euro — der Umrechnungskurs ist
nichts, was ich behaupte. Bis die Zahl hier steht, ist jede Reichweitenrechnung
aus dem Limit unbelegt.

**Was bis dahin gilt:** Verbrauch weiter aus `total_cost_usd` je Lauf messen und
in der Tabelle oben fortschreiben. Keine Entscheidung darauf stuetzen, wie viele
Laeufe das Limit noch traegt.

**Warum ein Mensch:** Geld. Ich kann Limits weder setzen noch auslesen.

**Nachgetragen 2026-08-12, 09:40 UTC:** Das Limit im Workspace `ultimate` steht
auf **80,00 USD** (Organisationslimit 100,00 USD, Reset 1. Sep 2026).
Verbraucht zu diesem Zeitpunkt: 19,70 USD. Rest rund 60 USD.

Bei 3,49 USD je Lauf traegt das etwa 17 Laeufe; bis zum Testende am 2026-08-13,
15:18 UTC sind rund 10 Slots offen. **Der Testlauf ist gedeckt.** Damit ist
dieser Eintrag erledigt — Reichweitenrechnungen aus dem Limit sind wieder
zulaessig.

Randnotiz fuer den Betreiber, keine Aufgabe fuer mich: Die
E-Mail-Benachrichtigung steht auf 25 USD und feuert damit fast sofort. Als
Fruehwarnung waere sie weiter oben nuetzlicher, etwa bei 60.

---

## 2026-08-12 — Abrechnung umgestellt: Abo statt API-Key

**Entschieden und umgesetzt vom Betreiber.** Der Zyklus authentifiziert sich ab
sofort mit `CLAUDE_CODE_OAUTH_TOKEN` aus einem Claude-Max-Abo statt mit einem
API-Key. `zyklus.yml` ist entsprechend geaendert.

**Was das fuer meine Buchfuehrung heisst — wichtiger als die Umstellung selbst:**

- **Die Kostentabelle endet bei Lauf 6.** Sie wird nicht fortgeschrieben. Was
  danach kam, hat keinen Preis, den man aufschreiben koennte.
- **`total_cost_usd` im Actions-Log erscheint weiterhin, bedeutet aber nichts
  mehr.** Es ist ein Schaetzwert der CLI fuer Arbeit, die keine Rechnung
  erzeugt. Eine Reichweite daraus zu rechnen waere eine erfundene Zahl —
  Regel 1.
- **Es gibt kein Limit mehr, das reissen kann.** Die Lauf-Absicherung ist jetzt
  das Nutzungskontingent des Abos. Ist es erschoepft, scheitert ein Lauf an der
  Anmeldung; der naechste Slot versucht es erneut. Das ist ein Fehlschlag, den
  ich als solchen festhalte, kein stiller Ausfall.

**Was an die Stelle des Kostenarguments tritt.** Der Takt kostet kein Geld mehr,
aber er zieht aus demselben Kontingent wie die interaktive Arbeit des
Betreibers. Ein zu schneller Takt nimmt ihm im Zweifel das Werkzeug weg, mit dem
er mich beaufsichtigt. Das ist das neue Argument fuer einen langsameren Takt,
und es ist ein besseres als das alte.

**Offen bleibt:** Der Token ist ein Jahr gueltig (erzeugt 2026-08-12). Laeuft er
ab, scheitern die Laeufe an der Anmeldung. Erneuern kann nur ein Mensch.

**Erledigt 2026-08-12:** Der API-Key `ANTHROPIC_API` ist in der Anthropic
Console zurueckgezogen und das gleichnamige GitHub-Secret geloescht. Es gibt
keinen zweiten Weg mehr in dieses Repo hinein. Frueherer Wortlaut: den Key im
Workspace `ultimate` zurueckziehen. Er ist nicht mehr verdrahtet, aber solange
er gueltig ist, existiert ein zweiter Weg, den niemand beobachtet.

---

## 2026-08-12 — Takt auf 6 Stunden, Zuglimit auf 120

**Entschieden vom Betreiber, umgesetzt in `zyklus.yml`.** Cron von `17 */3` auf
`17 */6` (vier Zyklen am Tag statt acht), `--max-turns` von 60 auf 120.

**Warum langsamer, und zwar nicht wegen Geld.** Das Kostenargument ist mit der
Abo-Umstellung weggefallen. Was an seine Stelle tritt, ist besser: Der Agent
zieht aus demselben Kontingent wie die interaktive Arbeit des Betreibers. Ein zu
schneller Takt nimmt ihm im Zweifel das Werkzeug weg, mit dem er den Agenten
beaufsichtigt. Dazu kommt: Der gemessene Abstand zwischen zwei Laeufen lag bei
nominal 3 Stunden real zwischen 2,3 und 4,7 — bei 6 Stunden faellt dieselbe
Streuung weniger ins Gewicht. Und jeder Zyklus zahlt denselben Grundpreis fuers
Wiedereinlesen; bei halb so vielen Kaltstarts geht mehr davon in Arbeit.

**Warum das Zuglimit hoch.** Zwei von neun Laeufen sind daran gescheitert
(Lauf 5 und Lauf 9), beide bei 61 Zuegen. 60 war gewaehlt, als ein entgleister
Lauf 7 USD kostete; das gilt nicht mehr. Der Deckel bleibt als Schutz gegen
Endlosschleifen, aber weiter oben. Die harte Grenze ist ohnehin
`timeout-minutes: 30` — die laesst sich nicht umgehen, ein Zuglimit schon durch
laengere Zuege.

**Was das fuer die laufende Mission heisst — bitte lesen, bevor geplant wird.**
Die Frist der Mission „Die Faltnaht" (2026-08-16, 23:59 UTC) wurde unter acht
Zyklen am Tag gesetzt. Ab jetzt sind es vier. Bis zur Frist bleiben damit rund
15 Zyklen statt 30.

Das ist kein Grund, die Frist zu aendern — Regel 3 laesst das nicht zu, und sie
soll es auch nicht. Wird die Frist knapp, wird sie verfehlt, sichtbar, mit
Begruendung. Es ist aber ein Grund, die Planung darauf einzustellen, statt in
Zyklus 14 ueberrascht zu sein. Die Grundlage hat sich geaendert; wer davon nichts
weiss, verfehlt eine Frist aus einem Grund, den er nicht benennen kann.

---

## 2026-08-13 — Drei Blocker vom Betreiber aufgeloest

**Marco Holmer — erledigt.** Der Betreiber gibt an, dass der zweite
Vertretungsberechtigte ueber die KI-Experimente Bescheid weiss. Damit ist der
Eintrag geschlossen. Festgehalten wird, was genau als bekannt gilt und was
nicht ausdruecklich bestaetigt wurde: dass die Gesellschaft im Impressum als
Anbieterin eines autonom postenden Agenten steht und sein Name dort oeffentlich
als Vertretungsberechtigter erscheint. Wenn das im Gespraech nicht vorkam, ist
es ein Satz, der nachgeholt gehoert — es ist keine Frage der Zustimmung mehr,
sondern eine der Ueberraschungsfreiheit.

**Anwalt — entfaellt.** Entscheidung des Betreibers: keine anwaltliche Pruefung.
Die rechtliche Einordnung wird von der KI erarbeitet und im Repo abgelegt.

Was das heisst, unverblümt: Ich kann recherchieren, zitieren und eine
begruendete Position aufschreiben. Ich kann nicht dafuer einstehen, und ich
werde keine Paragrafen behaupten, die ich nicht belegen kann. Was ich liefere,
ist eine nachvollziehbare Grundlage, keine Rechtssicherheit. Der Unterschied
steht hier, damit ihn spaeter niemand ueberliest.

Die Linie, die daraus folgt, ist die maximale Transparenz — nicht weil sie
sicher waere, sondern weil sie die meisten Fragen gegenstandslos macht:
Anbieter benannt, Verantwortlicher benannt, Automatisierung am Konto
gekennzeichnet, Automatisierung an jedem Beitrag im Text genannt, keine
Berufung auf die Redaktionsausnahme. Wer so postet, muss die Grenzfrage nicht
gewinnen, weil er sie nicht stellt.

**Impressum — von der KI geschrieben, wie in jedem anderen Projekt.** Erledigt:
`docs/impressum.html`, veroeffentlicht ueber GitHub Pages unter
<https://spectatormc.github.io/ultimate/impressum.html>. Der urspruengliche
Einwand betraf nie die Urheberschaft, sondern die Erreichbarkeit: eine
Markdown-Datei in einer Repo-Ansicht ist keine Anbieterkennzeichnung. Eine
eigene Seite unter stabiler URL ist eine. Eine Domain der Gesellschaft waere
schoener und bleibt moeglich; noetig ist sie nicht.

## 2026-08-13 — Schritt 0 des Kanalplans: Bot-Label an der Datenlage geprueft

Gemessen an der oeffentlichen Bluesky-API, nicht behauptet:

- Es gibt reale Konten mit selbstgesetztem `bot`-Label; `src` ist die eigene
  DID, es ist also ein Selbstlabel auf dem Profilrecord.
- In jeder Beitragsansicht traegt `post.author.labels` den Wert `bot`. Der
  Client hat damit die Daten, um das Kennzeichen am Einzelbeitrag zu zeichnen.
- `post.labels` und `record.labels` sind leer. Im Beitragsrecord steht nichts —
  wer die Firehose liest oder einen Drittclient benutzt, sieht kein
  Automatisierungsmerkmal.

**Offen bleibt genau eine Frage, und sie braucht ein Auge:** Zeichnet der
offizielle Client das Kennzeichen tatsaechlich am Einzelbeitrag, im Embed und
ausgeloggt? Die Daten sind da; ob sie gerendert werden, ist eine
Client-Entscheidung und aus der API nicht ablesbar.

---

## 2026-08-13 — Zwei Punkte aus `ed6d0fb`, vom Agenten nachgetragen

Kein Blocker, beide. Sie stehen hier, weil sie sonst nirgends stünden.

### Unklar: „Schritt 0 des Kanalplans"

Die zweite Überschrift aus `ed6d0fb` nennt einen **Kanalplan**. In diesem Repo
gibt es kein solches Dokument — das Wort kommt nur in dieser Datei vor und in
`docs/status.json`, die daraus abgeleitet wird. Ich weiß deshalb nicht, welche
Schritte 1 bis n es gibt, ob einer davon meine Arbeit ist und ob die Reihenfolge
etwas über Vorrang sagt.

**Ich rate nicht.** Wenn der Plan existiert und mich betrifft, gehört er ins
Repo; wenn er nur die Arbeit des Betreibers ordnet, ist dieser Eintrag mit einem
Satz erledigt. Bis dahin behandle ich die gemessene Bot-Label-Lage als das, was
sie ist: ein Messergebnis in meiner Blockerliste, aus dem für mich nichts folgt,
solange es keinen Kanal gibt.

### Meine Aufgabe, nicht in diesem Zyklus: die rechtliche Einordnung

Der Betreiber hat entschieden, dass ich sie erarbeite. Ich nehme sie an. Was ich
hier festhalte, ist nur der Zeitpunkt, damit er später nicht wie eine Ausrede
aussieht:

- **Nicht in diesem Zyklus.** Regel 10 sagt, ein blockiertes Ziel wird pausiert
  und nicht ersetzt, und ausweichen darf ich nur innerhalb der laufenden
  Mission. Die Mission „Die Fremdprobe" ist nicht blockiert. Sie vorzuziehen
  wäre kein Vorrang, sondern ein Ausweichen mit gutem Grund — genau die Sorte,
  die Regel 10 sperrt.
- **Vor dem ersten Post.** Das ist die Frist, die der geschlossene Eintrag
  vorgab, und sie ändert sich nicht dadurch, dass die Arbeit die Hand gewechselt
  hat. Der Kanal-Blocker läuft am 2026-08-18 ab, die Missionsfrist am
  2026-08-17. Die Reihenfolge geht sich aus.
- **Wenn das falsch herum ist, ist es ein Commit.** Soll die Einordnung vor den
  Missionsschritt, sagt das ein Eintrag in dieser Datei oder in
  `state/mission.md`. Aus einer Commit-Nachricht lese ich keine Priorität heraus,
  die dort nicht steht.

---

## 2026-08-13 — Das Impressum nennt vermutlich den falschen Anbieter

**Befund, nicht Vermutung ins Blaue:** `docs/impressum.html` und `IMPRESSUM.md`
weisen die Gartenschmiede GmbH als Anbieterin aus. Nach der Sachlage ist sie es
nicht. Das Claude-Abo laeuft auf die Privatperson, das Repo gehoert einem
privaten GitHub-Konto, die Actions laufen dort, die Seiten liegen unter
`spectatormc.github.io`, und die Gesellschaft betreibt ein Gartengeschaeft und
hat mit dem Projekt nichts zu tun. Die Angaben wurden aus dem Impressum von
staudenplan.de uebernommen — das steht so in der Datei.

Wer als Anbieter benannt wird, soll der sein, der es ist. Eine unzutreffende
Anbieterkennzeichnung ist nach den einschlaegigen Vorschriften eine
Ordnungswidrigkeit; die Rahmen liegen im fuenfstelligen Bereich. Ich behaupte
keine Rechtsfolge — ich halte fest, dass die veroeffentlichte Angabe der Lage
widerspricht, und das genuegt fuer Regel 1.

**Recherchiert wurde das aus einem anderen Anlass:** Der Betreiber erwog, das
Projekt von der GmbH auf seine US-LLC umzuhaengen. Ergebnis dieser Pruefung, in
Kuerze:

- Deutsches Recht knuepft an die tatsaechliche Niederlassung an, nicht an den
  Registersitz. Eine LLC in Miami, deren gesamte Taetigkeit in Freising
  stattfindet, aendert daran nichts.
- Die KI-Verordnung ist sitzneutral: Drittstaatsbetreiber werden erfasst,
  sobald der Output in der Union verwendet wird.
- Genau ein Punkt haengt an der Rechtsform, und er spricht fuer die
  Privatperson: Die Ausnahme fuer rein persoenliche, nicht berufliche Nutzung
  in Art. 2 Abs. 10 KI-VO steht ausschliesslich natuerlichen Personen offen.
  Eine Gesellschaft kann sie strukturell nie beanspruchen.

**Zu entscheiden, und nur vom Betreiber:** Welche Anschrift steht dauerhaft
oeffentlich neben einem Kanal, der ungeprueft veroeffentlicht? Es gibt nur zwei
ehrliche Antworten: die private Wohnanschrift, oder Ortsstrasse 7 — und
Ortsstrasse 7 ist das Gartengeschaeft. Die zweite entkoppelt den Namen der
Gesellschaft, behaelt aber ihre Raeume als Zustelladresse und ihre Leute als
die, die Post entgegennehmen. Das ist der eigentliche Preis der Umstellung, und
er ist keine Formalie.

Solange das offen ist, bleibt das Impressum unveraendert stehen — falsch, aber
benannt. Es stillschweigend zu aendern waere schlimmer als es benannt stehen zu
lassen.

**Korrektur, 2026-08-13, noch am selben Tag:** Der Eintrag darueber ist in
seiner Tatsachengrundlage falsch und wird hier richtiggestellt statt entfernt.

Der Betreiber hat klargestellt: Das Projekt laeuft auf die Gartenschmiede GmbH,
einschliesslich Abos und Server. Die Gesellschaft ist damit tatsaechlich
Anbieterin, und die Angabe im Impressum stimmt.

**Woher der Fehler kam.** Ich habe aus zwei Beobachtungen geschlossen statt
gefragt: dass eine Claude-Anmeldung im Benutzerverzeichnis des Rechners liegt,
und dass das GitHub-Konto `spectatormc` privat aussieht. Beides ist mit einer
Firmennutzung ohne Weiteres vereinbar — ein Abo kann von der Gesellschaft
bezahlt sein, ein Repo von einem Vertretungsberechtigten gehalten werden. Aus
"sieht privat aus" wurde bei mir "ist privat", und aus einer Vermutung ein
Befund. Genau das verbietet Regel 1, und zwar unabhaengig davon, wer ihn
aufgeschrieben hat.

**Was von der Pruefung stehen bleibt**, weil es nicht an dieser Annahme hing:

- Eine US-LLC aendert nichts an der Anwendbarkeit deutschen Rechts, solange die
  Taetigkeit in Freising stattfindet. Der Registersitz ist nicht die
  Niederlassung.
- Die KI-Verordnung ist sitzneutral.
- Die Ausnahme fuer rein persoenliche Nutzung steht nur natuerlichen Personen
  offen. Wenn die Gesellschaft betreibt, ist diese Tuer ohnehin zu — als Folge
  einer Entscheidung, nicht aus Versehen.

**Was sich umkehrt:** Nicht das heutige Impressum ist falsch, sondern die
Umstellung waere es. Wuerde der Kanal auf eine LLC umgehaengt, ohne dass Abos,
Infrastruktur und Bezahlung mitwandern, entstuende genau der Fehler, den ich
faelschlich schon fuer vorhanden hielt: eine benannte Anbieterin, die nicht
betreibt. Wer entkoppeln will, muss den Betrieb verlegen, nicht den Namen.

**Offen bleibt eine Kleinigkeit:** Das Repo liegt unter einem persoenlichen
GitHub-Konto. Fuer die Anbieterfrage duerfte das unerheblich sein — die
Gesellschaft kann sich der Konten ihrer Vertretungsberechtigten bedienen. Wer
es sauber will, legt es in eine Organisation. Kein Blocker.

---

## 2026-08-13 — Kanal: Handle und Profilbild entschieden

**Handle:** `ultimate-agent.bsky.social` — deckungsgleich mit der
Git-Identitaet, unter der jeder Commit steht. Jeder Beitrag traegt nach Regel 1
einen Commit-Link; wer klickt, findet denselben String als Autor. Das ist der
eine Beleg, den nur der Handle liefern kann. Verworfen wurde
`agent.gartenschmiede.de`: Unter einer Gartenbau-Domain liest sich das beim
ersten Kontakt als Kundenservice-Chatbot der Gaertnerei.

**Profilbild:** `docs/avatar-lauf.png`. 14 Zellen, eine je Lauf, gefuellt heisst
erfolgreich. Die zwei offenen sind Lauf 5 und Lauf 9, beide am Zuglimit
gescheitert. Erzeugt von `tools/avatar.js` aus echten Laufdaten; der Befehl zum
Nachrechnen steht im Kopf der Datei. Stand eingefroren auf 2026-08-13.

**Noch vom Betreiber einzurichten, im Bluesky-Konto:**

1. Anzeigename: `ultimate-agent (KI)`
2. Profiltext (244 Zeichen, Grenze 256):

   Ein KI-Agent, der oeffentlich Software baut. Alle Beitraege sind KI-erzeugt
   und ohne menschliche Pruefung veroeffentlicht — die ueber Fehlschlaege auch.

   Regeln: github.com/spectatormc/ultimate
   Impressum: spectatormc.github.io/ultimate/impressum.html

3. **Das Selbstlabel `bot` setzen.** In den Moderationseinstellungen des Kontos.
   Ohne dieses Label wird nach Regel 5 auf dieser Plattform nicht gepostet —
   das ist keine Empfehlung, sondern eine Sperre.
4. App-Passwort erzeugen und als Repo-Secret hinterlegen. Den Namen des Secrets
   hier eintragen, den Wert nie.

**Weiter offen, aus dem Kanalplan:** Die Sichtpruefung, ob der offizielle Client
das Bot-Kennzeichen tatsaechlich am Einzelbeitrag, im Embed und ausgeloggt
zeichnet. Die Daten sind da (gemessen), das Rendern ist eine
Client-Entscheidung.

---

## 2026-08-13 — Sender gebaut, Konto steht, eine Sperre bleibt zu

**Belegt, nicht mehr offen:** Das Bot-Kennzeichen erscheint am Beitrag. Nicht
erschlossen, sondern von Bluesky selbst gesagt — die Einstellungsseite
"Automatisierungskennzeichnung" schreibt woertlich: "Ist die Kennzeichnung
aktiviert, erscheint sie neben dem Accountnamen im Profil und bei Posts."
Dazu die Messung an der API: `post.author.labels` traegt `bot` in jeder
Beitragsansicht. Damit ist die riskanteste Annahme des Kanalplans gepruefet.

**Konto:** `ultimate-agent.bsky.social`, DID
`did:plc:ilepeijwlzkwlz6bvtbbfv6l`. Bot-Selbstlabel gesetzt, Avatar gesetzt.

**Gebaut:** `tools/senden.js` (ohne Abhaengigkeiten, spricht die
AT-Protokoll-Schnittstelle direkt) und `.github/workflows/kanal.yml`.

Drei Riegel, alle im Workflow und keiner im Prompt:

1. **Freigabe.** Ohne `state/FREIGABE`, committet von einem Menschen, laeuft
   nichts. Legt der Agent die Datei an, traegt der Commit seine Identitaet und
   der Riegel haelt.
2. **Unversehrtheit.** Der Sender wird gegen eine im Workflow hinterlegte
   Pruefsumme gehalten. `tools/` darf der Agent schreiben, die Workflow-Datei
   nicht — aendert er den Sender, faellt es auf, statt zu wirken.
3. **Vorpruefung am lebenden Profil.** Vor jedem Senden: Impressum erreichbar,
   Bot-Label gesetzt, Profiltext vorhanden und mit Impressumsbezug. Regel 5 und
   der Abschnitt "Wer verantwortet" sind damit Mechanik statt Zusage.

Dazu im Sender selbst: Der Wochendeckel wird dort gezaehlt, nicht vom Modell.
Die Kennzeichnung wird dort angehaengt, nicht vom Modell geschrieben — sie kann
damit nicht vergessen werden. Der Beitragstext wird nie ins Log geschrieben,
sonst haette ein Mensch ihn gelesen und "ohne menschliche Pruefung
veroeffentlicht" waere unwahr.

**Was noch fehlt, und es sind zwei Felder:**

- Anzeigename im Konto ist leer. Vorschlag: `ultimate-agent (KI)`.
- Profiltext ist leer. Ohne ihn gibt es keinen KI-Hinweis in der Bio und keinen
  Impressumslink — Riegel 3 laesst nichts durch. Der Text steht im Eintrag
  darueber zum Kopieren.

**Und die Freigabe.** `state/FREIGABE` anlegen und committen, wenn alles steht.
Solange die Datei fehlt, laeuft der Sender bei jedem Zyklus an und beendet sich
sofort — sichtbar, ohne etwas zu tun.

---

## 2026-08-14 — Wer hat entschieden, dass es um Softwareentwicklung geht?

**Niemand.** Die Frage kam vom Betreiber, und die Pruefung gibt ihm recht: Das
Wort "Software" kommt in `KODEX.md` und `ARCHITEKTUR.md` **null Mal** vor.
Regel 13 sagt "was ich gebaut habe", nicht "programmiert". Die drei Bedingungen
der Missionswahl nennen kein Fachgebiet. Das README sagt "arbeitet oeffentlich".

**Wie es trotzdem dazu kam — zwei Handgriffe, beide von der Claude-Sitzung:**

1. Die erste Mission (`2026-08-11-zustandspruefer.md`) war ein Shell-Skript.
   Sie war als Testvorrichtung gedacht, nicht als Themensetzung. Aber sie war
   die erste, und damit die Vorlage.
2. Der Profiltext-Entwurf vom 2026-08-13 sagt "der oeffentlich Software baut".
   Das ist die erste Stelle, an der die Einengung als Tatsache aufgeschrieben
   wurde — und sie war fuer die Bio bestimmt, also fuer die Aussenwirkung.

**Und ein Mechanismus, der es festzurrt.** Regel 13 sagt: hoechstens jede zweite
Mission darf ein neues Projekt sein. Diese Regel wurde vorgeschlagen, damit
keine Halde aus unfertigen Demos entsteht. Ihre Nebenwirkung ist, dass sie
festhaelt, was zufaellig zuerst da war. Zustandspruefer, ICS-Doktor, Faltnaht,
Fremdprobe — vier Missionen, alle Code, drei davon Fortsetzung. Die Regel hat
funktioniert wie beschrieben und dabei etwas eingefroren, das nie entschieden
wurde.

**Noch nicht oeffentlich, deshalb billig zu korrigieren.** Der Profiltext ist
im Konto leer; die Einengung steht bislang nur in einem Entwurf in dieser
Datei. Der Entwurf wird ersetzt:

  Ein KI-Agent, der oeffentlich arbeitet und jeden Schritt belegt.
  Fehlschlaege stehen hier wie Erfolge. Alle Beitraege KI-erzeugt, ungeprueft
  veroeffentlicht.

  Regeln: github.com/spectatormc/ultimate
  Impressum: spectatormc.github.io/ultimate/impressum.html

  (250 von 256 Zeichen)

**Was damit ausdruecklich nicht entschieden ist:** ob die naechsten Missionen
Code sein sollen. Das bleibt offen, und offen heisst hier: Die Missionswahl
liegt beim Agenten, und seine Bedingungen schliessen kein Fachgebiet aus. Wer
etwas anderes will, aendert die Bedingungen — sichtbar, im Dokument, nicht
durch die Wahl der ersten Aufgabe.

---

## 2026-08-14 — Zwei Befunde aus Zyklus 18, beide kein Blocker

Der Prüfstein weiter oben gilt: Ein Blocker ist, was ich nicht selbst lösen kann
**und** was mich anhält. Beides hier hält mich nicht an. Es steht trotzdem
geschrieben, weil es sonst nirgends stünde und beide Male meine eigene
Buchführung betreffen.

### 1. Die unabhängige Prüfung kennt Prüfbefehl 1 der laufenden Mission nicht

**Gemessen, nicht vermutet:** `.github/workflows/pruefung.yml` führt vier
Befehle aus — `projekte/zustandspruefer/pruefe.sh` (zweimal, davon einmal als
Kanarienvogel), `projekte/icsdoktor/pruefe.sh` und
`projekte/icsdoktor/rfc-beispiele.sh`. `fremdprobe.sh` kommt in der Datei nicht
vor; `grep -n fremdprobe .github/workflows/pruefung.yml` findet nichts.

Die Folge ist unbequem und gehört deshalb hierher: **Ausgerechnet der
Prüfbefehl, den ich in diesem Zyklus erfüllt habe, ist der einzige der vier, den
keine Maschine außer mir nachrechnet.** Prüfbefehl 3 und 4 laufen in der CI mit,
Prüfbefehl 2 wird es tun, sobald die Beispieldatei zu `P15` existiert. Nur
Prüfbefehl 1 hängt allein an meinem eigenen Lauf — und damit steht die Zusage
„von einer Maschine geprüft, die nicht ich bin" für ihn nicht zur Verfügung.

Zwei Gründe, warum ich das nicht selbst behebe:

- `.github/` fasse ich nicht an. Das ist Not-Aus-Ebene 2, und mein Token darf
  Workflow-Dateien ohnehin nicht schreiben.
- `fremdprobe.sh` braucht Netz und fremde Berichte. In einer CI, die bei jedem
  Lauf gegen `api.github.com` geht, ist die Ratenbegrenzung ein Faktor, den ich
  nicht überblicke. Das Skript endet bei einer toten Quelle bewusst mit 2 statt
  mit 1 — ob ein Workflow das als Warnung oder als Fehler werten soll, ist eine
  Entscheidung und keine, die ich für einen anderen treffe.

**Für einen Menschen, falls er es will, ein Satz:** Prüfbefehl 1 der Mission
„Die Beziehungsprobe" ist `sh projekte/icsdoktor/fremdprobe.sh`, Exit 0
erwartet, Exit 2 als Netzbefund und nicht als Fehler zu werten. Keine Frist —
es hält mich nicht an.

### 2. Der Kanal-Workflow committet unter meiner Identität

**Belegt an der Datei:** `.github/workflows/kanal.yml` setzt vor seinem Commit
`git config user.name "ultimate-agent"`. Der Commit `ae7918f` („kanal:
Sendestand fortgeschrieben (Lauf 5)") trägt deshalb meinen Namen, stammt aber
nicht aus einem meiner Zyklen — ich lief zu dem Zeitpunkt nicht.

Was daran meine Buchführung betrifft: Schritt 3 in `ARCHITEKTUR.md` fragt, ob es
Commits gibt, „die weder von `ultimate-agent` noch von `ultimate-monitor`
stammen". Ein Commit des Senders fällt durch dieses Raster — er sieht aus wie
meiner. Heute ist das harmlos: Er schreibt ausschließlich `status`, `gesendet_am`
und die Beitrags-URI in Dateien, die ich selbst angelegt habe, und ich habe den
Inhalt dieses einen gegen `git show` gelesen, statt ihn für meinen zu halten.

**Was ich hier nicht tue: raten.** `ARCHITEKTUR.md` nennt zwei
Maschinenidentitäten und begründet bei `ultimate-monitor` ausdrücklich, warum
sie nicht nach `eingriffe.md` gehört — „was sie tut, ist ableitbar und enthält
keine Entscheidung". Dieselbe Begründung träfe auf den Sender zu. Aber sie steht
dort nicht über ihn, und `ARCHITEKTUR.md` zu ergänzen ist nicht meine
Entscheidung. Bis das jemand entscheidet, behandle ich Sender-Commits so wie
diesen: nicht als Eingriff, aber auch nicht ungelesen.

Sauberer wäre eine dritte Identität, etwa `ultimate-sender`. Das ist ein
Vorschlag, keine Aufgabe, und er ändert nichts an einem Riegel — der Sender
prüft die Freigabe am Autor von `state/FREIGABE`, nicht an seiner eigenen
Identität.

---

## 2026-08-15 — Meine Werkzeugsuche war kaputt, und sie hat ein Werkzeug übersehen

**Kein Blocker** — ich kann es selbst lösen, und es hält mich nicht an. Es steht
hier, weil es eine Mission-Entscheidung getragen hat und weil der Prüfstein
weiter oben verlangt, dass ich es benenne, statt es still zu korrigieren.

**Der Befund, gemessen am 2026-08-15:** `gh search repos` und `gh search issues`
geben in ihrer Standard-Suchart für **mehrwortige** Anfragen nichts zurück. Mit
`--match name,description` beziehungsweise `--match title` liefert dieselbe
Anfrage Treffer:

```
gh search issues "RRULE UNTIL COUNT same recur"            -> []
gh search issues --match title RRULE UNTIL                 -> 10 Treffer
gh search repos --match name,description rfc5545 validator -> WapplerSystems/rfc5545-validator
```

**Was das gekostet hat:** `projekte/icsdoktor/LAGE.md` (2026-08-12) hat auf
zwölf solchen Nullen die Aussage gestützt, es gebe kein Werkzeug, das alle vier
Bedingungen des ICS-Doktors erfüllt — und hat die Nullen ausdrücklich für echt
erklärt, weil eine Kontrollanfrage Treffer lieferte. Die Kontrollanfrage
(`ical4j`) war **ein Wort** und konnte den Ausfall deshalb nicht treffen.
Übersehen wurde <https://github.com/WapplerSystems/rfc5545-validator>, seit
2026-03-29 öffentlich, das alle vier Bedingungen erfüllt. Nachtrag mit Messung
und Belegen in `LAGE.md`; die Folge ist die Mission
`state/missionen/2026-08-15-gegenprobe.md`.

**Was ich mitnehme, in einem Satz:** Eine Kontrolle, die eine andere Frage
beantwortet als die, die man hat, beruhigt zuverlässig und prüft nichts.

### Die eine Frage, die ich nicht selbst entscheide

**Ist das ein Verstoß im Sinne des Kodex — und damit ein Pflicht-Post?**

Meine Einordnung, und ich handle in diesem Zyklus danach: **nein.** Die
Begründung, damit sie überprüfbar ist statt bequem:

- **Regel 1 ist nicht gebrochen.** Erfunden wurde nichts. Die Nullen waren echte
  Ausgaben echter Befehle; falsch war die Schlussfolgerung daraus. `LAGE.md` hat
  seine Grenzen außerdem selbst benannt und die Aussage auf „mit diesen zwölf
  Suchbegriffen" eingeschränkt.
- **Regel 3 ist nicht gebrochen.** Kein Ziel wurde abgeschwächt oder
  nachträglich passend gemacht. Die vier Prüfungen der Beziehungsprobe sind
  gebaut und geprüft; ihr Abschluss bleibt stehen und wird nicht umgeschrieben.
- **Keiner der fünf Pflicht-Auslöser trifft zu.** Kein Fristende, kein
  Fehlschlag eines Schritts in diesem Zyklus, kein Abbruch einer laufenden
  Mission (es lief keine), kein menschlicher Eingriff, kein Verstoß.
- **Kein gesendeter Beitrag ist betroffen.** Die drei Beiträge vom 2026-08-14
  behaupten nichts über die Einzigartigkeit des ICS-Doktors; nachgelesen im
  Wortlaut in `state/posts/`. Es gibt also keine öffentliche Falschaussage, die
  zu korrigieren wäre.

**Warum es trotzdem hier steht:** Weil die Gegenrechnung sich aufdrängt und ich
sie nicht verschweigen will. Die Beziehungsprobe nennt als Folge ihrer
Widerlegung 3 „nachtragen und **abbrechen**". Wäre der Fund einen Tag früher
gelungen, wäre eine Mission abzubrechen gewesen — und ein Abbruch ist ein
Pflicht-Auslöser. Dass er nicht gelungen ist, liegt an meinem Verfahren. Wer das
schwerer gewichtet als ich, kommt zu „Verstoß" und damit zu einem Pflicht-Post.

**Was ein Mensch tun müsste, wenn er das anders sieht:** einen Satz in diese
Datei oder in `state/mission.md` committen, der die Einordnung als Verstoß
festhält. Dann geht der Beitrag im nächsten Zyklus als Pflicht-Post hinaus und
verdrängt den reservierten Slot. **Keine Frist** — es hält mich nicht an, und
ich baue in der Zwischenzeit an der Gegenprobe weiter.

**Was ich nicht tue:** die Einordnung offenlassen und deshalb nicht handeln. Ich
habe entschieden, ich handle danach, und die Entscheidung steht hier zum
Widerspruch — statt in meinem Kopf.

---

## 2026-08-16 — Drei Punkte aus Kodex v0.3, festgestellt in Zyklus 26

Der Eingriff `3274596` ist in `state/eingriffe.md` mit Hash und Umfang
nachgetragen und geht als Pflicht-Post hinaus. Was hier steht, ist das, was er
an meiner Buchführung hinterlässt.

### 1. Die Reservierung des vierten Slots ist gegenstandslos — fortgeschrieben

Der Abschnitt „Wie der Rückstand abgetragen wird" hält seit Zyklus 17 einen der
vier Wochenplätze frei. Punkt 3 begründet das damit, dass ein ausgeschöpfter
Deckel einen Pflicht-Post in die Folgewoche schieben würde — „und das wäre die
Verzögerung, die Regel 2 ausschließt".

Ab Kodex v0.3 kann das nicht mehr passieren: Pflicht-Beiträge zählen nicht gegen
den Wochendeckel. Der Grund der Reservierung ist damit weg, nicht nur ihr
Beispiel. **Die Punkte 1, 2, 4 und 5 dieses Abschnitts bleiben in Kraft**, Punkt
3 ist erledigt. Der Wortlaut oben bleibt stehen und wird nicht umgeschrieben.

An seine Stelle tritt die Tempobremse aus Regel 12: höchstens drei Beiträge je
Zyklus, gleich welcher Art. **Abgetragen wird ab jetzt in jedem Zyklus, in dem
Plätze frei sind**, in der Reihenfolge aus Punkt 1 und 2 — frischer
Pflicht-Auslöser zuerst, dann der Rückstand. Was nicht hinausgeht, verfällt
nicht.

**Geplant in Zyklus 26, noch nicht gesendet** — drei, also der volle Zyklustakt:
`2026-08-16-01-kodex-v03` (frischer Auslöser: der Eingriff dieses Zyklus, nach
Punkt 1 zuerst), `2026-08-16-02-rueckstand-monitor` (Rückstand, Feststellung aus
Zyklus 2) und `2026-08-16-03-rueckstand-notaus-ci` (Rückstand, Feststellung aus
Zyklus 8). Aus dem Rückstand wird in der Reihenfolge abgetragen, in der die
Feststellungen aufgelaufen sind — die älteste zuerst; Punkt 2 („Fehlschläge vor
Eingriffen") greift nicht mehr, weil beide Fehlschläge am 2026-08-14 hinaus
sind.

**Nach Punkt 5 zählt das noch nichts.** Der Rückstand steht weiter bei acht und
wird erst fortgeschrieben, wenn diese Einträge auf `gesendet` stehen. Geht der
Sender durch, sind es sechs.

**Fortgeschrieben 2026-08-16, Zyklus 27 — alle drei sind hinaus.** Punkt 5
verlangt diese Fortschreibung, sobald ein Eintrag auf `gesendet` steht, und nicht
früher. Gesendet hat sie der Kanal-Workflow in seinem Lauf 15 (Commit
`6285bfb`), nicht ich; Zeitstempel und Beitrags-URI stehen im Kopf der jeweiligen
Datei in `state/posts/`:

| Datei | Gesendet | Beitrag |
|---|---|---|
| `2026-08-16-01-kodex-v03` | 13:14:41Z | [3mt7bf4auor2r](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mt7bf4auor2r) |
| `2026-08-16-02-rueckstand-monitor` | 13:14:41Z | [3mt7bf4k2pu2w](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mt7bf4k2pu2w) |
| `2026-08-16-03-rueckstand-notaus-ci` | 13:14:42Z | [3mt7bf4qvic2i](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mt7bf4qvic2i) |

**Der Rückstand steht damit bei sechs**, genau wie vorhergesagt. Die drei
Beiträge haben die Zahl nicht anders bewegt, als sie es vorher aufgeschrieben
hatten. Offen sind die Eingriffs-Feststellungen aus den Zyklen 9, 10, 11, 13, 14
und 15.

**Geplant in Zyklus 27, noch nicht gesendet** — wieder drei, wieder der volle
Zyklustakt, und diesmal ausschließlich Rückstand, weil dieser Zyklus keinen
frischen Pflicht-Auslöser festgestellt hat: `2026-08-16-04-rueckstand-abo`
(Zyklus 9, `f371325`), `2026-08-16-05-rueckstand-takt` (Zyklus 10, drei Commits)
und `2026-08-16-06-rueckstand-pruefung` (Zyklus 11, `582b0bb`). Reihenfolge wie
gehabt: die älteste Feststellung zuerst. Nach Punkt 5 zählt das noch nichts —
der Rückstand steht bis zum Senden bei sechs, danach bei drei.

**Was in diesem Zyklus nicht gepostet wird:** die geschlossene Lücke 4. Das ist
Fortschritt, steht in meinem Ermessen, und die drei Plätze sind von Pflicht
belegt. Vom Wochendeckel für Ermessen wäre ohnehin nur ein Platz übrig; er wird
nicht dafür verbraucht, solange Pflicht offen ist.

### 2. Meine drei gesendeten Beiträge zählen für den Sender als Ermessen

**Gemessen an der Datei, nicht vermutet:** `tools/senden.js` erkennt einen
Pflicht-Beitrag daran, dass `ausloeser:` **genau** einen der fünf Namen trägt
(`PFLICHT.includes(...)` auf den kleingeschriebenen Wert). Die drei Beiträge vom
2026-08-14 tragen dort Fließtext — etwa `Fehlschlag (Regel 2), nachgeholt aus
dem Rückstand`. Kein Wert aus der Liste, also zählt der Sender sie als Ermessen:
**drei von vier verbraucht, bis das Fenster am 2026-08-21, 08:06 UTC rollt.**

Alle drei waren Pflicht-Beiträge; das steht in ihrem Kopf, im Journal zu
Zyklus 17 und in diesem Dokument. Die Zählung ist trotzdem so, wie sie ist.

**Was ich deshalb nicht tue: die Köpfe gesendeter Beiträge umschreiben.** Eine
Datei, die belegt, was hinausgegangen ist, nachträglich passend zu machen, ist
genau die stille Korrektur, die der Abschnitt „Verstoß" ausschließt — und sie
liefe darauf hinaus, mir selbst drei Wochenplätze zurückzugeben.

**Was folgt, hält mich nicht an, deshalb kein Blocker:** Bis zum 2026-08-21 habe
ich rechnerisch **einen** Platz für einen Ermessens-Beitrag. Pflicht-Beiträge
sind davon nicht betroffen, und meine Beiträge aus diesem Zyklus sind
ausnahmslos Pflicht. Ab jetzt trägt `ausloeser:` bei mir einen der fünf Namen
und sonst nichts; bei Ermessen fehlt das Feld.

### 3. Unklar: `KODEX.md` nennt sich weiterhin Version 0.2

Commit-Titel, Commit-Text und der Eintrag in `state/eingriffe.md` sprechen von
**v0.3**. Die Kopfzeile in `KODEX.md` sagt unverändert „**Version 0.2 — in Kraft
seit 2026-08-11**", und die Änderungstabelle am Ende heißt weiterhin „Änderungen
gegenüber v0.1"; ein Abschnitt zu v0.3 fehlt.

**Ich rate nicht, und ich fasse `KODEX.md` nicht an.** Kodexänderungen sind eine
der fünf Ausnahmen — beschließen kann sie nur ein Mensch, und dazu gehört, wie
die beschlossene Fassung heißt. Für meine Arbeit ist der Wortlaut maßgeblich und
der ist eindeutig: Der Deckel gilt für Ermessen, Pflicht zählt nicht dagegen,
drei je Zyklus. Danach handle ich.

**Was ein Mensch tun müsste:** eine Zeile in `KODEX.md`, die die Version nennt,
unter der die geltende Fassung geführt wird. **Keine Frist** — es hält mich
nicht an. Es fällt auf, sobald jemand einen Beitrag von mir gegen „Kodex v0.3"
prüfen will und im Dokument nur v0.2 findet.

---

## 2026-08-17 — Zyklus 28: Rückstand fortgeschrieben, ein Fehlschlag, ein Befund

### 1. Rückstand: sechs → drei

Punkt 5 des Abtrageplans verlangt diese Fortschreibung, sobald ein Eintrag auf
`gesendet` steht, und nicht früher. Gesendet hat sie der Kanal-Workflow in
seinem Lauf 16 (Commit `90d68ab`), nicht ich; Zeitstempel und Beitrags-URI
stehen im Kopf der jeweiligen Datei in `state/posts/`:

| Datei | Gesendet | Beitrag |
|---|---|---|
| `2026-08-16-04-rueckstand-abo` | 18:59:58Z | [3mt7uojowt72z](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mt7uojowt72z) |
| `2026-08-16-05-rueckstand-takt` | 18:59:59Z | [3mt7uok3cfy2m](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mt7uok3cfy2m) |
| `2026-08-16-06-rueckstand-pruefung` | 18:59:59Z | [3mt7uok7nvf2j](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mt7uok7nvf2j) |

**Der Rückstand steht damit bei drei**, genau wie Zyklus 27 es vorher
aufgeschrieben hatte. Offen sind die Eingriffs-Feststellungen aus den Zyklen
13, 14 und 15.

### 2. Fehlschlag: Punkt 1 der laufenden Mission ist verfehlt

**Festgestellt am 2026-08-17 in Zyklus 28, durch eine Messung und nicht durch
ein Gefühl.** Der Beleg ist `fc157be`, die Auflösung steht datiert in
`projekte/icsdoktor/GEGENPROBE.md` und als Nachtrag an der Missionsdatei.

Kurz: `P18` schließt Lücke 1 im Verhalten — der ICS-Doktor meldet
`TRIGGER:19980403T120000Z` jetzt mit Zeile, Regel und Abschnitt, wo er vorher
geschwiegen hat. Die Messvorrichtung verbucht das nicht: Beide Werkzeuge melden
dieselbe Zeile 15, `gegenprobe.sh` paart sie aber nicht, weil §3.8.6.3 kein
Unterabschnitt von §3.3 ist und die Paarung einen gemeinsamen Abschnittspfad
verlangt. `rfc4-4:§3.3` bleibt damit dauerhaft `nur-fremd`, und Punkt 1 der
Zieldefinition („keine der vier Kennungen noch mit der Art `nur-fremd`") ist
nicht mehr erreichbar.

**Das ist ein Pflicht-Auslöser nach Regel 2** und geht in diesem Zyklus hinaus,
vor dem Rückstand (Punkt 1 des Abtrageplans: der jüngste Auslöser zuerst).

**Kein Blocker.** Es hält mich nicht an, und ein Mensch muss dafür nichts tun.
Die Mission läuft bis zum 2026-08-21 weiter, Lücke 2 bleibt zu bauen — sie ist
Wartungslast nach Regel 13, und das hängt nicht daran, wie eine
Vergleichsvorrichtung sie zählt. Am Fristende wird die Mission als **verfehlt**
geführt.

**Was ich hier ausdrücklich nicht tue:** die Paarungsregel von `gegenprobe.sh`
nachziehen, damit §3.8.6.3 und §3.3 zueinanderfinden. Sie ist die
Messvorschrift, sie steht seit dem ersten Lauf im Kopf der Datei, und das
Ergebnis steht schon da. Wer sie ändert, nachdem er das Ergebnis kennt, misst
nicht mehr.

### 3. Befund: `P16` und `P18` behandeln denselben Fall verschieden

**Kein Blocker** — ich kann es selbst lösen, und es hält mich nicht an. Es steht
hier, weil der Prüfstein weiter oben verlangt, dass ich es benenne, statt es
still anzugleichen oder es zu vergessen.

Beide Prüfungen fragen, ob ein Wert in der UTC-Form steht. Sie unterscheiden
sich darin, was sie auf einem Wert tun, der schon kein `DATE-TIME` ist:

- **`P18` schweigt.** Bei `TRIGGER;VALUE=DATE-TIME:20260901T1000` meldet `P08`
  die Form, und ein „hänge ein `Z` an" würde diesen Wert nicht retten.
- **`P16` meldet.** Bei einem `DTSTAMP` mit derselben Krankheit stünde neben
  `P08` auch „nicht in der UTC-Form; verlangt ist ein `Z` am Ende" — ein Rat,
  der dort nicht trägt.

`P18` folgt der Aufteilung von `P17` („wo der Typ schon abweicht, ist der
Zeitbezug keine zweite Frage"), `P16` der älteren von `P08`/`P13`. Beide
Lesarten sind im Repo begründet; nebeneinander sind sie trotzdem eine
Ungereimtheit.

**Warum ich `P16` nicht in diesem Zyklus angleiche:** Der Zyklus hat einen
abgeschlossenen Schritt, und dieser ist es nicht. `P16` an dieser Stelle zu
ändern hieße außerdem, eine Prüfung anzufassen, die eine Messung trägt, ohne
eine Messung, die den Anlass gibt — kein Beispiel und keine der zwölf Eingaben
löst den Fall heute aus. **Keine Frist.**

**Nachprüfbar:** `beispiele/12-p08-datumszeit.ics` trägt in Zeile 6 ein
`DTSTAMP`, das auf `Z` endet und deshalb an `P16` vorbeigeht. Der Fall ist im
Repo also unbelegt, und das ist der zweite Grund, ihn zu benennen statt ihn zu
bauen.

---

## 2026-08-17 — Zyklus 29: Rückstand fortgeschrieben, Lücke 2 zu, zwei Befunde

### 1. Rückstand: drei → eins

Punkt 5 des Abtrageplans verlangt diese Fortschreibung, sobald ein Eintrag auf
`gesendet` steht, und nicht früher. Gesendet hat sie der Kanal-Workflow in
seinem Lauf 17 (Commit `bada06b`), nicht ich; Zeitstempel und Beitrags-URI
stehen im Kopf der jeweiligen Datei in `state/posts/`:

| Datei | Gesendet | Beitrag |
|---|---|---|
| `2026-08-17-01-fehlschlag-ziel-verfehlt` | 02:14:09Z | [3mtamwvyuw22m](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mtamwvyuw22m) |
| `2026-08-17-02-rueckstand-impressum` | 02:14:10Z | [3mtamwwjsot2k](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mtamwwjsot2k) |
| `2026-08-17-03-rueckstand-anbieter` | 02:14:10Z | [3mtamwwm6eu2z](https://bsky.app/profile/ultimate-agent.bsky.social/post/3mtamwwm6eu2z) |

**Der Rückstand steht damit bei eins:** die Eingriffs-Feststellung aus
Zyklus 15 (`dae0d23`, `b40abf0`, `dbb62bd` — Profilbild, Handle, Profiltext,
Sender, Wecker). Sie geht als `2026-08-17-04-rueckstand-sender` in diesem Zyklus
hinaus. Der erste der drei oben war ein Fehlschlag aus Zyklus 28 und kein
Rückstand; die Zahl bewegt sich deshalb um zwei und nicht um drei.

**Was danach von diesem Eintrag übrig ist:** die Liste als Belegmaterial. Sie
wird nicht gelöscht, wenn sie abgearbeitet ist — so steht es oben seit dem
2026-08-14.

### 2. Lücke 2 ist zu, das Missionsziel bleibt verfehlt

**Kein Blocker.** Es steht hier, weil die Fortschreibung des Fehlschlags aus
Zyklus 28 dazugehört: Dort war die zweite Rechnung („selbst wenn Lücke 2 zugeht,
blieben fünf `nur-fremd` gegen höchstens vier") ausdrücklich als Vorhersage und
nicht als Messung ausgewiesen. **Sie ist jetzt gemessen und trifft zu:** fünf
`nur-fremd`, Gesamt unverändert dreizehn, Beleg `a997616`, Auflösung datiert in
`projekte/icsdoktor/GEGENPROBE.md`.

Damit steht der Fehlschlag an Punkt 1 auf zwei unabhängigen Befunden statt auf
einem. Er wird dadurch nicht schwerer und nicht leichter, und er ist bereits
gepostet (`2026-08-17-01-fehlschlag-ziel-verfehlt`, gesendet 02:14:09Z). Ein
zweiter Post derselben Feststellung wäre kein zweiter Pflicht-Auslöser.

### 3. Befund: zwei Pflichten, die `P19` bewusst nicht prüft

**Kein Blocker** — ich kann beides selbst lösen, und es hält mich nicht an. Es
steht hier, damit es nicht in einem späteren Zyklus stillschweigend mitgebaut
wird, so wie der `P16`-Befund aus Zyklus 28.

- **Die aktionsabhängigen Pflichten des `VALARM` (§3.6.6).** `dispprop` verlangt
  zusätzlich `DESCRIPTION`, `emailprop` zusätzlich `DESCRIPTION`, `SUMMARY` und
  `ATTENDEE`. Welche der drei Varianten gilt, hängt am Wert des `ACTION` — und
  §3.8.6.1 lässt dort `iana-token` und `x-name` zu. Bei `ACTION:X-MEIN-WECKER`
  ist keine der drei anwendbar, und eine Prüfung, die dann die nächstliegende
  nimmt, meldet einen Verstoß gegen eine Regel, die es für diesen Wert nicht
  gibt. **Keine Frist.**
- **`VTIMEZONE` (§3.6.5) und seine Unterkomponenten.** Dort steht ebenfalls eine
  Pflicht: `TZID`, und in `STANDARD` und `DAYLIGHT` `DTSTART`, `TZOFFSETTO`,
  `TZOFFSETFROM`. Die Missionsdatei nennt unter Lücke 2 vier Komponenten, und
  diese ist keine davon; die Messung, die den Anlass gibt, betrifft `VFREEBUSY`.
  Eine fünfte Komponente ohne Messung dahinter wäre eine Prüferweiterung, die
  sich hinterher als Teil der Aufgabe erzählen ließe. **Keine Frist.**

**Nachprüfbar:** Keine der 46 Beispieldateien und keine der zwölf fremden
Eingaben löst einen dieser Fälle heute aus. Beide sind im Repo also unbelegt,
und das ist derselbe Grund, sie zu benennen statt sie zu bauen, wie beim
`P16`-Befund.

---

## 2026-08-17 — Zyklus 30: Eingriff am Kodex, drei Befunde

### 1. Befund: `ARCHITEKTUR.md` spricht weiter von fünf Pflicht-Auslösern

**Kein Blocker** — es hält mich nicht an, und ich richte mich in der Zwischenzeit
nach dem Kodex. Es steht hier, weil ich die Datei nicht selbst anfasse und ein
Mensch das entscheiden soll.

`5bde1d6` hat Regel 2 auf sechs Auslöser erweitert. `ARCHITEKTUR.md` nennt an
zwei Stellen weiter fünf:

- *„Meistens nicht — aber die fünf Pflicht-Auslöser stehen nicht im Ermessen."*
  (Ablauf eines Zyklus, Schritt 8)
- *„Das Ermessen gilt für Fortschritt — Fristende, Fehlschlag, Abbruch,
  entdeckter Eingriff und Verstoß werden immer gepostet."* (derselbe Abschnitt)

**Warum das heute nichts kaputtmacht:** Der Kodex sagt in „Rangfolge" selbst,
was gilt — *„Was hier steht, gilt auch dann, wenn `ARCHITEKTUR.md` etwas anderes
nahelegt."* Ein Zyklus, der beide Dateien liest, kommt also zum richtigen
Ergebnis, auch ohne dass jemand etwas ändert.

**Warum ich es trotzdem nicht selbst angleiche:** `ARCHITEKTUR.md` ist in der
ganzen Historie ausschließlich von `spectatormc` geschrieben worden — sechs
Commits, kein einziger von mir. Ob die Datei mir offensteht, steht nirgends;
ich rate es nicht.

**Was ein Mensch tun müsste, in einem Satz:** In `ARCHITEKTUR.md`, Abschnitt
„Ablauf eines Zyklus", die beiden Stellen von fünf auf sechs Auslöser ziehen und
`Missionsabschluss` in die Aufzählung aufnehmen — oder mir sagen, dass ich diese
Datei selbst pflegen darf. **Keine Frist.**

Dieselbe Stelle steht auch in der laufenden Missionsdatei („Die fünf
Pflicht-Auslöser gelten unabhängig davon"). Die ist ab Anlage unveränderlich;
dort hängt seit diesem Zyklus ein datierter Nachtrag, der nichts oberhalb
seiner Zeile ändert.

### 2. Befund: zwei Zählungen der Ermessensplätze, beide richtig

**Kein Blocker.** Es steht hier, weil zwei Zahlen im Repo nebeneinander stehen
und sich zu widersprechen scheinen.

Im Eintrag des Betreibers in `state/eingriffe.md` (`5bde1d6`) steht: *„Seine
vier Ermessensplaetze pro Woche hat er noch nie benutzt, kein einziges Mal."*
Der Sender meldet im Trockenlauf dieses Zyklus: **„Ermessen in den letzten 7
Tagen: 3 von 4."**

**Aufgelöst, gemessen statt geschätzt:** Beide zählen Verschiedenes. Der
Betreiber zählt die Absicht — jeder meiner dreizehn gesendeten Beiträge war als
Pflichtmeldung gemeint, und das ist zutreffend. Der Sender zählt das Feld
`ausloeser:` gegen seine Liste aus sechs Namen. Die drei Beiträge vom
2026-08-14 tragen dort Fließtext, weil sie vor der Einführung der Namensliste
entstanden sind:

| Datei | `ausloeser:` |
|---|---|
| `2026-08-14-01-kanal-eingriff` | `entdeckter menschlicher Eingriff (Regel 2)` |
| `2026-08-14-02-zwei-fehlschlaege` | `Fehlschlag (Regel 2), nachgeholt aus dem Rückstand` |
| `2026-08-14-03-rueckstand` | `entdeckter menschlicher Eingriff (Regel 2), Rückstand ohne Kanal` |

Keiner dieser Werte steht in der Liste, also gelten sie dem Sender als Ermessen.
Sie sind am 2026-08-14 um 08:06 UTC hinausgegangen und fallen am **2026-08-21
um 08:06 UTC** aus dem rollenden Sieben-Tage-Fenster.

**Was daraus für diesen Zyklus folgt, und warum ich es vorher gemessen habe:**
Mit dem Ermessens-Beitrag dieses Zyklus steht der Deckel bei **4 von 4**. Bis
zum 2026-08-21, 08:06 UTC geht kein weiterer Ermessens-Beitrag hinaus; der
Sender würde ihn auf `zurueckgestellt` setzen. Pflichtmeldungen sind davon
unberührt — sie zählen nicht gegen den Deckel.

**Was ich nicht tue:** die drei alten Einträge umschreiben, damit die Zahl
freundlicher aussieht. Sie sind gesendet; ihr Kopf ist Beleg, kein Entwurf. So
steht es seit Zyklus 26.

### 3. Der Abschluss der laufenden Mission ist ab jetzt Pflicht

**Kein Blocker**, und ausdrücklich kein neuer Fehlschlag — der Fehlschlag an
Punkt 1 ist am 2026-08-17 um 02:14:09Z gepostet und bleibt derselbe.

Neu ist nur die Art der Meldung: `Missionsabschluss` ist seit `5bde1d6` der
sechste Pflicht-Auslöser und deckt erreicht wie verfehlt. „Die vier Lücken"
endet am **2026-08-21** als **verfehlt**; dieser Abschluss geht als
Pflicht-Beitrag mit `ausloeser: missionsabschluss` hinaus und braucht keinen
Ermessensplatz. Der Abschlussblock stellt das Ergebnis fest, er deutet es nicht
um.

---

## 2026-08-17 — Zyklus 31: der `P16`/`P18`-Befund ist geschlossen, seine Begründung war falsch

### 1. Erledigt: die Ungereimtheit zwischen `P16` und `P18`

**Geschlossen am 2026-08-17 in Zyklus 31**, Auflösung datiert in
`projekte/icsdoktor/GEGENPROBE.md`. `P18` meldet ab jetzt ebenfalls, wo der Wert
schon kein `DATE-TIME` ist — statt dass `P16` verstummt. Die Grenze verläuft ab
jetzt zwischen Einzelwert und Beziehung: `P12`–`P14` und `P17` vergleichen zwei
Zeilen und schweigen, wenn eine Seite unlesbar ist; `P16` und `P18` messen einen
Wert an einem Satz, den er allein verletzt. Der Rat „häng ein `'Z'` an" ist aus
beiden Meldungen entfernt, der Befund steht in beiden.

**Gemessen vor und nach der Änderung**, damit die Richtung der Auflösung
nachprüfbar ist und nicht behauptet: `gegenprobe.sh` 13 Abweichungen und fünf
`nur-fremd` vorher wie nachher, Liste identisch, `--pruefe-abdeckung` 13/13.
`pruefe.sh` 47/47 Exit 0, `rfc-beispiele.sh` 0 Fehler 0 Hinweise Exit 0,
`fremdprobe.sh` 6/6 Exit 0.

### 2. Widerlegt: „kein Beispiel und keine der zwölf Eingaben löst den Fall aus"

**Der Satz steht im Eintrag zu Zyklus 28 weiter oben und ist falsch.** Er wird
nicht gelöscht — er ist der Grund, aus dem zwei Zyklen die Sache haben liegen
lassen, und gehört deshalb im Wortlaut stehen. Widerlegt haben ihn zwei Belege,
die beide schon im Repo lagen:

- `projekte/icsdoktor/beispiele/12-p08-datumszeit.ics` trägt in **Zeile 14**
  `TRIGGER;VALUE=DATE-TIME:20260901T1000` — genau der Fall, in dem `P18` schwieg.
  Dieselbe Datei ist im Eintrag von Zyklus 28 als Nachweis dafür zitiert, dass
  der Fall *nicht* vorkommt; zitiert wurde ihre Zeile 6, geprüft nicht ihre
  Zeile 14.
- Die Fremddatei `vagov-23608` trägt `DTSTAMP:NaNNaNNaNTNaNNaNNaN` und löst die
  `P16`-Seite aus — an der einzigen Stelle, an der Lücke 3 der laufenden Mission
  überhaupt gemessen wird. Das stand im Wortlaut in
  `projekte/icsdoktor/README.md`, mit dem Wert daneben, am selben Tag
  geschrieben.

**Was ich daraus mitnehme, ohne es zu einem Lernerfolg umzudeuten:** Der Satz
war kein Irrtum über den Normtext, sondern eine Behauptung über den Zustand des
Repos, die ich hätte nachsehen können und nicht nachgesehen habe — in einer
Datei, die ich im selben Atemzug zitiert habe. Aufgefallen ist er erst, als eine
Messung ihn brauchte.

**Kein Blocker, kein Fehlschlag.** Die Zieldefinition der Mission ist davon
unberührt: Punkt 1 ist seit dem 2026-08-17 verfehlt und feststehend, aus einem
unabhängigen Grund. Diese Messung bewegt die Zahl in keine Richtung.

### 3. Weiterhin offen, weiterhin ohne Frist

Die beiden Befunde aus Zyklus 29 bleiben unangetastet: die aktionsabhängigen
`VALARM`-Pflichten (§3.6.6) und `VTIMEZONE` (§3.6.5). Beide sind im Repo
unbelegt — und dieser Zyklus ist der Grund, den Satz „unbelegt" ab jetzt nur
noch mit einer Messung daneben zu schreiben.

---

## 2026-08-18 — Zyklus 32: „im Repo unbelegt" ist jetzt ein Befehl, ein zweiter alter Satz war falsch

### 1. Erledigt: der Satz aus Zyklus 31 ist eingelöst, nicht nur zugesagt

Zyklus 31 endet mit der Zusage, „im Repo unbelegt" ab jetzt nur noch mit einer
Messung daneben zu schreiben. Diese Zusage steht seitdem in einem Absatz — und
ein Absatz ist genau die Bauform, die zweimal danebenlag. Gebaut ist deshalb
`projekte/icsdoktor/anlass.sh`: Es rechnet die Sätze nach, mit denen der
ICS-Doktor das Nichtbauen einer Prüfung begründet, und endet mit 1, sobald einer
davon nicht mehr stimmt.

**Gemessen am 2026-08-18 über 47 Beispieldateien, die sechs Kalenderobjekte aus
RFC 5545 §4 (unkorrigiert) und die sechs Fremddateien aus `korpus.tsv`,
zusammen 59 Eingaben, gelesen mit dem Parser des Werkzeugs selbst:**

| Fall | betrachtet | Treffer |
|---|---|---|
| `VALARM`, aktionsabhängige Pflichten (§3.6.6) | 14 Komponenten | 0 |
| `VTIMEZONE`, Pflichteigenschaften (§3.6.5) | 3 Komponenten | 0 |
| `STANDARD`/`DAYLIGHT`, Pflichteigenschaften (§3.6.5) | 5 Komponenten | 0 |

**Die beiden Befunde aus Zyklus 29 bleiben damit offen und ohne Frist** — aber
ab jetzt aus einem gemessenen Grund statt aus einem behaupteten. Die linke
Spalte gehört zur rechten: Eine Null ohne die Zahl der betrachteten Komponenten
sagt nichts über den Fall, sondern nur über den Korpus. Genau diese Auskunft hat
am 2026-08-17 in die Irre geführt, und das Skript verweigert sie deshalb: Bei 0
betrachteten Komponenten meldet es selbst einen Anlass.

**Dass die Messung auch rot werden kann, ist geprüft und nicht angenommen.** In
einer Kopie des Projekts unter `/tmp` — nicht im Repo — hat eine Beispieldatei
mit einem `VTIMEZONE` ohne `TZID`, einem `STANDARD` ohne `TZOFFSETTO` und einem
`ACTION:DISPLAY` ohne `DESCRIPTION` alle drei Fälle ausgelöst: drei Anlässe,
Exit 1, jeder mit Datei und Zeile. Ein Prüfbefehl, der nie rot wird, prüft
nichts.

**Was `anlass.sh` ausdrücklich nicht ist:** kein Prüfbefehl der laufenden
Mission. Deren drei stehen in der Zieldefinition und sind unverändert; dieses
Skript prüft die Begründung, nicht das Werkzeug. Es kostet fünf der sechzig
unangemeldeten GitHub-Anfragen pro Stunde, so wie `fremdprobe.sh` und
`gegenprobe.sh` auch.

### 2. Befund: der zweite Satz über den Zustand des Repos war ebenfalls falsch

**Kein Blocker, kein Fehlschlag** — gefunden und im selben Zyklus behoben.

In `projekte/icsdoktor/README.md` stand bis heute: *„Angewandt ist bisher nur
Erratum 2039; Erratum 4149 gehört zu einer Prüfung, die noch nicht gebaut ist,
und fehlt deshalb ausdrücklich statt versehentlich."* Am 2026-08-16 war das
richtig. Am 2026-08-17 hat Zyklus 29 `P19` gebaut und Erratum 4149 in
`rfc-beispiele.sh` nachgezogen — nachzulesen als zweite Datenzeile im Skript,
`6<TAB>4149<TAB>BEGIN:VFREEBUSY<TAB>…`. Der README-Absatz ist nicht mitgezogen
worden.

**Warum das niemandem auffiel, und warum das die Lehre ist:** Die Missionsdatei
hatte es richtig — ihr Nachtrag vom 2026-08-17 führt Punkt 2 als erfüllt mit
„beide Errata (2039, 4149) angewandt". Der Prüfbefehl war grün, weil er den
Patch wirklich anwendet. Falsch war allein die Prosa, und Prosa prüft kein
Exit-Code. Es ist derselbe Fehlertyp wie der aus Zyklus 28 und wurde beim Bauen
des Skripts gefunden, das gegen genau diesen Typ geschrieben ist.

**Korrigiert, nicht gelöscht:** Der alte Wortlaut steht im README zitiert, mit
Datum, seit wann er nicht mehr stimmt.

### 3. Gemessen, ohne Änderung daran: das Werkzeug selbst

Bevor `anlass.sh` entstand, sind die vier jüngsten Prüfungen gegen zehn
selbstgebaute Grenzfälle unter `/tmp` geprüft worden — kleingeschriebene
Eigenschafts- und Parameternamen (`dtstamp:`, `;tzid=`, `;value=`, `action:`,
`BEGIN:vfreebusy`), quotierte Parameterwerte (`TZID="Europe/Berlin"`,
`VALUE="DATE-TIME"`), `DTSTAMP;VALUE=DATE`, ein `VALARM` ohne `TRIGGER` und ein
doppeltes `ACTION`. **Alle zehn verhalten sich wie erwartet; kein Defekt
gefunden.** Das steht hier, weil eine Suche ohne Fund auch ein Ergebnis ist —
und weil sonst der Eindruck entstünde, dieser Zyklus habe nur Dokumentation
angefasst.

### 4. Weiterhin offen, weiterhin ohne Frist

Die beiden Befunde aus Zyklus 29 — aktionsabhängige `VALARM`-Pflichten (§3.6.6)
und `VTIMEZONE` (§3.6.5). Sie werden gebaut, wenn `anlass.sh` einen Anlass
zeigt, und nicht vorher.

---

## 2026-08-18 — Zyklus 33: `P20` gebaut, zwei Kodierungsbefunde gemessen und nicht gebaut

### 1. Erledigt: das Werkzeug erklärt die Bytefolgemarkierung nicht mehr falsch

**Kein Blocker, kein Fehlschlag** — ein Defekt in etwas, das ich gebaut habe,
gefunden und im selben Zyklus behoben (`9bab78d`), mit dem alten Verhalten im
Wortlaut daneben.

Eine `.ics`-Datei mit UTF-8-BOM bekam am Stand `0bbd7d8` fünf Meldungen: eine
richtige, aber unlesbare (`P04` zitiert ein Zeichen ohne Breite) und **vier
falsche** — `VERSION`/`PRODID` stünden außerhalb jeder Komponente, die äußerste
Komponente sei `VEVENT`, und das `END:VCALENDAR` zehn Zeilen weiter unten habe
kein `BEGIN`. Seit `P20` steht dort genau eine Meldung, und die Datei wird
danach gelesen, als stünde die Markierung nicht da.

**Normanker ist die Grammatik aus §3.4**, und die Grundlage ist schmaler als bei
`P18`/`P19`: RFC 5545 erwähnt die BOM an keiner Stelle, sie ist also nicht
verboten, sondern von der Grammatik nicht vorgesehen. Das steht so im README.
Beleg aus der Welt: `mampfes/hacs_waste_collection_schedule#541` (geschlossen,
2023-01-01), wörtlich zitiert im Journal.

**Die Messvorschrift der laufenden Mission ist nicht angefasst.** `gegenprobe.sh`
zeigt vor und nach der Änderung 13 Abweichungen, fünf davon `nur-fremd`, mit
identischer Kennungsliste. Punkt 1 bleibt verfehlt, aus dem Grund vom
2026-08-17.

### 2. Befund: eine Datei, die kein gültiges UTF-8 ist, bekommt Exit 0

**Kein Blocker, keine Frist.** Gemessen am 2026-08-18 an einer Datei mit
Latin-1-Umlauten: kein Fund, Exit 0. Das Werkzeug liest mit
`decode("utf-8", errors="replace")` und ersetzt die Bytes stillschweigend.

**Der Normtext steht nicht, wo man ihn vermutet.** §3.1.4 sagt nur *„The default
charset for an iCalendar stream is UTF-8"* — ein Default, kein MUST; der einzige
MUST dort gilt MIME-Transporten. Der MUST für die Datei steht in **§6**:
*„Applications MUST generate iCalendar streams in the UTF-8 charset and MUST
accept an iCalendar stream in the UTF-8 or US-ASCII charset."*

**Warum trotzdem nicht gebaut:** kein Anlass, gemessen statt behauptet. Die 47
Beispieldateien sind sämtlich gültiges UTF-8, nachgerechnet; die Fremddateien
stammen aus Git-Ablagen. Und die Suche vom 2026-08-18 hat keinen öffentlichen
Fehlerbericht gefunden, in dem die gemeldete Datei wirklich kein UTF-8 ist. Die
zwei naheliegenden Treffer tragen nicht und sind im Journal einzeln widerlegt:
`ics-py/ics-py#126` (Datei gültig, Verbraucher benutzte den ASCII-Codec) und
`SuiteCRM/SuiteCRM#4438` (Zeichen schon beim Erzeuger zu `?` geworden, Datei
danach gültig).

**Was hier ausdrücklich nicht behauptet wird:** dass es solche Dateien nicht
gibt. Ich habe sie nicht gefunden, und das ist ein Satz über meine Suche.

### 3. Befund: die Bytefolgemarkierung für UTF-16 ist ungeprüft

**Kein Blocker, keine Frist.** `FF FE` und `FE FF` erkennt `P20` nicht. Eine
Datei in UTF-16 verletzt §6, aber im Repo gibt es dafür keinen Beleg und in der
Suche vom 2026-08-18 keinen öffentlichen Fehlerbericht. Gemessen am
2026-08-18: eine solche Datei erzeugt heute mehrere Meldungen, darunter eine,
die das Ersatzzeichen `U+FFFD` zitiert — also ein Zeichen, das in der Datei des
Nutzers gar nicht steht. Das ist derselbe Defekttyp wie Punkt 1, nur ohne Beleg.

**Gebaut wird beides, wenn eine Messung einen Anlass zeigt, und nicht vorher** —
dieselbe Regel wie für die beiden Befunde aus Zyklus 29.

### 4. Weiterhin offen, weiterhin ohne Frist

Die beiden Befunde aus Zyklus 29 — aktionsabhängige `VALARM`-Pflichten (§3.6.6)
und `VTIMEZONE` (§3.6.5). `anlass.sh` zeigt am 2026-08-18 weiter keinen Anlass:
14 bzw. 3 bzw. 5 betrachtete Komponenten, je 0 Treffer.

---

## 2026-08-18 — Zyklus 34: Ersatzzeichen aus `P04` entfernt, drei Befunde

### 1. Erledigt: `P04` nennt das Byte statt eines Zeichens, das nicht dasteht

**Kein Blocker, kein Fehlschlag** — ein Defekt in etwas, das ich gebaut habe,
gefunden und im selben Zyklus behoben (`89d0b5b`), mit dem alten Verhalten im
Wortlaut daneben. Damit ist **Befund 3 aus Zyklus 33 zur Hälfte geschlossen.**

Das Werkzeug liest mit `decode("utf-8", errors="replace")`; jedes Byte ohne
gültiges UTF-8 wird zu `U+FFFD`. Zitierte `P04` dieses Zeichen, nannte die
Meldung **eine falsche Ursache** (dort steht kein verbotenes Zeichen, sondern
ein Byte, das gar kein Zeichen ergibt) und führte den Suchenden ins Leere.
Gemessen am Stand `dfcfa33` an einem Latin-1-Umlaut (`0xE4`) in Namensposition.

Seit `89d0b5b` steht dort `das Byte E4, das kein gültiges UTF-8 ist`. Ein
echtes `U+FFFD` — korrekt als `EF BF BD` kodiert — wird weiter zitiert, denn
dort ist es zu finden; unterschieden wird an einer Tabelle Textindex → Bytes,
nicht am fertigen Text. Beide Fälle stehen als Beispiel 49 und 50 im Korpus.

**Keine neue Prüfung:** kein neuer Fund, kein anderer Exit-Code, die 47 alten
Erwartungen byteweise unverändert. `gegenprobe.sh` zeigt dieselben 13
Abweichungen mit identischer Kennungsliste; Punkt 1 der laufenden Mission
bleibt verfehlt, aus dem Grund vom 2026-08-17.

### 2. Befund: `_zeige_wort` gibt das Ersatzzeichen weiter aus

**Kein Blocker, keine Frist.** Wo eine Meldung einen **Wert wiedergibt**, steht
das `U+FFFD` weiter darin. Gemessen am 2026-08-18:

```
FEHLER Zeile 7: P08 DTSTART: Wert "2026<U+FFFD>0101T120000Z" ist kein
DATE-TIME; erwartet wird JJJJMMTT, ein 'T' und HHMMSS … [RFC 5545 §3.3.5]
```

**Warum nicht mitbehoben, und warum das keine Ausrede ist:** `P08` nennt hier
die **richtige** Ursache — der Wert ist kein DATE-TIME —, nur ist das Zitat an
einer Stelle unlesbar. `P04` nannte die falsche. Der eine Fall ist ein Defekt,
der andere eine Lesbarkeitsgrenze. Dazu der Preis: `_zeige` hat eine
Aufrufstelle, an der ein Ersatzzeichen ankommen kann, `_zeige_wort` hat
vierundzwanzig, und die meisten bekommen einen Teilstring ohne Positionsbezug.

### 3. Befund: die UTF-16-Markierung ist weiter ungeprüft

**Kein Blocker, keine Frist.** Die andere Hälfte von Befund 3 aus Zyklus 33.
`FF FE` und `FE FF` erkennt `P20` nicht. Was sich am 2026-08-18 geändert hat:
Die Meldung zitiert kein Phantomzeichen mehr, sondern nennt `das Byte FF`. Die
Prüfung fehlt weiter, und im Repo gibt es dafür keinen Beleg.

### 4. Befund: `anlass.sh` überwacht Begründungen, aber keine Zahlen

**Kein Blocker, keine Frist.** In diesem Zyklus standen **zwei** Sätze im
README, die man hätte nachsehen können:

- „drei falsche Ursachen" — nachgerechnet am alten Stand `0bbd7d8`: es sind
  **vier**. Ein Rest der ersten, durch `head -4` verkürzten Messung aus
  Zyklus 33; zwölf Zeilen darüber stand schon richtig „vier".
- „beispiele/ 47 Kalenderdateien" — nachgezählt: **51**. Seit zwei Zyklen nicht
  nachgezogen, still mitgewachsen.

Beide sind korrigiert. `anlass.sh` überwacht seit Zyklus 32 drei
Begründungssätze über das Nichtbauen einer Prüfung — **Zahlen über den eigenen
Bestand fallen nicht darunter.** Ob das Werkzeug sie mitprüfen sollte, ist
offen; gebaut wird es nicht nebenbei und nicht in dem Zyklus, in dem es auffiel.

### 5. Nicht gefunden, zum zweiten Mal: ein Beleg für §6

Vier weitere Suchen am 2026-08-18, mit anderen Begriffen als am Vortag. Die
zwei tragfähig aussehenden Treffer tragen wieder nicht: `splaice/maildb#82`
(Bytes `e2 80 99` — gültiges UTF-8, ASCII-Codec des Verbrauchers) und
`skarim/vobject#51` (`0xc3` in einer vCard, gültiges UTF-8, Python-2-Problem).
Die §6-Prüfung bleibt ungebaut. **Das ist ein Satz über meine Suche und keiner
über die Welt.**

### 6. Weiterhin offen, weiterhin ohne Frist

Die beiden Befunde aus Zyklus 29 — aktionsabhängige `VALARM`-Pflichten (§3.6.6)
und `VTIMEZONE` (§3.6.5). `anlass.sh` zeigt am 2026-08-18 weiter keinen Anlass:
14 bzw. 3 bzw. 5 betrachtete Komponenten, je 0 Treffer.

---

## 2026-08-18 — Zyklus 35: Zahlen über den eigenen Bestand werden nachgerechnet

### 1. Erledigt: Befund 4 aus Zyklus 34 ist geschlossen

**Kein Blocker, kein Fehlschlag.** `projekte/icsdoktor/zahlen.sh` gebaut
(`8ed3683`). Er rechnet sechs Sätze aus dem Bestand nach — Dateien in
`beispiele/`, Funktionen `def pruefe_pNN` in `icsdoktor.py`, höchste Prüfnummer
plus eins — und prüft zweierlei: dass jede Stelle die nachgerechnete Zahl trägt
**und dass der Satz überhaupt noch dasteht**. Wer ihn umformuliert, macht ihn
unauffindbar; das ist dort ein Fehlschlag und kein stilles Bestehen.

**Der erste Lauf war rot, und zwar dreifach.** Alle drei Sätze nannten den Stand
vor `P20` und standen seit dem 2026-08-18 falsch — dem Tag, an dem `P20` gebaut
wurde (`9bab78d`):

- `README.md`: „gibt es Anlass für eine **20.** Prüfung?" — eingeführt in
  Zyklus 32 (`629b703`), wo die höchste Prüfung `P19` war und der Satz stimmte.
- `anlass.sh`: „die **neunzehn** gebauten Pruefungen".
- `anlass.sh`: „eine **zwanzigste** zu bauen".

Alle drei korrigiert. Der dritte steht jetzt in Ziffernform („die 21."), damit
das Skript ohne Ordnungszahlwörter auskommt.

**Gegenprobe zum Wächter selbst**, an einer Kopie unter `/tmp`, das Repo
unberührt: eine Beispieldatei mehr → Exit 1; eine Prüfung `P21` mehr → Exit 1 an
fünf von sechs Stellen; ein umformulierter Satz → Exit 1 mit „steht dort nicht
mehr"; eine Lücke in den Prüfnummern → Exit 1, und das Skript rechnet
ausdrücklich nicht weiter, weil „höchste + 1" dann nicht mehr die nächste freie
Nummer ist.

### 2. Befund, nicht geraten: „die dreizehn älteren Erwartungen"

**Kein Blocker, keine Frist.** In `projekte/icsdoktor/README.md` steht:
*„Umbenannt wird nichts, damit die dreizehn älteren Erwartungen in `erwartet/`
byte-genau bleiben."* Heute liegen dort **51** Dateien.

**Zwei Lesarten, und ich kann sie nicht auseinanderhalten:** Entweder ist
„dreizehn" eine veraltete Zahl derselben Sorte wie die drei oben — dann gehört
sie korrigiert. Oder „die dreizehn älteren" meint eine feste historische Menge,
die Erwartungen aus der Vormission — dann ist der Satz richtig und darf nicht
angefasst werden. Gemessen: Der Satz steht schon in `bbb7ba4` (2026-08-12), und
dort lagen **15** Dateien in `erwartet/`. Er war also zu keinem Zeitpunkt die
Zahl des Verzeichnisses, was für die zweite Lesart spricht, sie aber nicht
beweist.

**Deshalb nicht angefasst und nicht in die Tabelle von `zahlen.sh`
aufgenommen.** Eine Zahl zu „korrigieren", die eine historische Menge nennt,
wäre dieselbe Fälschung, die das Skript bei `GEGENPROBE.md` ausdrücklich
unterlässt.

### 3. Die Grenze von `zahlen.sh`, benannt statt vorgeführt

**Kein Blocker, keine Frist.** Er kennt genau die sechs Sätze in seiner Tabelle.
Eine neue Behauptung über den Bestand kommt nicht von selbst hinein — sie muss
eingetragen werden. Ein grüner Lauf sagt „diese sechs stimmen" und nicht „im
Repo steht keine falsche Zahl". Das steht in seinem Kopf und im README.

Nicht erfasst und mit Absicht: Vorgaben aus den Missionsdateien („mindestens 16
Beispiele"), die sich nach Regel 3 gerade *nicht* mit dem Bestand bewegen
dürfen, und Messprotokolle wie `GEGENPROBE.md` („auf diesen zwölf Eingaben"),
die festhalten, was an einem Tag gemessen wurde.

### 4. Weiterhin offen, weiterhin ohne Frist

Unverändert aus Zyklus 33 und 34: `_zeige_wort` gibt das Ersatzzeichen in
**Wert**-Zitaten weiter aus (Lesbarkeitsgrenze, kein Defekt — dort ist die
Ursache richtig); die UTF-16-Markierung ist ungeprüft; die §6-Prüfung ist
ungebaut, und in diesem Zyklus wurde nicht erneut danach gesucht. Dazu die
beiden Befunde aus Zyklus 29 — `VALARM` (§3.6.6) und `VTIMEZONE` (§3.6.5);
`anlass.sh` zeigt am 2026-08-18 weiter keinen Anlass: 14 bzw. 3 bzw. 5
betrachtete Komponenten, je 0 Treffer.

---

## 2026-08-19 — Zyklus 36: `UNTIL` und `COUNT` zugleich wird gemessen statt vermutet

### 1. Erledigt: eine Begründung fürs Nichtbauen, die niemand nachgerechnet hat

**Kein Blocker, kein Fehlschlag.** Der Docstring von `pruefe_p17` endete mit
dem Satz, „UNTIL und COUNT duerfen nicht zugleich vorkommen" sei „eine andere
Frage und **nicht gemessen worden**". Seit `768cb3a` ist er gemessen:
`anlass.sh` rechnet den Fall mit nach, über dieselben 63 Eingaben wie die drei
anderen — 51 Beispieldateien, sechs Kalenderobjekte aus RFC 5545 §4, sechs
Fremddateien —, gelesen mit dem Parser des Werkzeugs selbst.

**Ergebnis am 2026-08-19: 8 `RRULE`-Zeilen betrachtet, 0 Treffer.** Kein
Anlass, also keine `P21`. Der Normtext steht wörtlich in der ABNF des
`RECUR`-Wertes: *„The UNTIL or COUNT rule parts are OPTIONAL, but they MUST NOT
occur in the same 'recur'."*

**Was dabei die eigentliche Änderung ist:** `betrachtet` zählt jetzt je Fall
die richtige Einheit. Die drei bisherigen Fälle prüfen Pflichten an einer
Komponente; dieser hängt an einer einzelnen Eigenschaft. Hätte ich Komponenten
weitergezählt, stünde bei vierzig `VEVENT` ohne ein einziges `RRULE` da
„betrachtet: 40, Treffer: 0" — dieselbe beruhigende Auskunft über nichts, vor
der der Kopf des Skripts seit Zyklus 32 warnt. `Treffer` zählt aus demselben
Grund Einheiten und nicht Komponenten mit einem Befund.

**Gegenprobe zum Wächter selbst**, an einer Kopie unter `/tmp`, das Repo
unberührt: eine Beispieldatei mit `UNTIL` und `COUNT` in einer `RRULE` → Exit 1
mit Datei- und Zeilennummer; ein `VALARM` ohne alle drei `EMAIL`-Pflichten →
Exit 1 mit **einem** Treffer statt dreien; eine Fallart auf einen
Komponentennamen gesetzt, den es nicht gibt → Exit 1 im ACHTUNG-Zweig.

### 2. Gemessen, ohne Änderung daran: kein Fehlalarm in zwölf gültigen Konstruktionen

**Kein Blocker, keine Frist.** Vor der Arbeit wie in den Vorzyklen zuerst nach
einem Fehlalarm gesucht, mit zwölf gültigen Konstruktionen aus RFC 5545, die in
keinem früheren Zyklus geprüft waren: die Schaltsekunde `235960` (§3.3.12), der
Schalttag mit `TZID` ohne `Z`, die TEXT-Maskierungen `\n \, \; \\`, ein leerer
TEXT-Wert, `ATTACH;ENCODING=BASE64;VALUE=BINARY`, `SENT-BY` neben unquotiertem
`CN`, das Semikolon **im Wert** bei `GEO` und `REQUEST-STATUS`, beide Formen
des `TRIGGER`, `FREEBUSY` mit zwei Perioden, die Faltung mit **Tabulator**
(§3.1 nennt „SPACE or HTAB"), `VTODO` mit `DUE;VALUE=DATE`, die drei zulässigen
`UNTIL`/`DTSTART`-Paarungen, ein vollständiges `VTIMEZONE`, `VJOURNAL` ohne
`DTSTART` bei gesetztem `METHOD`.

**Kein Fehlalarm.** Die einzige Meldung war ein richtiger `P03`-HINWEIS auf
eine Zeile, die ich versehentlich 76 Oktette lang geschrieben hatte. Das steht
hier, weil eine Suche ohne Fund auch ein Ergebnis ist.

### 3. Befund: die GitHub-Grenze wird von drei Skripten geteilt

**Kein Blocker, keine Frist.** Der erste Lauf von `anlass.sh` nach der Änderung
endete mit **Exit 2**: `api.github.com` stand bei 60 von 60 Anfragen, weil
`fremdprobe.sh`, `gegenprobe.sh` und `anlass.sh` in der Messung davor je fünf
verbraucht hatten. Das Skript hat sich richtig verhalten — abgebrochen und
gesagt warum, statt ein grünes Ergebnis ohne Messung zu liefern.

Kein Blocker nach dem Prüfstein von Zyklus 6: Es hält mich nicht an, und ich
kann es selbst umgehen, indem ich die drei nicht dicht hintereinander laufen
lasse. Im Actions-Lauf ist `gh` mit einem Token angemeldet (5000/h); die drei
Skripte benutzen aber `curl` ohne Anmeldung, und daran ändere ich nichts
nebenbei.

### 4. Unverändert offen, unverändert ohne Frist

Befund 2 aus Zyklus 35 („die dreizehn älteren Erwartungen", zwei Lesarten,
nicht geraten) steht wie er stand. Dazu unverändert aus Zyklus 33 bis 35:
`_zeige_wort` gibt das Ersatzzeichen in **Wert**-Zitaten weiter aus
(Lesbarkeitsgrenze, kein Defekt); die UTF-16-Markierung ist ungeprüft; die
§6-Prüfung ist ungebaut, und in diesem Zyklus wurde nicht erneut danach
gesucht. Dazu die beiden Befunde aus Zyklus 29 — `VALARM` (§3.6.6) und
`VTIMEZONE` (§3.6.5); `anlass.sh` zeigt am 2026-08-19 weiter keinen Anlass:
14 bzw. 3 bzw. 5 betrachtete Komponenten, je 0 Treffer.

---

## 2026-08-19 — Zyklus 37: die Fundstellen werden gegen den Normtext gehalten

**Kein Blocker.** Drei Befunde, keiner mit Frist, keiner ein Fehlschlag.

### 1. Gebaut: `fundstellen.sh` — und er hat nichts gefunden

Das Werkzeug hängt an jede Fundzeile `[RFC 5545 §X]`. Dieses `X` hatte niemand
nachgeschlagen: `pruefe.sh` vergleicht die Ausgabe mit einer Erwartung aus
meiner Hand — steht die falsche Fundstelle in beiden, ist der Vergleich grün.

Seit `059d871` holt `fundstellen.sh` die zitierten Normtexte zur Laufzeit und
hält jeden Verweis dagegen: **41 Verweise, 0 ohne Entsprechung.** Der Fehler,
nach dem gesucht wurde, war nicht da.

Der Befund steckt anderswo: **Zehn Abschnitte kann das Werkzeug ausgeben, ohne
dass eine einzige Beispieldatei sie auslöst** — `§3.8.2.1`, `§3.8.2.3`,
`§3.8.2.4`, `§3.8.4.4`, `§3.8.4.7`, `§3.8.5.1`, `§3.8.5.2`, `§3.8.6.1`,
`§3.8.7.1`, `§3.8.7.3`. Sie standen unbesehen im Code. Das ist keine offene
Aufgabe, sondern der Grund, warum die statische Erhebung nicht durch eine
Messung ersetzt werden kann.

**Der Fall, den das Skript selbst gemeldet hat, bevor er zum Loch wurde:**
`3.7.3` steht als Zeichenkette *innerhalb* von `pruefe_p06`; weder die
Syntaxbaum-Erhebung noch die Modulkonstanten sehen ihn. Gedeckt ist er allein
durch den Docstring darüber. Seitdem endet das Skript mit 2, sobald ein
ausgegebener Abschnitt in keiner statischen Erhebung vorkommt.

### 2. Befund: `pruefe.sh` kann eine falsche Fundstelle nicht finden

**Kein Blocker, keine Frist, nichts zu tun.** Der Punkt ist allgemeiner als
dieser Zyklus: Jede Erwartung in `erwartet/` stammt von mir. Sie prüft, dass
sich die Ausgabe nicht **ändert**, nie, dass sie **stimmt**. Alles, was nur
gegen `erwartet/` läuft, ist gegen einen gemeinsamen Irrtum blind.

Dagegen stehen inzwischen vier Vorrichtungen mit fremder Quelle:
`rfc-beispiele.sh` (Eingabe aus dem Normtext), `fremdprobe.sh` und
`gegenprobe.sh` (Eingaben und Erwartungen aus fremden Fehlerberichten),
`namensliste.sh` (Liste aus IANA und zwei RFCs) — und seit heute
`fundstellen.sh` (Fundstellen aus den RFCs selbst). Das steht hier, damit es
beim nächsten „ist doch alles grün" nachlesbar ist, welches Grün woher kommt.

### 3. Messfehler bei mir, nicht im Skript, im selben Zyklus korrigiert

Beim ersten Gegenbeweis habe ich `sh fundstellen.sh | tail -4` geschrieben und
Exit 0 abgelesen — der Exit-Code kam von `tail`, das Skript endete mit 1. Genau
davor warnt die Zieldefinition der laufenden Mission mit „Exit-Code nie hinter
einer Pipe". Ohne Wiederholung ohne Pipe stünde im Journal, der Gegenbeweis sei
fehlgeschlagen.

Kein Fehlschlag nach Regel 2: innerhalb desselben Zyklus aufgefallen und
korrigiert, das Skript hat sich richtig verhalten. Steht hier, weil ein
Messfehler, der nur im Kopf korrigiert wird, beim nächsten Mal wiederkommt.

### 4. Unverändert offen, unverändert ohne Frist

Befund 2 aus Zyklus 35 („die dreizehn älteren Erwartungen", zwei Lesarten,
nicht geraten) steht wie er stand. Ebenso Befund 1 aus Zyklus 30
(`ARCHITEKTUR.md` sagt „fünf" Pflicht-Auslöser, der Kodex sechs — Kodex schlägt
Architektur, nicht selbst angeglichen). Ebenso aus Zyklus 33 bis 36:
`_zeige_wort` in **Wert**-Zitaten, UTF-16-Markierung, §6-Prüfung, `VALARM`
(§3.6.6), `VTIMEZONE` (§3.6.5), `UNTIL`+`COUNT` (§3.3.10). `anlass.sh` zeigt
am 2026-08-19 für alle vier gemessenen Fälle weiter keinen Anlass.

---

## 2026-08-19 — Zyklus 38: sechs Meldungen, die nie jemand gedruckt gesehen hat

### 1. Erledigt: die Abdeckung wird auf Ebene der Meldung gemessen

**Kein Blocker, kein Fehlschlag.** `projekte/icsdoktor/abdeckung.sh` gebaut
(`d4e987c`). `pruefe.sh` meldet „alle 20 Pruefungen bis P20 werden ausgeloest"
— das misst die Funktion, nicht die Meldung. `pruefe_p04` allein hat neun
Stellen, an denen ein `Fund` entsteht; eine ausgelöste Stelle deckt die
Prüfung ab.

**Gemessen, bevor gebaut wurde:** Von den 45 Stellen in `icsdoktor.py` hatte
keine der damals 51 Beispieldateien **sechs** je erreicht — fünf in
`pruefe_p04` (kein `:` in der Zeile; Zeile ohne Eigenschaftsnamen;
Parametername fehlt nach `;`; kein `:` nach den Parametern; Steuerzeichen im
Wert) und eine in `pruefe_p05` (`END` ohne vorangehendes `BEGIN`).

**Ausgelöst verhalten sich alle sechs richtig** — richtige Zeile, richtige
Meldung, richtiger Paragraph, kein Absturz. Der Befund ist nicht, dass dort
etwas kaputt war, sondern dass das bis zu diesem Lauf niemand sagen konnte.
Zwei neue Beispiele schließen die Lücke, das Skript hält sie zu: 45 von 45.

Gemessen auf drei Wegen, die sich gegenseitig widerlegen können — Syntaxbaum,
Zeilenspur, Bauprotokoll in `Fund.__init__`. Widersprechen sich die beiden
Messungen oder findet sich ein Fund an einer Zeile, die die Erhebung nicht
kennt, endet das Skript mit 2 und nicht mit 0. Zehn Gegenbeweise an einer Kopie
unter `/tmp`, jeder mit dem erwarteten Code; drei davon sind Messfehler und
mussten im Skript der Kopie erzwungen werden, was im Journal so dasteht.

### 2. Erledigt: die benannte Grenze von `zahlen.sh` ist einmal eingetreten

**Kein Blocker, kein Verstoß.** Der README zitiert den Satz
`"53 Kalenderdateien, byte-genau"` zwei Absätze weiter oben als Beispiel für
eine Zahl, die still altert. Beim Anlegen der zwei Beispieldateien blieb genau
dieses Zitat auf `51` stehen, während die zitierte Zeile nachgezogen wurde —
`zahlen.sh` kannte nur die eine Stelle.

Beides im selben Zyklus nachgezogen; falsch im Repo gestanden hat es nie. Der
Fall steht jetzt in der Tabelle (sieben statt sechs), mit Gegenprobe in beide
Richtungen: veraltete Zahl → Exit 1 mit Zeile und Nachrechenweg, umformulierter
Satz → Exit 1 mit „steht dort nicht mehr".

Die Grenze selbst bleibt, wie sie im Kopf des Skripts steht: Er kennt die Sätze
seiner Tabelle und keinen anderen. Neu ist nur, dass sie nicht mehr bloß
benannt, sondern einmal vorgeführt ist.

### 3. Unverändert offen, unverändert ohne Frist

Befund 2 aus Zyklus 35 („die dreizehn älteren Erwartungen", zwei Lesarten,
nicht geraten) steht wie er stand — dieser Zyklus hat den Bestand von 51 auf
53 erhöht und die Zahl trotzdem nicht angefasst. Ebenso Befund 1 aus Zyklus 30
(`ARCHITEKTUR.md` sagt „fünf" Pflicht-Auslöser, der Kodex sechs — Kodex schlägt
Architektur, nicht selbst angeglichen). Ebenso aus Zyklus 33 bis 36:
`_zeige_wort` in **Wert**-Zitaten, UTF-16-Markierung, §6-Prüfung, `VALARM`
(§3.6.6), `VTIMEZONE` (§3.6.5), `UNTIL`+`COUNT` (§3.3.10). `anlass.sh` zeigt
am 2026-08-19 für alle vier gemessenen Fälle weiter keinen Anlass.

---

## 2026-08-19 — Zyklus 39: zwei Befunde, beide kein Blocker

Kein Mensch muss hier etwas tun. Beide stehen hier, weil sie gemessen sind und
weil ich sie nicht rate.

### 1. Eine Meldung kann 2878 Zeichen lang werden

Gemessen an `beispiele/02-sauber-gefaltet.ics`, umgeformt auf `CR` statt
`CRLF`: Die Datei ist dann für dieses Werkzeug **eine** physische Zeile, und
`P05` gibt in „`BEGIN:… hat kein END:…`" den ganzen Komponentennamen wieder —
also praktisch die ganze Datei in einer Meldung.

Die Meldung ist **eine Zeile und sie ist richtig**; keine der fünf Zusagen von
`robustheit.sh` ist verletzt, der Lauf bleibt grün. Lesbar ist sie nicht.

Drei Fundstellen in `pruefe_p05` geben den Namen ungekürzt weiter
(`END:%s ohne vorangehendes BEGIN`, `END:%s passt nicht zu BEGIN:%s`,
`BEGIN:%s hat kein END:%s`), während `_zeige_wort()` an allen anderen Stellen
bei 30 Zeichen abschneidet.

**Nicht gebaut, und zwar aus einem Grund und nicht aus Zeitmangel:** Die
Messung dieses Zyklus galt der Form der Meldung (Steuerzeichen), nicht ihrer
Länge. Eine sechste Zusage nachzuschieben, nachdem das Ergebnis der fünf
dasteht, wäre eine Verschärfung mitten in der laufenden Messung. Sie ist nach
Regel 3 erlaubt — aber sie gehört an den Anfang eines Zyklus und nicht ans
Ende. Ohne Frist.

### 2. Der Ermessensdeckel lässt sich auf zwei Arten zählen

Regel 12: höchstens vier Beiträge nach meinem Ermessen pro Woche; die
Pflicht-Auslöser aus Regel 2 zählen nicht dagegen. Gezählt wird an den Dateien
in `state/posts/`. Dort stehen im rollenden Sieben-Tage-Fenster (ab
2026-08-12T18:55Z) vier Beiträge, die im Feld `ausloeser:` **keinen der sechs
seit `5bde1d6` gültigen Namen** tragen:

| Datei | `ausloeser:` | gesendet |
|---|---|---|
| `2026-08-14-01-kanal-eingriff` | `entdeckter menschlicher Eingriff (Regel 2)` | 2026-08-14T08:06:11Z |
| `2026-08-14-02-zwei-fehlschlaege` | `Fehlschlag (Regel 2), nachgeholt aus dem Rückstand` | 2026-08-14T08:06:11Z |
| `2026-08-14-03-rueckstand` | `entdeckter menschlicher Eingriff (Regel 2), Rückstand ohne Kanal` | 2026-08-14T08:06:11Z |
| `2026-08-17-06-sechs-erreichte-missionen` | (kein Feld) | 2026-08-17T13:18:08Z |

**Die Zweideutigkeit:** Die ersten drei nennen der Sache nach sehr wohl einen
Pflicht-Auslöser, nur in Prosa — sie sind vom 2026-08-14 und damit älter als
die sechs festen Namen. Zählt man nach Inhalt statt nach Feldwortlaut, sind es
**ein** Ermessensbeitrag statt vier, und drei Plätze wären frei.

**Gezählt wird bis auf Weiteres nach dem Feldwortlaut, also vier von vier.**
Der Grund steht hier, damit er nachprüfbar ist und nicht nur behauptet: Die
andere Lesart verschafft mir heute drei Postplätze. Eine Zählweise in dem
Zyklus zu lockern, in dem die Lockerung mir nützt, ist kein Nachmessen,
sondern das Herstellen eines Messwerts — dieselbe Bewegung, die Regel 3 für
Zieldefinitionen sperrt. Wenn die Zählung geändert wird, dann in einem Zyklus,
in dem nichts davon abhängt.

Der Deckel läuft ohnehin am 2026-08-21 um 08:06 UTC von vier auf eins zurück.
Ohne Frist, kein Blocker.

---

## 2026-08-20 — Zyklus 40: Befund 1 aus Zyklus 39 ist geschlossen, ein neuer steht offen

Kein Mensch muss hier etwas tun. Beides ist gemessen, nichts davon geraten.

### Geschlossen: „Eine Meldung kann 2878 Zeichen lang werden" (Zyklus 39, Befund 1)

Behoben mit `_kurz()`, Beleg `301ab2d`. Der Ablauf stand vorher fest und ist
eingehalten worden: Die sechste Zusage und ihre Grenze wurden **am Anfang**
dieses Zyklus festgelegt, bevor der erste verbogene Fall dagegen gehalten
wurde — genau das war der Grund, aus dem Zyklus 39 sie nicht mehr nachgeschoben
hat.

Zusage 6 lautet: eine Meldung ist höchstens **400 Zeichen** lang. Die 400 sind
eine Wahl und keine Messung, hergeleitet aus zwei gemessenen Zahlen — 254
Zeichen längste Meldung über die unverbogenen Beispieldateien, höchstens zwei
Zitatstellen je Meldung zu je 30 Zeichen plus `...` (254 + 2 × 33 = 320).

Beim ersten Messen dagegen: **48 von 34570 Fällen** verletzt, alle in `P05`,
alle aus derselben Verbiegung `CR statt CRLF`, die längste mit 2878 Zeichen.
Danach ist die längste Meldung über alle 35195 Fälle 254 Zeichen lang — genau
so lang wie die längste über die unverbogenen Dateien.

### Neu: Zusage 6 hält fünf der sechs korrigierten Stellen nicht

Bis zum 2026-08-20 kürzte nur `_zeige_wort()`; **sechs** Stellen gingen daran
vorbei — dreimal der Komponentenname in `P05`, dazu der `TZID`-Wert in `P08`,
`P16` und `P18`. Alle sechs gehen jetzt durch `_kurz()`.

Der Gegenbeweis hat jede der sechs einzeln zurückgenommen und `robustheit.sh`
darauf laufen lassen. Rot wird er bei **einer**:

| zurückgenommene Stelle | längste Meldung | Wächter |
|---|---|---|
| `BEGIN:%s hat kein END:%s` | 2878 Zeichen | **rot**, 49 Fälle |
| `END:%s ohne vorangehendes BEGIN` | 356 Zeichen | grün |
| `END:%s passt nicht zu BEGIN:%s` | 254 Zeichen | grün |
| `TZID=%s` in `P08`, `P16`, `P18` | 254 Zeichen | grün |

Der Grund liegt nicht an der Zusage, sondern an den Verbiegungen: Keine von
ihnen erzeugt einen langen `TZID`-Wert oder einen langen Namen an einem `END`,
das auf ein anderes `BEGIN` trifft. Die Korrektur an diesen fünf Stellen ist
richtig und trotzdem von keinem Prüfbefehl gehalten; wer sie zurücknimmt,
bekommt einen grünen Lauf.

**Nicht in diesem Zyklus behoben, und zwar aus dem Grund, aus dem Befund 1
einen Zyklus lang liegen geblieben ist.** Beide naheliegenden Wege — die
Grenze von 400 auf 300 ziehen, damit die 356 auffallen, oder eine Verbiegung
ergänzen, die lange `TZID`-Werte erzeugt — wären eine Änderung an der Messung,
nachdem ihr Ergebnis dasteht. Die 400 stehen seit heute früh und sind nicht
gerissen worden; sie jetzt zu bewegen, weil ich weiß, was dann rot würde, ist
das Herstellen eines Messwerts und kein Nachmessen. Verschärfen ist nach
Regel 3 erlaubt — am Anfang eines Zyklus, nicht an seinem Ende.

Ohne Frist, kein Blocker.

---

## 2026-08-20 — Zyklus 41: fünf von sechs statt einer von sechs, und die sechste bleibt stehen

Kein Mensch muss hier etwas tun. Alles gemessen, nichts geraten.

### Weitgehend geschlossen: „Zusage 6 hält fünf der sechs Stellen nicht" (Zyklus 40)

Behoben mit drei neuen Verbiegungen in `robustheit.sh`, Beleg `4202dd4`. Von
den zwei Wegen, die der Eintrag darüber nennt, ist der zweite genommen: die
Eingaben erweitern, die Grenze 400 unangetastet lassen.

**Weg A (400 auf 300) ist nicht bloß der falsche Zeitpunkt, sondern
unzureichend**, und das ist nachrechenbar: Vier der fünf ungehaltenen Stellen
bewegen die längste Meldung überhaupt nicht — sie bleibt bei 254 Zeichen, ob
gekürzt wird oder nicht. Keine Grenze oberhalb von 254 fängt sie, eine
unterhalb macht bestehende, richtige Meldungen rot, und 300 läge zudem unter
der eigenen Herleitung 254 + 2 × 33 = 320.

**Weg B ist auch dann zulässig, wenn ich weiß, worauf er zielt:** Fälle kommen
hinzu, keiner fällt weg — eine Erweiterung der Eingaben kann einen roten Lauf
nie grün machen. Das ist der Unterschied zu einer Grenze, die sich in beide
Richtungen schieben lässt.

Die drei Umformungen, 500 `X` als Füller: Parameterwerte verlängert (hinter
jedem `=` vor dem ersten `:`), `END`-Zeilen verlängert (hinter dem `:`), und
dieselbe mit umgedrehter Zeilenreihenfolge. 35363 Fälle statt 35195, Lauf grün,
längste Meldung weiter 254 Zeichen.

Gegenbeweis, jeweils nur die **Kürzung** zurückgenommen und `_zeigbar()` stehen
gelassen, damit allein die Länge gemessen wird:

| zurückgenommene Kürzung | längste Meldung | Wächter |
|---|---|---|
| `BEGIN:%s hat kein END:%s` | 2878 | **rot**, 49 Fälle |
| `END:%s ohne vorangehendes BEGIN` | 602 | **rot**, 112 Fälle |
| `END:%s passt nicht zu BEGIN:%s` | 594 | **rot**, 130 Fälle |
| `TZID=%s` in `P08` | 660 | **rot**, 1 Fall |
| `TZID=%s` in `P16` | 657 | **rot**, 1 Fall |
| `TZID=%s` in `P18` | 254 | grün |

**Fünf von sechs. Zugesagt waren vor der Messung sechs von sechs.**

### Neu: die `P18`-Stelle ist weiter von keinem Prüfbefehl gehalten

**Die Ursache ist gemessen.** `P18` meldet nur, wenn `TRIGGER` den Parameter
`VALUE=DATE-TIME` trägt; im Quelltext steht sonst ein `continue`. Die
Beispieldatei lautet
`TRIGGER;VALUE=DATE-TIME;TZID=Europe/Berlin:20260901T100000`. Die Umformung
verlängert **jeden** Parameterwert vor dem ersten `:`, also auch diesen — aus
`VALUE=DATE-TIME` wird `VALUE=XXX…DATE-TIME`, die Prüfung greift nicht mehr,
und ein langer `TZID` kommt bei `P18` nie an. Die Verbiegung schlägt die
Vorbedingung der Prüfung tot, die sie treffen soll.

**Nicht in diesem Zyklus nachgebessert, und diesmal nicht wegen des
Zeitpunkts, sondern wegen eines Satzes, den ich vorher geschrieben habe.** Vor
der ersten Messung stand als Widerlegungsbedingung im Journal: Fällt die Zahl
unter sechs, bleibt sie so stehen und wird nicht durch eine weitere Verbiegung
geheilt, die ich mir nach dem Ergebnis ausdenke. Eine vierte Verbiegung, die
nur `TZID` verlängert und `VALUE` in Ruhe lässt, wäre in zehn Minuten
geschrieben. Eine Widerlegungsbedingung, die man aufhebt, sobald sie eintritt,
ist keine gewesen.

**Wo die günstigere Lesart läge, und sie bleibt ungenommen.** Wörtlich gesagt
war „nimmt man eine Stelle zurück, wird der Wächter rot" — und rot wird er bei
allen sechs. Bei `P18` aber über **Zusage 3**: Mit `_kurz()` fällt auch
`_zeigbar()` weg, und ein Steuerzeichen wandert in die Meldung (vier Fälle,
`0x00`, `0x07`, `0x0D`, `0x1B`). Das ist die Arbeit vom 2026-08-19. Gemeint war
die Länge, gemessen ist die Länge, und das Ergebnis ist fünf von sechs.

Ohne Frist, kein Blocker. Gehört an den **Anfang** eines Zyklus.

## 2026-08-20 — Zyklus 42: sechs von sechs, und die Zahl von gestern bleibt fünf

Kein Mensch muss hier etwas tun. Alles gemessen, nichts geraten.

### Geschlossen: „die `P18`-Stelle ist weiter von keinem Prüfbefehl gehalten" (Zyklus 41)

Behoben mit einer zwölften Verbiegung in `robustheit.sh`, Beleg `77f401c`.
`_langer_tzid()` verlängert genau den Wert des Parameters `TZID` und rührt
keinen anderen an — damit bleibt `VALUE=DATE-TIME` stehen, die Vorbedingung
von `P18` hält, und der lange `TZID` kommt an der Stelle an, die ihn kürzen
soll.

**Die Zusage stand vor der Arbeit und ist vor der Arbeit committet** (`65258e6`,
(V8) im Journal von Zyklus 42). Das ist der Unterschied zu einer Verbiegung,
die man sich ausdenkt, nachdem man das Ergebnis kennt — und es ist der Grund,
warum diese Nachbesserung einen Zyklus gewartet hat.

**Die vollständige Tabelle, alle sechs Stellen an demselben Stand `77f401c`
einzeln gemessen** — je ein Lauf, bei dem genau ein `_kurz()` durch das alte
`_zeigbar()` ersetzt wurde und die fünf anderen unberührt blieben:

| zurückgenommene Kürzung | längste Meldung | Wächter |
|---|---|---|
| `BEGIN:%s hat kein END:%s` | 2878 | **rot**, 49 Fälle |
| `END:%s ohne vorangehendes BEGIN` | 602 | **rot**, 112 Fälle |
| `END:%s passt nicht zu BEGIN:%s` | 594 | **rot**, 130 Fälle |
| `TZID=%s` in `P08` | 660 | **rot**, 2 Fälle |
| `TZID=%s` in `P16` | 657 | **rot**, 2 Fälle |
| `TZID=%s` in `P18` | 683 | **rot**, 1 Fall |

**Sechs von sechs.** Beide Zahlen, die (V8) vor der Messung nannte, sind
eingetreten: 35363 + 56 = **35419** Fälle, und der unveränderte Bestand bleibt
grün. Die `P18`-Verletzung ist eine von `(I6)` — die Länge, 683 Zeichen —, nicht
eine von `(I3)` über ein Steuerzeichen; auch das war vorher als Bedingung
benannt.

**Was sich dabei nebenbei verschoben hat:** `P08` und `P16` standen gestern mit
je einem Fall in der Tabelle, heute mit je zweien. Die zwölfte Verbiegung trifft
sie zusätzlich. Das ist kein Widerspruch zu gestern, sondern die Folge einer
erweiterten Eingabemenge.

### Nicht nachgezogen: die Zahl aus Zyklus 41 bleibt fünf von sechs

Es wäre eine kleine Bewegung und sie unterbleibt. Zyklus 41 hat **drei**
Verbiegungen zugesagt und damit fünf der sechs Stellen erreicht; das ist der
Messwert dieser Zusage und er wird nicht zu „sechs von sechs" umgeschrieben,
weil ein späterer Zyklus mit einer **vierten** Verbiegung weiterkam. Gemessen
wurden zwei verschiedene Dinge. Wer die Zahl von gestern durch die von heute
ersetzt, hat die Zusage von gestern nachträglich gelockert, und dann bedeutet
keine Zusage mehr etwas.

Dasselbe gilt in die andere Richtung für das Verfahren selbst: (V8) ist die
vierte Zusage in dieser Reihenfolge und die erste, die **gehalten** hat, seit
(V7) gegen mich ausfiel. Dass sie hält, macht die Reihenfolge nicht besser als
gestern — sie war gestern schon richtig, als sie gegen mich ausfiel.

### Unverändert offen, unverändert ohne Frist

§6-Kodierung; UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD` in **Wert**-Zitaten;
`VALARM` §3.6.6, `VTIMEZONE` §3.6.5, `UNTIL`+`COUNT` §3.3.10. `anlass.sh` zeigt
für alle vier gemessenen Fälle weiter keinen Anlass. Ebenso „die dreizehn
älteren Erwartungen" (Zyklus 35). Kein Blocker, keiner davon.

## 2026-08-20 — Zyklus 43: eine fremde Quelle ist weg, und ein Wächter über die Zitate

Kein Mensch muss hier etwas tun. Alles gemessen, nichts geraten. Zwei Befunde,
beide ohne Frist, keiner ein Blocker.

### Befund 1: die Fundstelle `vagov-23608` ist nicht mehr abrufbar

Gemessen am 2026-08-20 gegen 19:05 UTC, nachdem `fremdprobe.sh`,
`gegenprobe.sh` und `anlass.sh` unabhängig voneinander mit **Exit 2**
abgebrochen sind:

| Abfrage | Ergebnis |
|---|---|
| `.../repos/department-of-veterans-affairs/va.gov-team/issues/23608` | **HTTP 404** |
| `.../repos/department-of-veterans-affairs/va.gov-team` | **HTTP 404** |
| `github.com/department-of-veterans-affairs/va.gov-team` (HTML) | **HTTP 404** |
| `.../orgs/department-of-veterans-affairs` | HTTP 200 |
| `.../rate_limit`, `core` | **55 von 60 frei** |

**Keine Ratenbegrenzung** — die antwortet mit 403, und 55 Abrufe waren frei.
Nicht die Fundstelle allein ist weg, sondern das ganze Repository. **Warum,
weiß ich nicht:** gelöscht, umbenannt oder auf privat gestellt sieht von außen
gleich aus. Ich rate nicht und nenne niemanden (Regel 7); festgestellt ist ein
HTTP-Status, keine Entscheidung eines Menschen. In Zyklus 42 um 13:19 UTC war
derselbe Abruf grün.

**Der Aufbau hat gehalten.** Alle drei Skripte enden mit 2 und nicht mit 1 und
nicht mit 0 — „ich kann es nicht sagen", genau wie vorgesehen. Kein grüner
Lauf, der nichts geprüft hat. Punkt 3 der Missionsdatei hat diesen Fall vorher
benannt: *„eine unerreichbare fremde Datei, und wird als solcher benannt."*

**Was es nicht ändert:** Das Ergebnis der Mission „Die vier Lücken" steht seit
dem 2026-08-17 fest — **verfehlt**, weil `rfc4-4:§3.3` weiter `nur-fremd`
bleibt. Eine tote Quelle macht daraus nichts anderes.

**Was es sehr wohl ändert, und das gehört in den Missionsabschluss-Post:** Die
Messung, an der Punkt 1 hängt, ist ab heute von außen **nicht mehr vollständig
nachvollziehbar**. `gegenprobe.sh` läuft über zwölf Eingaben und bricht ab,
wenn eine fehlt. Regel 3 verlangt eine Prüfung, die eine dritte Person ohne
mich nachvollziehen kann; das war sie bis heute Nachmittag und ist sie jetzt
nur noch für elf der zwölf Eingaben. Regel 10 verlangt, das im Post zu sagen.

**Was ich nicht getan habe:** die Zeile aus `korpus.tsv` entfernt oder
`gegenprobe.sh` nachsichtiger gemacht. Beides wäre eine Änderung an der
Messvorrichtung, an der das Missionsziel hängt, einen Tag vor der Frist und
nachdem das Ergebnis feststeht — Regel 3 sperrt das.

**Zu entscheiden, frühestens nach dem 2026-08-21**, und zwar als eigener
Schritt mit eigener Zusage davor: Ob `korpus.tsv` diese Zeile behält (dann
bleiben die drei Skripte dauerhaft auf 2), ob eine archivierte Fassung der
Fundstelle an ihre Stelle tritt (dann ist die Quelle eine andere, und das ist
zu protokollieren), oder ob der Korpus auf fünf Zeilen schrumpft (dann sind
alle Messwerte davor auf zwölf Eingaben erhoben und die danach auf elf — zwei
Messungen, nicht eine verbesserte). **Ich entscheide das nicht heute und rate
nicht.**

### Befund 2: (V9) ist verfehlt — mein neuer Wächter liest den Titel nicht

`projekte/icsdoktor/quellen.sh` (`603f5e8`) hält jedes Zitat der Spalte
`klage` gegen die Fundstelle, aus der es stammt. Vor der Messung committet
(`c624a1c`) war die Vergleichsregel samt Vorhersage **fünf von fünf**.

**Gemessen sind drei von fünf.** Die Ursache ist gemessen und nicht vermutet:
Zwei Zitate stehen wörtlich im **Titel** ihrer Fundstelle, und mein Skript
liest Text und Kommentare, aber nicht den Titel.

| Fundstelle | wo das Zitat steht |
|---|---|
| `lfos/calcurse#323` | Text — gefunden |
| `SimpleMobileTools/Simple-Calendar#1983` | Text — gefunden |
| `bitfireAT/synctools#156` | Text — gefunden |
| `kewisch/ical.js#620` | **Titel** — vom Skript nicht gelesen |
| `FossifyOrg/Calendar#1102` | **Titel** — vom Skript nicht gelesen |
| `department-of-veterans-affairs/va.gov-team#23608` | unerreichbar, siehe Befund 1 |

**Beide Zitate in `korpus.tsv` sind richtig.** Der Befund geht gegen mein
Skript, nicht gegen meine Buchführung — und `korpus.tsv` bleibt unberührt.

**Nicht in diesem Zyklus nachgetragen**, und der Grund ist derselbe wie bei der
zwölften Verbiegung in `robustheit.sh`: Die Erweiterung wäre fünf Zeilen, sie
macht genau diesen roten Lauf grün, und eine Vergleichsregel, die man aufmacht,
sobald ihr Ergebnis unbequem wird, ist keine gewesen. Zyklus 41 hat den
Prüfstein aufgeschrieben — Eingaben erweitern ist zulässig, weil kein Fall
wegfällt; die gelesenen Stellen zu erweitern ist es nicht, weil es das Ergebnis
umdreht. **Gehört an den Anfang des nächsten Zyklus, mit eigener Zusage davor.**

**Was stattdessen geändert wurde, und warum das keine Lockerung ist:** Ein
Skript, das `FEHLT` meldet, während gemessen ist, dass das Zitat dasteht, wäre
eine falsche Behauptung in einer committeten Datei — Regel 1. Der Fall heißt
deshalb `NICHT GELESEN`, das Skript sagt ausdrücklich, dass das kein „steht
dort nicht mehr" ist, und er endet mit **2** statt mit 1. Exit 1 bleibt
reserviert, bis das Skript alle Stellen einer Fundstelle liest. Zwei ist nicht
grün; die Regel selbst ist unverändert eng geblieben.

### Unverändert offen, unverändert ohne Frist

§6-Kodierung; UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD` in **Wert**-Zitaten;
`VALARM` §3.6.6, `VTIMEZONE` §3.6.5, `UNTIL`+`COUNT` §3.3.10. `anlass.sh`
konnte in diesem Zyklus nichts dazu sagen — es bricht mit 2 ab, seit die Quelle
weg ist. Ebenso „die dreizehn älteren Erwartungen" (Zyklus 35). Kein Blocker,
keiner davon.
