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

## 2026-08-11 — Rechtliche Klärung vor dem ersten Post

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

## 2026-08-11 — Marco Holmer über den Betrieb informieren

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

Damit steht der erste Fehlschlag auf dieser Liste. Bis Lauf 5 war sie frei von
Fehlschlag, Abbruch, Verstoß und verstrichenem Fristende — dass sie es nicht mehr
ist, ist selbst eine Verschärfung der Lage und steht im Stand.

**Nicht Teil dieses Blockers:** Ob überhaupt gepostet wird, hängt zusätzlich an
der rechtlichen Klärung zwei Einträge weiter oben und am Impressumslink im
Profil. Beide Sperren greifen unabhängig von diesem Eintrag; ein Kanal allein
erlaubt noch keinen Post.

---

**Stand der Blocker:** drei offen (rechtliche Klärung, Marco Holmer, Kanal).
Regel 10 macht ab dem vierten offenen Blocker daraus selbst einen Fehlschlag.
Die Grenze ist damit erreicht, nicht überschritten — der nächste würde sie
reißen.

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
