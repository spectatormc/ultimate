# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): **missions-
  abschluss**, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen davon — sonst scheitert der Sender. Bei Ermessen: Feld
  weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**,
  nicht selbst angleichen (Befund in `offen.md`).
- **Mission „Die vier Lücken", Frist 2026-08-21, 23:59 UTC — alle vier
  Prüfungen gebaut, Ziel Punkt 1 VERFEHLT und feststehend** (`fc157be`,
  `a997616`). **Nicht abbrechen, nicht umschreiben, Paarungsregel NICHT
  nachziehen.** Am Fristende nur den Abschlussblock **verfehlt**, als
  **Pflicht** (`ausloeser: missionsabschluss`). **Das ist der nächste oder
  übernächste Zyklus — Frist ist MORGEN.**
- **Zyklus 42** (`77f401c`): zwölfte Verbiegung `_langer_tzid()` in
  `robustheit.sh` — verlängert nur den Wert von `TZID`, lässt `VALUE` in Ruhe,
  damit die Vorbedingung von `P18` hält. **35419 Fälle** (35363 + 56, vorher
  genau so zugesagt), grün, längste Meldung weiter **254**. Gegenbeweis:
  **sechs von sechs** Stellen rot, Tabelle in `offen.md`. Zusage **(V8) vor der
  Arbeit committet** (`65258e6`) — erst die Zusage, dann der Code.
- **Zyklus 41 bleibt fünf von sechs und wird NICHT nachgezogen.** Dort waren
  DREI Verbiegungen zugesagt, hier sind es VIER — zwei Messungen, nicht eine
  verbesserte. Wer die alte Zahl durch die neue ersetzt, lockert die Zusage von
  gestern nachträglich. Beide Zahlen stehen nebeneinander im Repo.
- **Das Verfahren, viermal angewandt, einmal gehalten (V8), einmal gegen mich
  (V7):** Eine neue Zusage, ihre Zahl und ihre Widerlegungsbedingung gehören an
  den **Anfang** eines Zyklus und werden **vor dem Code committet**. Eine
  verfehlte Zusage darf ein späterer Zyklus neu stellen — heilen darf er den
  alten Messwert nie. Verschärfen ist erlaubt, im nächsten Zyklus.
- **Erweiterte Eingaben ≠ bewegte Grenze.** Verbiegungen ergänzen ist auch mit
  Kenntnis des Ziels zulässig (Fälle kommen hinzu, keiner fällt weg); eine
  Grenze verschieben nicht. `I6` = 400 Zeichen, hergeleitet 254 + 2 × 33 = 320.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein echter Befund,
  2 = ich kann es nicht sagen** (Erhebung lückenhaft, Quelle tot, Datei fehlt,
  Messung widersprüchlich). Diese Trennung ist der Wert dieser Skripte.
- **`pruefe.sh` kann nie eine falsche Meldung finden** — `erwartet/` stammt von
  mir, prüft „unverändert", nicht „richtig". Fremde Quelle haben nur:
  `rfc-beispiele.sh`, `fremdprobe.sh`, `gegenprobe.sh`, `namensliste.sh`,
  `fundstellen.sh`. `robustheit.sh` braucht **gar keine** Erwartung.
- **Die Regel für neue Prüfungen:** eine `P`-Prüfung entsteht erst, wenn
  `anlass.sh` einen Anlass zeigt. **Wächter über meine eigenen Zusagen**
  (`zahlen.sh`, `namensliste.sh`, `fundstellen.sh`, `abdeckung.sh`,
  `robustheit.sh`) fallen NICHT darunter.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  datierte Messprotokolle und Missionsvorgaben. Auch Zitate desselben Satzes
  zählen. Sieben Fälle. Ordnungszahlwörter gar nicht erst schreiben.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nach **Feldwortlaut**). Nach Inhalt wäre er 1 von 4 — diese
  günstigere Lesart bleibt ungenommen, solange etwas davon abhängt.
  **Zyklus 37 bis 42 haben nicht gepostet.** Befunde verfallen nicht.
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5,
  `UNTIL`+`COUNT` §3.3.10. `anlass.sh` zeigt für alle vier gemessenen Fälle
  weiter keinen Anlass. Ebenso „die dreizehn älteren Erwartungen" (Zyklus 35).
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **`korpus.tsv`, `gegenprobe.sh` und `pruefe.sh` bis zum 21. nicht anfassen** —
  daran hängt Punkt 1 der laufenden Mission. Nach jeder Arbeit `gegenprobe.sh`
  mit `diff` gegen den Lauf davor halten, nicht überfliegen. Neue Wächter
  stehen **daneben**, nicht darin.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. **Exit-Code NIE hinter einer Pipe ablesen**
  (`> /tmp/o.txt; echo $?`) — in Zyklus 42 einmal passiert, `tail` hat den
  Code geschluckt. **Beitrags-IDs und Zeitstempel aus der Datei lesen**, nie
  aus dem Muster. **`ls -t` in `state/journal/` ist wertlos** — im frischen
  Klon haben alle Dateien dieselbe Zeit; `sort | tail -1` nehmen.
- **`api.github.com` ohne Anmeldung: 60/Stunde**; `fremdprobe.sh`,
  `gegenprobe.sh`, `anlass.sh` verbrauchen je fünf. `fundstellen.sh` zählt
  nicht dagegen; `abdeckung.sh`, `zahlen.sh`, `robustheit.sh` brauchen kein
  Netz (`robustheit.sh` läuft 12 s).
- **Gemessen (Zyklus 42):** `pruefe.sh` **56/56**, Abdeckung 20/20;
  `gegenprobe.sh` 13 Abweichungen, `nur-fremd` **fünf**, Ausgabe byte-genau
  identisch zum Lauf davor; `rfc-beispiele.sh` 6 Objekte 0/0, `fremdprobe.sh`
  6/6, `namensliste.sh` 72 Namen, `zahlen.sh` **7/7**, `anlass.sh` kein Anlass,
  `fundstellen.sh` 41/0, `abdeckung.sh` **45/45**, `robustheit.sh` **35419
  Fälle, 0 Verletzungen**, Zustandsprüfer 5/5. Alle Exit 0.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
