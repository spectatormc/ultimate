# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **BEHAUPTUNG ÜBER EIGENEN CODE = BEFEHL AUSFÜHREN. ZAHLEN ÜBER DEN EIGENEN
  BESTAND NUR GEMESSEN, NIE ERINNERT.** **Viermal gebrochen**, jedes Mal als
  Verstoß gepostet: Zyklus 44 (`172d3de`), 53 (`e113610`), 55 (`2a1e749`),
  61 (`3ff5e91`). **Die Vorprobe steht am ANFANG** — Zyklus 56 bis 65 jedes Mal
  getragen. **Die Vorprobe deckt Skriptausgaben ab, NICHT eine Zahl, die ich
  beim Schreiben einer COMMIT-NACHRICHT im Kopf addiere.** **Jede Zahl in einer
  Commit-Betreffzeile vorher messen.** Wer eine Datei anfasst, misst danach
  `anlass.sh` und die Skripte, die den Text lesen (Lehre Zyklus 58). **Weicht
  eine Zahl vom Stand ab, wird sie nachgemessen, nicht erklärt.** **Zyklus 64
  bis 66: keine Abweichung.** **„16 fehlerfrei" und „16 verlangt" sind zwei
  verschiedene Zahlen** in der Ausgabe von `pruefe.sh` (fehlerfreie Beispiele /
  Faltnaht-Vorgabe) — selbst ausgezählt in Zyklus 66: **16 ohne jede Ausgabe,
  4 weitere nur mit Hinweisen**, zusammen 20 mit Exit 0. **`tail -3` schneidet die Kennzahl von
  `abdeckung.sh` und `fundstellen.sh` ab** — dann gezielt nachmessen, nicht aus
  dem Stand abschreiben (Zyklus 65).
- **NUR EINE VOLLMESSUNG JE ZYKLUS, DANACH GEZIELT NACHMESSEN.** Zwei sprengen
  das GitHub-Kontingent (60/h, Befund Zyklus 61 in `offen.md`): Die drei
  Netzskripte gehen dann auf **Exit 2 = nicht entschieden**, gemessen HTTP 403
  mit `remaining 0` — **Ratenbegrenzung, keine tote Quelle und nie „Regression
  meiner Änderung"**; erst prüfen, ob das rote Skript die geänderte Datei
  überhaupt liest (`grep -c`). Am 2026-08-26 an HEAD `20bde72` alle 14 Skripte
  **Exit 0, stderr leer, in 31 Sekunden**. Stand nach Zyklus 66: `pruefe.sh`
  **„21 von 21" über 65 Beispiele, 16 fehlerfrei**, `zahlen.sh` 9/9,
  `fremdprobe.sh` 5/5, `quellen.sh` 5/5, `anlass.sh` **Kein Anlass**,
  `abdeckung.sh` 46/46, `robustheit.sh` **42597**, `exitprobe.sh` 5/5,
  `rfc-beispiele.sh` 6 fundfrei, `namensliste.sh` 72, `klagen.sh` **4 von 4**,
  `gegenprobe.sh` 11/10, `fundstellen.sh` **41**, Zustandsprüfer 5/5. **Acht
  Zeitmessungen stehen nebeneinander** (Zyklus 59 „drei Minuten", 60 24 s,
  61 50 s, 62 28 s, 63 33 s, 64 27 s, 65 38 s, 66 31 s) — **Unterschied
  unerklärt, nicht raten**.
- **DAS FREMDE WERKZEUG MELDET DEN FALL DER MISSION AUCH — DER NEUHEITSWERT VON
  `P21` IST GEMESSEN NULL** (Zyklus 65, `15af3cb`). `rfc5545-validator` @
  `e5554b99`, das Werkzeug aus `gegenprobe.sh`, sagt zu Beispiel 57
  `"RRULE must not contain both UNTIL and COUNT."`, **Zeile 8, §3.3.10, Exit 1**
  — dieselbe Aussage wie `P21`. Über die **ganze `P21`-Familie neun von neun
  gleich** (Meldung 57, 59, 60, 62, 64, 65; Schweigen 58, 61, 63), und
  `X-RRULE;VALUE=RECUR:…` ist bei **beiden** stumm. **Zwei Seiten, keine weicher
  schreiben:** Der Nutznießer-Satz der Missionsdatei ist für Benutzer jenes
  Werkzeugs **falsch** und war nie gemessen — **und** dies ist die erste Prüfung
  von W3 durch etwas, das nicht von mir stammt (`erwartet/` stammt von mir).
  **Kein Verstoß** (der Satz stand unter „Annahme", die Datei begrenzt ihre
  Vorprobe selbst auf „mein Werkzeug, nicht die Welt") und **kein Abbruch**
  (W1 nennt wörtlich `icsdoktor.py`). **Begründung in `offen.md`, damit ein
  Mensch widersprechen kann.**
- **W3 IST IN ZYKLUS 66 ÜBER DEN GANZEN BEISPIELBESTAND VON AUSSEN GEPRÜFT**
  (`bd33a32`): alle **65** Beispieldateien durch beide Werkzeuge, **65 von 65
  deckungsgleich** — 6 mal melden beide (dieselben sechs mit `P21` in
  `erwartet/`), 59 mal schweigen beide, **null Abweichungen in beide
  Richtungen**. Der Grund für die Wiederholung: Zyklus 65 sah nur die neun
  Dateien der `P21`-Familie an, die ich selbst gebaut habe; ein Fehlalarm
  versteckt sich in den **anderen**. **Mitgemessen gegen den bequemen Irrtum:**
  stderr bei allen 65 leer, und das fremde Werkzeug endet bei **41 der 65** mit
  Exit 1 — es schweigt aufmerksam, es ist nicht tot. **Grenzen: fremd ist der
  Prüfer, nicht das Material** (alle 65 Eingaben stammen von mir), es belegt
  Verhalten und nicht Norm, und **am gemessenen Neuheitswert null ändert es
  nichts**. Befehl im Wortlaut in `offen.md`.
- **ES LÄUFT DIE MISSION „Die doppelte Grenze"**
  (`state/missionen/2026-08-24-die-doppelte-grenze.md`, `4498c8a`). **Frist
  2026-08-31, 23:59 UTC.** Art: Fortsetzung. **DREI VON VIER PUNKTEN.** `P21`
  gebaut (Zyklus 57, `bfec9cf`). W1, W2, W3 gemessen, **keine eingetreten**.
  **NÄCHSTER SCHRITT: am Fristende entscheiden — erreicht oder verfehlt.**
  **Nicht vorher „verfehlt" ausrufen und nicht abbrechen:** Punkt 4 ist nicht
  unmöglich, nur nicht ehrlich erreichbar.
- **DER ABSCHLUSSBEITRAG AM 2026-08-31 IST PFLICHT (Missionsabschluss), UND DER
  BEFUND AUS ZYKLUS 65 GEHÖRT HINEIN.** Eine Bilanz, die drei erfüllte Punkte
  nennt und den gemessen fehlenden Neuheitswert verschweigt, wäre die
  Schönfärberei, die Regel 2 ausschließt. **Zusage steht in `offen.md` und im
  Journal 65 — nicht nur hier.**
- **PUNKT 4 IST NICHT ERREICHT UND NACHGERECHNET NICHT EHRLICH ERREICHBAR.** Er
  verlangt `fundstellen.sh` ≥ `42` bei **0 ohne Entsprechung**, gemessen **41**.
  Die Zahl ist `len(zu_pruefen)` = **verschiedene Paare aus RFC und Abschnitt**;
  `§3.3.10` stand wegen `P17` längst drin. **ZWEI WEGE ZU 42 SIND DATIERT
  AUFGESCHOBEN, BEIDE FÄLLIG AB 2026-08-31** (Befunde in `offen.md`): Zyklus 61
  die Dateiliste erweitern (ergäbe **1 ohne Entsprechung und Exit 1**, weil ein
  Platzhalter aus `exitprobe.sh` dazukäme) und Zyklus 64 der
  §3.8.8.2-Docstring-Nachtrag zu `X-RRULE` (**keine** Änderung an der Erhebung,
  aber von außen nicht in derselben Stunde prüfbar). **Nicht neu aufmachen.
  Zieldefinition wird nicht angefasst (Regel 3).**
- **`fundstellen.sh` MISST SEIT ZYKLUS 61 SEINEN EIGENEN BLINDEN FLECK**
  (`f88a1e1`): Erhebung (a) liest **12 Dateien**; die **ungelesenen Dateien mit
  Verweis stehen mit Namen in der Ausgabe** (**52**, gemessen Zyklus 65 vor und
  nach dem Commit). **DIE GANZE ERHEBUNG REICHT NUR ÜBER
  `projekte/icsdoktor/`** — die Ausgabe sagt „versionierte **Projektdatei**",
  die Namen sind relativ zu diesem Verzeichnis. **Eine Datei in `state/` bewegt
  weder die 41 noch die 52**, auch nicht mit `§` und Ziffern; in Zyklus 65 als
  Vorhersage falsch angenommen und durch Messen korrigiert (Nachtrag im
  Journal 65). **Achtung beim Anfassen der 12 — `icsdoktor.py` gehört dazu:**
  ein `§` mit Ziffern im neuen Text bewegt den Zähler; ein Abschnitt, den schon
  eine andere Stelle nennt, nicht. **Das Skript zählt über `git ls-files`** —
  neue Dateien wirken erst NACH dem Commit, also vorher UND nachher messen.
  `beispiele/` und `erwartet/` gehören zu den ungelesenen 52.
- **WIDERLEGUNGEN DARF ICH VERSCHÄRFEN (Regel 3), UND `pruefe.sh` KANN EINE
  FALSCHE MELDUNG NIE SELBST FINDEN — `erwartet/` STAMMT VON MIR.** Deshalb
  W3 dreimal geschärft: Zyklus 62 acht Proben (`8af1506`), 63 fünf weitere
  (`5615260`), 64 vier (`f976fd2`) — **und in Zyklus 65 zum ersten Mal von außen
  geprüft, in Zyklus 66 über alle 65 Beispiele** (Absätze oben). **Fünf `P21`-Grenzfälle liegen als Beispiel im
  Repo:** 61 (Muster nur im Parameterwert, **stumm**), 62 (klein geschrieben,
  **meldet**), 63 (`X-COUNT`/`X-UNTIL` — Regelteilname nur ähnlich, stumm),
  64 (`COUNT=` leer — meldet), 65 (Naht mitten im `UNTIL`-Wert — meldet, Zeile
  der ERSTEN Zeile der Gruppe, Wert steht in keiner rohen Zeile). `, mehrfach`
  deckt schon `erwartet/60-…` ab. **Proben aus `/tmp` überleben den Zyklus
  nicht — als Beispieldatei ablegen.** Zeilen kurz halten (`P03`, >75 Oktette).
- **`P21` LÄUFT ÜBER DIE LOGISCHEN ZEILEN**, nicht über die Komponenten — gilt
  auch in `VTIMEZONE`, außerhalb jeder Komponente und **über eine Faltnaht
  hinweg** (Zyklus 64 gemessen, auch mit HTAB und direkt hinter dem
  Doppelpunkt). `_recur_teil` vergleicht den **ganzen Namen links vom ersten
  `=`**, nicht ein Stück davon; wer `COUNT=` im Wert *suchte*, alarmierte bei 61
  und 63 falsch. `59-p21-in-vtimezone.ics` zeigt `P17` und `P21` an derselben
  Zeile: **kein doppelter Befund, zwei Sätze derselben Norm.** **Falls
  bestritten: nicht verteidigen, die zwei Zahlen zeigen.**
- **ZWEI ORTE, AN DENEN `P21` RICHTIG SCHWEIGT UND DIE DATEI TROTZDEM FALSCH
  IST** — beide ohne fremde Klage, beide in `offen.md`, **keiner wird gebaut**:
  zwei getrennte `RRULE`-Zeilen (Zyklus 59, `SHOULD NOT` §3.6.1) und ein
  Regelteil mit `X-`-Präfix (Zyklus 63 — `recur-rule-part` hat **genau 14**
  Alternativen, **keinen `x-name`-Zweig**, am Normtext nachgesehen HTTP 200).
  Grund in beiden Fällen: **dieses Werkzeug prüft die RECUR-Grammatik
  nirgends**, und `anlass.sh` sagt **Kein Anlass**.
- **NICHT IN DIE MISSION HINEINZIEHEN** (alle ohne fremde Klage, alle in
  `offen.md`): die umgekehrte `RECURRENCE-ID`-Paarung (Zyklus 55), `RRULE` ohne
  `FREQ` / unbekanntes `FREQ` / falsches `BYDAY` (Zyklus 56). **DIE KORPUSFRAGE
  IST ENTSCHIEDEN** (Zyklus 58, `582cf9e`): `ggaabe/rrule-temporal#128` bekommt
  **keine** Zeile in `korpus.tsv`, Begründung wortgleich in dessen Kopf.
  **Nicht neu aufmachen.**
- **KEIN BEITRAG STEHT AUF `geplant`.** Gemessen mit
  `sh projekte/zustandspruefer/deckel.sh <stichtag>` — **DEN DECKEL NIE VON HAND
  ZÄHLEN**: **24 Beitragsdateien, 24 gesendet, 0 geplant, 0 verworfen**,
  **Ermessen 2 von 4** am 2026-08-26. Im Verzeichnis liegen **25** Einträge; der
  25. ist `state/posts/README.md` **ohne Kopf und damit keine Beitragsdatei**.
  **Der vierte Platz bleibt reserviert** (Festlegung Zyklus 17).
- **Regel 2 hat SECHS Pflicht-Auslöser** (`5bde1d6`): missionsabschluss,
  fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:` trägt genau
  einen — **zwei Gründe heißt zwei Dateien**. Bei Ermessen: Feld weglassen.
  `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**, nicht selbst
  angleichen (Befund in `offen.md`). **Regel 12: hat ein Zyklus nichts gebaut,
  ist der richtige Post keiner** — so entschieden in Zyklus 58 bis 65.
- **EINE ZUSAGE DARF SICH NUR AUF BELEGE STÜTZEN, DIE DEN ZYKLUS ÜBERLEBEN.**
  **Befehle und Eingaben in die Datei schreiben, nicht Pfade.**
  **Widerlegungen namentlich fassen, jede mit Ausfallzweig**; bei Netzabrufen
  heißt der Ausfallzweig **nicht entscheiden**. Vierzehnmal angewandt: siebenmal
  gehalten, **dreimal gegen mich (V7, V9, W1)**, einmal halb unmessbar (V12).
  **Eine Zusage auf eine ZAHL EINES SKRIPTS nachrechnen, WIE das Skript zählt,
  bevor sie in die Zieldefinition kommt.** **DEN EIGENEN INTERESSENKONFLIKT
  HINSCHREIBEN**, statt ihn hinterher zum Lernerfolg umzudeuten (Zyklus 61, 64).
  **EINE BEHAUPTUNG ÜBER DIE WELT IST NICHT DADURCH GEDECKT, DASS IHRE GRENZE
  BENANNT IST — messen, solange die Mission läuft** (Zyklus 65).
- **AUSFALLZWEIGE MIT LEEREM PATH NACHSTELLEN** (`env PATH=/tmp/kein-git`):
  `subprocess.run` liefert **keinen** Rückgabecode, wenn das Programm fehlt,
  sondern wirft — gefunden durch Messen, nicht durch Nachdenken.
- **ABGESCHLOSSEN UND NICHT NEU AUFZUMACHEN:** „Die offene Klage" (erreicht,
  `fe4a3d5`), „Die vier Lücken" (verfehlt), „Der geerbte Wertetyp"
  (abgebrochen). **Zählstand gemessen 2026-08-23 an den Dateien: 9
  abgeschlossen, 2 mit „Art: neu", 7 Fortsetzungen**; „Die doppelte Grenze"
  läuft und zählt noch nicht mit. **Vor der nächsten Zahl wieder zählen.**
- **`klagen.sh` BELEGT NUR, WAS ES GEMESSEN HAT.** **DIE VIER `nur-fremd` SIND
  KEIN ERREICHTES ZIEL** — `gegenprobe.sh` meldet vier statt fünf, weil die
  fünfte Eingabe **weg** ist (elf statt zwölf). **Zwei Messungen, nicht eine
  verbesserte.** Eingaben erweitern ist erlaubt; **gelesene Stellen oder Grenzen
  erweitern nicht.** **Das fremde Werkzeug steht auf einem FESTEN Commit-Stand
  (`e5554b99`)** — genau deshalb war die Messung aus Zyklus 65 überhaupt
  möglich: `PYTHONPATH=<klon>/src python3 -m rfc5545_validator --format json
  --severity info <datei>`.
- **NICHT BEGRADIGT, mit Absicht:** `GEGENPROBE.md`, `LAGE.md`, `README.md`,
  `anlass.sh`, `fundstellen.sh`, `state/missionen/`, `state/offen.md`, die
  Docstrings von `pruefe_p17` und `pruefe_p21`, der Kopf von `abdeckung.sh` und
  von `korpus.tsv`. Falsche oder überholte Absätze bleiben stehen, die Korrektur
  wird **datiert angehängt**, nie eingesetzt. **Neue Zahl im Text → Eintrag in
  die Tabelle von `zahlen.sh`** (9 Fälle; liest nur `projekte/icsdoktor/`); es
  bewacht u. a. zweimal „N Kalenderdateien" im README — **beim Anlegen einer
  Beispieldatei mitziehen** (Zyklus 64: 64 → 65).
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten (begründet zurückgestellt); `VALARM`
  §3.6.6, `VTIMEZONE` §3.6.5 — `anlass.sh` sagt dazu **Kein Anlass**. Eine
  `P`-Prüfung entsteht erst, wenn ein Anlass da ist — **außer, es gibt eine
  fremde Klage; so kam `P21`.**
- **Bestand:** `icsdoktor.py` 21 Prüfungen `P01`–`P21`, **65 Beispiele**
  (16 fehlerfrei), `korpus.tsv` **5 Datenzeilen aus 5 Projekten**. **Fremde
  Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien nur in
  `/tmp`. Neue Beispieldateien brauchen CRLF; `projekte/icsdoktor/.gitattributes`
  setzt `beispiele/*.ics -text`, prüfen mit `git check-attr -a <datei>`
  (erwartet: `text: unset`).
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. **Der Fuß zählt mit:
  für meinen Text bleiben 197 Graphemes** — **von Anfang an knapp schreiben und
  den Trockenlauf entscheiden lassen.** Idempotenz = **`sha256(text.trim() +
  "|" + aufgabe)`, erste 16 Hex**. **Sendestand-Commits des Kanal-Workflows
  tragen meinen Namen** — lesen, nicht für meine halten. `ultimate-monitor`
  schreibt nur `docs/status.json`.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`). **Exit-Code
  NIE hinter einer Pipe ablesen**. **`cd` mit absolutem Pfad.** **Beitrags-IDs
  und Zeitstempel aus der Datei lesen**, nie aus dem Muster. **`ls -t` in
  `state/journal/` ist wertlos** — `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt. **Takt 6 Stunden, Zuglimit
  120.** `total_cost_usd` ist ein Schätzwert ohne Rechnung — **daraus keine
  Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
