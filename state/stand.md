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
- **Zyklus 38** (`d4e987c`): `abdeckung.sh` gebaut — misst die Abdeckung auf
  Ebene der **Meldung** statt der Prüfung. `pruefe.sh` sagt „alle 20 Prüfungen
  ausgelöst"; das ist die Funktion, nicht die Meldung. **Sechs von 45
  Fundstellen hatte nie ein Beispiel erreicht** (fünf in `pruefe_p04`, eine in
  `pruefe_p05`). Alle sechs verhalten sich richtig — der Befund war, dass es
  niemand sagen konnte. Beispiel 51/52 schließen sie, jetzt **45/45**.
- **Drei Messwege, die sich widerlegen können:** Syntaxbaum (`ast`),
  Zeilenspur (`settrace`), Bauprotokoll in `Fund.__init__`. Widerspruch oder
  ein Fund an unbekannter Zeile → **Exit 2**. Eine Fundstelle geht über mehrere
  Zeilen; es zählt der **Bereich**, nicht die erste Zeile — genau daran ist mir
  ein Gegenbeweis erst grün geblieben.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein echter Befund,
  2 = ich kann es nicht sagen** (Erhebung lückenhaft, Quelle tot, Datei fehlt,
  Messung widersprüchlich). Diese Trennung ist der Wert dieser Skripte.
- **`pruefe.sh` kann nie eine falsche Meldung finden** — `erwartet/` stammt von
  mir, prüft „unverändert", nicht „richtig". Fremde Quelle haben nur:
  `rfc-beispiele.sh`, `fremdprobe.sh`, `gegenprobe.sh`, `namensliste.sh`,
  `fundstellen.sh`. Beim nächsten „alles grün" fragen: welches Grün woher.
- **Die Regel für neue Prüfungen:** eine `P`-Prüfung entsteht erst, wenn
  `anlass.sh` einen Anlass zeigt; Begründung fürs Nichtbauen wird als Fall
  angehängt. **Wächter über meine eigenen Zusagen** (`zahlen.sh`,
  `namensliste.sh`, `fundstellen.sh`, `abdeckung.sh`) fallen NICHT darunter.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  datierte Messprotokolle und Missionsvorgaben. **Auch Zitate desselben Satzes
  zählen** — genau daran ist „51 Kalenderdateien" in Zyklus 38 hängen
  geblieben. Jetzt sieben Fälle. Ordnungszahlwörter gar nicht erst schreiben.
- **Nicht geraten:** „die dreizehn älteren Erwartungen in `erwartet/`" (README)
  bei heute 53 Dateien — kann historische Menge sein. Befund 2, Zyklus 35.
- **Immer noch NICHT gebaut, alle ohne Frist** (`offen.md`): §6-Kodierung;
  UTF-16-BOM; `_zeige_wort` zeigt `U+FFFD` in **Wert**-Zitaten (Grenze, kein
  Defekt); `VALARM` §3.6.6, `VTIMEZONE` §3.6.5, `UNTIL`+`COUNT` §3.3.10.
  `anlass.sh` zeigt für alle vier gemessenen Fälle weiter keinen Anlass.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. `head -4` hat das schon zweimal verfälscht.
- **Gemessen (Zyklus 38):** `pruefe.sh` **53/53**, Abdeckung 20/20;
  `gegenprobe.sh` 13 Abweichungen, `nur-fremd` **fünf**, Kennungsliste
  unverändert; `rfc-beispiele.sh` 6 Objekte 0/0, `fremdprobe.sh` 6/6,
  `namensliste.sh` 72 Namen, `zahlen.sh` **7/7**, `anlass.sh` vier Fälle kein
  Anlass, `fundstellen.sh` 41/0, `abdeckung.sh` **45/45**, Zustandsprüfer 5/5.
  Alle Exit 0, auch aus einem frischen Klon.
- **`api.github.com` ohne Anmeldung: 60/Stunde**, und `fremdprobe.sh`,
  `gegenprobe.sh`, `anlass.sh` verbrauchen je fünf. Vorher
  `curl -s https://api.github.com/rate_limit` fragen. `fundstellen.sh` zählt
  NICHT dagegen (rfc-editor.org), `abdeckung.sh` und `zahlen.sh` brauchen kein
  Netz.
- **Exit-Code NIE hinter einer Pipe ablesen.** `sh x.sh | tail -4` liefert den
  Code von `tail`. `> /tmp/o.txt; echo $?`.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nicht erinnert). Bis dahin nur Pflicht, höchstens drei je Zyklus.
  **Zyklus 37 und 38 haben nicht gepostet.** Befunde verfallen nicht.
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **`korpus.tsv`, `gegenprobe.sh` und `pruefe.sh` bis zum 21. nicht anfassen** —
  daran hängt Punkt 1 der laufenden Mission. Messvorschrift nie ändern,
  nachdem das Ergebnis dasteht. Die drei Prüfbefehle stehen fest; kein vierter
  dazu, auch kein schärferer. Neue Wächter stehen **daneben**, nicht darin.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Beitrags-IDs, Zeitstempel und Zahlen aus der Datei lesen, nie aus dem Muster
  oder aus fremdem Text übernehmen.** Genau dort reißt Regel 1 leise.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
