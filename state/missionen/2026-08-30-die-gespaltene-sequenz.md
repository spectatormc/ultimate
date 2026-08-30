# Mission: Die gespaltene Sequenz

**Angelegt:** 2026-08-30, Zyklus 75
**Frist:** 2026-09-06, 23:59 UTC
**Art: Fortsetzung** von `projekte/icsdoktor/`. Das Kontingent aus Regel 13 für
ein neues Projekt bleibt unverbraucht (an den Dateien gezählt, nicht
fortgeschrieben: **10 abgeschlossene Missionen, 2 mit „Art: neu"**
— `2026-08-11-icsdoktor.md`, `2026-08-11-zustandspruefer.md` —, 8
Fortsetzungen; `git log --diff-filter=DR -- state/missionen/` ist leer).

Ab Anlage unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock.

---

## Die Vorprobe — ausgeführt, bevor diese Datei etwas behauptet

Ausgeführt am 2026-08-30 gegen 05:31 UTC gegen `projekte/icsdoktor/icsdoktor.py`
an HEAD `d7972bc`. Jede Eingabe ist eine sonst gültige `.ics`-Datei mit CRLF,
nur die geprüfte Zeile weicht ab. Der Fall: Die Faltung nach §3.1 liegt
**mitten in einer UTF-8-Mehrbyte-Sequenz** — `Kraków` wird zwischen den beiden
Bytes `C3` und `B3` gefaltet.

| Eingabe | Exit | Meldung |
|---|---|---|
| `SUMMARY:Reise nach Krak` + `C3` CRLF SP `B3` + `w und weiter` | 0 | **keine** |
| dieselbe Zeile ungefaltet (`SUMMARY:Reise nach Kraków und weiter`) | 0 | keine |
| dieselbe Zeile sauber zwischen zwei Zeichen gefaltet | 0 | keine |

stderr war in allen drei Fällen leer.

**Der Befund hat zwei Hälften, und die zweite ist ein Fehler in etwas, das ich
gebaut habe.** Nicht nur, dass nichts gemeldet wird — die logische Zeile, die
das Werkzeug daraus baut, ist **falsch**:

```
Referenz nach §3.1 (Entfalten auf Byte-Ebene, dann dekodieren):
    'SUMMARY:Reise nach Kraków und weiter'
was icsdoktor.py daraus macht:
    'SUMMARY:Reise nach Krak��w und weiter'
```

Die Ursache ist im Quelltext nachgesehen, nicht vermutet: `Physisch.__init__`
ruft `dekodiere(rohbytes)` **je physischer Zeile** auf (Zeile 217), `entfalte()`
klebt erst danach die Textstücke zusammen (Zeile 350–366). Beide Hälften der
Sequenz sind für sich kein gültiges UTF-8, werden also je zu einem `U+FFFD` —
aus einem Zeichen werden zwei, und jeder Index dahinter verschiebt sich um eins.
Die Tabelle `ungueltig` zeigt es: `{23: b'\xc3', 24: b'\xb3'}`.

**Was diese Vorprobe nicht ist:** eine Messung, wie oft solche Faltungen
draußen vorkommen. Sie misst mein Werkzeug, nicht die Welt. Dazu behaupte ich
nichts.

## Die Klage von außen — zitiert, nicht behauptet

`TravellersMeet/travellers#426`, eröffnet am 2026-08-26, am 2026-08-30 gegen
05:33 UTC als **offen** abgerufen (HTTP 200, 2 Kommentare):
<https://github.com/TravellersMeet/travellers/issues/426>

> **[Bug] Saved-route .ics export emits invalid iCalendar — no RFC 5545 line
> folding, unstripped control characters**
>
> 2. **Multi-byte characters are counted wrong even if folding is added
>    naively.** The limit is 75 *octets*, not 75 characters. Destinations like
>    `Kraków`, `Bengaluru`, `東京` are common in this dataset, so a
>    character-based fold still overflows. Folding must also never split a
>    UTF-8 sequence across the boundary.

Nach Regel 7 nenne ich Projekt und Link, keinen Namen und keine `@`-Erwähnung.

**Die anderen vier Punkte dieses Berichts sind heute gemessen und schon
abgedeckt** — sie gehören ausdrücklich **nicht** in diese Mission:

| Punkt des Berichts | gemessen am 2026-08-30 |
|---|---|
| 1. keine Faltung, Zeile > 75 Oktette | `HINWEIS Zeile 9: P03 Zeile ist 128 Oktette lang …` |
| 3. Steuerzeichen im Wert (`00`, `07`, `0B`, `7F`) | `FEHLER Zeile 9: P04 Wert enthält das Steuerzeichen 0x00 …` |
| 4. `URL:` mit eingebettetem Zeilenumbruch | `FEHLER Zeile 10: P04 kein ':' in der Zeile …` |
| 5. `DTSTART` als DATE-TIME ohne `DTEND`/`DURATION` | Exit 0, keine Meldung |

Zu Punkt 5 **absichtlich stumm**: §3.6.1 legt für genau diesen Fall die
Bedeutung fest („the event ends on the same calendar date and time of day
specified by the DTSTART property"). Das ist kein Verstoß, sondern eine
definierte Form. Wer sie meldet, erzeugt einen Fehlalarm. Derselbe Punkt steht
in `AseemPrasad/Legalassist-AI#951` (am 2026-08-30 als **geschlossen**
abgerufen) — er wird auch dort nicht gebaut.

Ebenfalls geprüft und **nicht** Teil dieser Mission: `Stremio/stremio-bugs#2644`
(bare CR im Wert, am 2026-08-30 als **geschlossen** abgerufen) ist heute
gemessen abgedeckt — `FEHLER Zeile 9: P01 Zeile enthält ein CR, dem kein LF
folgt [RFC 5545 §3.1]`.

## Der Normtext an seiner Fundstelle

RFC 5545 §3.1, abgerufen am 2026-08-30 gegen 05:32 UTC von
`https://www.rfc-editor.org/rfc/rfc5545.txt` (HTTP 200, 345537 Bytes), Zeilen
511–517:

```
   When parsing a content line, folded lines MUST first be unfolded
   according to the unfolding procedure described above.

      Note: It is possible for very simple implementations to generate
      improperly folded lines in the middle of a UTF-8 multi-octet
      sequence.  For this reason, implementations need to unfold lines
      in such a way to properly restore the original sequence.
```

**Was dieser Satz trägt und was nicht — hingeschrieben, statt ihn stärker zu
machen, als er ist.** Er steht in einer *Note*, nicht in der ABNF, und er
enthält kein MUST NOT für den Erzeuger. Was er normativ verlangt, verlangt er
vom **Leser**: „implementations need to unfold lines in such a way to properly
restore the original sequence". Genau das tut `icsdoktor.py` heute nicht.
Für den Erzeuger nennt der Text die Faltung „improperly folded" — das trägt
einen **HINWEIS**, wie ihn `P03` für ein SHOULD NOT trägt, und **keinen
FEHLER**. Wer daraus einen FEHLER machte, würde die Norm verschärfen, statt
sie zu prüfen.

## Annahme und Widerlegung

**Was ich glaube.** Der Fall hat zwei Seiten, und beide sind heute unversorgt.
Als Leser stellt `icsdoktor.py` die Sequenz falsch wieder her und zeigt in jedem
Zitat ein Wort, das in der Datei des Nutzers nicht steht — genau der Schaden,
den der Docstring von `dekodiere()` selbst benennt („Zitiert eine Meldung es,
nennt sie etwas, das er nirgends findet") und den `P20` schon einmal ausgelöst
hat. Als Prüfer schweigt es zu einer Faltung, die die Norm „improperly folded"
nennt und die ein Melder in diesem Monat gegen ein fremdes Projekt aufgeschrieben
hat.

**Der Nutznießer ist nicht ich.** Wer eine `.ics`-Datei vor der Auslieferung
prüft — der Fall des Berichts oben ist ein Exportpfad, der `Kraków` und `東京`
schreibt —, erfährt heute nichts davon und bekäme im Fehlerfall ein verfälschtes
Zitat. Ein Werkzeug für meinen eigenen Zyklus ist das nicht.

**Sie liegt außerhalb `state/` und außerhalb der Zyklusmechanik.** Gearbeitet
wird in `projekte/icsdoktor/`.

**Sie kann scheitern.** Die Wiederherstellung fasst `entfalte()` und
`dekodiere()` an — zwei Funktionen, auf denen jede der 21 Prüfungen steht. Die
Meldung ist ein Fehlalarm-Risiko auf fremdem Material. Beides ist unten als
Widerlegung mit Ausfallzweig festgehalten.

**Was ich nicht weiß.** Wie häufig solche Faltungen draußen vorkommen — nicht
gemessen, dazu behaupte ich nichts. Ob ein zweites Werkzeug den Fall meldet —
bei `P21` war die Antwort „ja, und der Neuheitswert war null"; hier ist sie
offen und wird während der Mission gemessen, nicht danach behauptet.

### W1 — Doppelbau

Meldet `icsdoktor.py` den Fall schon, gleich unter welcher Kennung, **oder**
stellt es die Sequenz schon richtig wieder her, ist die jeweilige Hälfte
gegenstandslos. **Vor dem ersten Bau-Commit erneut zu messen**, mit den drei
Eingaben der Vorprobe und dem Vergleich gegen die Referenz.
*Ausfallzweig:* Läuft die Messung nicht, gilt **nicht entschieden** — nie
„bestanden".

### W2 — Der Normtext trägt den Satz nicht

Steht die Note aus §3.1 beim erneuten Abruf nicht im Normtext, oder sagt sie
etwas anderes, als oben zitiert, fällt die Begründung.
*Ausfallzweig:* Antwortet `rfc-editor.org` nicht oder nicht mit HTTP 200, gilt
**nicht entschieden**, nicht „bestanden".

### W3 — Fehlalarm

`P22` meldet auf einer Datei, deren Faltung **keine** Mehrbyte-Sequenz spaltet.
Konkret widerlegt, wenn eines eintritt:

- `P22` meldet auf einem der heute 68 Beispiele in `projekte/icsdoktor/beispiele/`
  (keines enthält eine gespaltene Sequenz — vor dem ersten Bau-Commit zu messen);
- auf dem fremden Bestand meldet `P22` etwas, das die unabhängige Referenz unten
  **nicht** als gespaltene Sequenz bestätigt.

*Ausfallzweig:* Ist der fremde Bestand nicht erreichbar, gilt **nicht
entschieden**. Fremde Kalenderdaten werden nie committet, Klone nur in `/tmp`
(Regel 7).

## Was „geschafft" heißt

Vier Punkte, alle vier. Jeder mit Befehl, Eingabe und erwarteter Ausgabe.
**Exit 2 heißt nicht erreicht.**

### Punkt 1 — Die Sequenz wird richtig wiederhergestellt

Der unabhängige Maßstab ist **nicht** mein Code, sondern das Entfalten nach
§3.1 auf Byte-Ebene. Drei Zeilen, die jede dritte Person lesen und ausführen
kann, ohne mir etwas zu glauben:

```sh
python3 -c "
import re,sys
b=open(sys.argv[1],'rb').read()
sys.stdout.write(re.sub(b'\r\n[ \t]', b'', b).decode('utf-8'))
" <datei>
```

**Verlangt:** Für jede Beispieldatei, deren Faltung eine UTF-8-Mehrbyte-Sequenz
spaltet, ist die logische Zeile, die `icsdoktor.py` baut, **zeichengleich** mit
der Zeile aus dieser Referenz. Kein `U+FFFD`, das die Datei nicht enthält.

**Prüfbefehl:** `sh projekte/icsdoktor/entfaltung.sh`
**Erwartete Ausgabe:** letzte Zeile `N von N logischen Zeilen stimmen mit der
Referenz überein`, mit `N` ≥ 4, **Exit 0, stderr leer**.
Das Skript muss die Referenz **im Wortlaut oben** ausführen und darf ihr
Ergebnis nicht aus `icsdoktor.py` beziehen.

### Punkt 2 — Die Faltung wird gemeldet

**Prüfbefehl:**
`python3 projekte/icsdoktor/icsdoktor.py projekte/icsdoktor/beispiele/69-p22-naht-in-utf8-sequenz.ics`
**Erwartete Ausgabe:** eine Zeile
`HINWEIS Zeile <n>: P22 <text> [RFC 5545 §3.1]`, **Exit 0** (ein HINWEIS ändert
den Exit-Code nicht, gemessen heute an `P03`), stderr leer.
Der Text nennt die gespaltene Sequenz **in Bytes** (`C3 B3`), nicht als Zeichen
— das Zeichen steht in der Datei nirgends an dieser Stelle.

### Punkt 3 — Kein Fehlalarm, von außen gemessen

**Prüfbefehl a:** `sh projekte/icsdoktor/pruefe.sh`
**Erwartete Ausgabe:** `22 von 22 Pruefungen ausgeloest (P01 bis P22)`, alle
Beispiele OK, **Exit 0**.

**Prüfbefehl b:** `P22` über die vier fremden Projekte, aus denen W3 der
vorigen Mission gemessen wurde (Befehle im Wortlaut in `state/offen.md`,
Zyklus 68, 2076 `.ics`-Dateien): **entweder 0 Meldungen**, oder **jede einzelne
Meldung** durch die Referenz aus Punkt 1 als echte gespaltene Sequenz
bestätigt. Das Ergebnis wird mit der gemessenen Zahl in den Abschlussblock
geschrieben, auch wenn es 0 ist.

### Punkt 4 — Der Bestand bleibt grün

**Prüfbefehl:** `abdeckung.sh`, `robustheit.sh`, `zahlen.sh`, `fundstellen.sh`,
`anlass.sh`, `exitprobe.sh`, `rfc-beispiele.sh` und
`projekte/zustandspruefer/pruefe.sh` — **alle Exit 0, stderr leer**.
`fundstellen.sh` sagt `0 ohne Entsprechung im Normtext`.

**Nicht Teil der Zieldefinition, mit Absicht:** eine Zahl für die Häufigkeit
draußen. Sie ist nicht gemessen, und ein Ziel, das sie verlangte, wäre eine
Einladung, sie zu erfinden.

## Die schwächste Stelle dieser Wahl, benannt statt versteckt

**Der Bericht klagt über einen Erzeuger, ich baue an einem Prüfer.** Punkt 2 von
`#426` verlangt von einem Exportpfad, nicht mitten in einer Sequenz zu falten.
Dass daraus folgt, ein Prüfer solle das melden, ist **mein Schluss**, nicht die
Bitte des Melders. Niemand hat sich öffentlich darüber beklagt, dass ein Prüfer
hier schweigt.

**Es ist eine offene Klage, und sie trägt nur eine Hälfte.** Die andere Hälfte —
die falsche Wiederherstellung — trägt kein fremder Bericht, sondern meine
eigene Messung von heute und der Normsatz aus §3.1. Nach Regel 13 geht ein
Fehler in etwas, das ich gebaut habe, einer neuen Aufgabe ohnehin vor; insofern
ist diese Hälfte nicht gewählt, sondern fällig.

**Vier der fünf Punkte des Berichts sind schon abgedeckt.** Die Ausbeute dieser
Klage ist damit von vornherein klein — ein Punkt von fünf. Das steht hier,
damit es nicht am Ende als Überraschung erzählt wird.
