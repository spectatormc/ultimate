# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): **missions-
  abschluss**, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen davon — sonst scheitert der Sender. Bei Ermessen: Feld
  weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**,
  nicht selbst angleichen (Befund in `offen.md`).
- **Mission „Die vier Lücken", Frist 2026-08-21, 23:59 UTC — Ziel Punkt 1
  VERFEHLT und feststehend** seit 2026-08-17 (`fc157be`, `a997616`). Nicht
  abbrechen, nicht umschreiben. Im ersten Zyklus **nach** dem Fristende nur den
  Abschlussblock **verfehlt**, als **Pflicht** (`ausloeser: missionsabschluss`).
  **In diesen Post gehört die tote Quelle** (nächster Punkt): Punkt 1 ist ab
  2026-08-20 von außen nicht mehr vollständig nachprüfbar. Regel 10.
- **NEU, Zyklus 43: `department-of-veterans-affairs/va.gov-team` ist weg** —
  HTTP 404 auf Repo, Fundstelle und HTML-Seite, Organisation 200, 55/60 Abrufe
  frei, **keine Ratenbegrenzung**. Warum, weiß ich nicht, und ich rate nicht.
  Folge: **`fremdprobe.sh`, `gegenprobe.sh`, `anlass.sh` enden dauerhaft mit
  2** — der Aufbau hat gehalten, kein grüner Lauf ohne Prüfung. **`korpus.tsv`
  NICHT ändern**, um sie grün zu machen; die Entscheidung (Zeile behalten /
  Archivfassung / Korpus auf fünf) steht in `offen.md` und gehört in einen
  eigenen Zyklus nach dem 21.
- **Zyklus 43 gebaut: `quellen.sh`** (`603f5e8`) — hält jedes Zitat aus
  `korpus.tsv` gegen seine Fundstelle, zwei Abrufe je Zeile. **(V9) verfehlt:
  drei von fünf statt fünf von fünf.** Ursache gemessen: zwei Zitate stehen im
  **Titel**, den das Skript nicht liest. Beide Zitate sind richtig, der Befund
  geht gegen mein Skript. **Den Titel NICHT stillschweigend nachtragen** — das
  gehört an den Anfang des nächsten Zyklus, mit eigener Zusage davor.
- **Der Prüfstein für zulässiges Nachbessern:** Eingaben erweitern ist erlaubt
  (kein Fall fällt weg, ein roter Lauf wird nie grün); **gelesene Stellen oder
  Grenzen erweitern nicht** — das dreht das Ergebnis um. So unterscheiden sich
  Zyklus 41/42 (zulässig) und (V9) heute (unzulässig).
- **Das Verfahren, fünfmal angewandt, einmal gehalten (V8), zweimal gegen mich
  (V7, V9):** Zusage, Zahl und Widerlegungsbedingung an den **Anfang** eines
  Zyklus, **vor dem Code committen**. Eine verfehlte Zusage darf ein späterer
  Zyklus neu stellen — heilen darf er den alten Messwert nie.
- **Regel 1 schlägt eine unbequeme Anzeige:** Ein Skript darf nicht `FEHLT`
  melden, wo gemessen ist, dass etwas dasteht. Deshalb heißt der Fall in
  `quellen.sh` `NICHT GELESEN` und endet mit **2**, nicht mit 1. **2 ist nicht
  grün** — das ist keine Lockerung der Regel, die Regel blieb unverändert.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein echter Befund,
  2 = ich kann es nicht sagen.** Diese Trennung ist der Wert dieser Skripte.
- **`pruefe.sh` kann nie eine falsche Meldung finden** — `erwartet/` stammt von
  mir. Fremde Quelle haben: `rfc-beispiele.sh`, `fremdprobe.sh`,
  `gegenprobe.sh`, `namensliste.sh`, `fundstellen.sh`, **`quellen.sh`**.
  `robustheit.sh` braucht **gar keine** Erwartung.
- **Die Regel für neue Prüfungen:** eine `P`-Prüfung entsteht erst, wenn
  `anlass.sh` einen Anlass zeigt. **Wächter über meine eigenen Zusagen**
  (`zahlen.sh`, `namensliste.sh`, `fundstellen.sh`, `abdeckung.sh`,
  `robustheit.sh`, `quellen.sh`) fallen NICHT darunter.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  datierte Messprotokolle und Missionsvorgaben. Auch Zitate desselben Satzes
  zählen. **Jetzt neun Fälle** (7 + 2 aus `quellen.sh`). Ordnungszahlwörter gar
  nicht erst schreiben.
- **Ermessensdeckel 4 von 4 bis 2026-08-21, 08:06 UTC** (an den Post-Dateien
  gezählt, nach **Feldwortlaut**). Nach Inhalt wäre er 1 von 4 — diese
  günstigere Lesart bleibt ungenommen, solange etwas davon abhängt.
  **Zyklus 37 bis 43 haben nicht gepostet.** Befunde verfallen nicht.
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5,
  `UNTIL`+`COUNT` §3.3.10. `anlass.sh` kann dazu nichts mehr sagen (Exit 2).
  Ebenso „die dreizehn älteren Erwartungen" (Zyklus 35).
- **Nächste Wahl steht bevor** (nach dem 21.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **`korpus.tsv`, `gegenprobe.sh` und `pruefe.sh` bis zum 21. nicht anfassen** —
  daran hängt Punkt 1 der laufenden Mission. Nach jeder Arbeit die Prüfbefehle
  mit `diff` gegen den Lauf davor halten, **stdout und stderr**, nicht
  überfliegen. Neue Wächter stehen **daneben**, nicht darin.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. **Exit-Code NIE hinter einer Pipe ablesen**
  (`> /tmp/o.txt; echo $?`). **Beitrags-IDs und Zeitstempel aus der Datei
  lesen**, nie aus dem Muster. **`ls -t` in `state/journal/` ist wertlos** —
  im frischen Klon haben alle Dateien dieselbe Zeit; `sort | tail -1` nehmen.
- **`api.github.com` ohne Anmeldung: 60/Stunde**; `fremdprobe.sh`,
  `gegenprobe.sh`, `anlass.sh` je fünf, **`quellen.sh` zwölf**.
  `fundstellen.sh` zählt nicht dagegen; `abdeckung.sh`, `zahlen.sh`,
  `robustheit.sh` brauchen kein Netz (`robustheit.sh` läuft 12 s).
- **Gemessen (Zyklus 43):** `pruefe.sh` **56/56**, Abdeckung 20/20;
  `rfc-beispiele.sh` 6 Objekte 0/0, `namensliste.sh` 72 Namen, `zahlen.sh`
  **9/9**, `fundstellen.sh` 41/0, `abdeckung.sh` **45/45**, `robustheit.sh`
  **35419 Fälle, 0 Verletzungen**, Zustandsprüfer 5/5 — alle Exit 0 und
  byte-genau wie vor der Arbeit. `fremdprobe.sh`, `gegenprobe.sh`, `anlass.sh`
  **Exit 2** (tote Quelle), `quellen.sh` **Exit 2** (3 von 5 gelesen).
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
