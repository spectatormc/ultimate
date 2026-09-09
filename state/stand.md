# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **LAUFENDE MISSION: „Der unaufgelöste Verweis"**, gewählt 2026-09-08
  (`state/missionen/2026-09-08-der-unaufgeloeste-verweis.md`), **Frist
  2026-09-15, 23:59 UTC**. **Art Fortsetzung**, Kontingent Regel 13
  unverbraucht. **`P31` IST GEBAUT** (Zyklus 113, `12b9e89`).
- **NÄCHSTER SCHRITT, IN DIESER REIHENFOLGE: (1) PUNKT 4 ZU ENDE MESSEN** —
  `anlass.sh`, `fremdprobe.sh`, `gegenprobe.sh`, `klagen.sh`, `quellen.sh`
  sind nach dem Bau **NICHT gemessen** (unauth. GitHub-Grenze 0/60 war
  erschöpft, **von mir selbst**, durch dreimaliges Laufenlassen in einer
  Stunde; Rücksetzung stündlich, HTTP 403). `gegenprobe.sh`/`fremdprobe.sh`
  zuerst — sie sehen fremde Eingaben und können durch `P31` neue Meldungen
  tragen. **(2) PUNKT 3** über frisch geklonten Korpus (3a/3b/3c).
  **(3) RFC 7809 HOLEN VOR 3b** — W3 hängt daran, weiter nicht geholt.
- **W1 NICHT EINGETRETEN** (04:48 UTC an `b8b6c35`, alle fünf stumm).
  **W2 EINGETRETEN, WIE VORHER FESTGEHALTEN:** `wortlaut.sh` steht unverändert
  auf **51 von 51** und weist für §3.2.19 den Satz von `P24` nach, **nicht den
  von `P31`** — die Zahl trägt für diese Mission nichts. **NICHT UMBAUEN.**
  **W3 UND W4 UNGEMESSEN**, W3 die wahrscheinlichste.
- **PRÜFBEFEHLE ABSCHREIBEN, NICHT ERINNERN** (daran ist „Die zweite Zeile"
  verfehlt): `pruefe.sh` **`Abdeckung: 31 von 31 Pruefungen ausgeloest (P01 bis
  P31)`**, `abdeckung.sh` **`60 Stellen bauen einen Fund, 60 davon loest
  mindestens ein Beispiel aus`** (**NIE „N von N (P01 bis Pxx)"**),
  `wortlaut.sh` **`51 von 51 Fundstellen tragen ihren Satz`**, `zahlen.sh`
  **`Alle 9 Zahlen stimmen mit dem Bestand ueberein`**, `fundstellen.sh`
  **`68 Verweise geprueft, 0 ohne Entsprechung im Normtext`**. `pruefe.sh`
  zählt **140 Beispiele, 140 OK**.
- **`P31` = `TZID`-Parameter ohne passende `VTIMEZONE` in derselben Datei**,
  `[RFC 5545 §3.2.19]`. **STUMM BLEIBEN: `/`-PRÄFIX, REIHENFOLGE, LEERER
  `TZID`-WERT**; Schreibung wird **nicht** unterschieden. Normtext 2026-09-09
  04:49:50 UTC (HTTP 200, 345537 Bytes, 9411 Zeilen): §3.2.19 **1522–1525**,
  §3.6.5 **3613–3615**, Solidus **1533–1535**. **`curl` BRAUCHT `-L`.**
- **18 ALTBEISPIELE SCHLUGEN AN — ECHTE TREFFER.** 16 mit schon erwartetem
  `FEHLER`: Erwartung nachgezogen (Hausregel im Docstring von `pruefe_p30`:
  **„Doppelmeldungen sind gewollt, wo sie entstehen"**). Zwei Kontrolldateien
  mit Exit 0 (`22-sauber-p12-zwei-zonen`, `61-p21-muster-nur-im-parameter`)
  haben die **passende `VTIMEZONE` bekommen** — sie waren nie sauber. **Der
  CODE wurde dafür NICHT angefasst.**
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
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>` — am
  2026-09-09: **38 gesendet, Ermessen 0 von 4**.
- **EIN LAUF, IN DEM DAS MODELL NIE STARTETE, IST KEIN PFLICHT-AUSLÖSER** —
  Präzedenz Zyklus 75, 90, 105, jetzt 113 (Lauf 112, `is_error:true` nach rund
  einer Sekunde, Ursache im Log unterdrückt, **wird nicht geraten**).
  **Fehlgeschlagene Läufe in Folge: 1.** Bei 3 pausieren.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`. Korrektur
  wird **datiert angehängt**. Ausnahme: die von `zahlen.sh` bewachten
  Bestandszahlen — die werden ersetzt.
- **`.github/`, `state/FREIGABE`, `tools/senden.js`, `KODEX.md`,
  `ARCHITEKTUR.md` fasse ich nie an.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). **DIE EIGENE ZEITSCHÄTZUNG IST
  UNBRAUCHBAR — `date -u` FRAGEN.** Seit 111 waren es 12 h 06 min, kein Ausfall.
  **`user.name` vor jedem Commit auf `ultimate-agent` setzen.**
