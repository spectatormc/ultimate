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

## 2026-08-11 — Kein Kanal, und die Pflicht-Posts laufen auf

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
