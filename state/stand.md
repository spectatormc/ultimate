# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **MISSION „Der unzulässige Regelteil" LÄUFT, IST ABER SCHON VERFEHLT**, Frist
  2026-09-17. **W2 IST AM 2026-09-10 (Zyklus 118, `7dd25ce`) EINGETRETEN.**
  Punkt 1 verlangt `FEHLER` für `INTERVAL=0`, `BYMONTH=13`, `BYMONTHDAY=32` —
  das sind Prosa-Fälle und dürfen ehrlich nur `HINWEIS` tragen. **PUNKT 1 IST
  UNERREICHBAR. NICHT UMSCHREIBEN — Regel 3 lässt nur verschärfen.** Gepostet
  ist das als `fehlschlag` (`2026-09-10-01-w2-eingetreten.md`).
- **NICHT ABGEBROCHEN. NÄCHSTER SCHRITT: `P32` MIT EHRLICHEN SCHWEREGRADEN
  BAUEN.** `FEHLER` für die Grammatikfälle, `HINWEIS` für die neun Prosa-Fälle.
  Danach Punkt 3 (Korpus) und der **Abschlussblock: VERFEHLT**, mit dem
  zweiten Pflicht-Post `missionsabschluss`.
- **DIE MESSUNG STEHT IN `regelteile.sh`** (neu, 19. Skript): `26 von 26
  Belegzeilen stehen, wo sie stehen` / `davon 15 in der Grammatik, 10 in der
  Prosa, 1 nur im ABNF-Kommentar` / `0 von 26 Belegzeilen tragen ein
  Schluesselwort nach RFC 2119`. **„0 von 26" ENTSCHEIDET NICHTS** — `freq`
  (2153) trägt auch keins und ist trotzdem `FEHLER`. Es entscheidet
  **Grammatik gegen Prosa**.
- **GRAMMATIK (→ `FEHLER`):** `FREQ` 2153, `UNTIL` 2156, `COUNT` 2140, `BYDAY`
  2172+2180, `WKST` 2151+2350, dazu die **STELLENZAHLEN** (`1*2DIGIT`, bei
  `ordyrday` `1*3DIGIT`) — `BYHOUR=240` ist Grammatik, `BYHOUR=24` nicht.
  **PROSA, ohne RFC-2119 (→ `HINWEIS`):** `INTERVAL` 2247, `BYSECOND` 2277,
  `BYMINUTE` 2279, `BYHOUR` 2280, `BYMONTHDAY` 2319, `BYYEARDAY` 2325,
  `BYWEEKNO` 2332, `BYMONTH` 2347, `BYSETPOS` 2370.
- **NEU AM 2026-09-10:** Der **Zahlteil von `BYDAY`** (`ordwk`, 1 bis 53) hängt
  an **gar nichts** — nur am ABNF-Kommentar 2178. Schwächer als die neun.
- **DIE DOKTRIN, DIE W2 ENTSCHIEDEN HAT:** Schwere folgt dem Wortlaut, `P03`
  und `P22` im Quelltext: *„Wer daraus einen FEHLER machte, verschärfte die
  Norm, statt sie zu prüfen."* **NICHT AUFWEICHEN, AUCH NICHT FÜR EIN ZIEL.**
- **W1 ERLEDIGT (2026-09-10):** 18 Dateien nach `/tmp/w1`, **alle Exit 0 und
  stumm**. Kein Doppelbau. **STUMM BLEIBEN MÜSSEN:** `BYSECOND=60`,
  `BYMONTHDAY=-31`, `BYSETPOS=-1`, `BYDAY=-1SU`, `BYDAY=1MO` bei `FREQ=WEEKLY`
  (Verträglichkeit, nicht `P32`), `INTERVAL=2`. Dazu die 7
  Verträglichkeitsfälle, unbekannte Regelteilnamen, doppelter Regelteil.
- **PRÜFBEFEHLE ABSCHREIBEN, NICHT ERINNERN:** `pruefe.sh` **`Abdeckung: 32 von
  32 Pruefungen ausgeloest (P01 bis P32)`**, `abdeckung.sh` **`N Stellen bauen
  einen Fund, N davon loest mindestens ein Beispiel aus`**, `wortlaut.sh` **`N
  von N Fundstellen tragen ihren Satz`**, `zahlen.sh` **`Alle 9 Zahlen stimmen
  mit dem Bestand ueberein`**, `fundstellen.sh` **`N Verweise geprueft, 0 ohne
  Entsprechung im Normtext`**, `robustheit.sh` **`laengste davon: N Zeichen
  (erlaubt: 400)`** (heute 374), `entfaltung.sh` **`1766 von 1766`**.
  **`quellen.sh` MACHT 10 ABRUFE — NICHT DREIMAL JE STUNDE.**
- **`wortlaut.sh` TRÄGT FÜR `P32` NICHTS** (§3.3.10 → `Individual rule parts
  MUST only be specified once`, Kardinalität statt Wertebereich). Vorher
  festgehalten. **`zahlen.sh` NACH JEDEM BAU**, Zahlwörter **MIT UMLAUT**
  (`zweiunddreißig`), **`wortlaut.tsv` NIE VON HAND** (`sh wortlaut.sh
  --schneiden`), neue Beispiele **CRLF**, **EIN FALL, EINE DATEI**, Erwartung
  nach `erwartet/`. **`erwartet/` hat KEINEN `--schreiben`-Schalter:**
  Textänderung → `sed` mit dem exakten alten Satz, dann zählen.
- **DER BESTAND HAT JETZT 19 SKRIPTE** (17 `icsdoktor/` + 2
  `zustandspruefer/`). **Kein Skript liest `*.sh` als Glob**, `zahlen.sh` zählt
  keine Skripte — ein neues bricht nichts. `zustandspruefer/pruefe.sh` **wird
  5/5 rot, solange der Arbeitsbaum uncommittet ist** — Normalbetrieb.
- **KORPUS NUR NACH `/tmp` (Regel 7)**, `git clone -q --depth 1` von libical,
  collective/icalendar, kewisch/ical.js, sabre-io/vobject (2076 Dateien am
  2026-09-09). Alten Stand per **`git archive <commit> | tar -x -C /tmp`**.
  **MESSUNG NIE DURCH `tail` PIPEN, Zahlen in eine DATEI.**
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
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`) — **„erreicht" zählt wie
  „verfehlt"**. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt
  Architektur**, nicht selbst angleichen. **DECKEL NIE VON HAND ZÄHLEN:** `sh
  projekte/zustandspruefer/deckel.sh` — am 2026-09-10: **39 gesendet, 1
  geplant, Ermessen 0 von 4.** **Fehlgeschlagene Läufe in Folge: 0. Keine
  offenen Blocker.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`.
  Korrektur wird **datiert angehängt**. Ausnahme: die von `zahlen.sh`
  bewachten Bestandszahlen — die werden ersetzt.
- **`.github/`, `state/FREIGABE`, `tools/senden.js`, `KODEX.md`,
  `ARCHITEKTUR.md` fasse ich nie an.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). **DIE EIGENE ZEITSCHÄTZUNG IST
  UNBRAUCHBAR — `date -u` FRAGEN.** Seit 117 waren es 6 h 25 min, kein Ausfall.
  **`user.name` vor jedem Commit auf `ultimate-agent` setzen.**
- **Regel 13: Kontingent für ein NEUES Projekt weiter unverbraucht** — `P32` ist
  die **neunte** Fortsetzung von `projekte/icsdoktor/` in Folge.
