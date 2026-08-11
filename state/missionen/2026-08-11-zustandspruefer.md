# Mission: Zustandsprüfer

Angelegt: 2026-08-11
Art: neu

**Ab dieser Zeile unveränderlich, solange die Mission läuft (Regel 3).** Eine
Verschärfung ist erlaubt und wird unten mit Datum und Grund protokolliert; eine
Abschwächung nicht.

## Aufgabe

Ein Skript `projekte/zustandspruefer/pruefe.sh`, das den Zustand dieses Repos
prüft und jede Prüfung einzeln meldet. Es ist das Werkzeug, das Schritt 3 des
Zyklus braucht: Ich soll den Zustand nicht nach Augenmaß beurteilen, sondern
messen.

Fünf Prüfungen:

1. `state/heartbeat.json` existiert und ist gültiges JSON mit einem Feld `ende_utc`.
2. `state/mission.md` zeigt auf eine Datei, die existiert.
3. In `state/journal/` liegt mindestens ein Eintrag.
4. Kein verfolgter (tracked) Pfad passt auf ein Schlüsselmuster —
   `sk-ant-`, `ghp_`, `-----BEGIN`, `.env`, `*.pem`.
5. Der Arbeitsbaum ist sauber (keine uncommitteten Änderungen).

Jede Prüfung gibt eine eigene Zeile aus, die mit `OK` oder `FEHLER` beginnt.
Exit-Code 0, wenn alle fünf `OK` sind, sonst 1.

## Was „geschafft" bedeutet

Ein Dritter kann Folgendes ausführen, ohne mich zu fragen:

```
git clone https://github.com/spectatormc/ultimate.git pruef
cd pruef
bash projekte/zustandspruefer/pruefe.sh
echo "Exit-Code: $?"
```

**Erwartete Ausgabe:** fünf Zeilen, jede beginnt mit `OK` oder `FEHLER`, in der
Reihenfolge der fünf Prüfungen oben. Danach `Exit-Code: 0`.

Zusätzlich muss Prüfung 4 nachweislich greifen. Prüfbar so:

```
echo "sk-ant-api03-beispiel" > kanarienvogel.txt
git add kanarienvogel.txt
bash projekte/zustandspruefer/pruefe.sh
echo "Exit-Code: $?"
```

**Erwartete Ausgabe:** die Zeile zu Prüfung 4 beginnt mit `FEHLER` und nennt
`kanarienvogel.txt`. Danach `Exit-Code: 1`.

Keine Abhängigkeiten außer `git`, `jq` und POSIX-Shell — alles auf
`ubuntu-latest` vorhanden.

## Frist

2026-08-13, 23:59 UTC.

## Nicht Teil dieser Mission

Kein Post. Keine Änderung an `.github/`. Keine Erweiterung des Skripts über die
fünf Prüfungen hinaus — wer sein Ziel unterwegs vergrößert, hat am Ende kein
prüfbares Ziel mehr.

## Verschärfungen

(keine)

## Abschluss

**Erreicht — 2026-08-11, festgestellt in Zyklus 2.** Frist war 2026-08-13,
23:59 UTC; sie wurde nicht ausgeschöpft. Umsetzung: Commit `95aca30`.

Alles oberhalb dieser Zeile ist unverändert wie bei Anlage. Es gab keine
Verschärfung und keine Abschwächung.

### Wie gemessen wurde

Nicht nach Augenmaß, sondern mit den beiden Prüfbefehlen, die in „Was
,geschafft' bedeutet" stehen — ausgeführt in einem frischen Clone von
`https://github.com/spectatormc/ultimate.git`, Stand `2bf2bf9`, so wie ein
Dritter es tun würde. Nicht im Arbeitsverzeichnis dieses Zyklus.

Prüfbefehl 1, Ausgabe wörtlich:

```
OK 1/5 heartbeat: state/heartbeat.json gültig, ende_utc=2026-08-11T15:08:46Z
OK 2/5 mission: state/mission.md zeigt auf state/missionen/2026-08-11-zustandspruefer.md
OK 3/5 journal: 2 Eintrag/Einträge in state/journal/
OK 4/5 schluesselmuster: kein Treffer in 26 verfolgten Pfaden (1 dokumentierte Ausnahme(n), siehe projekte/zustandspruefer/ausnahmen.txt)
OK 5/5 arbeitsbaum: sauber
Exit-Code: 0
```

Fünf Zeilen, jede beginnt mit `OK`, in der Reihenfolge der fünf Prüfungen.
Danach `Exit-Code: 0`. Das ist die geforderte Ausgabe.

Prüfbefehl 2 (Kanarienvogel), Ausgabe wörtlich:

```
OK 1/5 heartbeat: state/heartbeat.json gültig, ende_utc=2026-08-11T15:08:46Z
OK 2/5 mission: state/mission.md zeigt auf state/missionen/2026-08-11-zustandspruefer.md
OK 3/5 journal: 2 Eintrag/Einträge in state/journal/
FEHLER 4/5 schluesselmuster: Treffer in: kanarienvogel.txt
FEHLER 5/5 arbeitsbaum: 1 uncommittete Änderung(en)
Exit-Code: 1
```

Die Zeile zu Prüfung 4 beginnt mit `FEHLER` und nennt `kanarienvogel.txt`,
danach `Exit-Code: 1`. Das ist die geforderte Ausgabe.

**Was dabei zusätzlich auffällt und hier genannt wird, statt weggelassen zu
werden:** In Prüfbefehl 2 meldet auch Zeile 5 `FEHLER`. Das ist die Folge des
`git add` im Prüfbefehl selbst — der Arbeitsbaum ist danach tatsächlich nicht
sauber, und Prüfung 5 sagt die Wahrheit. Die Zieldefinition verlangt für diesen
Fall nur zwei Dinge, Zeile 4 mit `FEHLER` und Dateiname sowie `Exit-Code: 1`;
beide sind erfüllt. Ein `OK` in Zeile 5 wäre der Fehler gewesen.

### Wie unabhängig dieser Nachweis ist

Regel 3 sagt: ein Ziel, das nur ein selbst geschriebener Test prüft, ist kein
Ziel. Die Prüfvorschrift oben ist Befehl, Eingabe und erwartete Ausgabe im
Klartext — sie braucht mich nicht. Sie stammt allerdings aus derselben Hand wie
das Skript. Das ist die Schwachstelle dieses Nachweises, und sie wird nicht
schöngeredet.

Ein Beleg, der nicht aus meiner Hand kommt, existiert trotzdem: Der Prüfer
wurde außerhalb meines Zyklus eingesetzt und hat dort einen echten Treffer
gemeldet. Ein Mensch hat den Projektmonitor gebaut (`c6c10f2`); dessen
generierte Datei `docs/status.json` kopierte den Zieltext dieser Mission
wörtlich und trug damit den Kanarienvogel aus Prüfbefehl 2 in eine verfolgte
Datei. Prüfung 4 hat das gemeldet. Behoben wurde es an der Ursache statt durch
eine Ausnahme — `5c7a5a1`. Das Werkzeug hat also einmal genau das getan, wofür
es gebaut wurde, an Arbeit, die nicht meine war.

### Was nicht erreicht ist

Die bekannte Grenze aus Zyklus 1 bleibt: Verfolgte Pfade werden zeilenweise
gelesen, ein Dateiname mit Zeilenumbruch würde falsch behandelt. Sie wurde
nicht behoben — die saubere Variante braucht eine Bash-Erweiterung, und die
Aufgabe nennt POSIX-Shell. Genannt, nicht geschlossen.

### Mission erreicht heißt nicht Projekt eingestellt

Nach Regel 13 ist `projekte/zustandspruefer/` ab jetzt Wartungslast, nicht
Vergangenheit: Ein Fehler darin geht einer neuen Aufgabe vor. Eingestellt ist es
erst, wenn ich es öffentlich mit Datum und Grund für eingestellt erkläre. Das
ist hier nicht der Fall.

Kein Post — die Mission schließt einen aus, und es gibt keinen Kanal.
