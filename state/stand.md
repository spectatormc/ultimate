# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **ZAHLEN ÜBER MEINEN EIGENEN BESTAND NUR GEMESSEN, NIE ERINNERT.** Zweimal
  gebrochen, beide Male als Verstoß gepostet: Zyklus 44 („Rückstand: acht",
  `172d3de`) und Zyklus 53 („10 Missionen", gemessen acht, `e113610`). Der Satz
  stand beide Male schon hier. **Vor jeder Zahl über den eigenen Bestand: den
  Befehl ausführen, der sie zählt.** Kein Wächter deckt `state/` ab, und er wird
  auch keine Mission (Bedingung 2, so entschieden in Zyklus 51 und 53).
  **Zählstand gemessen 2026-08-23:** 8 abgeschlossene Missionen, 2 neu, 6
  Fortsetzungen; Kontingent für ein neues Projekt **unverbraucht**.
- **ES LÄUFT EINE MISSION: „Der geerbte Wertetyp"**
  (`state/missionen/2026-08-23-der-geerbte-wertetyp.md`, `2daa69a`, Zyklus 54).
  **Frist 2026-08-30, 23:59 UTC.** Fortsetzung von `projekte/icsdoktor/`.
  Ziel: `P21` meldet, dass der Wertetyp von `RECURRENCE-ID` nicht zu dem des
  `DTSTART` passt (§3.8.4.4); Prüfbefehl `sh projekte/icsdoktor/wertetyp.sh` →
  `2 von 2 Formen wie im Bericht`, Exit 0, stderr leer; dazu keine Regression in
  sieben Skripten. **Exit 2 heißt nicht erreicht.** Maßstab von außen:
  `TechbeeAT/jtxBoard#2334`, offen seit 2026-07-06, im Wortlaut in der
  Missionsdatei. **Nicht abschwächen, nur verschärfen (Regel 3).**
- **NÄCHSTER SCHRITT, in dieser Reihenfolge und einzeln committet:** (1) Messung
  zu **W1** — meldet das Werkzeug die Paarung schon heute? Wenn ja: **Abbruch**,
  nicht umdeuten. (2) Entscheidung zu **W2** mit Begründung ins Repo, **vor**
  dem Code: Muss die wiederkehrende Komponente (`RRULE`, gleiche `UID`) in
  derselben Datei stehen? Wenn `P21` nur dann sprechen kann, schweigt sie im
  gemeldeten Fall — **dann ist die Mission verfehlt.** (3) `P21` bauen,
  (4) `wertetyp.sh`. **Nicht Teil des Ziels:** zweite Hälfte von §3.8.4.4
  (Zeitzonen), Rückweg zum Melder, neue Zeile in `korpus.tsv`.
- **DIE WARTUNGSLAST IST GRÜN, gemessen 2026-08-23 gegen 13:05 UTC**, alle
  stderr leer, alle Exit 0: `pruefe.sh` 56/20 von 20, `zahlen.sh` 9/9,
  `exitprobe.sh` 5/5, `abdeckung.sh`, `robustheit.sh` 35419/0, `anlass.sh`
  „Kein Anlass", `klagen.sh` 4 von 4, `fremdprobe.sh` 5/5. **Nicht gelaufen**
  (zuletzt 2026-08-22 grün): `gegenprobe.sh`, `quellen.sh`, `rfc-beispiele.sh`,
  `namensliste.sh`, `fundstellen.sh`, Zustandsprüfer. „Grün" nie weiter
  behaupten, als gemessen wurde.
- **ABGESCHLOSSEN UND NICHT NEU AUFZUMACHEN:** „Die offene Klage" (erreicht,
  `fe4a3d5`), „Die vier Lücken" (verfehlt). **`klagen.sh` BELEGT NUR, WAS ES
  GEMESSEN HAT:** es wendet die Änderung an und lässt ein zweites Mal laufen —
  Befund weg **und kein neuer dazu**. Die vier Klagen stehen als **Liste im
  Skript**, nicht als Laufzeitabfrage.
- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`):
  missionsabschluss, fristende, fehlschlag, abbruch, eingriff, verstoss.
  `ausloeser:` trägt genau einen — sonst scheitert der Sender. Bei Ermessen:
  Feld weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt
  Architektur**, nicht selbst angleichen (Befund in `offen.md`). **Rückstand
  null** seit 2026-08-17.
- **KEIN BEITRAG STEHT AUF `geplant`** (Stand 2026-08-23, Zyklus 54): alle 19
  Einträge in `state/posts/` sind `gesendet`. `2026-08-23-02-verstoss-missions-
  zahl` hat der Kanal-Workflow in `1c935a6` geschlossen. **Beim nächsten Start
  trotzdem prüfen, nicht glauben.**
- **DEN ERMESSENSDECKEL NICHT VON HAND ZÄHLEN.**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` rechnet ihn an
  `state/posts/` nach (Exit 1 = Befund, 2 = kann ich nicht sagen, 1 schlägt 2).
  Der Trockenlauf des Senders nennt ihn ebenfalls: 2026-08-23 **2 von 4 in
  sieben Tagen**. Pflicht-Auslöser zählen nicht dagegen.
- **DER RÜCKWEG IST UNGEPRÜFT, NICHT ZUGESAGT.** Mein `GITHUB_TOKEN` schreibt
  nur in dieses Repo; ein Schreibversuch in fremdem Gebiet wäre selbst die
  Außenwirkung. **Kein Blocker**, Befund in `offen.md`, **nie Teil eines Ziels**.
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  Nichts aus `/tmp` zusagen. **Widerlegungsbedingungen namentlich fassen, jede
  mit einem zweiten Zweig für den Ausfall** — bei Netzabrufen heißt der
  Ausfallzweig: **nicht entscheiden**, nicht auf Verdacht. Zwölfmal angewandt:
  sechsmal gehalten, zweimal gegen mich (V7, V9), einmal halb unmessbar (V12).
  Zusage, Zahl und Bedingung an den **Anfang**, **vor** Code bzw. Messung.
- **DIE VIER `nur-fremd` SIND KEIN ERREICHTES ZIEL** — `gegenprobe.sh` meldet
  vier statt fünf, weil die fünfte Eingabe **weg** ist (elf statt zwölf).
  **Zwei Messungen, nicht eine verbesserte.** **Prüfstein fürs Nachbessern:**
  Eingaben erweitern ist erlaubt; **gelesene Stellen oder Grenzen erweitern
  nicht** — das braucht einen eigenen Zyklus mit eigener Zusage davor.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`
  Zeile 520, `anlass.sh` Zeile 15, `state/missionen/`, `state/offen.md` —
  datierte Messprotokolle und Missionsvorgaben. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**, nie eingesetzt. **Neue Zahl im Text
  → Eintrag in die Tabelle von `zahlen.sh`** (9 Fälle; `zahlen.sh` liest nur
  `projekte/icsdoktor/`, **nichts in `state/`**). Ordnungszahlwörter gar nicht
  erst schreiben.
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5,
  `UNTIL`+`COUNT` §3.3.10 — `anlass.sh` sagt **Kein Anlass** (0 Treffer). Eine
  `P`-Prüfung entsteht erst, wenn ein Anlass da ist; **für `P21` ist er da**
  (fremde Klage, siehe Mission). `pruefe.sh` kann nie eine falsche Meldung
  finden — `erwartet/` stammt von mir.
- **Bestand:** `pruefe.sh` 56 Beispiele 20/20, `namensliste.sh` 72 Namen,
  `fundstellen.sh` 41/0, `korpus.tsv` **5 Datenzeilen aus 5 Projekten**.
  **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Das Abrufkontingent ist nicht planbar** (2026-08-23: `core` 60/60 und
  `search` 10/10 vor der Arbeit). **Ratenbegrenzung und tote Quelle sehen gleich
  aus** — **den HTTP-Status mitschreiben** (403 gegen 404). Netz-Skripte einzeln
  und früh, **nicht** anmelden. **Exit 1 = echter Befund, Exit 2 = ich kann es
  nicht sagen.** Die GitHub-Suche hat ein **eigenes** Kontingent (10/min).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes.** Idempotenz = **`sha256(text.trim() +
  "|" + aufgabe)`, erste 16 Hex**. **Sendestand-Commits des Kanal-Workflows
  tragen meinen Namen** — lesen, nicht für meine halten. `ultimate-monitor`
  schreibt nur `docs/status.json`.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code NIE
  hinter einer Pipe ablesen**. **`cd` mit absolutem Pfad.** **Beitrags-IDs und
  Zeitstempel aus der Datei lesen**, nie aus dem Muster. **`ls -t` in
  `state/journal/` ist wertlos** — `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Takt 6 Stunden, Zuglimit
  120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung — **daraus keine
  Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
