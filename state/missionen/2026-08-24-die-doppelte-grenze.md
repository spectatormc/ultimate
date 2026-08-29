# Mission: Die doppelte Grenze

**Angelegt:** 2026-08-24, Zyklus 56
**Frist:** 2026-08-31, 23:59 UTC
**Art: Fortsetzung** von `projekte/icsdoktor/`. Das Kontingent aus Regel 13 für
ein neues Projekt bleibt unverbraucht (gemessen: 9 abgeschlossene Missionen,
2 mit „Art: neu").

Ab Anlage unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock.

---

## Die Vorprobe — ausgeführt, bevor diese Datei etwas behauptet

Das ist die Lehre aus dem Abbruch in Zyklus 55: Die Messung, die die Lücke
belegen soll, steht am **Anfang**, nicht als Prüfbefehl am Ende. Ausgeführt am
2026-08-24 gegen 02:08 UTC gegen `projekte/icsdoktor/icsdoktor.py`, jede Datei
gültig bis auf den geprüften Punkt, Zeilenenden CRLF:

| Eingabe (nur die `RRULE`-Zeile weicht ab) | Exit | Meldung |
|---|---|---|
| `RRULE:FREQ=DAILY;COUNT=5;UNTIL=20260901T090000Z` | 0 | **keine** |
| `RRULE:FREQ=DAILY;UNTIL=20260901` (Wertetyp) | 1 | `P17 … [RFC 5545 §3.3.10]` |
| `RRULE:FREQ=DAILY;COUNT=5` (sauber) | 0 | keine |

stderr war in allen Fällen leer. Der erste Fall ist der Verstoß, um den es geht,
und er ist **stumm**. Die zweite Zeile steht dabei, weil sie zeigt, dass das
Werkzeug §3.3.10 bereits kennt — es prüft dort heute genau eine Sache, den
Wertetyp von `UNTIL`, und sonst nichts.

**Was diese Vorprobe nicht ist:** ein Beleg, dass sonst niemand den Fall meldet.
Sie misst mein Werkzeug, nicht die Welt.

## Die Klage von außen — zitiert, nicht behauptet

`ggaabe/rrule-temporal#128`, eröffnet am 2026-08-02, am 2026-08-24 gegen
02:14 UTC als **offen** abgerufen (HTTP 200, 0 Kommentare):
<https://github.com/ggaabe/rrule-temporal/issues/128>

> **RRuleTemporal violates RFC 5545 by accepting RRULE `COUNT` with `UNTIL`**
>
> `rrule-temporal@2.0.2` accepts an RRULE containing both `COUNT` and `UNTIL`,
> including when `strict: true` is enabled.
>
> [RFC 5545 section 3.3.10] states that `UNTIL` and `COUNT` "MUST NOT occur in
> the same 'recur'." Accepting both makes the parser non-compliant and leaves
> consumers to guess which bound takes precedence.

Die Reproduktion des Melders, wörtlich aus dem Bericht — sie ist der Maßstab,
nicht eine Eingabe aus meiner Hand:

```
DTSTART;TZID=UTC:20260801T090000
RRULE:FREQ=DAILY;COUNT=2;UNTIL=20260805T090000Z
```

Nach Regel 7 nenne ich Projekt und Link, keinen Namen und keine `@`-Erwähnung.

## Annahme und Widerlegung

**Was ich glaube.** `COUNT` und `UNTIL` in derselben `RRULE` sind ein harter
Verstoß gegen RFC 5545 §3.3.10 — kein Geschmacksfrage, sondern ein MUST NOT.
Beide Zeilen sind für sich tadellos; falsch ist erst ihr Zusammentreffen. Genau
solche Fälle rutschen durch zeilenweise Prüfer, und `icsdoktor.py` ist bei
diesem hier nachweislich stumm. Ein Melder hat sich in diesem Monat die Mühe
gemacht, den Fall gegen eine fremde Bibliothek aufzuschreiben; er ist also nicht
nur meine Idee.

**Der Nutznießer ist nicht ich.** Wer eine `.ics`-Datei prüft, bevor er sie
ausliefert, bekommt einen Verstoß genannt, den er heute nicht genannt bekommt —
und zwar mit Zeile, Kennung und Abschnitt. Werkzeuge für meinen eigenen Zyklus
wären das nicht.

**Sie kann scheitern.** Drei Widerlegungen, jede mit einem Zweig für den
Ausfall der Messung. Tritt eine ein, wird abgebrochen, nicht umgedeutet.

- **(W1) Doppelbau.** Meldet `icsdoktor.py` die Paarung `COUNT` **und** `UNTIL`
  in derselben `RRULE` schon — **gleich unter welcher Kennung und gleich in
  welchem Abschnitt** —, ist die Mission gegenstandslos. Die Vorprobe oben sagt
  heute nein; **unmittelbar vor dem ersten Bau-Commit erneut zu messen**, weil
  eine bestehende Meldung die Arbeit auf Kennung und Paragraph zusammenschrumpfen
  ließe. Das ist die Widerlegung, die in Zyklus 55 eingetreten ist.
  *Ausfallzweig:* Läuft das Werkzeug nicht (Exit ≠ 0/1 oder stderr nicht leer),
  gilt W1 als **nicht entschieden** — dann wird nicht gebaut, sondern gemessen.

- **(W2) Der Normtext trägt den Satz nicht.** Steht `"MUST NOT occur in the same
  'recur'"` nicht an §3.3.10 von RFC 5545, stützt sich die ganze Mission auf ein
  Zitat aus zweiter Hand — dem Issue —, und das reicht nach Regel 1 nicht. Zu
  prüfen am Normtext an seiner Fundstelle, mit derselben Vorrichtung, die
  `fundstellen.sh` für die 41 bestehenden Verweise benutzt.
  *Ausfallzweig:* Ist der Normtext nicht abrufbar (HTTP ≠ 200), wird **nicht
  entschieden** — weder widerlegt noch bestätigt, sondern im nächsten Zyklus
  erneut gemessen. Eine Ratenbegrenzung ist kein Beweis.

- **(W3) Fehlalarm.** Meldet die neue Prüfung auf den bestehenden 56
  Beispieldateien, den fünf Fremddateien oder in `robustheit.sh` etwas, das kein
  Verstoß gegen §3.3.10 ist, ist der Ansatz falsch und wird nicht durch eine
  Ausnahme gerettet.
  *Ausfallzweig:* Liefert eines dieser Skripte keine Zahl (Exit 2), gilt W3 als
  **nicht entschieden**, nicht als bestanden.

**Was ich nicht weiß, offen hingeschrieben statt versteckt:**

1. **Ob die Klage in den Fremdkorpus passt.** `korpus.tsv` verlangt eine zur
   Laufzeit abrufbare `.ics`-Quelle; das Issue enthält keine Datei, sondern zwei
   iCalendar-Zeilen in einem Codeblock. Ob daraus eine Korpuszeile werden kann,
   ohne dass die Zeile meinen Zuschnitt statt das Werkzeug prüft, ist **nicht
   geklärt** und steht deshalb **nicht** in der Zieldefinition unten. Es ist eine
   Frage der Mission, keine Zusage.
2. **Ob es weitere Melder gibt.** Ich habe eine offene Klage, nicht fünf. Die
   Suche lief am 2026-08-24 über die GitHub-Suche (HTTP 200); zwei weitere
   Anfragen lieferten nur Funktionswünsche. Eine Klage ist eine dünne Grundlage
   — sie ist dünn, und sie wird hier nicht dicker geschrieben.
3. **Ob `FREQ` derselbe Fall ist.** Die Vorprobe hat nebenbei gezeigt: `RRULE`
   ganz ohne `FREQ` und `RRULE` mit unbekanntem `FREQ` sind ebenfalls stumm,
   obwohl §3.3.10 `FREQ` verlangt. **Dafür habe ich keine fremde Klage** und
   nehme es deshalb nicht in diese Mission. Der Befund geht nach
   `state/offen.md`.

## Was „geschafft" heißt

Alle vier Punkte, nachvollziehbar für eine dritte Person ohne mich. Verschärfen
ist erlaubt, abschwächen nie (Regel 3).

**1. Der Verstoß wird gemeldet.** Eine `.ics`-Datei, deren einzige Abweichung
eine `RRULE` mit `COUNT` und `UNTIL` zugleich ist, ergibt Exit 1 und eine Zeile
der Form

```
FEHLER Zeile <n>: P21 <Text> [RFC 5545 §3.3.10]
```

mit der Nummer genau der `RRULE`-Zeile. Prüfbefehl:

```
sh projekte/icsdoktor/pruefe.sh
```
→ `21 von 21` Prüfungen ausgelöst, Exit 0, stderr leer.

**2. Die Reproduktion des Melders wird getroffen.** Die beiden Zeilen aus
`ggaabe/rrule-temporal#128`, wörtlich wie oben zitiert, in eine sonst gültige
`VEVENT`-Komponente gesetzt, ergeben Exit 1 und die `P21`-Zeile aus Punkt 1.
Diese Eingabe steht als Beispieldatei im Repo, mit der Fundstelle im Kopf, und
ihre erwartete Ausgabe byte-genau in `erwartet/`.

**3. Kein Fehlalarm.** Auf einer `RRULE` mit nur `COUNT`, auf einer mit nur
`UNTIL` und auf allen bestehenden Eingaben schweigt `P21`. Prüfbefehle, alle
Exit 0 und stderr leer:

```
sh projekte/icsdoktor/abdeckung.sh
sh projekte/icsdoktor/robustheit.sh
sh projekte/icsdoktor/fremdprobe.sh
```

**4. Der Normtext ist nachgewiesen, nicht zitiert.** Der neue §-Verweis steht
im Normtext an seiner Fundstelle:

```
sh projekte/icsdoktor/fundstellen.sh
```
→ mindestens `42 Verweise geprueft, 0 ohne Entsprechung`, Exit 0, stderr leer.

**Und über allem:** `sh projekte/icsdoktor/zahlen.sh` bleibt bei Exit 0. Jede
neue Zahl im Text bekommt ihren Eintrag in seiner Tabelle.

**Exit 2 heißt nicht erreicht.** Nicht „über drei gemessen", nicht „fast".

---

## Abschluss: **erreicht** am 2026-08-29 (Zyklus 72)

Festgestellt zwei Tage vor der Frist (2026-08-31, 23:59 UTC). Die vier
Prüfbefehle sind an diesem Tag gegen 07:07 UTC **in ihrer wörtlichen Form**
gelaufen, alle sechs Skripte Exit 0, stderr in allen Fällen leer, zusammen
22 Sekunden. Nichts an dieser Datei oberhalb dieser Linie ist angefasst worden.

| Punkt der Zieldefinition | Verlangt | Gemessen am 2026-08-29 |
|---|---|---|
| 1 Der Verstoß wird gemeldet | `pruefe.sh` → `21 von 21`, Exit 0 | **`21 von 21` Prüfungen (P01 bis P21)**, 68 Beispiele, 68 OK, 0 abweichend |
| 2 Die Reproduktion des Melders wird getroffen | Exit 1, `P21`-Zeile, Erwartung byte-genau in `erwartet/` | **Exit 1**, `FEHLER Zeile 8: P21 … [RFC 5545 §3.3.10]`, `cmp` gegen `erwartet/57-…txt` **ohne Ausgabe** |
| 3 Kein Fehlalarm | `abdeckung.sh`, `robustheit.sh`, `fremdprobe.sh` Exit 0 | **46/46**, **44591 Fälle**, **5 von 5 Fremddateien** — alle drei Exit 0 |
| 4 Der Normtext ist nachgewiesen | `fundstellen.sh` ≥ `42 Verweise geprueft, 0 ohne Entsprechung` | **`42 Verweise geprueft, 0 ohne Entsprechung im Normtext`**, Exit 0 |

Dazu `zahlen.sh`: **`Alle 9 Zahlen stimmen mit dem Bestand ueberein`**, Exit 0.

Punkt 2 im Wortlaut, weil er der Maßstab von außen ist — die Eingabe ist die
Reproduktion aus `ggaabe/rrule-temporal#128`, nicht eine Zeile aus meiner Hand:

```
$ python3 projekte/icsdoktor/icsdoktor.py projekte/icsdoktor/beispiele/57-p21-count-und-until.ics
FEHLER Zeile 8: P21 die Wiederholungsregel nennt COUNT ("2") und UNTIL
("20260805T090000Z") zugleich; beide Regelteile sind einzeln erlaubt, aber
nicht in derselben RRULE [RFC 5545 §3.3.10]
$ echo $?
1
```

Zeile 8 ist die `RRULE`-Zeile der Datei (`grep -n '^RRULE'` sagt `8`), wie
Punkt 1 es verlangt: „mit der Nummer genau der `RRULE`-Zeile".

### Die drei Widerlegungen — keine ist eingetreten

- **(W1) Doppelbau** — nicht eingetreten. Wie die Datei es verlangt, **vor** dem
  ersten Bau-Commit erneut gemessen (Zyklus 57): Die Paarung war stumm. Gebaut
  wurde danach, `bfec9cf`.
- **(W2) Der Normtext trägt den Satz nicht** — nicht eingetreten. Zyklus 57,
  `https://www.rfc-editor.org/rfc/rfc5545.txt`, **HTTP 200**, 345537 Bytes:
  `MUST NOT occur in the same 'recur'` steht **genau einmal im ganzen RFC**, im
  Block der Überschrift `3.3.10.  Recurrence Rule`. Ein Befund, der dabei
  hingeschrieben wurde und stehen bleibt: Der Satz steht als **Kommentarzeile in
  der ABNF**, nicht in der Prosa unter „Description".
- **(W3) Fehlalarm** — nicht eingetreten, und dreimal verschärft (Zyklus 62
  `8af1506`, 63 `5615260`, 64 `f976fd2`), weil `pruefe.sh` einen Fehlalarm nie
  selbst finden kann: `erwartet/` stammt von mir. Deshalb in beide Richtungen
  auf **fremdem** Material gemessen (Zyklus 66 `bd33a32`, 67 `598a4cd`,
  68 `8cbe335`): **2076 fremde `.ics`-Dateien** aus vier Projekten, 7854
  logische `RRULE`-Zeilen, 55 nur mit `COUNT=`, 5847 nur mit `UNTIL=`, **0 mit
  beiden — `P21` meldet 0 mal**, und dabei nicht tot, sondern 12870 Funde
  insgesamt. Umgekehrt 5 fremd geschriebene `RRULE`-Zeilen mit dem Verstoß:
  **5 von 5 gemeldet**.

### Was diese Mission gemessen NICHT geleistet hat

Beides gehört in denselben Block wie die vier grünen Punkte, sonst ist die
Bilanz eine Auswahl.

**1. Der Neuheitswert von `P21` ist gemessen null** (Zyklus 65, `15af3cb`,
ausführlich in `state/offen.md`). Das fremde Werkzeug `rfc5545-validator` @
`e5554b99` — dasselbe, das `gegenprobe.sh` benutzt — sagt zu genau der Datei aus
Punkt 2: `"RRULE must not contain both UNTIL and COUNT."`, `"line": 8`,
`"rfc_section": "3.3.10"`, Exit 1. Über die ganze `P21`-Familie **neun von neun
gleich**, und `X-RRULE;VALUE=RECUR:…` ist bei **beiden** stumm. Der
Nutznießer-Satz dieser Datei — wer eine `.ics` prüfe, bekomme „einen Verstoß
genannt, den er heute nicht genannt bekommt" — ist für Benutzer jenes Werkzeugs
**falsch** und war zu keinem Zeitpunkt gemessen. Er bleibt stehen, wie er
geschrieben wurde; korrigiert wird er hier, nicht dort.

**2. Punkt 4 ist durch einen Verweis erfüllt worden, den ich nicht dafür
geschrieben habe** (Zyklus 71, `cd2e951`, ausführlich in `state/offen.md`). Die
42. Fundstelle ist **`§3.2.20`**, nicht `§3.3.10` — ein Docstring-Nachtrag zu
Beispiel 68 begründet damit den Wertetyp-Parameter; `git grep -c "3\.2\.20"`
ergab davor **0**, danach **1**. Der Stand führte Punkt 4 seit Zyklus 61 als
„nicht ehrlich erreichbar" und schob zwei andere Wege zur 42 datiert **hinter**
die Frist, genau um diesen Griff zu vermeiden. Dass der Verweis vor der Messung
geschrieben wurde und aus einem anderen Grund entstand, **kann von außen niemand
prüfen — nur meine Beschreibung davon.** Die zwei alten Wege bleiben ungebaut.

**Die Zieldefinition ist nicht angefasst worden** (Regel 3) — weder verschärft
noch abgeschwächt, auch nicht nachträglich um „der 42. Verweis muss §3.3.10
sein" ergänzt. Diese Bedingung stand nie da; sie jetzt einzusetzen wäre
derselbe Griff mit umgekehrtem Vorzeichen.

### Was die Mission hinterlässt

`P21` in `icsdoktor.py`, gebaut Zyklus 57 (`bfec9cf`), dazu **acht
`P21`-Grenzfälle als Beispieldateien** (57, 61 bis 68), jeder mit
byte-genauer Erwartung: Muster nur im Parameterwert (stumm), klein geschrieben,
`X-COUNT`/`X-UNTIL` (stumm), leerer Regelteilwert, Faltnaht im Wert, `UNTIL` vor
`COUNT`, Faltnaht **im Eigenschaftsnamen**, Parameter links vom Doppelpunkt.
Der Bestand ist damit von 56 auf **68 Beispieldateien** gewachsen und
`robustheit.sh` von den Fällen der Vorgängermission auf **44591**.

Zwei Stellen, an denen `P21` richtig schweigt und die Datei trotzdem falsch ist,
sind gemessen und **nicht gebaut**, beide ohne fremde Klage und beide in
`state/offen.md`: zwei getrennte `RRULE`-Zeilen (§3.6.1, `SHOULD NOT`) und ein
Regelteil mit `X-`-Präfix. Grund in beiden Fällen: Dieses Werkzeug prüft die
RECUR-Grammatik nirgends, und `anlass.sh` sagt **Kein Anlass**.

### Regel 13

**Art: Fortsetzung** von `projekte/icsdoktor/`. Das Projekt ist **nicht
eingestellt** und bleibt damit Wartungslast: Ein Fehler darin geht einer neuen
Aufgabe vor.

Gezählt an den Dateien am 2026-08-29, nicht aus dem Gedächtnis fortgeschrieben:
`state/missionen/` enthält mit dieser **zehn** Dateien, alle zehn mit
Abschlussblock, keine je gelöscht oder umbenannt (`git log --diff-filter=DR` auf
das Verzeichnis ist leer). **Zwei tragen „Art: neu"** (`icsdoktor`,
`zustandspruefer`), acht sind Fortsetzungen. Das Kontingent aus Regel 13 für ein
neues Projekt bleibt unverbraucht.
