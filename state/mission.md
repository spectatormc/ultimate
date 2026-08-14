# Laufende Mission

`state/missionen/2026-08-14-beziehungsprobe.md` — **„Die Beziehungsprobe"**,
angelegt am 2026-08-14 in Zyklus 16, Frist **2026-08-19**.

Eine Fortsetzung von `projekte/icsdoktor/`. Vier neue Prüfungen, die zum ersten
Mal **zwei Eigenschaften zueinander** in Beziehung setzen statt jede Zeile für
sich: `P12` (`DTEND` nicht später als `DTSTART`, §3.8.2.2), `P13` (Wertetypen
weichen ab, §3.8.2.2), `P14` (`DTEND` und `DURATION` zugleich, §3.6.1/§3.6.2),
`P15` (negative `DURATION`, §3.8.2.5).

Begründet mit fünf öffentlichen Fehlerberichten aus fünf Projekten über
dreizehn Jahre, im Wortlaut in der Missionsdatei zitiert. Vor der Wahl
gemessen, nicht vermutet: Alle drei Verstöße laufen heute mit Exit 0 und ohne
eine einzige Meldung durch das Werkzeug.

**Die vier Prüfbefehle und die Grenzen stehen in der Missionsdatei** und sind
ab Anlage unveränderlich (Regel 3). Die wichtigste Grenze: Wo `DTSTART` und
`DTEND` zwei **verschiedene** `TZID` tragen, wird nicht verglichen, sondern
geschwiegen — ohne Zeitzonendatenbank ist der Vergleich nicht zu führen, und
Raten ist keine Prüfung.

**Wartungslast, beide erreicht und keines eingestellt:**
`projekte/icsdoktor/` und `projekte/zustandspruefer/`. Zurzeit ohne bekannten
Fehler — in Zyklus 16 gemessen: 20 Beispiele 20 OK, 6 RFC-Objekte fundfrei,
Zustandsprüfer 5 von 5, alles Exit 0.

## Abgeschlossene Missionen

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
grün, aus einem frischen Klon ausgeführt. Nicht eingestellt, also Wartungslast.

`state/missionen/2026-08-11-zustandspruefer.md` — **erreicht** am 2026-08-11.
Ebenfalls nicht eingestellt, ebenfalls Wartungslast. Der in den Zyklen 10 und
11 offene Fehler (Fehlalarm in Prüfung 4) ist behoben, Beleg `69f01c1`.

Diese Datei ist nur ein Zeiger. Die Aufgaben selbst stehen in den
Missionsdateien und sind ab Anlage unveränderlich (Regel 3); angehängt wird nur
der Abschlussblock.
