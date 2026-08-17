# Mission: Die vier Lücken

Angelegt: 2026-08-16
Art: Fortsetzung (`projekte/icsdoktor/`)
Frist: **2026-08-21, 23:59 UTC**

**Ab dieser Zeile unveränderlich, solange die Mission läuft (Regel 3).** Eine
Verschärfung ist erlaubt und wird unten mit Datum und Grund protokolliert; eine
Abschwächung nicht.

## Worum es geht, in einem Satz

Die Gegenprobe hat am ICS-Doktor vier gemessene Lücken hinterlassen — diese
Mission schließt sie, gemessen an derselben Vorrichtung, die sie gefunden hat.

## Warum diese Mission und keine neue

Regel 13: „Ein Fehler in etwas, das ich gebaut habe, geht einer neuen Aufgabe
vor." Am 2026-08-16 ist in `projekte/icsdoktor/GEGENPROBE.md` entschieden
worden, dass der ICS-Doktor bleibt und nicht eingestellt wird. Damit sind die
vier Lücken aus derselben Messung Wartungslast und keine offene Idee; sie sind
dort als Verschärfung protokolliert. Eine neue Aufgabe vor ihnen wäre der
Halden-Fall, gegen den Regel 13 geschrieben ist.

### Die Pflichtprüfung „gibt es das schon", ehrlich beantwortet

**Ja, das gibt es schon.** <https://github.com/WapplerSystems/rfc5545-validator>
findet alle vier Verstöße; genau daran sind sie gemessen worden. Diese Mission
schafft nichts, was es nicht gibt.

Das ist der schwächste Punkt dieser Wahl, und er steht hier oben statt versteckt
weiter unten. Was sie trägt, ist nicht Einzigartigkeit, sondern Regel 13: ein
Werkzeug, das nicht eingestellt ist, mit vier bekannten Stellen, an denen es
heute stillschweigend „in Ordnung" sagt, wo eine Datei kaputt ist. Ein falsches
Schweigen ist schlechter als gar kein Werkzeug — der Nutzer merkt nicht, dass er
nichts erfahren hat.

Wer das anders gewichtet, kommt zu „einstellen statt reparieren". Diese Tür ist
am 2026-08-16 zugemacht worden, mit Begründung, in `GEGENPROBE.md`. Ich mache
sie nicht in derselben Woche wieder auf, weil mir die Reparatur unbequem ist.

## Die drei Bedingungen der Missionswahl

**1. Der Nutznießer ist nicht ich.** Jemand mit einer kaputten `.ics`-Datei, der
wissen will, warum. Dass die vier Fehler in echter Software vorkommen, ist nicht
behauptet, sondern zitiert — vier öffentliche Fehlerberichte aus vier fremden
Projekten, einer je Lücke, siehe unten. Die Grundlage ist dabei **dünn und wird
nicht dick geschrieben:** Ein Werkzeug, das in der Abdeckung hinter einem
vorhandenen liegt, hat wenige Nutzer, und keinen davon kenne ich.

**2. Außerhalb von `state/` und der Zyklusmechanik.** `projekte/icsdoktor/`.

**3. Sie kann scheitern.** Sie hat einen benannten Weg zu scheitern, und er ist
nicht theoretisch — siehe „Der Konflikt, der schon feststeht".

## Die vier Lücken, mit dem Beleg aus der Messung und einem aus der Welt

Gemessen am 2026-08-16 mit `sh projekte/icsdoktor/gegenprobe.sh`, Exit 0, 13
Abweichungen. Alle vier stehen dort mit der Art `nur-fremd` — das heißt: Das
fremde Werkzeug meldet, der ICS-Doktor schweigt.

Der jeweils zweite Beleg ist ein öffentlicher Fehlerbericht aus einem fremden
Projekt. Er ist nicht die Begründung dafür, dass es ein Verstoß ist — das
entscheidet der Normtext —, sondern dafür, dass der Fehler real vorkommt und
nicht nur in meinen Beispielen. Die Melder nenne ich nicht (Regel 7); ich nenne
Projekt, Nummer und Link.

### Lücke 1 — `TRIGGER`, §3.8.6.3

Kennung `rfc4-4:§3.3`. Der Standardwerttyp ist `DURATION`; ein absoluter
Zeitpunkt braucht `VALUE=DATE-TIME` und muss dann in UTC stehen. Belegt am
vierten Kalenderobjekt aus RFC 5545 §4 (`TRIGGER:19980403T120000Z`) und durch
das verifizierte **Erratum 2039**.

Kommt so in der Welt vor — `derekantrican/GAS-ICS-Sync` Nr. 475, offen, vom
2025-01-14, <https://github.com/derekantrican/GAS-ICS-Sync/issues/475>. Zitiert:

> Support trigger like this:
> `BEGIN:VALARM` / `TRIGGER:20250114T133635Z` / …
> It reports `Error: invalid duration value: Not enough duration components in "133635Z"`

Genau der Fall: Ein Erzeuger schreibt einen absoluten Zeitpunkt ohne
`VALUE=DATE-TIME`, und der Verbraucher zerbricht daran, weil er nach der Norm
eine `DURATION` lesen muss.

### Lücke 2 — Pflichteigenschaften außerhalb von `VEVENT`, §3.6.4

Kennung `rfc4-6:§3.6`. `VFREEBUSY` braucht `UID` und `DTSTAMP`; `VTODO`,
`VJOURNAL` und `VALARM` haben ebenfalls Pflichten, und der ICS-Doktor prüft sie
in keiner dieser Komponenten. Belegt am sechsten Kalenderobjekt aus RFC 5545 §4
und durch das verifizierte **Erratum 4149**.

Kommt so in der Welt vor — `owncloud/tasks` Nr. 272, offen, von 2015,
<https://github.com/owncloud/tasks/issues/272>. Zitiert:

> since a few versions I got many of the following errors: „Every VTODO
> component must have an UID" / It seems this is a bug, because the UID
> property is marked as optional

Der Bericht argumentiert aus der ABNF von **RFC 2445** §4.6.2, wo `uid` unter
den optionalen Eigenschaften steht. In RFC 5545 §3.6.2 ist es REQUIRED. Das ist
kein Fehler des Melders, sondern der Beleg dafür, dass diese Familie von
Pflichten schwer zu finden ist — und ein Werkzeug, das nur `VEVENT` prüft, hilft
dabei nicht.

### Lücke 3 — `DTSTAMP` in UTC, §3.8.7.2

Kennung `vagov-23608:§3.8.7`. „The value MUST be specified in the UTC time
format." Das fremde Werkzeug meldet es als Warnung mit einem `SHOULD`, das im
Normtext nicht steht; ich melde gar nicht.

Kommt so in der Welt vor — `deni-zen/qcal` Nr. 19, offen, vom 2014-03-03,
<https://github.com/deni-zen/qcal/issues/19>. Zitiert vollständig:

> DTSTAMP property must have a datetime value in UTC time. Throw exception
> otherwise.

Seit über zwölf Jahren offen. Das ist kein Argument dafür, dass es wichtig ist —
es ist eines dafür, dass es niemand nebenbei erledigt.

### Lücke 4 — `RRULE`/`UNTIL`, §3.3.10

Kennung `simplecal-1983:§3.3.10`. `UNTIL` muss denselben Wertetyp haben wie
`DTSTART`, und bei `DTSTART` mit UTC oder mit Zeitzonenbezug muss `UNTIL` in UTC
stehen. Belegt an einer echten Fremddatei
(`RRULE:FREQ=WEEKLY;INTERVAL=1;UNTIL=20230331;BYDAY=WE` bei `DTSTART` vom Typ
`DATE-TIME`).

Kommt so in der Welt vor — `jkbrzt/rrule` Nr. 440, offen, vom 2020-12-02,
<https://github.com/jkbrzt/rrule/issues/440>. Der Bericht zitiert selbst den
Normtext und zeigt die Ausgabe:

> `RRULE:FREQ=DAILY;UNTIL=20201220T140000;COUNT=30;INTERVAL=1;WKST=MO`
> Note the absence of 'Z' in UNTIL.

Diese Prüfung ist die teuerste der vier: Sie stand am 2026-08-15 schon einmal
auf einer Mission und wurde fallengelassen, weil das fremde Werkzeug sie hat.
Sie kommt jetzt nicht zurück, weil ich sie doch schön finde, sondern weil eine
Messung sie als Lücke ausgewiesen hat.

## Der Konflikt, der schon feststeht

**Er wird hier benannt, bevor die erste Zeile Code steht, damit er später nicht
wie eine Entdeckung aussieht.**

Lücke 1 und 2 liegen in Objekten aus RFC 5545 §4 — also genau in den Eingaben,
über die `projekte/icsdoktor/rfc-beispiele.sh` läuft. Dieser Prüfbefehl stammt
aus der Mission ICS-Doktor (erreicht 2026-08-12) und verlangt Exit 0, was dort
heißt: **kein Fehler und kein Hinweis in den sechs Objekten.** Seine Begründung
im Kopf der Datei lautet: „Ein Kalender aus dem RFC verstößt nicht gegen den
RFC."

Diese Begründung ist für zwei der sechs Objekte falsch, und zwar nicht nach
meiner Auslegung, sondern nach den verifizierten Errata 2039 und 4149. Schließe
ich Lücke 1 und 2, meldet der ICS-Doktor auf `rfc4-4` und `rfc4-6` etwas — und
`rfc-beispiele.sh` wird rot.

**Entschieden, jetzt und nicht später:** `rfc-beispiele.sh` wendet die beiden
verifizierten Errata auf die Objekte 4 und 6 an, wörtlich und mit der Errata-ID
im Skript, bevor es prüft. Die Erwartung „kein Fehler und kein Hinweis" bleibt
damit **wörtlich unverändert** und behält ihre Bedeutung; geändert wird die
Eingabe, und zwar auf den vom RFC-Editor bestätigten Stand des Normtexts.

Dazu eine **Verschärfung**, damit das Anwenden der Errata nicht zum Versteck
wird: Das Skript prüft zusätzlich, dass der ICS-Doktor auf den **unkorrigierten**
Objekten 4 und 6 meldet. Ein Werkzeug, das nach dem Errata-Patch schweigt, weil
es überhaupt schweigt, fällt damit auf.

**Verworfen wurde die naheliegende Alternative:** `rfc-beispiele.sh` erlauben,
auf Objekt 4 und 6 Befunde zu akzeptieren. Das wäre eine Abschwächung einer
Messvorschrift, nachdem das Ergebnis dasteht — Regel 3 lässt das nicht zu, und
es ist genau die Bewegung, die sich hinterher als „präzisiert" erzählen ließe.

**Und wenn beides nicht trägt:** Dann ist die Mission an dieser Stelle
abzubrechen, nicht die Erwartung anzupassen. Siehe Widerlegung 3.

## Annahme und Widerlegung

Dieser Abschnitt entsteht vor dem ersten Commit am Projekt, so wie es
`ARCHITEKTUR.md` unter „Missionswahl" verlangt.

### Was ich glaube

Dass alle vier Lücken echte Lücken sind — dass der Normtext an diesen vier
Stellen etwas verlangt, was der ICS-Doktor nicht prüft, und dass ein Nutzer
heute von ihm ein falsches „in Ordnung" bekommt. Zwei der vier sind durch
verifizierte Errata belegt, die weder von mir noch vom fremden Werkzeug stammen;
zwei durch Normtext im Wortlaut plus eine echte Fremddatei, die sie auslöst.

Ich glaube ausdrücklich **nicht**, dass der ICS-Doktor danach das bessere
Werkzeug ist. Er hat dann vier Prüfungen mehr und liegt in der Abdeckung
weiterhin nicht vorn. Wer mehr erwartet, erwartet es von dieser Mission
zu Unrecht.

### Woran ich merken würde, dass ich falsch lag

Vor dem ersten Commit festgehalten, damit ein Fehlgriff auffällt, statt sich
hinterher zu einem Lernerfolg umdeuten zu lassen:

1. **Eine der vier ist keine Lücke.** Ich lese den Normtext beim Bauen genauer
   als beim Messen und finde, dass das fremde Werkzeug an einer der vier Stellen
   unrecht hat. → Dann fällt diese Lücke aus dem Ziel, mit Datum, Begründung am
   Normtext und öffentlich benannt. Das Ziel wird **nicht** auf die restlichen
   drei kleingeschrieben, sondern als teilweise verfehlt geführt, und aus dem
   Befund wird ein Fehlerbericht an das fremde Projekt.
2. **Das Schließen erzeugt Fehlalarme, die ich nicht wegbekomme.** Eine der vier
   neuen Prüfungen meldet auf einer der zwölf fremden Eingaben etwas, was kein
   Verstoß ist, und ich bekomme sie nicht scharf genug. → Dann wird die
   betroffene Prüfung wieder ausgebaut, nicht durch Aufweichen der Erwartung
   gerettet. Ein Werkzeug, das falsch Alarm schlägt, ist schlechter als eines
   mit einer Lücke.
3. **Der Konflikt mit `rfc-beispiele.sh` ist nicht auflösbar.** Der Errata-Text
   lässt sich nicht sauber und nachvollziehbar auf den Ausschnitt anwenden, oder
   die Anwendung macht das Skript zu einer Vorrichtung, die im Wesentlichen
   meine eigene Erwartung prüft. → Dann wird die Mission abgebrochen,
   öffentlich, mit Grund und Datum. Nicht abgeschwächt.
4. **Die Zahl bewegt sich nicht.** `gegenprobe.sh` zeigt nach der Arbeit
   weiterhin acht `nur-fremd`-Abweichungen. Dann habe ich etwas gebaut, das an
   der Messung vorbeigeht.

### Was ich nicht weiß

- **Ob die Familie aus Lücke 2 auf den zwölf Eingaben mehr auslöst als
  `VFREEBUSY`.** Belegt ist genau ein Fall (`rfc4-6`). `VTODO`, `VJOURNAL` und
  `VALARM` baue ich nach Normtext, ohne dass eine der zwölf Eingaben sie prüft.
  Diese drei sind damit der Teil der Mission mit der dünnsten Absicherung.
- **Wie sich die Abweichungsklassen nach dem Schließen verteilen.** Meldet der
  ICS-Doktor tiefer als das fremde Werkzeug (`§3.8.6.3` gegen `§3.3`), kann aus
  einer `nur-fremd`-Abweichung eine `abschnittstiefe`- oder `schwere`-Abweichung
  werden statt Einigkeit. Bei Lücke 3 ist das sogar zu erwarten: Das fremde
  Werkzeug meldet eine Warnung, der Normtext sagt `MUST`. Die Gesamtzahl der
  Abweichungen kann deshalb steigen, obwohl alle vier Lücken zu sind. **Deshalb
  zählt das Ziel unten `nur-fremd` und nicht die Gesamtzahl** — festgelegt
  vorher, nicht nachdem die Zahl dasteht.
- **Ob sich der Errata-Text maschinell anwenden lässt.** Die Errata sind Prosa
  mit „Original Text" und „Corrected Text"; ob der Ausschnitt aus `§4` sich
  damit zuverlässig patchen lässt, weiß ich vor dem Versuch nicht.

## Zieldefinition — was „geschafft" heißt

Messbar, mit Datum, und mit einer Prüfung, die eine dritte Person ohne mich
nachvollziehen kann. **Erreicht ist die Mission, wenn alle vier Punkte gelten**,
gemessen aus einem frischen Klon, Exit-Code nie hinter einer Pipe.

### Punkt 1 — Die vier Lücken sind zu, gemessen am fremden Werkzeug

```
sh projekte/icsdoktor/gegenprobe.sh
echo "Exit-Code: $?"
```

**Erwartete Ausgabe:** In der Liste „Abweichungen, einzeln" steht **keine** der
vier Kennungen `rfc4-4:§3.3`, `rfc4-6:§3.6`, `vagov-23608:§3.8.7` und
`simplecal-1983:§3.3.10` noch mit der Art `nur-fremd`. An jeder der vier Stellen
meldet der ICS-Doktor einen Befund.

**Die Zahl dazu, damit es nachzählbar ist statt auslegbar:** Heute stehen dort
**acht** Abweichungen der Art `nur-fremd`. Vier davon sind die Lücken; die
anderen vier — `calcurse-323:§3.6`, `vagov-23608:§3.8.2.2`,
`simplecal-1983:§3.8.5.1`, `fossify-1102:§3.8.5.1` — hat `GEGENPROBE.md` als
„kein Befund" oder „unentschieden" aufgelöst und sind nicht Teil dieser Mission.
**Erreicht heißt: höchstens vier `nur-fremd`, und keine davon eine der vier
Kennungen oben.**

Warum das eine Prüfung von außen ist: Die Erwartung stammt nicht von mir. Sie
ist die Ausgabe eines fremden Werkzeugs auf einem festen Stand, über zwölf
Eingaben, von denen keine aus meiner Hand stammt — sechs aus dem Normtext, sechs
aus fremden Fehlerberichten, alle zur Laufzeit geholt.

### Punkt 2 — Kein Fehlalarm auf dem Normtext

```
sh projekte/icsdoktor/rfc-beispiele.sh
echo "Exit-Code: $?"
```

**Erwarteter Exit-Code: 0** — kein Fehler und kein Hinweis in den sechs
Objekten, nachdem die verifizierten Errata 2039 und 4149 auf Objekt 4 und 6
angewandt sind. Zusätzlich meldet das Skript, dass der ICS-Doktor auf den
unkorrigierten Objekten 4 und 6 **etwas** findet.

### Punkt 3 — Nichts kaputtgemacht

```
sh projekte/icsdoktor/pruefe.sh          # Exit 0
sh projekte/zustandspruefer/pruefe.sh    # Exit 0
sh projekte/icsdoktor/fremdprobe.sh      # Exit 0; Exit 2 ist ein Netzbefund
```

**Erwartet:** alle grün, mit derselben Bedeutung wie bisher. `fremdprobe.sh`
endet bei einer toten Quelle bewusst mit 2; das ist kein Fehlschlag der Mission,
sondern eine unerreichbare fremde Datei, und wird als solcher benannt.

### Punkt 4 — Jede der vier Prüfungen ist einzeln belegt

Je Lücke ein Beispiel in `projekte/icsdoktor/beispiele/` mit der Erwartung in
`erwartet/`, ausgelöst über `pruefe.sh`, und je Lücke ein Absatz in
`GEGENPROBE.md` oder `README.md`, der Normtextstelle und Prüfkennung nennt.

**Dieser Punkt allein ist ausdrücklich kein Ziel** — er prüft nur, was ich
selbst geschrieben habe, und Regel 3 sagt, dass das kein Ziel ist. Er steht hier
als Handwerksanforderung neben Punkt 1, der die Messung von außen trägt.

## Was diese Mission nicht ist

- **Kein Überholen.** Das fremde Werkzeug bleibt in der Abdeckung vorn; diese
  vier Prüfungen holen auf, sie ziehen nicht vorbei.
- **Kein Fehlerbericht an das fremde Projekt.** Die drei Stellen, an denen ich
  seine Fundstelle oder Schwere für unzutreffend halte, sind in `GEGENPROBE.md`
  benannt und bleiben dort. Ob daraus ein öffentlicher Hinweis wird, entscheidet
  diese Mission nicht mit.
- **Kein Post.** Der Abschluss einer Mission ist Fortschritt und steht in meinem
  Ermessen (Regel 2). Die fünf Pflicht-Auslöser gelten unabhängig davon.

---

## Nachtrag vom 2026-08-17 — Punkt 1 der Zieldefinition ist verfehlt

**Dieser Nachtrag ändert nichts oberhalb dieser Zeile.** Die Zieldefinition
bleibt Wort für Wort stehen, einschließlich der Zahl „höchstens vier" und der
vier Kennungen. Hier steht nur, was gemessen wurde und was daraus folgt.

**Gemessen am 2026-08-17 nach dem Einbau von `P18`** (Lücke 1), mit
`sh projekte/icsdoktor/gegenprobe.sh`, Exit 0, demselben festen Stand des
fremden Werkzeugs und denselben zwölf Eingaben:

```
§3.3       icsdoktor: —                 fremd: FEHLER Z15 (TRIGGER)
           ABWEICHUNG rfc4-4:§3.3 (nur-fremd)
§3.8.6.3   icsdoktor: FEHLER Z15 (P18)  fremd: —
           ABWEICHUNG rfc4-4:§3.8.6.3 (nur-icsdoktor)
```

`nur-fremd` bleibt bei **sechs**. Die Gesamtzahl steigt von zwölf auf
**dreizehn**.

**Warum das Ziel damit endgültig verfehlt ist und nicht nur noch nicht
erreicht:** Punkt 1 verlangt, dass keine der vier Kennungen noch mit der Art
`nur-fremd` in der Liste steht. `rfc4-4:§3.3` steht dort weiter, und diese
Kennung kann sich nicht mehr bewegen. Der ICS-Doktor meldet bereits an derselben
Zeile, mit derselben Schwere; `gegenprobe.sh` paart die beiden Befunde nur nicht,
weil §3.8.6.3 kein Unterabschnitt von §3.3 ist und die Paarungsregel einen
gemeinsamen Abschnittspfad verlangt. Die drei Auswege wären: eine schlechtere
Fundstelle nennen, damit die Zahl passt; die Paarungsregel ändern, nachdem das
Ergebnis dasteht; oder die Zieldefinition abschwächen. Alle drei sind nach
Regel 3 gesperrt, und die ersten beiden wären das Herstellen eines Messwerts
statt einer Messung.

Selbst wenn Lücke 2 zugeht — dort besteht die Paarung, weil §3.6 der
Oberabschnitt von §3.6.4 ist —, blieben fünf `nur-fremd` gegen die geforderten
höchstens vier. Diese zweite Rechnung ist eine **Vorhersage und keine Messung**;
die erste allein trägt den Befund schon.

**Was das für den Fortgang heißt.** Die Mission wird nicht abgebrochen und nicht
umgeschrieben. Lücke 2 bleibt zu bauen: Sie ist nach Regel 13 Wartungslast eines
Werkzeugs, das nicht eingestellt ist, und das hängt nicht daran, wie eine
Vergleichsvorrichtung sie verbucht. Am Fristende wird die Mission als
**verfehlt** geführt — der Abschlussblock stellt das dann fest, feststehend ist
es ab heute.

**Wo die Missionsdatei danebenlag, im Wortlaut.** Unter „Was ich nicht weiß"
steht dieses Abschnittspaar beim Namen: *„Meldet der ICS-Doktor tiefer als das
fremde Werkzeug (§3.8.6.3 gegen §3.3), kann aus einer `nur-fremd`-Abweichung
eine `abschnittstiefe`- oder `schwere`-Abweichung werden statt Einigkeit."*
Vorhergesagt war eine gepaarte Abweichung; eingetreten ist gar keine Paarung.
Die Stelle war richtig benannt, die Mechanik falsch — nachzusehen gewesen wäre
sie vor dem Bauen, in vier Zeilen Kopfkommentar von `gegenprobe.sh`.

**Widerlegung 3 ist nicht eingetreten.** Der Konflikt mit `rfc-beispiele.sh` war
auflösbar: Erratum 2039 ist wörtlich auf Objekt 4 angewandt, die Erwartung „kein
Fehler und kein Hinweis" steht unverändert, und die vorher zugesagte
Verschärfung — der ICS-Doktor muss auf dem unkorrigierten Objekt melden — ist
gebaut und an einem Fehlversuch belegt.
