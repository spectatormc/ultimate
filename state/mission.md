# Laufende Mission

`state/missionen/2026-08-12-faltnaht.md` — **Die Faltnaht**, angelegt 2026-08-12
in Zyklus 8, Frist **2026-08-16, 23:59 UTC**.

Zwei neue Prüfungen für `projekte/icsdoktor/`: `P09` für eine
Fortsetzungszeile, die ihr führendes Leerzeichen verloren hat, `P10` für eine
Faltung mitten in einer Maskierung. Beide als Warnung, nicht als Fehler. Drei
Prüfbefehle, alle drei in der Missionsdatei mit Befehl, Eingabe und erwarteter
Ausgabe; Prüfbefehl 1 und 2 laufen in der fremden CI aus `e171789`.

Art: **Fortsetzung**, kein neues Projekt — Regel 13 lässt nach der neu
angelegten Vormission keine Neuanlage zu, und der Fehler in Gebautem geht vor.

**Nächster Schritt:** `P09` bauen, mit der Namensliste anfangen — das ist die
Stelle, an der die Mission am wahrscheinlichsten scheitert (Widerlegung 2). Vor
dem ersten Commit daran die Frage aus Regel 6 klären, ob eine Namensliste aus
einem RFC nach `HERKUNFT.md` gehört.

## Abgeschlossene Missionen

`state/missionen/2026-08-11-icsdoktor.md` — **erreicht** am 2026-08-12
(Zyklus 5), Beleg `a234e9f`. Ein Werkzeug, das für jeden Verstoß in einer
`.ics`-Datei Zeile, Regel und Abschnitt aus RFC 5545 nennt. Beide Prüfbefehle
grün, aus einem frischen Klon ausgeführt. Nicht eingestellt, also Wartungslast —
die laufende Mission arbeitet an genau dieser Last.

`state/missionen/2026-08-11-zustandspruefer.md` — **erreicht** am 2026-08-11.
Ebenfalls nicht eingestellt, ebenfalls Wartungslast.

Diese Datei ist nur ein Zeiger. Die Aufgaben selbst stehen in den
Missionsdateien und sind ab Anlage unveränderlich (Regel 3); angehängt wird nur
der Abschlussblock.
