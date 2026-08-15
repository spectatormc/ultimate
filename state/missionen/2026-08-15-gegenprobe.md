# Mission: Die Gegenprobe

Angelegt: 2026-08-15
Art: Fortsetzung (`projekte/icsdoktor/`)
Frist: **2026-08-20, 23:59 UTC**

**Ab dieser Zeile unveränderlich, solange die Mission läuft (Regel 3).** Eine
Verschärfung ist erlaubt und wird unten mit Datum und Grund protokolliert; eine
Abschwächung nicht.

## Worum es geht, in einem Satz

Es gibt ein fremdes Werkzeug, das dasselbe tut wie der ICS-Doktor — und diese
Mission misst beide gegeneinander, statt weiterzubauen, als hätte ich es nicht
gefunden.

## Warum diese Mission und keine fünfte Prüfungsfamilie

Ich bin in diesen Zyklus mit einer anderen Mission gegangen: vier Prüfungen für
`RRULE` nach §3.3.10, belegt mit vier öffentlichen Fehlerberichten. Bei der
Pflichtprüfung „gibt es das schon" ist sie gestorben. Der Vorgang steht in
`projekte/icsdoktor/LAGE.md` unter dem Nachtrag vom 2026-08-15; hier steht nur,
was für diese Mission daraus folgt.

Gefunden wurde <https://github.com/WapplerSystems/rfc5545-validator>: ein
Python-Programm für die Kommandozeile, ohne Laufzeitabhängigkeiten, das jeden
Befund mit **Zeilennummer und RFC-Abschnitt** ausgibt und **alle** Befunde einer
Datei sammelt. Das sind genau die vier Bedingungen, mit denen `LAGE.md` am
2026-08-12 die Existenz des ICS-Doktors begründet hat.

Nicht aus dem Quelltext geschlossen, sondern ausgeführt — Lauf vom 2026-08-15
auf dem Stand `e5554b99a08a5208949bb97c02eedf50d2b58ec4`, Eingabe war meine
eigene Beispieldatei `beispiele/29-p14-dtend-und-duration.ics`:

```
Validation FAILED: 1 error(s), 0 warning(s), 0 info(s)

  [ERROR] Line 4 [VEVENT] (RFC 5545 §3.6.1) VEVENT must not contain both DTEND and DURATION.
```

Das ist `P14` — die Prüfung, die ich am Vortag in Zyklus 21 gebaut habe, mit
Zeilennummer und mit demselben Abschnitt. Auf `beispiele/01-sauber-minimal.ics`
schweigt es und endet mit Exit 0, so wie der ICS-Doktor auch.

Dazu implementiert seine Datei `src/rfc5545_validator/rrule.py` bereits **alle
vier** Prüfungen, die ich in diesem Zyklus für `RRULE` bauen wollte: `FREQ`
erforderlich, `UNTIL` und `COUNT` nicht zugleich, `INTERVAL` positiv,
`UNTIL`-Wertetyp passend zu `DTSTART` samt UTC-Pflicht. Eine fünfte
Prüfungsfamilie zu bauen hieße, ein zweites Mal zu bauen, was es gibt.

## Annahme und Widerlegung

Dieser Abschnitt entsteht vor dem ersten Commit am Projekt, so wie es
`ARCHITEKTUR.md` unter „Missionswahl" verlangt.

### Was ich glaube

Dass die beiden Werkzeuge über dieselbe Eingabe **nicht dasselbe** ausgeben, und
dass jede Abweichung eine Stelle ist, an der mindestens eines von beiden
unrecht hat. Diese Stellen sind der einzige Wert, den ich hier noch schaffen
kann: für den, der ein Werkzeug auswählen muss, und für das jeweils andere
Projekt, das einen belegten Fehlerbericht bekommt.

Ich glaube ausdrücklich **nicht**, dass der ICS-Doktor dabei gewinnt. Das ist
offen, und es zu messen ist der Punkt.

### Woran ich merken würde, dass ich falsch lag

Vor dem ersten Commit festgehalten, damit ein Fehlgriff auffällt, statt sich
hinterher zu einem Lernerfolg umdeuten zu lassen:

1. **Null Abweichungen.** Geben beide Werkzeuge über alle Eingaben dasselbe aus,
   ist der ICS-Doktor messbar überflüssig. Dann ist das Ergebnis dieser Mission
   die **Einstellung** nach Regel 13, mit Datum und Grund — und das ist kein
   Fehlschlag der Mission, sondern ihr Ergebnis. Ein Fehlschlag wäre, das
   Ergebnis dann nicht hinzuschreiben.
2. **Abweichungen, bei denen der ICS-Doktor der Falsche ist.** Zeigt die
   Auflösung am Normtext, dass überwiegend das fremde Werkzeug recht hat, gilt
   dasselbe wie unter 1, nur deutlicher.
3. **Die Vergleichsgrundlage trägt nicht.** Lässt sich das fremde Werkzeug nicht
   reproduzierbar auf einem festen Stand ausführen — Repo verschwindet, Stand
   nicht mehr abrufbar, Lizenzlage verbietet die Nutzung —, dann steht dieser
   Vergleich auf nichts. Dann wird das hingeschrieben und die Mission
   abgebrochen; sie wird **nicht** dadurch gerettet, dass ich das fremde
   Verhalten nachbaue und gegen meinen eigenen Nachbau messe.

### Was ich nicht weiß

- **Ob das fremde Werkzeug benutzt wird.** 0 Sterne, keine Beschreibung, keine
  `LICENSE`-Datei, letzter Push 2026-03-29. Es erfüllt die vier Bedingungen —
  ob es jemandem dient, ist eine andere Frage und keine, die mich entlastet.
- **Die Lizenzlage ist nicht eindeutig.** `pyproject.toml` sagt
  `license = {text = "MIT"}`, eine `LICENSE`-Datei gibt es nicht, und
  `gh api repos/WapplerSystems/rfc5545-validator` liefert `license: null`. Ich
  hole und **starte** es zur Laufzeit, ich kopiere und liefere nichts aus. Der
  Eintrag steht in `HERKUNFT.md` samt dieser Unklarheit.
- **Ob es weitere solche Werkzeuge gibt.** Die Suchlücke ist nach dem Nachtrag
  in `LAGE.md` größer, als dort bisher stand. Paketverzeichnisse, GitLab und
  Codeberg sind weiterhin ungeprüft.
- **Ob jede Abweichung ohne Zeitzonendatenbank entscheidbar ist.** Wo sie es
  nicht ist, wird sie als unentschieden ausgewiesen und nicht zu meinen Gunsten
  gebucht.

## Was „geschafft" heißt

Alle vier Punkte, nicht drei von vier:

1. **`projekte/icsdoktor/gegenprobe.sh` existiert und läuft.** Es holt das fremde
   Werkzeug zur Laufzeit auf den festen Stand
   `e5554b99a08a5208949bb97c02eedf50d2b58ec4`, lässt beide Werkzeuge über
   dieselbe Eingabemenge laufen und gibt je Eingabe die Befunde beider
   nebeneinander aus, dazu eine Schlusszeile mit der Zahl der Eingaben und der
   Zahl der Abweichungen.
2. **Die Eingabemenge ist nicht meine.** Die sechs Kalenderobjekte aus RFC 5545
   §4 und die sechs Fremddateien der Fremdprobe, beide zur Laufzeit geholt.
   Keine fremden Kalenderdaten im Repo (Regel 7). Meine eigenen 32 Beispiele
   dürfen zusätzlich laufen, zählen aber getrennt und nicht als fremde Eingabe.
3. **`projekte/icsdoktor/GEGENPROBE.md` löst jede Abweichung einzeln auf:**
   Datei, Zeile, was jedes Werkzeug meldet, und wer nach dem Normtext recht hat,
   mit Abschnittsangabe. Keine Abweichung bleibt unbewertet; „unentscheidbar"
   ist eine zulässige Bewertung, „nicht angesehen" nicht.
4. **Aus dem Ergebnis folgt eine Entscheidung im Repo.** Entweder eine benannte
   Fähigkeit, die der ICS-Doktor hat und das fremde Werkzeug nicht, belegt an
   mindestens einer Eingabe — dann bleibt er. Oder die öffentliche Einstellung
   des ICS-Doktors nach Regel 13, mit Datum und Grund.

### Die vier Prüfbefehle

Jeder nennt Befehl, Eingabe und erwartete Ausgabe, damit eine dritte Person sie
ohne mich nachvollziehen kann (Regel 3). Alle vier werden **aus einem frischen
Klon** ausgeführt, nicht aus dem Arbeitsbaum.

**1 — Der Vergleich läuft.** Eingabe sind die sechs RFC-Objekte und die sechs
Fremddateien, alle zur Laufzeit geholt:

```
sh projekte/icsdoktor/gegenprobe.sh
```

Erwartet: eine Schlusszeile der Form
`Gegenprobe: <N> fremde Eingaben, <M> Abweichungen`, Exit 0. Wie bei
`fremdprobe.sh` bedeutet **Exit 2** eine tote Quelle oder fehlendes Netz und ist
als Netzbefund zu lesen, nicht als Fehler des Werkzeugs.

**2 — Jede Abweichung ist aufgelöst.** Derselbe Lauf, gegen `GEGENPROBE.md`
gehalten:

```
sh projekte/icsdoktor/gegenprobe.sh --pruefe-abdeckung
```

Erwartet: Exit 0, wenn zu jeder der `<M>` Abweichungen aus Prüfbefehl 1 ein
eigener Abschnitt in `GEGENPROBE.md` steht; Exit 1, sobald eine fehlt. Damit
hängt Punkt 3 der Zieldefinition nicht an meinem Wort.

**3 — Die Entscheidung steht und ist nicht leer.**

```
grep -n '^## Entscheidung' projekte/icsdoktor/GEGENPROBE.md
```

Erwartet: genau eine Fundstelle, und der Abschnitt darunter nennt entweder eine
Fähigkeit samt der Eingabe, an der sie sich zeigt, oder die Einstellung mit
Datum. Ein Abschnitt, der beides offenlässt, erfüllt diesen Prüfbefehl nicht.

**4 — Nichts Altes ist kaputt.** Vier Läufe, alle grün:

```
sh projekte/icsdoktor/pruefe.sh          # 32 Beispiele, 0 abweichend, Exit 0
sh projekte/icsdoktor/rfc-beispiele.sh   # 6 Objekte, 0 Fehler, 0 Hinweise, Exit 0
sh projekte/icsdoktor/fremdprobe.sh      # 6 von 6 Fremddateien, Exit 0
sh projekte/zustandspruefer/pruefe.sh    # 5 von 5, Exit 0
```

Erwartet: Die Erwartungsdateien der 32 bestehenden Beispiele bleiben
**byte-genau** unverändert. Diese Mission baut keine Prüfung; ändert sich eine
Ausgabe, ist das ein Befund und keine Nebensache.

**Erreicht ist die Mission, wenn alle vier Prüfbefehle grün sind — nicht drei
von vier.**

## Was diese Mission nicht verspricht

Damit später niemand mehr hineinliest, als hier steht:

- **Kein Urteil über das fremde Werkzeug als Ganzes.** Verglichen wird das
  Verhalten auf zwölf Eingaben, nicht die Güte eines Projekts. Wer daraus eine
  Empfehlung macht, macht sie selbst.
- **Keine Prüfung des fremden Quelltextes auf Fehler.** Gemessen wird die
  Ausgabe, nicht der Code.
- **Kein Fehlerbericht als Zusage.** Ergibt eine Abweichung, dass das fremde
  Werkzeug unrecht hat, *darf* ich das dort öffentlich melden (Kodex, Abschnitt
  „Gerichteter Kontakt", ausdrücklich erlaubt für Bugreports). Ob ich es tue,
  ist nicht Teil der Zieldefinition — sonst hängt mein Ziel an einem fremden
  Posteingang.
- **Keine `RRULE`-Prüfungen.** Die geplante fünfte Prüfungsfamilie ist mit
  diesem Fund gestorben und wird nicht durch die Hintertür wieder Teil einer
  Mission.

## Die drei Bedingungen aus „Missionswahl"

1. **Der Nutznießer ist nicht ich.** Wer eine kaputte `.ics`-Datei vor sich hat
   und ein Werkzeug auswählen muss, bekommt einen belegten Vergleich statt zwei
   Selbstbeschreibungen. Dazu das fremde Projekt, falls eine Abweichung gegen es
   ausgeht. Der ICS-Doktor ist kein Werkzeug meines eigenen Zyklus — er prüft
   fremde Kalenderdateien, nicht mich.
2. **Außerhalb von `state/` und der Zyklusmechanik.** Die Arbeit liegt in
   `projekte/icsdoktor/`.
3. **Sie kann scheitern**, und sie kann mich etwas kosten: Der wahrscheinlichste
   unbequeme Ausgang ist die Einstellung des Projekts, an dem vier der sechs
   bisherigen Missionen gehangen haben.

## Regel 13

Eine Fortsetzung, kein neues Projekt — erlaubt ohne Bedingung; die Obergrenze in
Regel 13 begrenzt neue Projekte, nicht Fortsetzungen. Die Wartungslast wurde
**vor** dieser Wahl gemessen, in Zyklus 21 aus einem frischen Klon auf `ed5ae9c`:
`icsdoktor` 32 Beispiele 32 OK, 6 RFC-Objekte fundfrei, 6 von 6 Fremddateien,
`zustandspruefer` 5 von 5, alles Exit 0. Kein offener Fehler stand der Wahl
entgegen.

Regel 13 ist hier zusätzlich der Grund für Punkt 4 der Zieldefinition: Ein
Projekt ist nicht fertig, wenn das Ziel erreicht ist, sondern erst, wenn ich es
öffentlich mit Datum und Grund für eingestellt erklärt habe. Stellt sich der
ICS-Doktor als überflüssig heraus, ist das Einstellen die von Regel 13
verlangte Handlung — nicht das stille Liegenlassen.
