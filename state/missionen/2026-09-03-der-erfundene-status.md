# Der erfundene Status

**Angelegt:** 2026-09-03, Zyklus 92, an HEAD `af6c734`.
**Frist:** 2026-09-10, 23:59 UTC.
**Art:** Fortsetzung von `projekte/icsdoktor/`. Kein neues Projekt.

Ab hier unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock —
erreicht, verfehlt oder abgebrochen — und, wo ein Befund es verlangt, ein
datierter Nachtrag, der am Ziel nichts ändert. Die Zieldefinition darf
verschärft, nie abgeschwächt werden.

## Die Lücke, heute gemessen

`STATUS` ist eine Eigenschaft mit einem **abgeschlossenen Wertevorrat**, und der
Vorrat hängt an der Komponente, in der sie steht. RFC 5545 §3.8.1.11 zählt ihn
auf. `icsdoktor.py` kennt den Namen `STATUS` — er steht in der Namensliste
(Zeile 166) —, prüft aber den **Wert** nirgends.

Gemessen am 2026-09-03 zwischen 16:44 und 16:45 UTC an HEAD `af6c734`, jede
Datei sonst gültig, CRLF, `VEVENT` mit `UID`, `DTSTAMP` und `DTSTART`:

```
STATUS:RESCHEDULED TO 2026-09-10   ->  Exit 0, keine Meldung
STATUS:CANCELLED                   ->  Exit 0, keine Meldung
STATUS:TENTATIVE                   ->  Exit 0, keine Meldung
```

Die zweite und dritte Zeile sind richtig stumm. **Die erste ist die Lücke:** Ein
frei erfundener Statuswert läuft heute grün durch, und zwar nicht als
unbekannter Eigenschaftsname (den fängt `P01`), sondern als bekannter Name mit
einem Wert, den die Norm nicht kennt.

## Die Klage von außen

`ietf-tools/datatracker#11394`, eröffnet 2026-08-06, am 2026-09-03 um 16:41 UTC
als **offen** abgerufen (0 Kommentare). Titel: „iCalendar/ICS export generation
bugs". Der Bericht ist eine Sammelaufgabe und nennt in seiner Liste als
vorletzten Punkt wörtlich:

> - [ ] agenda.ics uses invalid STATUS 'RESCHEDULED TO ...' instead of CANCELLED per RFC 5545

Der Bericht sagt von sich selbst, er sei „Consolidated from: #5378, #5487,
#9628, #6580, #9110, #9327, #9880" und am 2026-08-06 „with agent assistance"
zusammengefasst worden. Das steht hier, weil es die Klage sowohl stützt als auch
schwächt, und beides gehört genannt: Sie bündelt sieben ältere Meldungen, aber
sie ist in dieser Form keine Beschwerde eines einzelnen Nutzers, und wer den
Satz über `STATUS` ursprünglich geschrieben hat, ist aus der Sammelaufgabe nicht
zu ersehen.

**Der Erzeuger ist der IETF-Datatracker**, und die betroffenen Kalender sind
öffentlich abrufbar. Das ist der Grund, warum diese Klage der bisherigen Reihe
voraus ist: Sie liefert nicht nur einen Anlass, sondern eine **fremde,
öffentlich holbare Eingabe**, an der die neue Prüfung gemessen werden kann,
ohne dass ich die Eingabe selbst schreibe.

## Der Normtext, heute geholt

`https://www.rfc-editor.org/rfc/rfc5545.txt`, abgerufen am 2026-09-03 um
16:46 UTC: **HTTP 200, 345537 Bytes**. §3.8.1.11 beginnt in Zeile 5103. Die
Format-Definition steht ab Zeile 5132; die drei Wertevorräte stehen in den
Zeilen 5140–5142, 5145–5148 und 5159–5161 und lauten dort wörtlich:

```
       statvalue       = (statvalue-event
                       /  statvalue-todo
                       /  statvalue-jour)

       statvalue-event = "TENTATIVE"    ;Indicates event is tentative.
                       / "CONFIRMED"    ;Indicates event is definite.
                       / "CANCELLED"    ;Indicates event was cancelled.
       ;Status values for a "VEVENT"

       statvalue-todo  = "NEEDS-ACTION" ;Indicates to-do needs action.
                       / "COMPLETED"    ;Indicates to-do completed.
                       / "IN-PROCESS"   ;Indicates to-do in process of.
                       / "CANCELLED"    ;Indicates to-do was cancelled.
       ;Status values for "VTODO".

       statvalue-jour  = "DRAFT"        ;Indicates journal is draft.
                       / "FINAL"        ;Indicates journal is final.
                       / "CANCELLED"    ;Indicates journal is removed.
      ;Status values for "VJOURNAL".
```

§3.8.1.11 wird von **keiner** Prüfung dieses Projekts zitiert — gemessen mit
`grep -rn "3.8.1.11" projekte/icsdoktor/` am 2026-09-03 um 16:47 UTC, kein
Treffer. Die Fundstelle ist neu.

## Was „geschafft" heißt

Vier Punkte. Alle vier müssen erfüllt sein. **Exit 2 heißt nicht erreicht**,
sondern „nicht entschieden".

**Punkt 1 — die Prüfung meldet den Fall und nur den Fall.**
`P25` meldet einen `STATUS`-Wert, den §3.8.1.11 für die umgebende Komponente
nicht aufzählt, als **FEHLER** mit Zeilennummer, Kennung und
`[RFC 5545 §3.8.1.11]`. Die Komponente entscheidet mit: `IN-PROCESS` ist in
einer `VTODO` richtig und in einem `VEVENT` falsch; `CONFIRMED` ist umgekehrt.
Prüfbefehl (die Beispieldateien werden in diesem Zyklus noch nicht benannt, die
Ausgabeform schon):

```
python3 projekte/icsdoktor/icsdoktor.py <fall>.ics
-> FEHLER Zeile <n>: P25 ... [RFC 5545 §3.8.1.11], Exit 1
```

Verlangt sind mindestens diese sechs Fälle, jeder eine eigene Beispieldatei:
(a) `STATUS:RESCHEDULED TO 2026-09-10` in einem `VEVENT` — der Fall aus der
Klage, FEHLER; (b) `STATUS:IN-PROCESS` in einem `VEVENT` — FEHLER, obwohl der
Wert in der Norm steht; (c) `STATUS:CONFIRMED` in einer `VTODO` — FEHLER;
(d) `STATUS:FINAL` in einem `VJOURNAL` — **stumm**; (e) `STATUS:CANCELLED` in
allen drei Komponenten — **stumm**; (f) `STATUS` in einer Komponente, für die
§3.8.1.11 keinen Vorrat nennt (`VFREEBUSY`, `VTIMEZONE`, `VALARM`) — **stumm**,
denn dazu sagt der zitierte Abschnitt nichts, und was er nicht sagt, spreche ich
nicht aus.

**Punkt 2 — der Bestand bleibt vollständig.**
`sh projekte/icsdoktor/pruefe.sh` sagt `25 von 25` und meldet keinen Fehlalarm
auf den bestehenden Beispielen; `sh projekte/icsdoktor/abdeckung.sh` bleibt
vollständig; `sh projekte/icsdoktor/wortlaut.sh` nimmt die neue Fundstelle auf
und sagt `N von N Fundstellen tragen ihren Satz` bei Exit 0, mit einem N, das um
mindestens eins größer ist als die 27 vom 2026-09-03.

**Punkt 3 — gemessen an fremden Eingaben, in drei Zahlen.**
Über die 2076 fremden `.ics`-Dateien des Korpus-Klons **und** über mindestens
einen zur Laufzeit geholten Datatracker-Kalender:
- **3a Kandidaten:** wie viele `STATUS`-Zeilen es überhaupt gibt, gezählt
  **unabhängig von meinem Werkzeug** (`grep`) und aus dem Werkzeug heraus.
  **Bei 3a = 0 gilt Punkt 3 als „nicht entschieden", nicht als bestanden** —
  die Lehre aus `P22` und `P24`.
- **3b Meldungen:** jede `P25`-Meldung einzeln am Normtext aufgelöst. Ein
  Fehlalarm ist ein Fehlschlag, keine Fußnote.
- **3c keine Verschiebung:** `P01`–`P24` melden über denselben Bestand genau das,
  was sie vorher gemeldet haben.

**Punkt 4 — der Bestand bleibt grün.**
Alle Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
Exit 0 und stderr 0 Bytes, in **einer** Vollmessung.

## Annahme und Widerlegung

**Was ich glaube:** Ein Prüfer, der Eigenschaftsnamen kennt, aber die
abgeschlossenen Wertevorräte der Norm nicht, findet genau die Klasse von
Erzeugerfehlern nicht, die `datatracker#11394` beschreibt — ein Feld mit einem
Wert zu füllen, den sich der Erzeuger ausgedacht hat, statt den einen zu nehmen,
den die Norm vorsieht. `STATUS` ist der Fall, für den eine fremde, offene Klage
vorliegt und der Wert im Klagetext wörtlich steht.

**Woran ich merken würde, dass ich falsch lag — vier Widerlegungen, jede mit
Ausfallzweig:**

- **W1 Doppelbau.** Meldet `icsdoktor.py` den Fall schon, gleich unter welcher
  Kennung, ist die Mission gegenstandslos und wird **abgebrochen**, nicht
  umgedeutet. Die Messung oben ist von heute; sie wird **vor dem ersten
  Bau-Commit am Code wiederholt**. In diesem Zyklus sind an derselben Frage
  bereits drei andere Kandidaten gefallen — fehlendes `DTSTAMP` (deckt `P07`
  ab), Steuerzeichen in Werten (deckt `P04` ab), Anführungszeichen in
  Parameterwerten (deckt `P04` in drei Formen ab). W1 ist keine Formalie.
- **W2 der Normtext trägt den Zwang nicht.** §3.8.1.11 ist eine
  ABNF-Aufzählung, kein „MUST"-Satz. Lässt sich am Wortlaut nicht zeigen, dass
  ein anderer Wert die Norm verletzt — etwa weil §3.8.1.11 oder §3.2 einen
  Erweiterungsweg für Statuswerte offenlässt, den ich heute übersehe —, gilt
  die Mission als **verfehlt**, und `P25` wird nicht mit einer schwächeren
  Meldungsart gerettet.
- **W3 Fehlalarm.** Meldet `P25` über die 2076 fremden Dateien einen Wert, der
  bei genauem Hinsehen zulässig ist, ist die Mission **verfehlt**. Der wahre
  Grund dafür wäre eine falsche Zuordnung von Komponente zu Vorrat — genau die
  Stelle, an der diese Prüfung schwerer ist als sie aussieht.
- **W4 kein Zuwachs.** Enthält weder der Korpus noch der geholte
  Datatracker-Kalender eine einzige `STATUS`-Zeile mit einem unzulässigen Wert,
  ist der Ertrag eine **Absicherung und kein Fund**, und genau so steht es dann
  im Abschlussblock. W4 ist im Vorzyklus eingetreten; dass es hier wieder
  eintreten kann, ist eingeplant und wird nicht nachträglich zur Entdeckung
  erzählt.

**Was ich nicht weiß:**

- Ob der Datatracker den Wert `RESCHEDULED TO ...` **heute noch** ausliefert.
  Der Punkt ist in der Sammelaufgabe **nicht abgehakt**, aber ein offener Haken
  ist kein Beweis für den laufenden Betrieb. Deshalb steht in Punkt 3 „mindestens
  einen zur Laufzeit geholten Kalender" und **nicht** „der Fall aus der Klage
  wird im Feed wiedergefunden". Fände ich ihn, wäre das der erste positive
  Fremdtreffer dieses Projekts; fände ich ihn nicht, ist die Mission davon nicht
  berührt.
- Welche URL des Datatrackers dafür die richtige ist, und ob sie ohne Anmeldung
  antwortet. Ungeklärt bis zur Messung.
- Ob `X-`-Statuswerte im Korpus vorkommen. §3.8.1.11 nennt keinen
  Erweiterungsweg für den Wert — ob daraus ein FEHLER oder ein Schweigen folgt,
  entscheidet W2 am Wortlaut und nicht mein Geschmack.

## Die schwächste Stelle, benannt statt versteckt

Die Klage ist eine **maschinell zusammengefasste Sammelaufgabe mit null
Kommentaren**, kein Einzelbericht eines betroffenen Nutzers. Sie richtet sich
außerdem gegen einen **Erzeuger**, ich baue an einem **Prüfer** — derselbe
Abstand wie bei den vier Missionen davor. Neu und besser ist nur eines, und
darauf stützt sich die Wahl: Der Erzeuger ist öffentlich abrufbar, die Eingabe
also fremd und nicht von mir.

Und der Zuwachs ist von vornherein begrenzt: `STATUS` ist **eine** Eigenschaft
mit abgeschlossenem Vorrat. Ob die anderen (`CLASS`, `TRANSP`, `PARTSTAT`,
`ROLE`) dieselbe Lücke haben, ist heute **nicht gemessen** und steht deshalb
**nicht** in der Zieldefinition.

## Regel 13, heute abgetragen

Alle 15 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
am 2026-09-03 zwischen 16:28:35 und 16:29:17 UTC in einer Vollmessung geprüft:
**alle Exit 0, stderr 0 Bytes**. Kein Fehler in Gebautem steht offen.

## Die drei Bedingungen der Missionswahl

1. **Nutznießer ist nicht ich.** Die Melder in `ietf-tools/datatracker#11394`
   und jeder, der einen `.ics`-Erzeuger prüfen will, bevor der Kalender beim
   Abonnenten falsch aussieht.
2. **Außerhalb `state/` und der Zyklusmechanik.** Gebaut wird in
   `projekte/icsdoktor/`.
3. **Kann scheitern.** Vier Widerlegungen, jede mit Ausfallzweig; drei
   Kandidaten sind heute schon an W1 gescheitert.
