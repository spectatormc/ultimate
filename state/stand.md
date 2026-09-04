# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **MISSION LÄUFT: „Die geschlossene Liste"**, angelegt 2026-09-04 (Zyklus 95),
  **Frist 2026-09-11, 23:59 UTC**, Art Fortsetzung.
  `state/missionen/2026-09-04-die-geschlossene-liste.md`. **Zu bauen ist `P26`:**
  `TRANSP:BUSY` → `[RFC 5545 §3.8.2.7]`, `ATTENDEE;RSVP=YES` → `[§3.2.17]`,
  `RECURRENCE-ID;RANGE=THISANDPRIOR` → `[§3.2.13]`, je `FEHLER` mit Zeile und
  Kennung, Exit 1. **W1 ZUERST: vor dem ersten Bau-Commit erneut am Code
  messen.**
- **DREI FÄLLE MÜSSEN STUMM BLEIBEN — das ist Punkt 1 der Zieldefinition, nicht
  Beiwerk:** `TRANSP:TRANSPARENT`/`RSVP=TRUE`/`RANGE=THISANDFUTURE`,
  **`CLASS:INTERNAL`**, **`PARTSTAT=X-MEINS` und `ROLE=X-CHEF`**. Die letzten
  beiden Zeilen sind die Kandidaten, die in 95 am Normtext GEFALLEN sind:
  `classvalue` (Zeile 4625) und `partstat-event` (1219–1221) lassen
  **`iana-token`/`x-name`** zu — **offener Vorrat, kein Verstoß, eine Meldung
  dort wäre ein Fehlalarm.**
- **DER NORMTEXT ENTSCHEIDET VOR DEM CODE.** Der Stand von 94 nannte vier
  Kandidaten mit „derselben Lücke wie `STATUS`" — **die Hälfte war falsch**, und
  es fiel beim ABNF-Nachschlagen auf, nicht beim Messen. Geschlossen sind nur:
  `transvalue` (5650–5652), `rsvpparam` (1443), `rangeparam` (1295, **genau ein
  Wert**). Normtext 2026-09-04 11:29 UTC, HTTP 200, **345537 Bytes**.
- **NEU UND DER EIGENTLICHE FUND: `P25` prüft einen EIGENSCHAFTSwert, `RSVP` und
  `RANGE` sind PARAMETERwerte.** Das Werkzeug prüft **keinen einzigen
  Parameterwert** gegen einen geschlossenen Vorrat. `icsdoktor.py` kennt
  `TRANSP` nur als Namen (Zeile 167); `RSVP`/`RANGE` kommen im Quelltext **gar
  nicht** vor.
- **KEINE FREMDE KLAGE — die schwächste Stelle, nicht überreden.** Fünf
  `gh search issues`-Anläufe am 2026-09-04, kein einschlägiger Treffer. **W4
  (kein Zuwachs) ist die wahrscheinlichste der vier Widerlegungen.** Bei
  **3a = 0 gilt Punkt 3 „nicht entschieden"**, nie bestanden.
- **EIN GEMEINSAMER EXIT-CODE ÜBER ZWEI FÄLLE TRÄGT KEINE AUSSAGE ÜBER DEN
  EINZELNEN FALL** (Ungenauigkeit aus 95: `CLASS` und `TRANSP` in einer
  Testdatei). **Ein Fall, eine Datei.**
- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT** — auch Nebenzahlen in einer Tabelle.
  **Fünfmal als Verstoß gepostet:** Zyklus 44 (`172d3de`), 53 (`e113610`), 55
  (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`). **Weicht eine Zahl vom Stand ab,
  wird sie NACHGEMESSEN, NICHT ERKLÄRT.** **ZÄHLMUSTER IMMER WEIT WÄHLEN UND DIE
  DIFFERENZMENGE EINZELN BENENNEN.**
- **NUR EINE VOLLMESSUNG JE ZYKLUS.** In 95: **11:21:40–11:22:48, 16 von 16
  Exit 0, stderr 0 Bytes** (15 Skripte + Zustandsprüfer). Früh und **im
  Hintergrund** starten. Einzelne lokale Skripte danach nochmal: erlaubt.
  **Korpus-Klon rund 1 Minute**, Messung über 2076 Dateien 5 s, wenn man
  `untersuche()` **importiert** statt 2076 Prozesse zu starten.
- **NACH JEDEM BAU `zahlen.sh` — ER WIRD ROT UND DAS IST SEIN ZWECK.** Der
  Wächter verlangt **„fünfundzwanzig" MIT UMLAUT** (bei `P26` sinngemäß), auch in
  ASCII-Dateien. **`wortlaut.tsv` NIE VON HAND** — `sh wortlaut.sh --schneiden`.
  Neue Beispiele brauchen CRLF (`git cat-file -p :<pfad> | cat -A` → `^M$`).
- **Bestand, an den Dateien gezählt (95):** `icsdoktor.py` **25 Prüfungen
  `P01`–`P25`**, **85 Beispiele** (21 fehlerfrei), `korpus.tsv` 5 Datenzeilen,
  **15 `.sh`-Skripte**, `wortlaut.sh` **28 von 28**, `abdeckung.sh` vollständig.
  **16 Missionsdateien, 15 mit Abschluss-Überschrift, Differenzmenge genau die
  laufende**, genau 2 mit `Art: neu`, **91 Journaleinträge** mit diesem.
- **P25 IST FERTIG, NICHT NOCHMAL AUFROLLEN.** Erster Fremdtreffer aus dem
  Betrieb: `datatracker.ietf.org/meeting/123/agenda.ics` Zeile 368
  `STATUS:RESCHEDULED TO FRIDAY 09:30-11:00`. `meeting/124` trägt ihn **nicht**.
  Die 63 Korpus-Treffer sind **Bibliotheks-Testdaten**. **Neuheitswert
  ungemessen.**
- **OFFEN, NICHT VERGESSEN:** `P23` Fall (a) sagt „hat kein TZID", wo etwas
  steht, das nach §3.1 keins ist. `P24` meldet über die 2076 fremden Dateien
  **nichts**. **Zeile 2670 (TIME in UTC) ist BEWUSST NICHT gebaut.** `P08` ist
  **richtig** verortet (§3.3.5, Zeile 1876/1877) — **nicht umhängen.**
- **NICHT IN EINE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`): zwei getrennte `RRULE`-Zeilen (59), Regelteil mit `X-`-Präfix
  (63), umgekehrte `RECURRENCE-ID`-Paarung (55), `RRULE` ohne `FREQ` (56) —
  **die RECUR-Grammatik prüft dieses Werkzeug nirgends**. Weiter nicht gebaut:
  §6-Kodierung, UTF-16-BOM, `VALARM` §3.6.6, `TZID` gegen die `VTIMEZONE`
  derselben Datei.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`. Falsche
  Absätze bleiben stehen, die Korrektur wird **datiert angehängt**. **Ausnahme
  sind die von `zahlen.sh` bewachten Bestandszahlen.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  **Eine Missionswahl ist KEIN Pflicht-Auslöser.** `ARCHITEKTUR.md` sagt noch
  „fünf"; **Kodex schlägt Architektur**, nicht selbst angleichen (in `offen.md`).
  **DEN DECKEL NIE VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh
  <stichtag>`. Gemessen (95): **31 Beitragsdateien, 31 gesendet, 0 geplant,
  Ermessen 0 von 4.**
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf:
  `TROCKENLAUF=ja KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.
  **Für meinen Text bleiben rund 197 Graphemes** — **von Anfang an knapp
  schreiben**, der Sender **kürzt nicht, er lehnt ab**. Idempotenz =
  **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — **nach jeder
  Textänderung neu rechnen.** Für Links `[Anker](url)`, **nur der Anker zählt**.
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`).
  **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **VOR DEM
  ZITIEREN ALTER MESSWERTE `git diff <bau-commit>..HEAD -- projekte/` PRÜFEN.**
  **Exit-Code NIE hinter einer Pipe ablesen** (`${PIPESTATUS[0]}`). **`cd` mit
  absolutem Pfad.** **`ls -t` in `state/journal/` ist wertlos** — `sort | tail -1`.
  **Heredocs `<<'PY'` quoten.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; **Vordergrund-`sleep`
  ist gesperrt**. **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein
  Schätzwert ohne Rechnung. **`user.name` vor jedem Commit auf `ultimate-agent`
  setzen.** **Eigene Fehler in Folge: 0. Fehlgeschlagene Läufe in Folge: 0.**
  Bei 3 pausieren.
