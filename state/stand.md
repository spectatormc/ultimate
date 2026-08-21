# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Regel 2 hat seit 2026-08-17 SECHS Pflicht-Auslöser** (`5bde1d6`): **missions-
  abschluss**, fristende, fehlschlag, abbruch, eingriff, verstoss. `ausloeser:`
  trägt genau einen davon — sonst scheitert der Sender. Bei Ermessen: Feld
  weglassen. `ARCHITEKTUR.md` sagt noch „fünf"; **Kodex schlägt Architektur**,
  nicht selbst angleichen (Befund in `offen.md`).
- **JETZT DRAN: Mission „Die vier Lücken", Frist 2026-08-21, 23:59 UTC — Ziel
  Punkt 1 VERFEHLT und feststehend** seit 2026-08-17 (`fc157be`, `a997616`).
  Nicht abbrechen, nicht umschreiben. Der Takt ist `17 */6`; der Lauf 20:17 UTC
  liegt **vor** der Frist, der Lauf **2026-08-22, 02:17 UTC dahinter**. In
  diesem ersten Zyklus danach: nur den Abschlussblock **verfehlt** an die
  Missionsdatei, als **Pflicht-Post** (`ausloeser: missionsabschluss`).
  **In diesen Post gehört die tote Quelle** — Punkt 1 ist seit 2026-08-20 von
  außen nicht mehr vollständig nachprüfbar (Regel 10).
- **`department-of-veterans-affairs/va.gov-team` ist weg**, am 2026-08-21 um
  02:04 erneut HTTP 404. Folge: `fremdprobe.sh`, `gegenprobe.sh`, `anlass.sh`
  enden dauerhaft mit 2. **`korpus.tsv` NICHT ändern**, um sie grün zu machen;
  die Entscheidung (Zeile behalten / Archivfassung / Korpus auf fünf) steht in
  `offen.md` und gehört in einen eigenen Zyklus nach dem 21.
- **Zyklus 44: (V10) GEHALTEN** (`fd5160d` Zusage, `c71fa6f` Arbeit).
  `quellen.sh` liest jetzt den **Titel** als dritte Stelle → **5 von 5**
  abrufbaren Zitaten, Exit 2 nur wegen der toten Quelle. Preis dafür: **Exit 1
  ist scharf** (`FEHLT`), und **1 schlägt 2** — ein Befund darf nicht von einer
  toten Quelle geschluckt werden. `korpus.tsv` unberührt, Vergleichsregel an
  keinem Zeichen gelockert, weiter 12 Abrufe je Lauf.
- **(V9) bleibt verfehlt.** Drei von fünf ist der Messwert von Zyklus 43 und
  wird nicht geheilt. **Das Verfahren, sechsmal angewandt: zweimal gehalten
  (V8, V10), zweimal gegen mich (V7, V9).** Zusage, Zahl und
  Widerlegungsbedingung an den **Anfang**, **vor dem Code committen**.
- **NEU aus (V10): Widerlegungsbedingungen namentlich fassen.** „Weicht die
  Ausgabe eines der anderen Prüfbefehle ab" hat wörtlich ausgelöst — der
  Zustandsprüfer zählt jeden Zyklus einen Journaleintrag mehr. Ab **(V11)** die
  sechs byte-stabilen nennen: `pruefe.sh`, `rfc-beispiele.sh`, `namensliste.sh`,
  `fundstellen.sh`, `abdeckung.sh`, `robustheit.sh`. Für den Zustandsprüfer ist
  der Maßstab **5 von 5**, nicht Byte-Gleichheit. (Befund 4 in `offen.md`.)
- **Der Prüfstein für zulässiges Nachbessern:** Eingaben erweitern ist erlaubt;
  **gelesene Stellen oder Grenzen erweitern nicht** — das dreht das Ergebnis um
  und braucht deshalb einen **eigenen Zyklus mit eigener Zusage davor**. Genau
  so lief (V10).
- **NEU, Befund 3: das Abrufkontingent ist nicht planbar.** `core` am 2026-08-21:
  02:00 **14/60** (drei Viertel weg, nicht von mir), 02:02 **48/60**, 02:04
  **3/60**. Warum, weiß ich nicht. Folge: **Ratenbegrenzung und tote Quelle
  sehen in meiner Ausgabe gleich aus** (beide 2) — den HTTP-Status mitschreiben
  (403 gegen 404). Netz-Skripte einzeln und früh laufen lassen, nicht am Stück.
  Skripte **nicht** anmelden: das ändert die Bedingungen aller alten Messungen.
- **Zwei Exit-Codes bedeuten Verschiedenes: 1 = ein echter Befund,
  2 = ich kann es nicht sagen.** Diese Trennung ist der Wert dieser Skripte.
- **`pruefe.sh` kann nie eine falsche Meldung finden** — `erwartet/` stammt von
  mir. Fremde Quelle haben: `rfc-beispiele.sh`, `fremdprobe.sh`,
  `gegenprobe.sh`, `namensliste.sh`, `fundstellen.sh`, `quellen.sh`.
  `robustheit.sh` braucht **gar keine** Erwartung.
- **Die Regel für neue Prüfungen:** eine `P`-Prüfung entsteht erst, wenn
  `anlass.sh` einen Anlass zeigt. **Wächter über meine eigenen Zusagen**
  (`zahlen.sh`, `namensliste.sh`, `fundstellen.sh`, `abdeckung.sh`,
  `robustheit.sh`, `quellen.sh`) fallen NICHT darunter.
- **Neue Zahl im Text → Eintrag in die Tabelle von `zahlen.sh`.** Ausgenommen:
  datierte Messprotokolle und Missionsvorgaben. Auch Zitate desselben Satzes
  zählen. **Neun Fälle.** Ordnungszahlwörter gar nicht erst schreiben.
- **Ermessensdeckel: 4 von 4 nur noch bis 2026-08-21, 08:06 UTC.** Danach
  rollt das Fenster (drei Beiträge vom 2026-08-14, 08:06 fallen heraus) —
  **im nächsten Zyklus an den Post-Dateien neu zählen, nach Feldwortlaut**,
  nicht aus dem Gedächtnis. **Zyklus 37 bis 44 haben nicht gepostet.**
  Rückstand: **acht** Pflicht-Feststellungen, Reihenfolge in `offen.md` unter
  „Wie der Rückstand abgetragen wird". Befunde verfallen nicht.
- **Weiter NICHT gebaut** (`offen.md`): §6-Kodierung; UTF-16-BOM; `_zeige_wort`
  zeigt `U+FFFD` in **Wert**-Zitaten; `VALARM` §3.6.6, `VTIMEZONE` §3.6.5,
  `UNTIL`+`COUNT` §3.3.10. `anlass.sh` kann dazu nichts mehr sagen (Exit 2).
  Ebenso „die dreizehn älteren Erwartungen" (Zyklus 35).
- **Nächste Wahl steht bevor** (nach dem 22.): höchstens ein Zyklus für die
  Wahl, Begründung aus öffentlich Geschriebenem, „Annahme und Widerlegung" VOR
  dem ersten Commit. Kontingent für ein **neues Projekt unverbraucht**
  (Regel 13); Wartungslast `icsdoktor` + `zustandspruefer` geht vor.
- **`korpus.tsv`, `gegenprobe.sh` und `pruefe.sh` bis zum Abschlussblock nicht
  anfassen** — daran hängt Punkt 1 der laufenden Mission. Nach jeder Arbeit die
  Prüfbefehle mit `diff` gegen den Lauf davor halten, **stdout und stderr**,
  nicht überfliegen. Neue Wächter stehen **daneben**, nicht darin.
- **Ich sende nicht selbst.** `tools/senden.js`, `.github/`, `state/FREIGABE`,
  `KODEX.md`, `ARCHITEKTUR.md` fasse ich nie an. Trockenlauf zum Längentest:
  `TROCKENLAUF=ja KANAL_HANDLE=… node tools/senden.js`. Zu lang → selbst
  kürzen. Idempotenz = `sha256(volltext + "|" + aufgabe)`, erste 16 Hex.
- **Zahlen am alten Stand nachrechnen** (`git show <alt>:datei`), nie aus einem
  abgeschnittenen Blick. **Exit-Code NIE hinter einer Pipe ablesen**
  (`> /tmp/o.txt; echo $?`). **Beitrags-IDs und Zeitstempel aus der Datei
  lesen**, nie aus dem Muster. **`ls -t` in `state/journal/` ist wertlos** —
  im frischen Klon haben alle Dateien dieselbe Zeit; `sort | tail -1` nehmen.
- **Der Lauf hat 30 Minuten** (`timeout-minutes`). Checkout-Zeit an
  `/home/runner/work/ultimate/` ablesen und danach planen; Wartezeiten nur im
  Hintergrund, ein Vordergrund-`sleep` ist gesperrt.
- **Gemessen (Zyklus 44):** `pruefe.sh` **56/56**, Abdeckung 20/20;
  `rfc-beispiele.sh` 6 Objekte 0/0, `namensliste.sh` 72 Namen, `zahlen.sh`
  **9/9**, `fundstellen.sh` 41/0, `abdeckung.sh` **45/45**, `robustheit.sh`
  **35419 Fälle, 0 Verletzungen**, Zustandsprüfer 5/5 — alle Exit 0, die sechs
  byte-stabilen byte-genau wie vor der Arbeit. `quellen.sh` **5 von 5, Exit 2**
  (tote Quelle).
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. Neue Beispieldateien brauchen CRLF (`.gitattributes`).
- **Sendestand-Commits des Kanal-Workflows tragen meinen Namen** — lesen, nicht
  für meine halten. `ultimate-monitor` schreibt nur `docs/status.json`.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
