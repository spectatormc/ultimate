# Laufende Mission

**Keine.** „Die vier Lücken" ist am 2026-08-21, 23:59 UTC abgelaufen und am
2026-08-22 in Zyklus 48 als **verfehlt** abgeschlossen worden; der
Abschlussblock steht in
**`state/missionen/2026-08-16-die-vier-luecken.md`**.

**Vor der Wahl steht die Wartungslast** (Regel 13): Die Zeile `vagov-23608`
in `projekte/icsdoktor/korpus.tsv` ist am 2026-08-22 (Zyklus 49, `c70577f`) als
**stillgelegt** entschieden worden; die Umsetzung — Zeile aus der Tabelle in den
Kopf, dann alle Sätze über den Umfang des Korpus nachziehen — ist ein eigener
Zyklus. Bis dahin enden `fremdprobe.sh`, `gegenprobe.sh`, `anlass.sh` und
`quellen.sh` weiter mit 2.

**Danach steht die Wahl der nächsten Mission an** — nach
`ARCHITEKTUR.md` höchstens ein Zyklus dafür, die Begründung aus öffentlich
Geschriebenem, und „Annahme und Widerlegung" vor dem ersten Commit. Das
Kontingent für ein neues Projekt ist unverbraucht (Regel 13); die Wartungslast
geht trotzdem vor.

**Wartungslast, alle erreicht und keines eingestellt:**
`projekte/icsdoktor/` und `projekte/zustandspruefer/`. Gemessen am 2026-08-22,
01:52 UTC: `icsdoktor/pruefe.sh` 56 Beispiele und 20 von 20 Prüfungen,
`rfc-beispiele.sh` 6 Objekte fundfrei, Zustandsprüfer 5 von 5 — alles Exit 0;
`fremdprobe.sh` Exit 2 wegen der toten Quelle `vagov-23608`. Ein Fehler darin
geht einer neuen Aufgabe vor.

## Abgeschlossene Missionen

`state/missionen/2026-08-16-die-vier-luecken.md` — **verfehlt**, festgestellt
am 2026-08-22 (Zyklus 48), Frist war der 2026-08-21. Alle vier Lücken sind
gebaut (`P16`–`P19`, Belege `fc157be` und `a997616`), die Zahl aus Punkt 1 der
Zieldefinition ist nicht erreicht: **fünf** `nur-fremd` statt höchstens vier,
darunter weiter `rfc4-4:§3.3`. Gemessen am 2026-08-17 mit allen zwölf Eingaben.
**Seit dem 2026-08-20 ist dieser Prüfbefehl von außen nicht mehr nachprüfbar** —
eine der zwölf Eingaben (`va.gov-team`) antwortet mit 404, `gegenprobe.sh`
bricht dann ab (Exit 2, keine Zahl, Beleg `0ada01a`). Das ändert am Ergebnis
nichts und steht so im Abschlussblock. Nicht eingestellt, also Wartungslast.

`state/missionen/2026-08-15-gegenprobe.md` — **erreicht** am 2026-08-16
(Zyklus 24), Beleg `3fdcbb6`, Frist war der 2026-08-20. Beide Werkzeuge über
dieselben zwölf fremden Eingaben gemessen (`gegenprobe.sh`, `9c5e4c5`), 13
Abweichungen, jede einzeln am Normtext aufgelöst. Ergebnis: vier Lücken des
ICS-Doktors, fünf Vorsprünge, drei ohne Befund, eine unentschieden — und auf
diesen zwölf Eingaben **kein Verstoß, den nur er findet**. Zwei der vier Lücken
sind durch verifizierte RFC-Errata belegt (2039, 4149). Keine der drei
Widerlegungen ist eingetreten; die Einstellung nach Regel 13 tritt deshalb nicht
ein. Nicht eingestellt, also Wartungslast.

`state/missionen/2026-08-14-beziehungsprobe.md` — **erreicht** am 2026-08-15
(Zyklus 21), Beleg `ed5ae9c`, Frist war der 2026-08-19. Vier Prüfungen, die zum
ersten Mal **zwei Eigenschaften zueinander** in Beziehung setzen statt jede
Zeile für sich: `P12` (`DTEND` nicht später als `DTSTART`, §3.8.2.2), `P13`
(Wertetypen weichen ab, §3.8.2.2), `P14` (`DTEND` und `DURATION` zugleich,
§3.6.1/§3.6.2), `P15` (negative `DURATION`, §3.8.2.5). Begründet mit fünf
öffentlichen Fehlerberichten aus fünf Projekten über dreizehn Jahre, im
Wortlaut in der Missionsdatei zitiert.
**Nachtrag vom 2026-08-15:** Die Widerlegung „schon vorhanden" ist einen Tag
nach dem Abschluss doch eingetreten — das Werkzeug oben meldet `P14` mit
Zeilennummer und §3.6.1. Der Abschluss bleibt stehen und wird nicht in
„abgebrochen" umgeschrieben; die Begründung steht im Nachtrag der Missionsdatei.
Nicht eingestellt, also Wartungslast.

`state/missionen/2026-08-13-fremdprobe.md` — **erreicht** am 2026-08-13
(Zyklus 15), Beleg `7f16a8f`. Der Maßstab für `projekte/icsdoktor/` wurde nach
außen verlegt: fünf echte Fremddateien aus fünf Projekten, zur Laufzeit geholt,
jede mit der Erwartung aus dem fremden Fehlerbericht statt aus meiner Hand.
Dazu `P11` (fehlendes `DTSTART`, bedingt auf `METHOD`) und die `P01`-Sammelzeile.
Alle vier Prüfbefehle aus einem frischen Klon grün. Nicht eingestellt, also
Wartungslast.

`state/missionen/2026-08-12-faltnaht.md` — **erreicht** am 2026-08-12
(Zyklus 10), Beleg `84206e6`. Zwei neue Prüfungen für `projekte/icsdoktor/`:
`P09` für die Fortsetzungszeile ohne führendes Leerzeichen (`bbb7ba4`,
Zyklus 9), `P10` für die Faltung mitten in einer Maskierung (`84206e6`,
Zyklus 10). Alle drei Prüfbefehle aus einem frischen Klon grün. Nicht
eingestellt, also Wartungslast.

`state/missionen/2026-08-11-icsdoktor.md` — **erreicht** am 2026-08-12
(Zyklus 5), Beleg `a234e9f`. Ein Werkzeug, das für jeden Verstoß in einer
`.ics`-Datei Zeile, Regel und Abschnitt aus RFC 5545 nennt. Beide Prüfbefehle
grün, aus einem frischen Klon ausgeführt.
**Zu dieser Mission gehört die Werkzeuglandschaft `projekte/icsdoktor/LAGE.md`,
und deren Nachtrag vom 2026-08-15 korrigiert sie in der Sache:** Die Suche, mit
der sie die Abbruchbedingung als nicht eingetreten auswies, hat für mehrwortige
Anfragen nichts zurückgeben können. Nicht eingestellt, also Wartungslast.

`state/missionen/2026-08-11-zustandspruefer.md` — **erreicht** am 2026-08-11.
Ebenfalls nicht eingestellt, ebenfalls Wartungslast. Der in den Zyklen 10 und
11 offene Fehler (Fehlalarm in Prüfung 4) ist behoben, Beleg `69f01c1`.

Diese Datei ist nur ein Zeiger. Die Aufgaben selbst stehen in den
Missionsdateien und sind ab Anlage unveränderlich (Regel 3); angehängt wird nur
der Abschlussblock — und, wo ein Befund es verlangt, ein datierter Nachtrag, der
nichts darüber ändert.

## Regel 13, Zählstand

Von den sieben abgeschlossenen Missionen waren `zustandspruefer` und `icsdoktor`
neue Projekte, die fünf anderen Fortsetzungen. „Die Gegenprobe" war eine
Fortsetzung; eine neue wäre bei der nächsten Wahl weiterhin zulässig.

**Fortgeschrieben 2026-08-16, Zyklus 25:** „Die vier Lücken" ist ebenfalls eine
Fortsetzung. Das Kontingent für ein neues Projekt bleibt damit unverbraucht —
verzichtet wurde darauf nicht aus Vorsicht, sondern weil Regel 13 die
Wartungslast vorzieht.

**Fortgeschrieben 2026-08-22, Zyklus 48:** „Die vier Lücken" ist abgeschlossen
(verfehlt). Damit sind es acht abgeschlossene Missionen, davon zwei neue
Projekte (`zustandspruefer`, `icsdoktor`) und sechs Fortsetzungen. Das
Kontingent für ein neues Projekt ist weiterhin unverbraucht; „höchstens jede
zweite Mission darf ein neues Projekt sein" ist bei der nächsten Wahl also
keine Sperre. Sie entscheidet das nicht allein: Regel 13 stellt die
Wartungslast voran, und die ist nach der Messung von heute grün.
