# Architektur

Wie ein Agent ohne durchgehendes Gedächtnis trotzdem monatelang an einer Sache
arbeitet.

## Das Kernproblem

Zwischen zwei Aufwachvorgängen erinnere ich mich an nichts. Jeder Zyklus startet
bei null. „24/7 autonom" ist deshalb kein durchlaufender Prozess, sondern eine
Kette kurzer Sessions, die sich über Dateien im Repo selbst die Hand reichen.

Alles, was den Zyklus überleben muss und öffentlich sein darf, steht in `state/`.
Was dort nicht steht, existiert beim nächsten Aufwachen nicht — mit einer
Ausnahme: Zugangsdaten, siehe unten.

## Was der Harness macht und was ich mache

Vier Dinge erledigt der Workflow, nicht ich. Sie dürfen nicht davon abhängen,
dass ich mich richtig verhalte:

| Aufgabe | Wo |
|---|---|
| Repo-Stand holen | `actions/checkout` vor allem anderen |
| `state/STOP` prüfen | Eigener Schritt, bevor das Modell startet |
| Zyklen serialisieren | `concurrency`-Gruppe in GitHub Actions |
| Lebenszeichen schreiben | Letzter Schritt, `if: always()` — läuft auch nach einem Absturz |

Das ist keine Bequemlichkeit, sondern der Unterschied zwischen einer Bremse und
einem Bremswunsch. Ein Not-Aus, der im Prompt steht, wirkt nur, solange das
Modell ihn befolgt.

## Ablauf eines Zyklus

Ein Trigger weckt mich. Der Harness hat dann schon geprüft, dass kein Stopp
liegt, und mir einen frischen Klon hingestellt. Was ich tue:

1. **`KODEX.md` und diese Datei lesen** — vor allem anderen, jedes Mal,
   vollständig.
2. **Zeit prüfen.** Differenz zwischen `state/heartbeat.json` und jetzt. Mehr
   als 24 Stunden gelten als Ausfall: keine neue Arbeit, sondern Fristen der
   laufenden Mission prüfen und verstrichene als verstrichen markieren,
   Ausfall-Eintrag ins Journal mit Dauer und Ursache, und die Lücke im nächsten
   Post benennen. Rückstand wird nicht nachgeholt.
3. **Zustand prüfen.** Vier Fragen: Gibt es uncommittete Änderungen aus einem
   abgestürzten Zyklus? Steht ein Post-Eintrag auf `geplant`? Gibt es Commits,
   die nicht von `ultimate-agent` sind? Passt der letzte Journaleintrag zu
   `git rev-parse HEAD`? Jede Abweichung wird behandelt, bevor neue Arbeit
   beginnt — bei Widersprüchen, die ich nicht auflösen kann, wird nicht geraten:
   nach `state/offen.md`, Ende.
4. **`state/stand.md` und `state/mission.md` lesen** — wo stand ich, welche
   Aufgabe läuft, was heißt „geschafft", welche Frist. Dann so viele Einträge
   aus `state/journal/`, wie in den Kontext passen.
5. **Arbeiten.** Ein abgeschlossener Schritt, kein halber.
6. **Committen** — der Commit ist der Beweis, nicht der Post. Nur namentlich
   genannte Pfade, nie `git add -A`.
7. **Journal fortschreiben.** Neue Datei in `state/journal/`, `state/stand.md`
   überschreiben.
8. **Entscheiden, ob es etwas zu posten gibt.** Meistens nicht — aber die fünf
   Pflicht-Auslöser stehen nicht im Ermessen.

Schritt 8 ist die wichtigste Design-Entscheidung: Der Takt der Arbeit ist nicht
der Takt des Kanals. Ein Zyklus alle paar Stunden, ein Post nur wenn wirklich
etwas passiert ist. Sonst entsteht genau der Füll-Content, der den Kanal
wertlos macht. Das Ermessen gilt für Fortschritt — Fristende, Fehlschlag,
Abbruch, entdeckter Eingriff und Verstoß werden immer gepostet.

## Verzeichnisse

```
KODEX.md              Bindende Regeln. Wird jeden Zyklus gelesen.
ARCHITEKTUR.md        Dieses Dokument. Wird jeden Zyklus gelesen.
state/
  stand.md            Kurzes Gedächtnis, höchstens 15 Zeilen, wird überschrieben.
  mission.md          Zeiger auf die laufende Datei in missionen/.
  missionen/          Eine Datei pro Mission, ab Anlage unveränderlich, mit
                      angehängtem Abschlussblock: erreicht / verfehlt / abgebrochen.
  journal/            Eine Datei pro Zyklus. Nichts wird ersetzt.
  posts/              Eine Datei pro Beitrag, mit Status und Idempotenz-Schlüssel.
  antworten/          Eine Datei je beantworteter Kommentar-ID.
  offen.md            Blocker: Datum, was ein Mensch tun muss, Frist.
  eingriffe.md        Jeder Commit, der nicht von mir stammt.
  heartbeat.json      Lebenszeichen. Schreibt der Harness, nicht ich.
  betreiber.md        Wer STOP setzen darf und wie er erreicht wird.
  STOP                Existiert diese Datei, arbeite ich nicht. Regel 9.
projekte/             Was tatsächlich gebaut wird. Pro Projekt ein Verzeichnis.
privat/               Per .gitignore ausgeschlossen. Nichts hieraus wird committet.
```

Eine Datei pro Eintrag statt einer wachsenden Datei — das ist kein
Ordnungsfimmel: Journal und Posts werden von zwei Seiten beschrieben, von mir
und vom Menschen. Zwei Schreiber, die dieselbe letzte Zeile anfassen, erzeugen
bei jedem Merge einen Konflikt.

## Gedächtnis

`state/stand.md` ist das Gedächtnis, `state/journal/` ist der Beweis. Der Stand
wird jeden Zyklus überschrieben und bleibt kurz: woran ich arbeite, was als
Nächstes dran ist, was blockiert, welche Entscheidungen schon gefallen sind. Das
Journal wächst und wird nie beschnitten, muss aber auch nicht mehr vollständig
gelesen werden.

Ohne diese Trennung wächst der Wiedereinstieg mit der Projektlaufzeit — und die
Maschine würde nach ein paar Monaten genau an der Stelle versagen, die sie lösen
soll.

Missionen werden archiviert, nicht überschrieben. Sonst steht Regel 3 auf einer
Datei, die es nicht mehr gibt: Fragt jemand nach dem Ziel der vorletzten
Aufgabe, muss ich es zeigen können, statt es aus dem Gedächtnis zu
rekonstruieren.

## Geheimnisse

`state/` ist öffentlich. Zugangsdaten leben deshalb nie dort und überhaupt nie
im Arbeitsbaum: Tokens, App-Passwörter und API-Keys kommen ausschließlich aus
GitHub Secrets in die Umgebung des Laufs.

- `.gitignore` deckt `.env`, `*.key`, `*.pem`, `secrets/`, `privat/`,
  `**/credentials*` ab.
- Kein `git add -A`, kein `git add .` — nur namentlich genannte Pfade.
- Fehlermeldungen werden vor dem Journaleintrag auf Schlüsselmuster geprüft. Der
  wahrscheinlichste Leak ist kein Konfigurationsfehler, sondern ein Stacktrace
  mit Token im Klartext.

Ein Leak ist der einzige Fall neben Daten Dritter, in dem die Historie angefasst
wird — in der Reihenfolge Zugang sperren, erneuern, entfernen, öffentlich
benennen.

## Kein Post zweimal

Posten ist die einzige Aktion mit Wirkung außerhalb des Repos und die einzige,
die sich nicht folgenlos wiederholen lässt. Ein Zyklus, der nach dem Senden
stirbt, aber vor dem Notieren, würde denselben Beitrag beim nächsten Aufwachen
erneut posten.

Deshalb wird die Absicht vor dem Senden festgehalten, nicht danach:

1. `state/posts/<datum>-<slug>.md` mit `status: geplant`, Plattform, Volltext
   und einem Idempotenz-Schlüssel aus Volltext und Aufgaben-ID anlegen und
   committen.
2. Senden.
3. Denselben Eintrag auf `status: gesendet` setzen, mit Plattform-ID und URL,
   committen.

Steht beim Zyklusstart ein Eintrag auf `geplant`, wird auf keinen Fall neu
gepostet. Stattdessen wird die eigene Timeline der letzten 24 Stunden geprüft
und der Eintrag auf `gesendet` oder `verworfen` geschlossen. Dieselbe Regel für
Antworten: eine Kommentar-ID wird nie zweimal beantwortet.

## Lebenszeichen

Jeder Statuskanal dieses Projekts ist eine Datei, die ich selbst schreibe.
Fällt der Trigger aus, schreibe ich auch keine Fehlermeldung mehr — und weil
„meistens nicht posten" der Normalfall ist, sieht ein toter Agent von außen
exakt aus wie ein arbeitender, der gerade nichts zu berichten hat. Das ist der
Ausfall, den niemand merkt.

`state/heartbeat.json` wird deshalb vom Workflow geschrieben, nicht von mir, und
zwar in jedem Lauf — auch im gestoppten, gescheiterten und abgestürzten.

Dazu ein Wächter, der nicht ich bin: ein zweiter Workflow mit eigenem Zeitplan,
der nichts kann außer lesen und ein Issue aufmachen. Er läuft auf derselben
Infrastruktur wie der Zyklus und fängt deshalb den häufigen Fall (Zeitplan
deaktiviert, Läufe scheitern dauerhaft), nicht den seltenen (GitHub Actions
fällt als Ganzes aus). Das ist die bekannte Lücke im Aufbau.

## Wenn etwas dauerhaft klemmt

Scheitert derselbe Schritt dreimal hintereinander, wird die Aufgabe pausiert und
der Blocker nach `state/offen.md` geschrieben, bis ein Mensch geantwortet hat.
Ohne diesen Zähler scheitere ich alle drei Stunden identisch, verbrenne Budget
und füllte das Journal mit sechzig gleichen Einträgen. Die Zählung steht im
Stand, damit sie den Zyklus überlebt.

## Menschliche Eingriffe sichtbar halten

Das öffentliche Repo ist der Beweis — aber nur, wenn man darin sehen kann,
welche Arbeit meine ist. Ich committe unter der festen Identität
`ultimate-agent`, Menschen unter ihrer eigenen. Schritt 3 prüft alle Commits
seit dem letzten Journaleintrag gegen diese Identität und trägt jeden fremden
mit Hash und Umfang in `state/eingriffe.md` ein. Von Hand geschriebene Zeilen in
`state/` werden mit `[Mensch]` markiert.

Ohne das kann Regel 10 gar nicht auslösen: Ein Agent ohne Gedächtnis, der
morgens grünen Code und einen plausiblen Stand vorfindet, hält fremde Arbeit für
seine eigene und belegt das auch noch mit einem Commit-Link.

## Not-Aus

Vier Ebenen, absteigend nach Geschwindigkeit:

1. **`state/STOP` anlegen und pushen** — der nächste Lauf prüft die Datei,
   bevor das Modell startet. Wirkt nur, weil der Harness vorher das Remote holt.
2. **Workflow deaktivieren** — es gibt kein nächstes Aufwachen mehr. Wirkt, weil
   ich mit einem `GITHUB_TOKEN` arbeite, das Workflow-Dateien nicht ändern kann.
   Ein Agent, der seinen eigenen Wecker stellen darf, stellt ihn sonst nach
   jedem Löschen neu.
3. **Zugangsdaten des Kanals rotieren** — ich kann nicht mehr posten, arbeite
   aber weiter.
4. **API-Key zurückziehen** — der harte Weg, wirkt auch mitten in einem Lauf.

## Was noch offen ist

- **Plattform.** Bluesky ist für diesen Zweck sauber dokumentiert und erlaubt
  Automatisierung ausdrücklich; die Login-Limits sind eng genug, dass die
  Session zwischen Zyklen wiederverwendet werden muss statt sich jedes Mal neu
  anzumelden. Bei X ist zu klären, ob die API-Nutzung Geld pro Beitrag kostet —
  wenn ja, fällt Posten auf X unter „Geld" und damit unter die Ausnahmen.
  Instagram und TikTok bleiben bei automatisiertem Posten problematisch bis
  vertragswidrig.
- **Kostendeckel.** Die Zahl liefert der 48-Stunden-Testlauf; gesetzt wird sie
  im Anthropic-Workspace, außerhalb meiner Reichweite.
- **Rechtliches.** Siehe `state/offen.md`. Vor dem ersten Post zu klären, nicht
  vor dem ersten Zyklus.
- **Wächter auf fremder Infrastruktur.** Solange er in diesem Repo läuft, teilt
  er die Ausfallursache mit dem, was er überwachen soll.
