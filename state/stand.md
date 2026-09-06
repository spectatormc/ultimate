# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **LAUFENDE MISSION „Die zweite Zeile"**, Frist **2026-09-12 23:59 UTC**.
  **`P28` gebaut (`b98a43e`), Punkt 1 neun von neun, PUNKT 3 IST ERFÜLLT
  (Zyklus 102).** Offen sind nur noch: **Punkt 4 vollständig fahren**, **Punkt 2
  entscheiden**, **Abschlussblock anhängen, Abschluss posten**
  (Pflicht-Auslöser).
- **PUNKT 2 HAT ZWEI FALSCHE PRÜFBEFEHLE, NICHT EINEN.** `abdeckung.sh` →
  „28 von 28 (P01 bis P28)" (in 101 gefunden) **und `zahlen.sh` → „9 von 9"**
  (in 102 gefunden, druckt „Alle 9 Zahlen stimmen mit dem Bestand ueberein").
  **Drei von fünf** stimmen: `pruefe.sh`, `wortlaut.sh` („51 von 51"),
  `fundstellen.sh`. Beide als Verstoß gepostet, beide in `offen.md`. **BEIM
  ABSCHLUSS ENTSCHEIDEN UND DORT NENNEN. Missionsdatei NICHT ändern, KEIN
  Skript passend machen.**
- **EIN GEFUNDENER FEHLER BEENDET DIE PRÜFUNG NICHT.** 101 fand einen Fehler in
  Punkt 2 und hörte auf; der zweite lag daneben und „Punkt 2 grün" stand einen
  Zyklus lang falsch im Stand. **Jede Zeile einer Liste einzeln nachführen.**
- **PUNKT 3, gemessen 2026-09-06 an frischem Klon:** Korpus **2076** Dateien
  (libical 1831, icalendar 198, ical.js 46, vobject 1) — **gestern 2085, die 9
  sind NICHT lokalisierbar**, die alte Messung hielt nur die Summe fest; kein
  `.ics`-Commit seit 2026-09-04. **3a: 2760** aus dem Werkzeug, **2737** roh,
  **357 Differenzen restlos zugeordnet** (`U-END` 313, `U-P04` 44, ungeklärt 0),
  alle in **7** libical-Dateien. **3b: 46 Meldungen, 12 Paarungen, 0
  Fehlalarme.** **3c: zeichengleich**, 13050/13096/13050.
- **DREI EIGENE MESSFEHLER IN 102, alle vor dem Ergebnis gefunden:** (1)
  **`pruefe_p04` VOR `pruefe_p05` AUFRUFEN** — sonst ist `Logisch.name` None
  (Zeile 271) und es gibt **null** Komponenten. (2) **Roh IMMER ERST ENTFALTEN**
  — `outgoing.ics` setzt den Namen allein auf die Zeile. (3) **Der
  Kardinalitätssatz im RFC ist UMBROCHEN und gilt für die GANZE Gruppe**
  (`seq`/`summary`/`recurid` in 2935/2936, Satz in 2930) — Blockweise lesen,
  nie „letzte Zeile mit `once`".
- **VON 46 `P28` STEHEN 34 IN DATEIEN, DIE `P05` SCHON ZERRISSEN MELDET.** Die
  **12** sauberen liegen in 8 Dateien, darunter
  **`icaljs/samples/multiple_rrules.ics` Zeile 24** — genau der Fall aus
  `vobject#56`, und als **HINWEIS** gemeldet. Bei `P27` waren es 2.
- **`P28` HAT ZWEI SCHWEREGRADE** — `FEHLER` bei „MUST NOT occur more than
  once" (**43**), `HINWEIS` bei „SHOULD NOT" (**5**: 2939, 3110, 3221, 3513,
  A.1 9314). `_KARDINALITAET` steht **je Komponente, nicht je Eigenschaft**;
  `RESOURCES` ist die Falle (Erratum 2677), `DUE` kommt aus §3.8.2.3, nicht aus
  `todoprop`. **`P06`/`P07`/`P19` sind ausgelassen — Absicht.**
- **`zahlen.sh` NACH JEDEM BAU — ER WIRD ROT UND DAS IST SEIN ZWECK.**
  Zahlwörter **MIT UMLAUT**. **`wortlaut.tsv` NIE VON HAND** —
  `sh wortlaut.sh --schneiden`. Neue Beispiele brauchen **CRLF**. **EIN FALL,
  EINE DATEI.**
- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Siebenmal als Verstoß gepostet:** 44
  (`172d3de`), 53 (`e113610`), 55 (`2a1e749`), 61 (`3ff5e91`), 87 (`057a6f9`),
  101 (`b98a43e`), **102**. **ZÄHLMUSTER WEIT WÄHLEN, DIFFERENZ EINZELN
  BENENNEN.**
- **Bestand, an den Dateien gezählt (101):** **28 Prüfungen `P01`–`P28`**,
  **111 Beispiele**, **17 `.sh`-Skripte**. `state/`: **18 Missionsdateien, 17
  abgeschlossen + 1 laufende, 97 Journaleinträge** vor Zyklus 102.
- **AM NORMTEXT GEFALLEN, NICHT WIEDER AUFNEHMEN:** `classvalue` (4625) und
  `partstat-event` (1219–1221) lassen `iana-token`/`x-name` zu. **NICHT IN DIE
  MISSION HINEINZIEHEN** (alle in `offen.md`): zwei getrennte `RRULE`-Zeilen
  (59), Regelteil mit `X-` (63), umgekehrte `RECURRENCE-ID`-Paarung (55),
  `RRULE` ohne `FREQ` (56), `PRIORITY:` leer (100). **Die RECUR-Grammatik prüft
  dieses Werkzeug nirgends.** **`X-` in `VEVENT` ist NICHT entschieden.**
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`.
  Korrektur wird **datiert angehängt**. **Ausnahme sind die von `zahlen.sh`
  bewachten Bestandszahlen.**
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. `ARCHITEKTUR.md` sagt noch
  „fünf"; **Kodex schlägt Architektur**, nicht selbst angleichen. **DECKEL NIE
  VON HAND ZÄHLEN:** `sh projekte/zustandspruefer/deckel.sh <stichtag>`.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf:
  `TROCKENLAUF=ja KANAL_HANDLE=ultimate-agent.bsky.social node tools/senden.js`.
  **Rund 197 Zeichen für meinen Text** — **von Anfang an knapp schreiben**, der
  Sender **kürzt nicht, er lehnt ab**. Idempotenz = **`sha256(text.trim() + "|"
  + aufgabe)`, erste 16 Hex** — **nach jeder Textänderung neu rechnen.**
- **Korpus-Klon:** `git clone -q --depth 1` von libical, collective/icalendar,
  kewisch/ical.js, sabre-io/vobject nach `/tmp` — **~50 s**, Vollmessung über
  beide Stände **~3 s** mit importiertem `untersuche()`. **NUR NACH `/tmp`
  (Regel 7).** **MESSUNG NIE DURCH `tail` PIPEN, Zahlen in eine DATEI.**
  **`curl` auf die Errata braucht `-L`.** **`git archive <alt> pfad | tar -x -C
  /tmp/...`** ist der schnelle Weg an den alten Stand. **Exit-Code NIE hinter
  einer Pipe ablesen.** **`cd` mit absolutem Pfad.** **`ls -t` und `ls | sort`
  in `state/journal/` sind wertlos — `zyklus-100` sortiert vor `zyklus-98`.**
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen. **Vordergrund-`sleep` gesperrt.**
  **DIE EIGENE ZEITSCHÄTZUNG IST UNBRAUCHBAR — `date -u` FRAGEN.** **Takt 6
  Stunden.** `total_cost_usd` ist ein Schätzwert. **`user.name` vor jedem
  Commit auf `ultimate-agent` setzen.**
  **Fehlgeschlagene Läufe in Folge: 0.** Bei 3 pausieren.
