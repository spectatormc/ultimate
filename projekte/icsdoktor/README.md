# ICS-Doktor

Ein Werkzeug, das eine kaputte `.ics`-Kalenderdatei liest und für jeden Verstoß
**Zeile, Regel und Abschnitt aus RFC 5545** nennt.

Die Aufgabe, die acht Prüfungen `P01` bis `P08`, das Ausgabeformat und die Frist
stehen in `state/missionen/2026-08-11-icsdoktor.md` und sind ab Anlage der
Mission unveränderlich. Diese Datei erklärt nur, was daraus geworden ist.

`P09` und `P10` kommen aus der Folgemission
`state/missionen/2026-08-12-faltnaht.md`: `P09` prüft den Eigenschaftsnamen
gegen die IANA-Registry, `P10` die Faltstelle gegen die Maskierung. Beide sind
gebaut; ob die Mission damit erreicht ist, entscheidet ihr Abschlussblock und
nicht diese Datei.

`P11` kommt aus der Mission `state/missionen/2026-08-13-fremdprobe.md` und
unterscheidet sich von allen zehn davor: Sie stammt nicht aus einem Beispiel,
das ich mir ausgedacht habe, sondern aus einer fremden Datei, die ein Mensch
öffentlich als kaputt gemeldet hat (`lfos/calcurse#323`). Sie meldet ein
`VEVENT` ohne `DTSTART` — und zwar nur, solange das umgebende `VCALENDAR` keine
`METHOD` trägt, weil §3.6.1 die Pflicht genau daran knüpft.

## Warum

Drei öffentliche Fehlerberichte, in der Missionsdatei mit Link und Wortlaut
zitiert, beschreiben dieselbe Lage aus verschiedenen Richtungen: Ein Programm
lehnt eine Kalenderdatei ab, und der Mensch, dem die Datei gehört, erfährt
nicht, wo er suchen soll. Die verbreiteten Bibliotheken melden entweder die
Regel oder die Zeile — die geprüfte Werkzeuglandschaft steht in `LAGE.md`, mit
dem Befund, der gegen diese Mission spricht.

## Aufruf

```
python3 projekte/icsdoktor/icsdoktor.py DATEI.ics
```

Eine Zeile je Fund:

```
<SCHWERE> Zeile <n>: <code> <klartext> [RFC 5545 §<abschnitt>]
```

`<n>` ist die physische Zeile der Datei, gezählt ab 1. Bei gefalteten Zeilen ist
es die Zeile, in der die logische Zeile beginnt.

Exit-Code: `0` kein FEHLER, `1` mindestens ein FEHLER, `2` Aufruf- oder
Lesefehler. Nur Python 3 aus der Standardbibliothek, kein Netz zur Laufzeit.

Beispiel:

```
$ python3 icsdoktor.py beispiele/12-p08-datumszeit.ics
FEHLER Zeile 6: P08 DTSTAMP: Wert "2026-08-12T05:00:00Z" ist kein DATE-TIME; …
FEHLER Zeile 7: P08 DTSTART: den 30. gibt es im Monat 02 des Jahres 2026 nicht …
```

## Zwei Schweregrade

`P03` (Zeilenlänge) steht im RFC als „SHOULD NOT" und ist deshalb `HINWEIS`; er
ändert den Exit-Code nicht. `P09` ist ebenfalls `HINWEIS`: Ein unbekannter
Eigenschaftsname verstößt gegen kein „MUST", und Hersteller-Eigenschaften ohne
`X-` gibt es wirklich. `P10` ebenso: §3.1 erlaubt die Faltung an nahezu jeder
Stelle, gemeldet wird also keine Regelverletzung, sondern eine Stelle, an der
Programme messbar auseinandergehen. Alles andere ist `FEHLER`. Ein Werkzeug,
das eine Empfehlung als Verstoß ausgibt, schickt Menschen auf die Suche nach
Fehlern, die keine sind.

Die Missionsdatei nennt diesen Grad „Warnung". Das Werkzeug hat genau zwei
Grade, und der nicht-fehlerhafte heißt seit der Vormission `HINWEIS` — gemeint
ist derselbe. Umbenannt wird nichts, damit die dreizehn älteren Erwartungen in
`erwartet/` byte-genau bleiben.

## Selbst nachprüfen

```
sh projekte/icsdoktor/pruefe.sh          # neunzehn mitgelieferte Beispiele
sh projekte/icsdoktor/rfc-beispiele.sh   # die sechs Kalender aus RFC 5545 §4
sh projekte/icsdoktor/namensliste.sh     # woher die Namensliste von P09 kommt
```

Der zweite ist der wichtigere: Seine Eingabe stammt nicht von mir, sondern aus
dem Normtext. Ein Kalender aus dem RFC verstößt nicht gegen den RFC — meldet das
Werkzeug dort einen Fehler, hat das Werkzeug unrecht. Er braucht Netz; ist
`rfc-editor.org` nicht erreichbar, endet er mit Exit-Code 2 und sagt das, statt
grün zu melden.

`pruefe.sh` vergleicht Byte für Byte gegen `erwartet/` und leitet den erwarteten
Exit-Code aus der Erwartung ab, statt ihn danebenzuschreiben. Zusätzlich rechnet
er die Vorgaben der Missionsdatei nach: mindestens zwölf Beispiele, jede
Prüfung mindestens einmal ausgelöst, mindestens zwei fehlerfreie Dateien. Die
abgeschlossene Mission „Die Faltnaht" verlangt mehr — 16 Beispiele und die zehn
Prüfungen `P01` bis `P10` —, und wo das steht, sagt die letzte Zeile der
Ausgabe, damit ein grüner Exit-Code nicht als „Mission erreicht" gelesen wird.
`P11` füllt diese Zehn nicht auf, sondern wird getrennt gezählt: Eine
abgeschlossene Zusage wird nicht dadurch billiger, dass später eine Prüfung
dazukommt.

Seit `rfc-beispiele.sh` auch bei einem `HINWEIS` mit `1` endet, ist er die
Kontrolle gegen Fehlalarme von `P09` und `P10`: Ein Kalender aus dem Normtext
darf keine Warnung erzeugen — die sechs Objekte aus §4 sind gefaltet, und eine
der beiden Prüfungen hätte dort anschlagen können. `namensliste.sh` holt die
IANA-Registry sowie die Tabellen aus
RFC 5545 §8.3.2 und RFC 7986 §9.1 und vergleicht sie mit der Liste im Werkzeug;
weicht sie ab, endet er mit `1` und nennt jeden Unterschied. Beide brauchen Netz.

## Entscheidungen, die im RFC nicht festgelegt sind

Wo der Standard mehrere Lesarten zulässt, steht hier, welche gewählt wurde:

- **Eine Zeile, deren Form unklar ist, geht nicht in die weiteren Prüfungen
  ein.** Scheitert `P04`, wird die Zeile für `P05` bis `P08` übersprungen statt
  geraten. Sie fehlt dann in der Struktur — das erzeugt manchmal einen zweiten,
  echten Befund.
- **`P08` prüft die Eigenschaften, deren Wert nach RFC vom Typ DATE-TIME ist**
  (`DTSTAMP`, `DTSTART`, `DTEND`, `DUE`, `CREATED`, `LAST-MODIFIED`,
  `COMPLETED`, `RECURRENCE-ID`, `EXDATE`, `RDATE`), und überspringt sie, wenn
  ein `VALUE`-Parameter einen anderen Typ nennt. `TRIGGER` ist ohne
  `VALUE=DATE-TIME` eine DURATION und wird nur mit diesem Parameter geprüft.
  `FREEBUSY` ist PERIOD und wird nicht geprüft.
- **Sekunde 60 ist erlaubt** — §3.3.5 lässt sie für Schaltsekunden zu.
- **Ein `END`, das nicht zum offenen `BEGIN` passt, schließt das offene
  trotzdem.** Sonst hängt der Rest der Datei an einem Fehler, der zehn Zeilen
  weiter oben passiert ist.
- **`P01` meldet ein CR ohne folgendes LF, aber `P04` meldet es nicht als
  Steuerzeichen im Wert.** Derselbe Befund zweimal ist keine doppelte
  Diagnose.
- **Fehlt der Datei am Ende das CRLF, ist das ein `P01`-Fehler** — §3.1
  schließt jede Inhaltszeile mit CRLF ab, auch die letzte.

## Was dieses Werkzeug nicht tut

Die Grenzen gehören in die Beschreibung, nicht in die Fußnote:

- **Es repariert nichts.** Nur Diagnose. So steht es in der Mission.
- **Es prüft genau die elf Prüfungen** und nicht mehr. Insbesondere nicht die
  Maskierung von Sonderzeichen in TEXT-Werten (§3.3.11) — `P10` sieht nur, wo
  eine Faltung sie zerschneidet, nicht ob sie richtig ist —, nicht die
  Zeichenkodierung, nicht `RRULE`, und für `VTODO`, `VJOURNAL` und `VFREEBUSY`
  keine Pflichtangaben — die erfasst nur `P05` strukturell.

  Für das `VEVENT` sind seit `P11` alle drei Pflichtangaben aus §3.6.1 erfasst:
  `UID` und `DTSTAMP` durch `P07`, `DTSTART` durch `P11`. Bis zum 2026-08-13
  stand hier, `DTSTART` sei nicht darunter — der Satz galt und ist durch die
  fremde Datei aus `lfos/calcurse#323` widerlegt worden, nicht durch eine
  Überlegung von mir.
- **`P11` prüft nur das fehlende `DTSTART`, nicht das doppelte.** §3.6.1
  verbietet auch, dass es zweimal vorkommt; das ist nicht gebaut, weil der
  Prüfbefehl der Mission den fehlenden Fall verlangt. Ein `VEVENT` ohne
  umgebendes `VCALENDAR` meldet `P11` ebenfalls nicht — dort fehlt der
  Bedingung ihr Bezugspunkt, und `P05` meldet die Stelle bereits.
- **Ein unbekannter Eigenschaftsname ist weiter kein Fehler, aber seit `P09`
  ein Hinweis.** Der Satz, der hier bis zum 2026-08-12 stand — „keine der acht
  Prüfungen schlägt an, der Fehler ist echt, das Werkzeug sieht ihn nicht" —
  galt für den Fall, dass eine Fortsetzungszeile ihr führendes Leerzeichen
  verliert und aus `\r\n mailto:employee-A@example.com` die formal gültige
  Eigenschaft `mailto` wird. Genau dieser Fall wird jetzt gemeldet, mit Zeile,
  Kennung `P09` und dem Namen. Der alte Wortlaut steht in der Git-Historie und
  wird nicht begradigt.
- **`P09` kann irren, und zwar in eine Richtung.** Wer eine
  Hersteller-Eigenschaft ohne `X-` benutzt oder eine, die nach dem Stand der
  Liste registriert wurde, bekommt einen Hinweis auf eine Faltung, die intakt
  ist. Deshalb Hinweis statt Fehler, deshalb „möglicherweise" in der Meldung,
  und deshalb ist die Liste nachprüfbar (`namensliste.sh`) statt behauptet.
- **`P10` meldet eine Stelle, die der RFC erlaubt.** Eine Faltung zwischen `\`
  und dem maskierten Zeichen ist nach §3.1 zulässig; wer entfaltet, bevor er
  auswertet, sieht nichts Falsches. Gemeldet wird sie trotzdem, weil der
  zitierte Fehlerbericht zeigt, dass Programme hier auseinandergehen — ein
  Kalender wurde von einem Dienst nicht angezeigt und von einem anderen ohne
  Klage gelesen. Wer `P10` für zu streng hält, hat einen Punkt, den dieser
  Absatz nicht wegdiskutiert: Der Hinweis nennt eine Uneinigkeit zwischen
  Programmen, keinen Verstoß.
- **`P10` sieht die Naht, nicht den Sinn.** Erkannt wird eine ungerade Zahl von
  `\` am Zeilenende vor einer Fortsetzung. Ein `\\` am Zeilenende ist eine
  vollständige, maskierte Maskierung und wird nicht gemeldet
  (`beispiele/17-sauber-maskierter-rueckwaertsstrich.ics` ist genau diese
  Gegenprobe). Ob der maskierte Buchstabe dahinter überhaupt einer ist, den
  §3.3.11 kennt, prüft `P10` nicht — das wäre eine Prüfung der Maskierung und
  steht in keiner Mission.

## Dateien

```
icsdoktor.py        Das Werkzeug. Nur Standardbibliothek.
pruefe.sh           Prüfbefehl 1: Beispiele gegen Erwartungen.
rfc-beispiele.sh    Prüfbefehl 2: die sechs Kalender aus RFC 5545 §4.
namensliste.sh      Herkunftsprüfung der Namensliste von P09. Kein Prüfbefehl
                    der Mission — er beweist die Herkunft, nicht die Prüfung.
beispiele/          Neunzehn Kalenderdateien, byte-genau, teils mit Absicht kaputt.
erwartet/           Je eine Datei mit der erwarteten Ausgabe.
LAGE.md             Geprüfte Werkzeuglandschaft, mit Links.
.gitattributes      Hält CRLF in beispiele/ auch über einen Klon hinweg.
```

Die Beispiele sind nachgebaut, nicht kopiert: Keine fremde Kalenderdatei liegt
in diesem Repo, damit keine Herkunftsfrage entsteht, die ich nicht sauber
beantworten kann. Siehe `HERKUNFT.md`.
