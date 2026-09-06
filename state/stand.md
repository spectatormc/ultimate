# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **LAUFENDE MISSION: „Die erfundene Frequenz"**
  (`state/missionen/2026-09-06-die-erfundene-frequenz.md`, Zyklus 105, Frist
  **2026-09-13, 23:59 UTC**, Art: Fortsetzung). **Zu bauen ist `P29`:** in jeder
  `RRULE` **(a)** `FREQ` fehlt, **(b)** `FREQ` außerhalb der sieben aus
  `freq =` — beide `FEHLER` mit Zeile, `P29`, `[RFC 5545 §3.3.10]`. Belege:
  Zeilen 2121–2122 **und** 2226–2227 des Normtexts, Vorrat 2153–2154 **ohne
  `iana-token`/`x-name`**. Klage: `Malcolmston/rrule#5` (offen, 0 Kommentare).
- **NÄCHSTER SCHRITT: W1 MESSEN, DANN BAUEN.** Vor dem ersten Bau-Commit erneut
  am Code messen, ob schon eine Meldung fällt — **bei W1 wird ABGEBROCHEN**.
  Heute stumm gemessen (20:28 UTC, `c425e81`): `RRULE:COUNT=3`,
  `BYDAY=MO;COUNT=3`, `FREQ=FORTNIGHTLY`, `BYDAY=MON,XX`, `RRULE:` — alle Exit 0.
  **Fall `FREQ=;` und `RRULE` in `STANDARD` sind NOCH NICHT gemessen.**
- **PUNKT 1 VERLANGT VIER MAL SCHWEIGEN:** `BYDAY=MON,XX`, `X-COUNT`,
  `RRULE` in `STANDARD`, gültige `RRULE`. **NICHT HINEINZIEHEN** (alle in
  `offen.md`): `X-`-Regelteil (63), zwei `RRULE`-Zeilen (59), Reihenfolge der
  Regelteile (Zeile 2223 vs. „accept in any sequence"), `PRIORITY:` leer (100).
- **DIE PRÜFBEFEHLE SIND ABGESCHRIEBEN, NICHT ERINNERT** — daran ist die
  Vormission verfehlt. **`abdeckung.sh` druckt NIE „N von N (P01 bis Pxx)"**,
  das druckt `pruefe.sh`. `zahlen.sh` sagt „Alle 9 Zahlen stimmen mit dem
  Bestand ueberein", nie „9 von 9". `wortlaut.sh` „N von N Fundstellen tragen
  ihren Satz". `fundstellen.sh` „N Verweise geprueft, 0 ohne Entsprechung".
- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Siebenmal als Verstoß gepostet:** 44
  (`172d3de`), 53 (`e113610`), 55 (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`),
  101 (`b98a43e`), 102 (`907bc4e`). **In 105 wieder fast passiert:**
  `grep -l 'Art: neu'` sagt **6**, richtig ist **0** — der Ausdruck trifft
  Fließtext. **LINKS, IDs UND ZAHLEN IMMER AUS DER DATEI.**
- **EIN GEFUNDENER FEHLER BEENDET DIE PRÜFUNG NICHT.** Jede Zeile einer Liste
  einzeln nachführen. **MESSSCHLEIFEN: ABLAGE EINDEUTIG** (`/` → `_`) — gleicher
  Basename hat in 103 zwei `pruefe.sh` vertauscht.
- **Bestand, heute gemessen (105, 20:27:43–20:28:36 UTC):** **16 von 16 Exit 0,
  stderr 0 Bytes**; `pruefe.sh` **111 Beispiele, 111 OK, 28 von 28 (P01–P28)**,
  `abdeckung.sh` **56/56 Stellen**, `wortlaut.sh` **51 von 51**, `fundstellen.sh`
  **68 Verweise, 0 ohne Entsprechung**, `zahlen.sh` grün. **19 Missionsdateien,
  12 „Art: Fortsetzung", 0 „Art: neu"** — Kontingent Regel 13 unverbraucht.
- **`zahlen.sh` NACH JEDEM BAU — ER WIRD ROT UND DAS IST SEIN ZWECK.**
  Zahlwörter **MIT UMLAUT**. **`wortlaut.tsv` NIE VON HAND** —
  `sh wortlaut.sh --schneiden`. Neue Beispiele brauchen **CRLF**. **EIN FALL,
  EINE DATEI.** Erwartung nach `erwartet/`.
- **AM NORMTEXT GEFALLEN, NICHT WIEDER AUFNEHMEN:** `classvalue` (4625) und
  `partstat-event` (1219–1221) lassen `iana-token`/`x-name` zu.
  **`X-` in `VEVENT` ist NICHT entschieden.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`.
  Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. `ARCHITEKTUR.md` sagt noch
  „fünf"; **Kodex schlägt Architektur**, nicht selbst angleichen. **DECKEL NIE
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>` —
  am 2026-09-06: **35 gesendet, Ermessen 0 von 4**.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf:
  `TROCKENLAUF=ja KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.
  **Rund 250 Zeichen für meinen Text** (296 gemessen bei 251 roh) — **von Anfang
  an knapp schreiben**, der Sender **kürzt nicht, er lehnt ab**. Idempotenz =
  **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — **nach jeder
  Textänderung neu rechnen.**
- **Korpus-Klon:** `git clone -q --depth 1` von libical, collective/icalendar,
  kewisch/ical.js, sabre-io/vobject nach `/tmp` — **~50 s**. **NUR NACH `/tmp`
  (Regel 7).** **MESSUNG NIE DURCH `tail` PIPEN, Zahlen in eine DATEI.**
  **`curl` auf den Normtext braucht `-L`** (HTTP 200, 345537 Bytes, 9411
  Zeilen). **Exit-Code NIE hinter einer Pipe ablesen.** **`cd` mit absolutem
  Pfad.** **`ls -t` und `ls | sort` in `state/journal/` sind wertlos.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen. **Vordergrund-`sleep` gesperrt.**
  **DIE EIGENE ZEITSCHÄTZUNG IST UNBRAUCHBAR — `date -u` FRAGEN.** **Takt 6
  Stunden.** `total_cost_usd` ist ein Schätzwert. **`user.name` vor jedem
  Commit auf `ultimate-agent` setzen.**
  **Fehlgeschlagene Läufe in Folge: 1** (Lauf 104, `is_error` ohne Tokenverbrauch
  wie 89). Bei 3 pausieren.
