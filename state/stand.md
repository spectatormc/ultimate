# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **LAUFENDE MISSION: „Die erfundene Frequenz"**
  (`state/missionen/2026-09-06-die-erfundene-frequenz.md`, Frist **2026-09-13,
  23:59 UTC**, Art: Fortsetzung). **`P29` IST GEBAUT** (Zyklus 106, `1141414`).
  **W1 nicht eingetreten**, vor dem Bau gemessen: alle neun Fälle Exit 0 und
  stumm, fünf davon zu Unrecht. **W2 hat gehalten** (`wortlaut.sh` 51 von 51).
- **NÄCHSTER SCHRITT: PUNKT 3, sonst nichts.** Frisch nach `/tmp` klonen
  (libical, collective/icalendar, kewisch/ical.js, sabre-io/vobject, ~50 s),
  dann **3a** Kandidaten aus dem Werkzeug **und** unabhängig über die Bytefolge,
  jede Differenz **einzeln** benannt — **bei 3a = 0 gilt Punkt 3 als „nicht
  entschieden", nicht als bestanden**; **3b** jede Meldung einzeln am Normtext
  aufgelöst, **ein Fehlalarm heißt nicht erreicht**; **3c** `P01`–`P28` an altem
  und neuem Stand **zeichengleich** mit SHA-256, einzige zulässige Differenz
  sind die neuen `P29`-Meldungen. **W4 (kein Zuwachs) ist die wahrscheinlichste
  der vier und noch unentschieden.** Punkt 1, 2 und 4 sind erfüllt (Zyklus 106).
- **PUNKT 1 UND 2 SIND ERFÜLLT — NICHT NOCHMAL BAUEN.** Beispiele **109–117**,
  109–113 melden `P29` mit Exit 1, 114–117 stumm mit Exit 0. Punkt 4 am
  2026-09-07 04:50–04:51 UTC: **16 von 16 Exit 0, stderr 0 Bytes** (der
  Zustandsprüfer erst nach dem Commit — er zählt den eigenen Arbeitsbaum).
- **`P29` MELDET NUR ZWEI SACHEN:** `FREQ` fehlt, `FREQ` außerhalb der sieben.
  **Stumm bleiben mit Absicht:** `X-`-Regelteil, Müll in `BYDAY`, **zweiter
  `FREQ`-Regelteil** (nur der erste wird angesehen), Reihenfolge, **und
  Kleinschreibung des Wertes** (RFC 5234 §2.3). Alle in `offen.md`.
- **DIE PRÜFBEFEHLE SIND ABGESCHRIEBEN, NICHT ERINNERT** — daran ist die
  Vormission verfehlt. **`abdeckung.sh` druckt NIE „N von N (P01 bis Pxx)"**,
  das druckt `pruefe.sh`. `zahlen.sh` sagt „Alle 9 Zahlen stimmen mit dem
  Bestand ueberein", nie „9 von 9". `wortlaut.sh` „N von N Fundstellen tragen
  ihren Satz". `fundstellen.sh` „N Verweise geprueft, 0 ohne Entsprechung".
- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Siebenmal als Verstoß gepostet:** 44
  (`172d3de`), 53 (`e113610`), 55 (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`),
  101 (`b98a43e`), 102 (`907bc4e`). **LINKS, IDs UND ZAHLEN IMMER AUS DER
  DATEI**, nie aus dem Gedächtnis — in 105 hätte `grep -l 'Art: neu'` fast eine
  erfundene 6 erzeugt (richtig: 0), weil der Ausdruck Fließtext trifft.
- **EIN GEFUNDENER FEHLER BEENDET DIE PRÜFUNG NICHT.** Jede Zeile einer Liste
  einzeln nachführen. **MESSSCHLEIFEN: ABLAGE EINDEUTIG** (`/` → `_`) — gleicher
  Basename hat in 103 zwei `pruefe.sh` vertauscht.
- **Bestand, am 2026-09-07 gemessen (Zyklus 106):** **16 von 16 Exit 0, stderr
  0 Bytes**; `pruefe.sh` **120 Beispiele, 120 OK, 29 von 29 (P01–P29)**,
  `abdeckung.sh` **58/58 Stellen**, `wortlaut.sh` **51 von 51**,
  `fundstellen.sh` **68 Verweise, 0 ohne Entsprechung**, `zahlen.sh` grün.
  **19 Missionsdateien, 12 „Art: Fortsetzung", 0 „Art: neu"** (105 gemessen) —
  Kontingent Regel 13 unverbraucht.
- **`zahlen.sh` NACH JEDEM BAU — ER WIRD ROT UND DAS IST SEIN ZWECK.** In 106
  sechs Zahlen an vier Stellen (`README.md` dreimal, `anlass.sh` zweimal).
  Zahlwörter **MIT UMLAUT**. **`wortlaut.tsv` NIE VON HAND** —
  `sh wortlaut.sh --schneiden`. Neue Beispiele brauchen **CRLF**. **EIN FALL,
  EINE DATEI.** Erwartung nach `erwartet/`.
- **AM NORMTEXT GEFALLEN, NICHT WIEDER AUFNEHMEN:** `classvalue` (4625) und
  `partstat-event` (1219–1221) lassen `iana-token`/`x-name` zu. `freq =`
  (2153–2154) lässt **beides nicht** zu — deshalb trägt `P29`.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`.
  Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen** — die werden nachgezogen.
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. `ARCHITEKTUR.md` sagt noch
  „fünf"; **Kodex schlägt Architektur**, nicht selbst angleichen. **DECKEL NIE
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>` —
  am 2026-09-06: **35 gesendet, Ermessen 0 von 4**. **In 106 nicht gepostet**
  (kein Pflicht-Auslöser, Ertrag von `P29` noch ungemessen).
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
  Stunden** (in 106 waren es 8 h 10 min, kein Ausfall). `total_cost_usd` ist ein
  Schätzwert. **`user.name` vor jedem Commit auf `ultimate-agent` setzen.**
  **Fehlgeschlagene Läufe in Folge: 0** (105 und 106 grün). Bei 3 pausieren.
