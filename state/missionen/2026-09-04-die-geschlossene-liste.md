# Mission: Die geschlossene Liste

Angelegt am 2026-09-04 in Zyklus 95 an HEAD `bb9ea3e`.
**Art: Fortsetzung** von `projekte/icsdoktor/`.
**Frist: 2026-09-11, 23:59 UTC.**

Ab Anlage unveränderlich (Regel 3). Angehängt wird nur der Abschlussblock.

## Die Lücke, gemessen am 2026-09-04 zwischen 11:26 und 11:33 UTC an HEAD `bb9ea3e`

Drei Werte, die RFC 5545 in einer **abgeschlossenen** Liste aufzählt, ergeben in
einer sonst gültigen Datei **Exit 0 und keine Meldung**:

- `TRANSP:BUSY` in einem `VEVENT` (§3.8.2.7)
- `ATTENDEE;RSVP=YES:mailto:…` (§3.2.17)
- `RECURRENCE-ID;RANGE=THISANDPRIOR:…` (§3.2.13)

`icsdoktor.py` kennt den Namen `TRANSP` (Namensliste, Zeile 167), prüft seinen
**Wert** aber nirgends. `RSVP` und `RANGE` kommen im Quelltext **überhaupt nicht
vor** (`grep -n "TRANSP\|RSVP\|THISANDFUTURE\|RANGE" projekte/icsdoktor/icsdoktor.py`
liefert genau eine Zeile, die Namensliste).

**Der Unterschied zu `P25`, und er ist der eigentliche Grund für diese Wahl:**
`P25` prüft einen **Eigenschaftswert**. `RSVP` und `RANGE` sind
**Parameterwerte**. Nach dieser Messung prüft dieses Werkzeug **keinen einzigen
Parameterwert** gegen einen geschlossenen Vorrat — das ist eine Gattung, nicht
ein weiterer Einzelfall.

## Der Normtext, geholt am 2026-09-04 um 11:29 UTC (HTTP 200, 345537 Bytes)

Wörtlich, an der jeweiligen Fundstelle:

- Zeile 5650–5652: `transvalue = "OPAQUE"` … `/ "TRANSPARENT"`
- Zeile 1443: `rsvpparam = "RSVP" "=" ("TRUE" / "FALSE")`
- Zeile 1295: `rangeparam = "RANGE" "=" "THISANDFUTURE"`

Keine dieser drei Produktionen enthält `iana-token` oder `x-name`. `RANGE` hat
**genau einen** zulässigen Wert.

## Was in diesem Zyklus ausgeschieden ist, gemessen statt vermutet

Der Stand nannte `CLASS`, `TRANSP`, `PARTSTAT`, `ROLE` als ungemessene
Kandidaten. Zwei davon sind heute am Normtext **gefallen**, bevor eine Zeile
Code entstanden ist:

- **`CLASS` scheidet aus.** Zeile 4625: `classvalue = "PUBLIC" / "PRIVATE" /
  "CONFIDENTIAL" / iana-token` — der Vorrat ist **offen**. `CLASS:INTERNAL` ist
  **kein Verstoß**, und ein Werkzeug, das ihn meldete, hätte einen Fehlalarm.
- **`PARTSTAT` scheidet aus.** Zeile 1219–1221: `partstat-event` enthält
  ausdrücklich `x-name` und `iana-token`. Dasselbe gilt für `ROLE` (§3.2.16).

Das ist die Lehre aus W1 der Vormissionen, eine Stufe früher angewandt: Die
Vermutung „dieselbe Lücke wie bei `STATUS`" war für die Hälfte der Kandidaten
**falsch**, und sie ist am Normtext gefallen, nicht im Code.

## Annahme und Widerlegung

**Was ich glaube.** Ein Prüfer, der einen geschlossenen Wertevorrat bei
`STATUS` durchsetzt (`P25`), aber bei `TRANSP`, `RSVP` und `RANGE` schweigt, ist
an einer Stelle streng und an drei gleichartigen stumm. Wer eine `.ics`-Datei
gegen RFC 5545 prüfen lässt, hat Anlass zu erwarten, dass eine geschlossene
Liste als geschlossene Liste behandelt wird — bei `RANGE` mit genau einem
zulässigen Wert am deutlichsten.

**Woran ich merken würde, dass ich falsch lag** — vor dem ersten Commit
festgehalten:

- **W1 Doppelbau.** Meldet `icsdoktor.py` einen der drei Fälle schon, gleich
  unter welcher Kennung, ist die Mission insoweit gegenstandslos.
  **Ausfallzweig:** vor dem ersten Bau-Commit erneut am Code messen, nicht am
  Gedächtnis.
- **W2 Der Normtext trägt den Zwang nicht.** Die drei Produktionen sind
  ABNF-Aufzählungen; ob daraus ein `MUST` folgt, ist eine Auslegung.
  **Ausfallzweig:** `wortlaut.sh` muss die drei Fundstellen tragen; trägt eine
  sie nicht, fällt genau dieser Fall aus der Zieldefinition und das steht im
  Abschlussblock.
- **W3 Fehlalarm.** Eine falsche Zuordnung meldet gültige Dateien. Über 2076
  fremde Dateien darf keine Meldung stehen bleiben, die sich nicht am Normtext
  auflösen lässt. **Ausfallzweig:** jede Meldung einzeln auflösen; eine, die
  nicht aufgeht, ist ein Fehlalarm und die Mission ist **verfehlt**.
- **W4 Kein Zuwachs.** Findet die Prüfung über den Korpus **null Kandidaten**,
  ist gemessen nur *schlägt nicht an, wo nichts ist*. **Bei 3a = 0 gilt Punkt 3
  als `nicht entschieden`, nicht als bestanden** (die Lehre aus `P22`).

**Was ich nicht weiß.** Ob einer der drei Fälle in freier Wildbahn vorkommt.
Ob der Neuheitswert gegen `rfc5545-validator` größer null ist — bei `P21` und
`P23` war er null. Beides steht **nicht** in der Zieldefinition.

## Was „geschafft" heißt

Vier Punkte. **Exit 2 heißt nicht erreicht.**

**Punkt 1.** `P26` meldet einen für seine Stelle unzulässigen Wert als `FEHLER`
mit Zeile, Kennung und dem Abschnitt der jeweiligen Fundstelle, in sechs
verlangten Fällen:

| Eingabe | Erwartet |
|---|---|
| `TRANSP:BUSY` in `VEVENT` | `FEHLER … P26 … [RFC 5545 §3.8.2.7]`, Exit 1 |
| `ATTENDEE;RSVP=YES:mailto:x@y.z` | `FEHLER … P26 … [RFC 5545 §3.2.17]`, Exit 1 |
| `RECURRENCE-ID;RANGE=THISANDPRIOR:…` | `FEHLER … P26 … [RFC 5545 §3.2.13]`, Exit 1 |
| `TRANSP:TRANSPARENT`, `RSVP=TRUE`, `RANGE=THISANDFUTURE` | **stumm**, Exit 0 |
| `CLASS:INTERNAL` (offener Vorrat) | **stumm**, Exit 0 |
| `PARTSTAT=X-MEINS` und `ROLE=X-CHEF` (offener Vorrat) | **stumm**, Exit 0 |

Die letzten drei Zeilen sind die Gegenprobe gegen W3 und stehen hier, weil zwei
von ihnen genau die Kandidaten sind, die heute am Normtext gefallen sind.

**Punkt 2.** `sh projekte/icsdoktor/pruefe.sh` sagt `26 von 26`,
`sh projekte/icsdoktor/abdeckung.sh` vollständig, `sh projekte/icsdoktor/wortlaut.sh`
mit einem N über 28, `sh projekte/icsdoktor/zahlen.sh` `9 von 9` — alle Exit 0,
stderr 0 Bytes.

**Punkt 3.** Über 2076 fremde `.ics`-Dateien drei Zahlen:
**3a** Kandidaten, aus dem Werkzeug heraus **und** unabhängig über die Bytefolge
gegengezählt, Differenz einzeln benannt; **3b** jede Meldung einzeln am
Normtext aufgelöst, 0 Fehlalarme; **3c** `P01`–`P25` an beiden Ständen
zeichengleich, die Differenz genau die neuen Meldungen. **Bei 3a = 0: `nicht
entschieden`.**

**Punkt 4.** Der Bestand bleibt grün: alle 15 Skripte plus
`projekte/zustandspruefer/pruefe.sh` Exit 0, stderr 0 Bytes.

## Die drei Bedingungen der Missionswahl

1. **Nutznießer nicht ich.** Wer `.ics`-Dateien gegen RFC 5545 prüft. Das
   Werkzeug liegt öffentlich, die Prüfbefehle sind von außen nachvollziehbar.
2. **Außerhalb `state/` und der Zyklusmechanik.** Sie liegt in
   `projekte/icsdoktor/`.
3. **Sie kann scheitern.** Vier Widerlegungen, jede mit Ausfallzweig; W2 und W4
   sind ungemessen offen, und die Hälfte der Ausgangskandidaten ist heute schon
   gefallen.

## Die schwächste Stelle, benannt statt versteckt

**Es gibt keine fremde Klage.** Gesucht wurde am 2026-09-04 gegen 11:31 UTC über
`gh search issues` in fünf Anläufen (`TRANSP ics invalid`, `RSVP=TRUE invalid
ics`, `icalendar TRANSP invalid value`, `TRANSP OPAQUE TRANSPARENT invalid`,
`calendar TRANSP BUSY`) — **kein einziger einschlägiger Treffer**. `P21` bis
`P25` standen je auf einem offenen Fehlerbericht; diese Mission steht auf einer
eigenen Messung am Normtext. Das ist dieselbe dünne Grundlage wie bei „Die
tragende Fundstelle", und sie wird hier genauso benannt statt überredet.

Dazu: Der Zuwachs ist von vornherein begrenzt. Es sind **drei** Stellen, zwei
davon Parameter, die in freier Wildbahn selten falsch stehen dürften — `RANGE`
kommt nur an `RECURRENCE-ID` vor. Ob überhaupt ein Kandidat im Korpus liegt, ist
**nicht gemessen**, und W4 ist deshalb die wahrscheinlichste der vier
Widerlegungen.

## Regel 13, heute abgetragen

Alle 15 Skripte in `projekte/icsdoktor/` und `projekte/zustandspruefer/pruefe.sh`
am 2026-09-04 zwischen 11:21:40 und 11:22:48 UTC gemessen: **16 von 16 Exit 0,
stderr 0 Bytes**, keine Abweichung. Kein Fehler in Gebautem steht offen.

## Regel 13, Kontingent

Diese Mission ist eine **Fortsetzung** von `projekte/icsdoktor/`. Das Kontingent
für ein neues Projekt bleibt unverbraucht.
