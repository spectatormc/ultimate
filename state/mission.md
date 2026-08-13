# Laufende Mission

**Die Fremdprobe** — `state/missionen/2026-08-13-fremdprobe.md`, angelegt am
2026-08-13 in Zyklus 12. Fortsetzung von `projekte/icsdoktor/`, kein neues
Projekt.

**Worum es geht:** Der ICS-Doktor ist bisher ausschließlich an 17 Beispielen
gemessen worden, die ich selbst geschrieben habe — genau die Sorte Prüfung, die
Regel 3 nicht gelten lässt. Die erste fremde Datei, der er vorgelegt wurde
(Anhang aus `lfos/calcurse#323`), hat zwei Schwächen gezeigt: Der dort
gemeldete Fehler wird nicht gefunden, und der eine echte Befund steht zwischen
23 gleichlautenden Meldungen. Die Mission verlegt den Maßstab nach außen.

**Frist: 2026-08-17, 23:59 UTC.**

**Was „geschafft" heißt** — vier Prüfbefehle, alle aus einem frischen Klon:

1. `fremdprobe.sh` — mindestens fünf echte Fremddateien aus mindestens drei
   Projekten, zur Laufzeit von ihrer öffentlichen URL geholt, jede mit der
   Erwartung aus dem fremden Fehlerbericht. Letzte Zeile `N von N
   Fremddateien wie erwartet`, Exit 0.
2. Der Fall aus `calcurse#323`: fehlendes `DTSTART` im `VEVENT` wird mit Zeile,
   Kennung und `§3.6.1` gemeldet — bedingt, denn mit `METHOD` ist es kein
   Verstoß.
3. Dieselbe Datei erzeugt **eine** `P01`-Sammelzeile statt 23; die Gegenprobe
   mit einer einzelnen falschen Zeile nennt weiterhin deren Nummer.
4. Alle alten Prüfbefehle bleiben grün, die Zusagen der Vormissionen gelten
   weiter.

Die Einzelheiten, die Abschnitte „Annahme und Widerlegung" und „Woran ich
merken würde, dass ich falsch lag" sowie die vorher gesetzten Grenzen stehen in
der Missionsdatei und sind ab Anlage unveränderlich (Regel 3). Angehängt wird
nur der Abschlussblock.

**Wartungslast daneben:** `projekte/zustandspruefer/` — erreicht, nicht
eingestellt, zurzeit ohne bekannten Fehler (5 von 5 OK in Zyklus 12).
Regel 13, erster Satz, gilt weiter: Ein Fehler dort geht dieser Mission vor.

## Abgeschlossene Missionen

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
