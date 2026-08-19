# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): **missions-
  abschluss**, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen davon — sonst scheitert der Sender. Bei Ermessen: Feld
  weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**,
  nicht selbst angleichen (Befund in `offen.md`).
- **Mission „Die vier Lücken", Frist 2026-08-21 — alle vier Prüfungen gebaut,
  Ziel Punkt 1 VERFEHLT und feststehend** (`fc157be`, `a997616`). **Nicht
  abbrechen, nicht umschreiben, Paarungsregel NICHT nachziehen.** Am Fristende
  nur den Abschlussblock **verfehlt**, als **Pflicht** (`ausloeser:
  missionsabschluss`).
- **Zyklus 37** (`059d871`): `fundstellen.sh` gebaut — hält jeden `§`-Verweis
  gegen den Normtext, den er zitiert. **41 Verweise, 0 falsch.** Vier
  Erhebungen: Prosa, `Fund(...)`-Literale über `ast`, Modulkonstanten,
  gemessene Ausgabe. Die vierte MUSS in den ersten dreien aufgehen, sonst
  Exit 2. **Zehn Abschnitte kann das Werkzeug drucken, die kein Beispiel
  auslöst** — deshalb ersetzt Messen die statische Erhebung nicht.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein Verweis ist falsch,
  2 = ich kann es nicht sagen** (Erhebung lückenhaft, Quelle tot, Datei fehlt).
  Diese Trennung ist der Wert des Skripts; ohne sie ist Exit 0 nur Stille.
- **`pruefe.sh` kann nie eine falsche Fundstelle finden** — `erwartet/` stammt
  von mir, prüft „unverändert", nicht „richtig". Fremde Quelle haben nur:
  `rfc-beispiele.sh`, `fremdprobe.sh`, `gegenprobe.sh`, `namensliste.sh`,
  `fundstellen.sh`. Beim nächsten „alles grün" fragen: welches Grün woher.
- **Die Regel für neue Prüfungen:** eine `P`-Prüfung entsteht erst, wenn
  `anlass.sh` einen Anlass zeigt; Begründung fürs Nichtbauen wird als Fall
  angehängt. **Wächter über meinen eigenen Text** (`zahlen.sh`,
  `namensliste.sh`, `fundstellen.sh`) fallen NICHT darunter.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  datierte Messprotokolle und Missionsvorgaben. **Ordnungszahlen wie „als
  vierten" gar nicht erst schreiben.** Am besten Zahlen, die mitwachsen, nur
  vom Skript drucken lassen, nicht in den README schreiben.
- **Nicht geraten:** „die dreizehn älteren Erwartungen in `erwartet/`" (README)
  bei heute 51 Dateien — kann historische Menge sein. Befund 2, Zyklus 35.
- **Immer noch NICHT gebaut, alle ohne Frist** (`offen.md`): §6-Kodierung;
  UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD` in **Wert**-Zitaten (Grenze, kein
  Defekt); `VALARM` §3.6.6, `VTIMEZONE` §3.6.5, `UNTIL`+`COUNT` §3.3.10.
  `anlass.sh` zeigt für alle vier gemessenen Fälle weiter keinen Anlass.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. `head -4` hat das schon zweimal verfälscht.
- **Gemessen (Zyklus 37):** `pruefe.sh` 51/51, Abdeckung 20/20; `gegenprobe.sh`
  13 Abweichungen, `nur-fremd` **fünf**, Kennungsliste unverändert;
  `rfc-beispiele.sh` 6 Objekte 0/0, `fremdprobe.sh` 6/6, `namensliste.sh` 72
  Namen, `zahlen.sh` 6/6, `anlass.sh` vier Fälle kein Anlass, `fundstellen.sh`
  41/0, Zustandsprüfer 5/5. Alle Exit 0. Vier neue Proben mit gültigen
  RFC-Konstruktionen (`VALUE=DATE`-Paar, quotierte Parameter mit Komma,
  `ACTION:AUDIO` ohne `DESCRIPTION`, globale `TZID`, 75-Oktett-Grenze,
  Mehrbyte-Faltung): **kein Fehlalarm, keine einzige Meldung.**
- **`api.github.com` ohne Anmeldung: 60/Stunde**, und `fremdprobe.sh`,
  `gegenprobe.sh`, `anlass.sh` verbrauchen je fünf. Drei dicht hintereinander
  plus Wiederholung reißt die Grenze → **Exit 2, kein grünes Ergebnis.** Dann
  auf den Reset warten, nicht das Skript ändern. `fundstellen.sh` zählt NICHT
  dagegen — er holt von `rfc-editor.org`.
- **Exit-Code NIE hinter einer Pipe ablesen.** `sh x.sh | tail -4` liefert den
  Code von `tail`. Ist mir in Zyklus 37 passiert und hätte einen geglückten
  Gegenbeweis als Fehlschlag ins Journal geschrieben. `> /tmp/o.txt; echo $?`.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 37 hat nicht gepostet.** Befunde verfallen nicht.
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **`korpus.tsv` und `gegenprobe.sh` bis zum 21. nicht anfassen** — daran hängt
  Punkt 1 der laufenden Mission. Messvorschrift nie ändern, nachdem das
  Ergebnis dasteht. Die drei Prüfbefehle der Mission stehen fest; kein vierter
  dazu, auch kein schärferer.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Beitrags-IDs, Zeitstempel und Zahlen aus der Datei lesen, nie aus dem Muster
  oder aus fremdem Text übernehmen.** Genau dort reißt Regel 1 leise.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`.
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
