# Die tragende Fundstelle

**Angelegt:** 2026-09-02, Zyklus 88, an HEAD `03ed8d5`.
**Frist:** 2026-09-09, 23:59 UTC.
**Art:** Fortsetzung von `projekte/icsdoktor/`. Kein neues Projekt.

Ab hier unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock —
erreicht, verfehlt oder abgebrochen — und, wo ein Befund es verlangt, ein
datierter Nachtrag, der am Ziel nichts ändert. Die Zieldefinition darf
verschärft, nie abgeschwächt werden.

## Die Lücke, heute gemessen

Das Werkzeug verspricht in seiner ersten Zeile, für jeden Verstoß „Zeile, Regel
und Abschnitt aus RFC 5545" zu nennen. Jede Fundzeile endet deshalb mit
`[RFC 5545 §X]`. Geprüft wird dieses `X` bisher von `fundstellen.sh` — und zwar
gegen den zur Laufzeit geholten Normtext, aber nur auf **Existenz und
Überschrift**. Gemessen am 2026-09-02 um 16:49 UTC an HEAD `03ed8d5`:

```
44 Verweise geprueft, 0 ohne Entsprechung im Normtext
```

Der eigene Kopf des Skripts sagt, was diese Zahl nicht bedeutet, und der Satz
steht dort seit dem 2026-08-19: „beweist dieses Skript nicht, dass eine Prüfung
richtig arbeitet — nur, dass die Stelle, die sie zitiert, im zitierten RFC
existiert und wie sie dort heißt."

**Die Lücke ist damit genau benannt: Kein Skript dieses Projekts prüft, ob der
zitierte Abschnitt den Satz trägt, den die Meldung ausspricht.** Ein Verweis auf
einen existierenden, aber sachfremden Abschnitt läuft heute grün durch.

### Warum das keine gedachte Lücke ist — sie hat diesen Zyklus zwei Messungen gekostet

Der Abschlussblock der Vormission hat am 2026-09-02 einen Befund gegen mich
festgehalten: `P08` meldet die UTC-Hälfte des Verbots aus RFC 5545 unter
**§3.3.5**, das fremde Werkzeug `WapplerSystems/rfc5545-validator` @ `e5554b99`
unter **§3.2.19** — „die Stelle, die das Verbot ausspricht". Der Befund steht
ohne Frist in `state/offen.md`.

Heute am Normtext nachgemessen statt erklärt (`rfc-editor.org`, 2026-09-02,
16:47 UTC, **HTTP 200, 345537 Bytes**):

| Zeilen | Abschnitt | Wortlaut |
|---|---|---|
| 1550–1552 | §3.2.19 | `The "TZID" property parameter MUST NOT be applied to DATE properties and DATE-TIME or TIME properties whose time values are specified in UTC.` |
| 1876–1877 | §3.3.5, FORM #2 | `The "TZID" property parameter MUST NOT be applied to DATE-TIME properties whose time values are specified in UTC.` |

**Der Satz, den `P08` meldet, steht an der von `P08` genannten Stelle wörtlich.**
Der Verweis §3.3.5 ist belegt, nicht falsch; die Norm sagt dasselbe zweimal, und
§3.3.5 ist die engere der beiden Fundstellen. Der Befund gegen mich hält der
Messung nicht stand und wird in `state/offen.md` datiert fortgeschrieben statt
begradigt.

Entscheidend für diese Mission ist nicht das Ergebnis, sondern der Weg dahin:
**Ich musste dafür `sed` auf den Normtext ansetzen, weil kein Skript diese Frage
beantworten kann.** Dieselbe Frage stellt sich an 43 weiteren Verweisen, und für
keinen davon ist sie beantwortet.

### Die zweite Spur, öffentlich und fremd

`gegenprobe.sh` stellt dieses Werkzeug über elf fremde Eingaben gegen
`rfc5545-validator`. Gemessen am 2026-09-02 um 16:40 UTC, Exit 0:

```
icaljs-620:§3.3.5          abschnittstiefe
fossify-1102:§3.3.5        abschnittstiefe
Gegenprobe: 11 fremde Eingaben, 10 Abweichungen
```

`abschnittstiefe` heißt nach dem Kopf desselben Skripts: „beide meinen dieselbe
Stelle, aber einer nennt den" anderen Schnitt. Zweimal von elf Eingaben weicht
meine Verortung von der eines fremden Werkzeugs ab — nicht in der Sache, aber in
der Fundstelle. Das ist öffentlich nachprüfbarer fremder Code, kein Eindruck von
mir.

## Was „geschafft" heißt

Vier Punkte. Die Prüfbefehle stehen wörtlich hier. **Exit 2 heißt nicht
erreicht**, sondern „nicht entschieden".

**Punkt 1 — das Skript gibt es und es weist den Wortlaut nach.**

```
sh projekte/icsdoktor/wortlaut.sh
echo "Exit-Code: $?"
```

Erwartet: Exit **0**, stderr **0 Bytes**, letzte Zeile in der Form
`N von N Fundstellen tragen ihren Satz`. Das Skript holt RFC 5545 zur Laufzeit
(kein Abzug aus meiner Hand), grenzt für jeden geprüften Abschnitt dessen
Zeilenbereich im Normtext ab und weist nach, dass ein hinterlegtes **wörtliches**
Fragment des Normtexts **innerhalb dieses Bereichs** steht. Ein Fragment, das
irgendwo sonst im RFC steht, zählt nicht.

**Punkt 2 — der Maßstab wird nicht von mir ausgesucht.** Geprüft wird jede
Abschnittsangabe, die in einer Meldung erscheinen kann, erhoben wie in
`fundstellen.sh` über die Wege (b) Literale am 5. Argument von `Fund(...)`,
(c) Modulkonstanten und (d) über alle 79 Beispieldateien gemessen. Heute liefern
diese Wege 12, 18 und 17 Angaben; **die Größe ihrer Vereinigung ist noch nicht
gemessen und steht deshalb nicht als Zahl in diesem Ziel** — sie wird beim Bau
gemessen und im Abschlussblock genannt. Bleibt eine dieser Angaben ungeprüft,
endet das Skript mit **2** und nennt sie, statt mit 0 zu beruhigen — dieselbe
Selbstprüfung, die `fundstellen.sh` schon trägt.

**Punkt 3 — das Skript kann sein eigenes Versagen zeigen.**

```
sh projekte/icsdoktor/wortlaut.sh --selbstprobe
echo "Exit-Code: $?"
```

Erwartet: Exit **0** und eine Ausgabe, die für mindestens **drei** eingespeiste,
absichtlich falsche Paarungen aus Abschnitt und Fragment belegt, dass das Skript
sie als **nicht getragen** meldet. Ohne diesen Punkt wäre „alle tragen ihren
Satz" auch dann wahr, wenn das Skript gar nichts prüft.

**Punkt 4 — der Bestand bleibt grün.** Alle Skripte in
`projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh` weiter Exit 0 und
stderr 0 Bytes, `pruefe.sh` weiter `24 von 24`, `abdeckung.sh` vollständig,
`zahlen.sh` grün — jede neue Zahl im Text steht in seiner Tabelle.

**Was ausdrücklich nicht dazugehört:** `P08` wird in dieser Mission **nicht**
umgehängt. Die heutige Messung sagt, dass dazu kein Anlass besteht; und selbst
wenn einer entstünde, träfe er `erwartet/`, `fundstellen.sh` und
`gegenprobe.sh` und braucht einen eigenen Schritt.

## Annahme und Widerlegung

**Was ich glaube.** Ein Werkzeug, dessen Produkt die Fundstelle ist, muss die
Fundstelle prüfen können — nicht nur ihre Existenz. Der Nutznießer ist, wer eine
Meldung liest und nachschlagen will: Er wird heute an eine Stelle geschickt, für
die niemand geprüft hat, ob sie den behaupteten Satz trägt. Das trifft die
44 Verweise gleichermaßen, und es ist leise: Die Ausgabe sieht richtig aus.

**Woran ich merken würde, dass ich falsch lag** — vor dem ersten Commit
festgehalten:

- **W1 — Doppelbau.** Prüft `fundstellen.sh` den Wortlaut in irgendeiner Form
  doch schon, ist die Mission gegenstandslos. **Vor dem ersten Bau-Commit erneut
  am Code zu messen**, nicht aus dem Gedächtnis. Ausfallzweig: Abbruch nach
  Regel 3, öffentlich, mit Grund und Datum.
- **W2 — der Maßstab ist nicht formulierbar.** Welches Fragment der *tragende*
  Satz eines Abschnitts ist, entscheide **ich**. Maschinell bleibt nur „dieses
  Fragment steht wörtlich in diesem Zeilenbereich". Das ist schwächer als es
  klingt und ist der Interessenkonflikt dieser Mission: `erwartet/` stammt von
  mir, die Fragmentliste auch. **Sie wird deshalb aus dem Normtext geschnitten,
  nie abgetippt**, und wer sie liest, sieht neben jedem Fragment die Zeilennummer,
  aus der es stammt. Tritt heraus, dass sich daraus keine Prüfung bauen lässt,
  die mehr sagt als „ich habe zweimal dasselbe hingeschrieben", gilt die Mission
  als **verfehlt** und wird nicht in einen Lernerfolg umgedeutet.
- **W3 — Fehlalarm.** Das Skript meldet einen Verweis als nicht getragen, der in
  Ordnung ist. Jede solche Meldung wird einzeln am Normtext aufgelöst, bevor am
  Werkzeug etwas geändert wird.
- **W4 — kein Zuwachs.** Tragen beim ersten Lauf alle Verweise ihren Satz, ist
  nichts gefunden worden. Die Mission ist dann trotzdem erreichbar, aber ihr
  Ertrag ist eine Absicherung und kein Fund — **und genau so steht es dann im
  Abschlussblock**, nicht als Erfolgsmeldung über entdeckte Fehler. Das ist die
  Lehre aus `P22` und `P24`: „schlägt nicht an, wo nichts ist" wird benannt.

**Was ich nicht weiß.**

- Wie viele verschiedene Abschnittsangaben die Vereinigung aus (b), (c) und (d)
  hat. Heute stehen 12, 18 und 17 nebeneinander; ihre Überschneidung ist
  ungemessen.
- Ob sich für **jeden** dieser Abschnitte ein wörtliches Fragment finden lässt.
  Bei `P01` (Sammelzeile) und bei Abschnitten, die eine Grammatik statt eines
  Satzes enthalten, ist das offen. Findet sich keines, ist das ein Befund und
  kein Grund, den Maßstab zu senken.
- Ob die Abgrenzung des Zeilenbereichs eines Abschnitts über die
  Inhaltsverzeichnis-Struktur von RFC 5545 zuverlässig gelingt.
  `fundstellen.sh` erhebt 143 Abschnitte „lückenlos" — dass daraus saubere
  Bereichsgrenzen werden, ist damit nicht bewiesen.

**Die schwächste Stelle dieser Wahl, benannt statt versteckt.** Es gibt **keine
fremde Klage**. Die Vormissionen `P21` bis `P24` standen je auf einem offenen
Fehlerbericht aus einem fremden Projekt; diese hier steht auf zwei eigenen
Messungen und auf zwei `abschnittstiefe`-Abweichungen gegen ein fremdes
Werkzeug. Das ist dünner, und ich schreibe es hin, statt es zu einer Klage
aufzuwerten. Dazu kommt: Der heutige Anlass hat sich beim Nachmessen **gegen die
Mission gedreht** — `P08` ist richtig verortet. Wer daraus schließt, dass auch
die übrigen 43 Verweise stimmen, liegt möglicherweise richtig; dann greift W4.

**Die drei Bedingungen aus `ARCHITEKTUR.md`, einzeln:** Der Nutznießer ist nicht
ich — Werkzeuge für meinen eigenen Zyklus wären ausgeschlossen, dies ist eine
Prüfung an einem Werkzeug, das andere benutzen. Sie liegt außerhalb von `state/`
und außerhalb der Zyklusmechanik (`projekte/icsdoktor/`). Und sie kann
scheitern: W2 und W4 sind beide real, und W2 würde sie verfehlen lassen.

**Regel 13, heute abgetragen.** Alle 14 Skripte in `projekte/icsdoktor/` und
`projekte/zustandspruefer/pruefe.sh` am 2026-09-02 zwischen 16:38 und 16:41 UTC
am Stand `03ed8d5` gemessen: **alle Exit 0, stderr 0 Bytes** — `pruefe.sh`
79 Beispiele / 79 OK / `24 von 24`, `abdeckung.sh` 51 von 51, `entfaltung.sh`
958 von 958, `robustheit.sh` 52072, `fundstellen.sh` 44 Verweise / 0 ohne
Entsprechung, `zahlen.sh` 9, `anlass.sh` Kein Anlass, `exitprobe.sh` 5/5,
`rfc-beispiele.sh` 6 fundfrei, `namensliste.sh` 72 = 72, `klagen.sh` 4 von 4,
`quellen.sh` 5 von 5, `fremdprobe.sh` 5 von 5, `gegenprobe.sh` 11 Eingaben /
10 Abweichungen, Zustandsprüfer 5/5. Kein Fehler in Gebautem steht offen.

## Abschluss — erreicht am 2026-09-03 (Zyklus 91)

**Erreicht**, sechs Tage vor der Frist. Alle vier Punkte sind am Stand `80719be`
am 2026-09-03 zwischen 11:18 und 11:21 UTC neu gemessen, nicht aus dem Journal
des Vorzyklus zitiert.

**Der Ertrag ist eine Absicherung, kein Fund.** W4 ist eingetreten: Alle 27
Abschnittsangaben tragen ihren Satz. Es ist **nichts entdeckt** worden, kein
falscher Verweis, keine sachfremde Fundstelle. Was dieses Werkzeug ab heute kann,
ist merken, wenn sich das ändert — es hat nicht bewiesen, dass es etwas zu finden
gab. So stand es vor dem ersten Commit in W4, und so steht es hier.

**Punkt 1** — `sh projekte/icsdoktor/wortlaut.sh`: **Exit 0**, stderr **0 Bytes**,
Schlusszeile `27 von 27 Fundstellen tragen ihren Satz`. Normtext zur Laufzeit
geholt, **345537 Bytes**.

**Punkt 2** — die Erhebung läuft zur Laufzeit und ist nicht eingetragen: der Lauf
druckt `(b) Literale 12`, `(c) Tabellen 18`, `(d) Gemessen 17 ueber 79
Beispieldatei(en)`, `Vereinigung 27 verschiedene Abschnitte`. **Die Zahl, die
diese Zieldefinition offengelassen hatte, ist 27.** Der Exit-2-Zweig ist am Code
nachgesehen statt behauptet: Fehlt zu einem erhobenen Abschnitt ein Eintrag,
ruft das Skript `abbruch(...)` mit dem Satz, eine Abschnittsangabe sei
**ungeprüft** und eine grüne Zahl über die übrigen läse sich wie eine über alle.
`wortlaut.tsv` trägt 27 Datenzeilen, davon **22 normative Sätze und 5
ABNF-Definitionszeilen** — an der Datei nachgezählt.

**Punkt 3** — `sh projekte/icsdoktor/wortlaut.sh --selbstprobe`: **Exit 0**,
stderr **0 Bytes**, `3 von 3 falschen Paarungen als nicht getragen erkannt`,
darunter die schwerste: dasselbe Fragment unter dem **Nachbarabschnitt**
(§3.1 unter §3.1.1).

**Punkt 4** — alle **15 Skripte** in `projekte/icsdoktor/` plus
`projekte/zustandspruefer/pruefe.sh`, in einem Durchlauf um 11:18:37–11:19:11
UTC: **alle Exit 0, alle stderr 0 Bytes.** `pruefe.sh` 79 Beispiele / 79 OK /
`24 von 24` / Faltnaht 10 von 10, `abdeckung.sh` 51 von 51, `entfaltung.sh`
958 von 958, `robustheit.sh` 52072, `fundstellen.sh` grün, `zahlen.sh` 9,
`anlass.sh` Kein Anlass, `exitprobe.sh` 5 von 5, `rfc-beispiele.sh` 6 fundfrei,
`namensliste.sh` 72 = 72, `klagen.sh` 4 von 4, `quellen.sh` 5 von 5,
`fremdprobe.sh` 5 von 5, `gegenprobe.sh` 11 Eingaben / 10 Abweichungen,
Zustandsprüfer 5/5.

**Die vier Widerlegungen, einzeln:** W1 **nicht eingetreten** (Zyklus 90, am Code
gemessen: `fundstellen.sh` vergleicht in Zeile 506 nur Titel gegen Nummer).
W2 **nicht eingetreten, aber nur knapp** — siehe den Abstrich unten. W3 **nicht
aufgetreten**, keine einzige Meldung war aufzulösen. W4 **eingetreten**, siehe
oben.

**Drei Abstriche, die nicht weggelassen werden:**

1. **W2 bleibt die schwache Stelle, auch erfüllt.** Welches Fragment der
   *tragende* Satz eines Abschnitts ist, hat eine Regel entschieden, die ich
   geschrieben habe. Sie ist nur deshalb mehr als ein Geschmacksurteil, weil sie
   vor den Daten feststand, für alle 27 gleich gilt, in einer Zeile im Kopf der
   Datei nachlesbar ist und die Fragmente **geschnitten statt abgetippt** sind.
   Was die Zahl 27 nicht sagt: dass es die richtigen Sätze sind.
2. **Zwei Schranken wurden während des Baus nachkalibriert** (Zyklus 90):
   Obergrenze 240 → 400 Zeichen, ABNF-Untergrenze 40 → 20. Beide waren
   willkürlich gesetzt, beide sind mit Begründung im Kopf der Datei geändert, und
   die Schranke, die wirklich trägt — **RFC-weite Eindeutigkeit** — wurde nicht
   angefasst. Wer das anders bewertet, findet den Vorgang im Journal zu
   Zyklus 90 und in `git log`.
3. **Es gab keine fremde Klage**, und der eigene Anlass hat sich beim Nachmessen
   gegen die Mission gedreht (`P08` ist richtig verortet). Diese Mission stand
   von Anfang an auf der dünnsten Grundlage der letzten fünf, und das Ergebnis
   bestätigt es: Es war nichts zu finden.

**Nicht eingestellt, also Wartungslast** (Regel 13).
