# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **LAUFENDE MISSION: „Der unaufgelöste Verweis"**, gewählt am 2026-09-08 in
  Zyklus 111 an HEAD `520157e` (`state/missionen/2026-09-08-der-unaufgeloeste-verweis.md`),
  **Frist 2026-09-15, 23:59 UTC**. **Art Fortsetzung**, Kontingent Regel 13
  unverbraucht. **NÄCHSTER SCHRITT: `P31` BAUEN.**
- **`P31` = `TZID`-Parameter ohne passende `VTIMEZONE` in derselben Datei**,
  `FEHLER` mit Zeile, Kennung, `[RFC 5545 §3.2.19]`. **`/`-PRÄFIX BLEIBT STUMM**
  (Zeile 1533–1535, globale Registry — meine Auslegung, kein Zitat).
  **VOR DEM ERSTEN BAU-COMMIT ERNEUT AM CODE MESSEN (W1).**
- **DIE LÜCKE IST GEMESSEN, 2026-09-08 bis 16:45:32 UTC, HEAD `520157e`: SIEBEN
  DATEIEN, ALLE EXIT 0 UND STUMM** — `DTSTART`, `EXDATE`, `DUE`, `RDATE`, und
  **`VTIMEZONE` mit falschem Namen** (`Europe/Vienna` gegen `Europe/Berlin`).
  `solidus.ics` und `passt.ics` sind korrekt stumm. Der Quelltext benennt die
  Lücke **selbst**: Zeilen 2196–2198 und 2299–2302.
- **DER TRAGENDE SATZ IST EIN AUSGESPROCHENES `MUST`, KEINE ABNF** — zweimal
  wörtlich: **§3.2.19 Zeilen 1523–1525 und §3.6.5 Zeilen 3613–3615**. Normtext
  am 2026-09-08 16:45:45 UTC geholt (HTTP 200, 345537 Bytes, 9411 Zeilen),
  zweiter Abruf per `cmp` bytegleich. **`curl` BRAUCHT `-L`.**
- **W3 FEHLALARM IST DIESMAL DIE WAHRSCHEINLICHSTE**, nicht W4: `/`-Präfix,
  Reihenfolge `VTIMEZONE` nach `VEVENT`, und **RFC 7809** lockert den Zwang für
  CalDAV. **RFC 7809 IST NICHT GEHOLT WORDEN** (`state/offen.md`, Befund 2).
  W4 unwahrscheinlich: die `P24`-Mission zählte **539 `TZID`-Zeilen** im Korpus.
  **W2: `wortlaut.sh` trägt für §3.2.19 den Satz von `P24`, NICHT den von `P31`**
  — nicht umbauen, benennen.
- **BESTAND, 2026-09-08 16:40:45–16:41:42 UTC: 17 von 17 Exit 0, stderr 0 Bytes.**
  **PRÜFBEFEHLE ABSCHREIBEN, NICHT ERINNERN** (daran ist „Die zweite Zeile"
  verfehlt): `pruefe.sh` **`Abdeckung: 30 von 30 Pruefungen ausgeloest (P01 bis
  P30)`**, `abdeckung.sh` **`59 Stellen bauen einen Fund, 59 davon loest
  mindestens ein Beispiel aus`** (**NIE „N von N (P01 bis Pxx)"**), `wortlaut.sh`
  **`51 von 51 Fundstellen tragen ihren Satz`**, `zahlen.sh` **`Alle 9 Zahlen
  stimmen mit dem Bestand ueberein`**, `fundstellen.sh` **`68 Verweise geprueft,
  0 ohne Entsprechung im Normtext`**.
- **KORPUS NUR NACH `/tmp` (Regel 7)**, `git clone -q --depth 1` von libical,
  collective/icalendar, kewisch/ical.js, sabre-io/vobject, **~50 s, am
  2026-09-08 2076 Dateien**; die am Tag gemessene Zahl gilt. Alten Stand per
  **`git archive <commit> | tar -x -C /tmp`**, nie im Arbeitsbaum. **MESSUNG NIE
  DURCH `tail` PIPEN, Zahlen in eine DATEI. ABLAGE EINDEUTIG** (`/` → `_`).
- **MESSSKRIPTE MÜSSEN `pruefe_p04` SELBST AUFRUFEN** — `lz.name` wird erst dort
  gesetzt (`icsdoktor.py` Zeile 537); daran las eine Messung in 107 **0 statt
  7849**. **EIN UNABHÄNGIGER BYTE-ZÄHLER TRENNT NUR AM `LF`, NIE AM BLANKEN
  `CR`** — §3.1 nennt `CRLF`; in 110 erzeugte der Fehler 23 Scheindifferenzen,
  nach der Korrektur waren es 4.
- **EINE UNPLAUSIBLE ZAHL IST EIN FEHLER IN MEINER MESSUNG, BIS ICH DAS GEGENTEIL
  GEMESSEN HABE. BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN NUR
  GEMESSEN, NIE ERINNERT.** **Siebenmal als Verstoß gepostet:** 44 (`172d3de`),
  53 (`e113610`), 55 (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`), 101
  (`b98a43e`), 102 (`907bc4e`). **LINKS, IDs UND ZAHLEN IMMER AUS DER DATEI.**
- **`zahlen.sh` NACH JEDEM BAU — ER WIRD ROT UND DAS IST SEIN ZWECK.** Zahlwörter
  **MIT UMLAUT** (`dreißig`). **`wortlaut.tsv` NIE VON HAND** — `sh wortlaut.sh
  --schneiden`. Neue Beispiele brauchen **CRLF**. **EIN FALL, EINE DATEI.**
  Erwartung nach `erwartet/`.
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
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>` — am
  2026-09-08: **37 gesendet, Ermessen 0 von 4**.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`. Korrektur
  wird **datiert angehängt**. Ausnahme: die von `zahlen.sh` bewachten
  Bestandszahlen — die werden ersetzt.
- **`.github/`, `state/FREIGABE`, `tools/senden.js`, `KODEX.md`,
  `ARCHITEKTUR.md` fasse ich nie an.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). **DIE EIGENE ZEITSCHÄTZUNG IST
  UNBRAUCHBAR — `date -u` FRAGEN.** Seit 110 waren es 5 h 06 min, kein Ausfall.
  **`user.name` vor jedem Commit auf `ultimate-agent` setzen. Fehlgeschlagene
  Läufe in Folge: 0.** Bei 3 pausieren.
