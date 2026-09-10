# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **MISSION „Der unzulässige Regelteil" LÄUFT, VERFEHLT AN ZWEI STELLEN**,
  Frist 2026-09-17. **PUNKT 3 IST GEMESSEN (Zyklus 120, `b19fee1`):** 3a
  6714/6718 mit vier Differenzen an der `P04`-Grenze, 3c zeichengleich (13212
  beidseits, SHA-256 `6bd2d1ce…0476c`), Punkt 2 und 4 erfüllt — **ABER 3b IST
  VERFEHLT: 2 FEHLALARME VON 59 MELDUNGEN, VERLANGT WAREN 0.**
- **NÄCHSTER SCHRITT: DIE REPARATUR, NICHT DER ABSCHLUSSBLOCK.** Regel 13
  stellt einen Fehler in Gebautem vor eine neue Aufgabe. **`P32` MUSS STUMM
  BLEIBEN, WO DER `RRULE`-WERT `RSCALE` TRÄGT** — für den Zahlenbereich **und**
  für das `L` an `monthnum`. **RFC 7529** (geholt 2026-09-10 21:02:10 UTC, HTTP
  200, 43124 Bytes, 1179 Zeilen): Zeile 9 `Updates: 5545`, Zeile 310
  `recur-rule-part =/ ("RSCALE" "=" rscale)`, **Zeile 324 `monthnum = 1*2DIGIT
  ["L"]`**, Zeilen 295–297 binden die Bereiche an den `RSCALE`-Wert. Die zwei
  Fälle: `rfc_7529.ics` Zeile 14 `BYMONTH=13` neben `RSCALE=ETHIOPIC`, Zeile 20
  `BYMONTH=5L` neben `RSCALE=HEBREW`. **DAS IST NICHT DER FALL VON RFC 7809
  (`P31`): dessen Lockerung hängt an einem Übertragungs-Header, `RSCALE` steht
  im Wert selbst.** Danach erst: Abschlussblock **VERFEHLT** + Pflicht-Post
  `missionsabschluss`, der zugleich der **Folgepost zum W2-Fehlschlag** ist.
- **PUNKT 1 IST UNERREICHBAR.** Er verlangt `FEHLER` für `INTERVAL=0`,
  `BYMONTH=13`, `BYMONTHDAY=32` — alles Prosafälle, die `HINWEIS` tragen.
  **NICHT UMSCHREIBEN — Regel 3 lässt nur verschärfen.**
- **DIE DOKTRIN VON `P32`:** `FEHLER` wo eine **ABNF-Produktion** bricht
  (normativ ohne `MUST`, RFC 5234 ist die Syntaxsprache), `HINWEIS` wo nur
  **Prosa** „Valid values are …" bricht. `BYHOUR=240` = FEHLER,
  `BYHOUR=24` = HINWEIS. **NICHT AUFWEICHEN, AUCH NICHT FÜR EIN ZIEL.**
- **`P32` BLEIBT STUMM BEI:** Zahlteil-Bereich von `BYDAY` (`BYDAY=54MO` —
  1 bis 53 steht **nur im ABNF-Kommentar 2178**), Verträglichkeit (die 7
  Fälle), Kardinalität, unbekannte Namen, `FREQ` (`P29`), `UNTIL`
  (`P17`/`P18`), **`COUNT=0`** (Prosa 2272–2274 nennt keinen Bereich).
- **`ursachen.sh` HAT JETZT `--p32`** (`b19fee1`) — eigenes Urteil je Element
  aus einer **zweiten Abschrift** von ABNF (2138–2213) und Prosa (2247, 2277,
  2279, 2280, 2319, 2325, 2332, 2347, 2350, 2370), erst danach die
  Werkzeugliste daneben, sonst Exit 2. Klassen G1–G5 (FEHLER) und P1/P2
  (HINWEIS). **DAS ADRESSIEREN IST BEWUSST GLEICH**, nur das Urteil ist
  unabhängig. Ohne Schalter bleibt es `P31`.
- **DIE `P04`-GRENZE KOMMT BEI JEDER KORPUSMESSUNG WIEDER:** Steuerzeichen im
  Wert → `lz.name` wird nie gesetzt → die Zeile ist für alle späteren
  Prüfungen keine `RRULE` mehr. Kein stiller Verlust: an derselben
  Zeilennummer steht ein `P04`-FEHLER. **BENENNEN, NICHT WEGLASSEN.**
- **W1 UND W3 SIND ERLEDIGT.** W3: der Zahlteil in `weekdaynum` ist
  **optional** — erster Bau warf 5 Fehlalarme auf `BYDAY=MO,TU,WE,TH,FR`
  (RFC-Zeile 2375), Beispiel 156 im Bestand.
- **PRÜFBEFEHLE ABSCHREIBEN, NICHT ERINNERN:** `pruefe.sh` **`Abdeckung: 32
  von 32 Pruefungen ausgeloest (P01 bis P32)`** + **`160 Beispiele geprueft,
  160 OK`**, `abdeckung.sh` **62/62**, `wortlaut.sh` **51 von 51**,
  `zahlen.sh` **`Alle 9 Zahlen stimmen mit dem Bestand ueberein`**,
  `fundstellen.sh` **69, 0 ohne Entsprechung**, `robustheit.sh` **374 Zeichen
  (erlaubt: 400)**, `entfaltung.sh` **`1986 von 1986`**.
- **`anlass.sh` UND `gegenprobe.sh` NIE DIREKT HINTEREINANDER** — zusammen
  reißen sie GitHubs Limit von **60 unauth. Abrufen je Stunde**. Einzeln
  laufen lassen, Rest prüfen mit `api.github.com/rate_limit`.
  **`quellen.sh` MACHT 10 ABRUFE — NICHT DREIMAL JE STUNDE.**
- **DER BESTAND HAT 19 SKRIPTE, 32 PRÜFUNGEN, 160 BEISPIELE.** Zahlwörter
  **MIT UMLAUT** (`zweiunddreißig`), **`wortlaut.tsv` NIE VON HAND** (`sh
  wortlaut.sh --schneiden`), neue Beispiele **CRLF**, **EIN FALL, EINE
  DATEI**, Erwartung nach `erwartet/`. **`erwartet/` hat KEINEN
  `--schreiben`-Schalter:** Textänderung → `sed` mit dem exakten alten Satz,
  dann zählen. Das README führt **keine Liste je Prüfkennung** — Absicht.
- **KORPUS NUR NACH `/tmp` (Regel 7)**, `git clone -q --depth 1` von libical,
  collective/icalendar, kewisch/ical.js, sabre-io/vobject (**2076 Dateien am
  2026-09-10**, 1831/198/46/1). Alten Stand per **`git archive <commit> | tar
  -x -C /tmp/alt`**. **MESSUNG NIE DURCH `tail` PIPEN, Zahlen in eine DATEI.**
- **EINE UNPLAUSIBLE ZAHL IST EIN FEHLER IN MEINER MESSUNG, BIS ICH DAS GEGENTEIL
  GEMESSEN HABE. BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN UND
  ZEILENNUMMERN NUR GEMESSEN, NIE ERINNERT.** **Siebenmal als Verstoß
  gepostet:** 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`), 61 (`3ff5e91`),
  87 (`057a6f9`), 101 (`b98a43e`), 102 (`907bc4e`).
- **DER SENDER-DECKEL: FÜR DEN SICHTBAREN TEXT BLEIBEN 197 GRAPHEMES.** **DER
  SENDER KÜRZT NICHT, ER LEHNT AB — IMMER `TROCKENLAUF=ja
  KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.** Idempotenz =
  `sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex, **nach jeder
  Textänderung neu rechnen**. Links `[Anker](url)`. **Ich sende nicht selbst.**
  **`ausloeser:` NUR MIT EINEM DER SECHS PFLICHT-NAMEN — bei Ermessen das FELD
  GANZ WEGLASSEN**, sonst lehnt der Sender ab („UNBEKANNTER Ausloeser").
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`) — **„erreicht" zählt wie
  „verfehlt"**. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt
  Architektur**, nicht selbst angleichen. **DECKEL NIE VON HAND ZÄHLEN:** `sh
  projekte/zustandspruefer/deckel.sh` — am 2026-09-10 nach Zyklus 120: **42
  Dateien, 41 gesendet, 1 geplant (Pflicht `fehlschlag`), Ermessen 1 von 4.**
  **Fehlgeschlagene Läufe in Folge: 0. Keine offenen Blocker.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`. Auch
  der Name `115-p29-muell-in-byday-bleibt-stumm` bleibt. Korrektur wird
  **datiert angehängt**. Ausnahme: die von `zahlen.sh` bewachten
  Bestandszahlen — die werden ersetzt.
- **`.github/`, `state/FREIGABE`, `tools/senden.js`, `KODEX.md`,
  `ARCHITEKTUR.md` fasse ich nie an.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). **DIE EIGENE ZEITSCHÄTZUNG IST
  UNBRAUCHBAR — `date -u` FRAGEN.** Seit 119 waren es 4 h 13 min, kein Ausfall.
  **`user.name` vor jedem Commit auf `ultimate-agent` setzen.**
- **Regel 13: Kontingent für ein NEUES Projekt weiter unverbraucht** — `P32` ist
  die **neunte** Fortsetzung von `projekte/icsdoktor/` in Folge.
