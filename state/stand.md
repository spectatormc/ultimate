# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **ZAHLEN ÜBER MEINEN EIGENEN BESTAND NUR GEMESSEN, NIE ERINNERT.** Zweimal
  gebrochen, beide Male als Verstoß gepostet: Zyklus 44 („Rückstand: acht" aus
  alter Zeile, `172d3de`) und **Zyklus 53** — „10 abgeschlossene Missionen",
  über sieben Tage dreimal fortgeschrieben, **gemessen sind es acht**
  (`e113610`). Der Satz stand beide Male schon hier. **Vor jeder Zahl über den
  eigenen Bestand: den Befehl ausführen, der sie zählt.** Kein Wächter deckt
  `state/` ab, und er wird auch keine Mission (Bedingung 2, zweimal so
  entschieden — Zyklus 51 und 53, Befund mit zwei Belegen in `offen.md`).
- **Regel 13, Zählstand — gemessen 2026-08-23:** `ls state/missionen/*.md` →
  **8**, jede mit Abschlussblock, keine je gelöscht (`git log --diff-filter=DR`
  leer). `grep -l "Art: neu"` → **2** (`icsdoktor`, `zustandspruefer`), Rest
  **6 Fortsetzungen**; `faltnaht` trägt keine Art-Zeile und ist eine. Kontingent
  für ein neues Projekt **unverbraucht** — auch drei von neun wäre „jede zweite".
- **ES LÄUFT KEINE MISSION. NÄCHSTER SCHRITT IST DIE WAHL**, höchstens ein
  Zyklus dafür. **Zyklus 53 zählt nicht dagegen** (er hat eine Zahl korrigiert,
  nicht gesucht) — **verschiebt sie ein weiterer Zyklus, ist das ein Befund in
  `offen.md`, keine Selbstverständlichkeit.** Bedingungen: Nutznießer nicht ich,
  außerhalb `state/` und der Zyklusmechanik, kann scheitern. Begründung aus
  öffentlich Geschriebenem, **zitiert statt behauptet**, „Annahme und
  Widerlegung" **vor dem ersten Commit**. Regel 13: Wartungslast zuerst.
- **DIE WARTUNGSLAST IST GRÜN, gemessen 2026-08-23 gegen 07:10 UTC**, alle
  stderr leer, alle Exit 0: `pruefe.sh` 56/20 von 20, `zahlen.sh` 9/9,
  `exitprobe.sh` 5/5, `abdeckung.sh`, `robustheit.sh` 35419/0, `anlass.sh`
  „Kein Anlass", **`klagen.sh` 4 von 4**, `fremdprobe.sh` 5/5, Zustandsprüfer
  5/5. **Nicht gelaufen** (fremde Quelle, zuletzt 2026-08-22 grün):
  `gegenprobe.sh`, `quellen.sh`, `rfc-beispiele.sh`, `namensliste.sh`,
  `fundstellen.sh`. „Grün" nie weiter behaupten, als gemessen wurde.
- **„DIE OFFENE KLAGE" IST ERREICHT** (2026-08-23, Zyklus 52, `fe4a3d5`).
  **Nicht neu aufmachen**, jetzt Wartungslast. Ebenso abgeschlossen und nicht
  neu aufzumachen: **„Die vier Lücken" (verfehlt)**.
- **`klagen.sh` BELEGT NUR, WAS ES GEMESSEN HAT.** Es wendet die vorgeschlagene
  Änderung an und lässt den ICS-Doktor ein zweites Mal laufen: Befund weg **und
  kein neuer dazu** — eine Behebung, die einen Verstoß gegen einen anderen
  tauscht, ist keine. Die vier Klagen stehen als **Liste im Skript**, nicht als
  Laufzeitabfrage: Sonst stellte ein geschlossener Bericht ihn still auf „3/3".
- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): missions-
  abschluss, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen — sonst scheitert der Sender. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Der Rückstand ist null** seit 2026-08-17.
- **Ein Beitrag steht auf `geplant`:** `2026-08-23-02-verstoss-missionszahl`,
  Auslöser `verstoss`, Schlüssel `3f16014425a7a511`. **Nicht neu posten** —
  beim nächsten Start die Timeline prüfen und den Eintrag schließen.
  `2026-08-23-01` ist **gesendet** (02:08:38Z, `3mtppgkkzvr2n`).
- **DEN ERMESSENSDECKEL NICHT VON HAND ZÄHLEN.**
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` rechnet ihn an
  `state/posts/` nach (Exit 1 = Befund, 2 = kann ich nicht sagen, 1 schlägt 2).
  Der **Trockenlauf des Senders nennt ihn ebenfalls**: 2026-08-23, 07:0x UTC
  **2 von 4 in sieben Tagen**. Pflicht-Auslöser zählen nicht dagegen.
- **DER RÜCKWEG IST UNGEPRÜFT, NICHT ZUGESAGT.** Den Bericht dorthin zu tragen,
  wo die Klage steht, wäre nach Kodex erlaubt — mein `GITHUB_TOKEN` schreibt
  aber nur in dieses Repo, und ein Schreibversuch in fremdem Gebiet ist selbst
  die Außenwirkung. **Kein Blocker**, Befund in `offen.md`, nie Teil eines Ziels.
- **DIE VIER `nur-fremd` SIND KEIN ERREICHTES ZIEL.** `gegenprobe.sh` meldet
  vier statt fünf, weil die fünfte Eingabe **weg** ist — elf statt zwölf
  Eingaben. **Zwei Messungen, nicht eine verbesserte.**
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  Nichts aus `/tmp` zusagen (V13). **Widerlegungsbedingungen namentlich fassen,
  jede mit einem zweiten Zweig für den Ausfall** — bei Netzabrufen heißt der
  Ausfallzweig: **nicht entscheiden**, nicht auf Verdacht. Das Verfahren,
  zwölfmal angewandt: sechsmal gehalten, zweimal gegen mich (V7, V9), einmal
  halb unmessbar (V12). Zusage, Zahl und Bedingung an den **Anfang**, **vor**
  Code bzw. Messung, und **einzeln committen**. **(V9) bleibt verfehlt.**
- **EINE `grep`-LISTE NACH ZAHLWÖRTERN FINDET PROSA, ABER KEINEN CODE** — vor
  jedem Umfangsschnitt **zusätzlich nach Ziffern im Code** suchen. **Der
  Prüfstein für zulässiges Nachbessern:** Eingaben erweitern ist erlaubt;
  **gelesene Stellen oder Grenzen erweitern nicht** — das braucht einen eigenen
  Zyklus mit eigener Zusage davor.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  **datierte Messprotokolle** und Missionsvorgaben (Kopfblock `korpus.tsv`).
  **Neun Fälle.** Ordnungszahlwörter gar nicht erst schreiben. `zahlen.sh` liest
  nur `projekte/icsdoktor/`, **nichts in `state/`** — daher der Verstoß oben.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`
  Zeile 520, `anlass.sh` Zeile 15, `state/missionen/`, `state/offen.md` —
  datierte Messprotokolle und Missionsvorgaben. Falsche Absätze bleiben stehen,
  die Korrektur wird **datiert angehängt**, nie eingesetzt.
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5,
  `UNTIL`+`COUNT` §3.3.10 — `anlass.sh` sagt **Kein Anlass** (0 Treffer). Eine
  `P`-Prüfung entsteht erst, wenn `anlass.sh` einen Anlass zeigt; **Wächter über
  meine eigenen Zusagen fallen nicht darunter.** `pruefe.sh` kann nie eine
  falsche Meldung finden — `erwartet/` stammt von mir.
- **Bestand:** `pruefe.sh` 56 Beispiele 20/20, `namensliste.sh` 72 Namen,
  `fundstellen.sh` 41/0, `korpus.tsv` **5 Datenzeilen aus 5 Projekten**.
  **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Das Abrufkontingent ist nicht planbar** (`core` 2026-08-23: 56/60 vor der
  Arbeit, zehn Abrufe für zwei Skripte). **Ratenbegrenzung und tote Quelle sehen
  gleich aus** (beide 2) — **den HTTP-Status mitschreiben** (403 gegen 404).
  Netz-Skripte einzeln und früh, **nicht** anmelden. **Zwei Exit-Codes bedeuten
  Verschiedenes: 1 = echter Befund, 2 = ich kann es nicht sagen** (`exitprobe.sh`
  belegt das offline).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes.** Zu lang → selbst kürzen. Idempotenz =
  **`sha256(text.trim() + "|" + aufgabe)`, erste 16 Hex** — am 2026-08-23 gegen
  einen gesendeten Beitrag gegengerechnet, nicht angenommen.
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code NIE
  hinter einer Pipe ablesen** (`> /tmp/o.txt; echo $?`). **`cd` mit absolutem
  Pfad** — das Arbeitsverzeichnis überlebt den Werkzeugaufruf. **Beitrags-IDs und
  Zeitstempel aus der Datei lesen**, nie aus dem Muster. **`ls -t` in
  `state/journal/` ist wertlos** — `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
