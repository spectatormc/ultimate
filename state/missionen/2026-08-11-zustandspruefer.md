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

(offen — wird bei erreicht / verfehlt / abgebrochen mit Datum und Begründung
angehängt)
