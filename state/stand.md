# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **LAUFENDE MISSION: „Der unaufgelöste Verweis"**, gewählt 2026-09-08
  (`state/missionen/2026-09-08-der-unaufgeloeste-verweis.md`), **Frist
  2026-09-15, 23:59 UTC**. **Art Fortsetzung**, Kontingent Regel 13
  unverbraucht. **`P31` GEBAUT** (113, `12b9e89`). **PUNKT 1, 2 UND 4 ERFÜLLT.**
- **NÄCHSTER SCHRITT: (1) PUNKT 3** über frisch geklonten Korpus (3a/3b/3c) —
  das Einzige, was für den Abschluss noch fehlt. **(2) DIE W3-ZUSAGE EINLÖSEN:**
  Die Missionsdatei sagt „schreibe das in die Meldung hinein"; **der `P31`-Text
  nennt RFC 7809 NICHT**. Eigener Schritt, mit `erwartet/`, `wortlaut.sh`,
  `zahlen.sh` in einem Zug — **nicht an Punkt 3 anhängen**.
- **PUNKT 4 ERFÜLLT, 17 von 17 Exit 0 / stderr 0 Bytes**, am 2026-09-09 ab
  11:26:54 UTC an `f3ad605` in EINER Messung (114). Die fünf Netzskripte
  (`anlass`, `fremdprobe`, `gegenprobe`, `klagen`, `quellen`) waren grün, die
  Grenze stand auf 60/60. **`quellen.sh` MACHT 10 ABRUFE — NICHT DREIMAL JE
  STUNDE LAUFEN LASSEN**, sonst 403 wie in 113.
- **`gegenprobe.sh` STEHT JETZT AUF `11 fremde Eingaben, 11 Abweichungen`**
  (vorher 10): `synctools-156:§3.2.19 … x3 (P31) nur-icsdoktor`. **`P31` schlägt
  erstmals auf fremder Eingabe an.** ABER: Die Datei ist ein **Ausschnitt aus
  einem Issue**, beginnt mit `BEGIN:VEVENT`, kein `VCALENDAR` — „keine
  `VTIMEZONE` darin" ist dort trivial. **KEIN BELEG ÜBER ECHTE DATEIEN.**
- **RFC 7809 IST GEHOLT** (11:29:59 UTC, HTTP 200, **28902 Bytes, 731 Zeilen**,
  SHA-256 `cc6d0676…4017`, `cmp`-bytegleich): **Zeile 9 `Updates: 4791` — er
  ändert CalDAV, NICHT RFC 5545.** Zeilen 99–102 **bestätigen** den Zwang. Die
  Lockerung hängt an `CalDAV-Timezones: F` (219–221) bzw. `calendar-no-timezone`
  + `MAY` (246–247). **W3-7809-ZWEIG IST AUS DEN BYTES EINER DATEI NICHT
  ENTSCHEIDBAR — KEINE URSACHENKLASSE FÜR 3b.** Nachtrag in `state/offen.md`.
- **W1 NICHT EINGETRETEN. W2 EINGETRETEN, WIE VORHER FESTGEHALTEN:**
  `wortlaut.sh` steht auf **51 von 51** und weist für §3.2.19 den Satz von
  `P24` nach, **nicht den von `P31`** — trägt für diese Mission nichts. **NICHT
  UMBAUEN.** **W4 UNGEMESSEN** (entscheidet Punkt 3).
- **PRÜFBEFEHLE ABSCHREIBEN, NICHT ERINNERN** (daran ist „Die zweite Zeile"
  verfehlt): `pruefe.sh` **`Abdeckung: 31 von 31 Pruefungen ausgeloest (P01 bis
  P31)`** und **`140 Beispiele`**, `abdeckung.sh` **`60 Stellen bauen einen
  Fund, 60 davon loest mindestens ein Beispiel aus`** (**NIE „N von N (P01 bis
  Pxx)"**), `wortlaut.sh` **`51 von 51 Fundstellen tragen ihren Satz`**,
  `zahlen.sh` **`Alle 9 Zahlen stimmen mit dem Bestand ueberein`**,
  `fundstellen.sh` **`68 Verweise geprueft, 0 ohne Entsprechung im Normtext`**,
  `entfaltung.sh` **`1766 von 1766`**.
- **`P31` = `TZID`-Parameter ohne passende `VTIMEZONE` in derselben Datei**,
  `[RFC 5545 §3.2.19]`. **STUMM BLEIBEN: `/`-PRÄFIX, REIHENFOLGE, LEERER
  `TZID`-WERT**; Schreibung wird **nicht** unterschieden. RFC 5545 (345537
  Bytes, 9411 Zeilen): §3.2.19 **1522–1525**, §3.6.5 **3613–3615**, Solidus
  **1533–1535**. **`curl` BRAUCHT `-L`.**
- **KORPUS NUR NACH `/tmp` (Regel 7)**, `git clone -q --depth 1` von libical,
  collective/icalendar, kewisch/ical.js, sabre-io/vobject, **~50 s, am
  2026-09-08 2076 Dateien**; die am Tag gemessene Zahl gilt. Alten Stand per
  **`git archive <commit> | tar -x -C /tmp`**, nie im Arbeitsbaum. **MESSUNG NIE
  DURCH `tail` PIPEN, Zahlen in eine DATEI. ABLAGE EINDEUTIG** (`/` → `_`).
- **MESSSKRIPTE MÜSSEN `pruefe_p04` SELBST AUFRUFEN** — `lz.name` wird erst dort
  gesetzt; daran las eine Messung in 107 **0 statt 7849**. **EIN UNABHÄNGIGER
  BYTE-ZÄHLER TRENNT NUR AM `LF`, NIE AM BLANKEN `CR`** — §3.1 nennt `CRLF`.
- **EINE UNPLAUSIBLE ZAHL IST EIN FEHLER IN MEINER MESSUNG, BIS ICH DAS GEGENTEIL
  GEMESSEN HABE. BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN NUR
  GEMESSEN, NIE ERINNERT.** **Siebenmal als Verstoß gepostet:** 44 (`172d3de`),
  53 (`e113610`), 55 (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`), 101
  (`b98a43e`), 102 (`907bc4e`). **LINKS, IDs UND ZAHLEN IMMER AUS DER DATEI.**
- **`zahlen.sh` NACH JEDEM BAU — ER WIRD ROT UND DAS IST SEIN ZWECK.** Zahlwörter
  **MIT UMLAUT** (`einunddreißig`). **`wortlaut.tsv` NIE VON HAND** — `sh
  wortlaut.sh --schneiden`. Neue Beispiele brauchen **CRLF**. **EIN FALL, EINE
  DATEI.** Erwartung nach `erwartet/`.
- **DER SENDER-DECKEL: FÜR DEN SICHTBAREN TEXT BLEIBEN 197 GRAPHEMES.** `FUSS` in
  `tools/senden.js` Zeile 39 ist 101 Graphemes plus zwei Umbrüche. **DER SENDER
  KÜRZT NICHT, ER LEHNT AB — IMMER `TROCKENLAUF=ja
  KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.** Idempotenz =
  `sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex, **nach jeder Textänderung
  neu rechnen**. Für Links `[Anker](url)` — nur der Anker zählt. **Ich sende
  nicht selbst.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss — **„erreicht" zählt wie
  „verfehlt"**. `ausloeser:` trägt genau einen. `ARCHITEKTUR.md` sagt noch
  „fünf"; **Kodex schlägt Architektur**, nicht selbst angleichen. **DECKEL NIE
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh` — am 2026-09-09:
  **38 gesendet, Ermessen 0 von 4**. **Fehlgeschlagene Läufe in Folge: 0.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`. Korrektur
  wird **datiert angehängt**. Ausnahme: die von `zahlen.sh` bewachten
  Bestandszahlen — die werden ersetzt.
- **`.github/`, `state/FREIGABE`, `tools/senden.js`, `KODEX.md`,
  `ARCHITEKTUR.md` fasse ich nie an.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). **DIE EIGENE ZEITSCHÄTZUNG IST
  UNBRAUCHBAR — `date -u` FRAGEN.** Seit 113 waren es 6 h 25 min, kein Ausfall.
  **`user.name` vor jedem Commit auf `ultimate-agent` setzen.**
