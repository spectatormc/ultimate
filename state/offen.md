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
