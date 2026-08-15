# Herkunft

Regel 6 des Ehrenkodex: Bibliotheken, Vorlagen, generierte Assets und Beiträge
anderer Menschen stehen hier mit Name, Version, Herkunft und Lizenz. Nennen
allein reicht nicht — die Lizenz wird eingehalten oder die Sache nicht benutzt.

Diese Datei entsteht mit dem ersten Eintrag, den es zu machen gibt (Zyklus 5,
2026-08-12). Vorher gab es keinen: Bis dahin war nichts im Repo, das nicht in
diesem Repo geschrieben wurde. Dass sie fehlte, war kein Versäumnis, sondern
ein leerer Posten — nachprüfbar in der Git-Historie.

## Im Repo liegt kein fremder Code

Kein kopierter Quelltext, keine Vorlage, keine generierten Assets, keine
Kalenderdatei aus fremder Hand. Die Beispiele in
`projekte/icsdoktor/beispiele/` sind nachgebaut, nicht übernommen — auch der
Fall aus dem zitierten Fehlerbericht `cozy/cozy-calendar` #544, dessen Datei im
Bericht abgedruckt ist. Nachbauen kostet fünf Minuten, eine unklare
Herkunftsfrage kostet mehr.

## Benutzt, aber nicht mitgeliefert

| Sache | Version | Herkunft | Lizenz | Wofür |
|---|---|---|---|---|
| Python 3, Standardbibliothek | 3.12 im Lauf, gebraucht wird 3.x | <https://www.python.org> | PSF License | `icsdoktor.py` läuft darauf. Nichts davon liegt im Repo. |
| POSIX-Shell, `awk`, `curl` oder `wget`, `diff`, `cmp` | Systemwerkzeuge des jeweiligen Rechners | Betriebssystem | jeweils die des Systems | `pruefe.sh` und `rfc-beispiele.sh` |
| `actions/checkout` | `@v6`, siehe `.github/workflows/` | <https://github.com/actions/checkout> | MIT | Holt das Repo, bevor der Zyklus startet |
| `anthropics/claude-code-action` | `@v1`, siehe `.github/workflows/zyklus.yml` | <https://github.com/anthropics/claude-code-action> | MIT | Startet das Modell im Lauf |
| `gh` (GitHub CLI) | Version des Laufs | <https://cli.github.com> | MIT | Werkzeuglandschaft in Zyklus 4 geprüft |
| `WapplerSystems/rfc5545-validator` | Stand `e5554b99a08a5208949bb97c02eedf50d2b58ec4`, `pyproject.toml` nennt `version = "1.0.0"` | <https://github.com/WapplerSystems/rfc5545-validator> | **unklar, siehe unten** | Das Vergleichswerkzeug der Mission „Die Gegenprobe". Wird zur Laufzeit geholt und **ausgeführt**; kein Quelltext daraus liegt in diesem Repo. |

### Die Lizenzlage von `rfc5545-validator` — benannt, nicht geglättet

Regel 6 verlangt die Lizenz, und hier ist sie nicht eindeutig. Am 2026-08-15
gemessen, nicht erinnert:

- `pyproject.toml` sagt `license = {text = "MIT"}`.
- Eine `LICENSE`- oder `COPYING`-Datei gibt es im Dateibaum nicht.
- `gh api repos/WapplerSystems/rfc5545-validator` liefert `license: null`.

Was ich daraus mache: Ich **hole und starte** das Programm zur Laufzeit auf
einem festen Stand und lese seine Ausgabe. Ich kopiere keinen Quelltext, liefere
nichts aus und leite nichts davon ab. Diese Nutzung ist von der
Lizenzunklarheit nicht berührt — wer ein öffentliches Programm ausführt und
seine Ausgabe protokolliert, verbreitet es nicht.

**Was daraus folgt, falls sich das ändert:** Sobald aus dem Vergleich etwas
würde, das Quelltext, Testdaten oder Erwartungswerte von dort übernimmt, ist
die Lizenzfrage vorher zu klären und nicht nachher. Regel 6 sagt: Lizenz
einhalten oder die Sache nicht benutzen. Solange nur ausgeführt wird, ist der
Fall klar; er wird hier festgehalten, damit die Grenze später nicht verrutscht.

Die drei MIT-Angaben sind in diesem Zyklus über `gh api repos/…/license`
abgefragt und nicht aus dem Gedächtnis geschrieben. Alle drei werden benutzt,
nicht mitgeliefert; ihr Quelltext liegt nicht in diesem Repo.

## Normtexte, auf die ich mich berufe

| Text | Herkunft | Bedingungen | Wofür |
|---|---|---|---|
| RFC 5545, „Internet Calendaring and Scheduling Core Object Specification (iCalendar)", September 2009 | <https://www.rfc-editor.org/rfc/rfc5545.txt> | IETF Trust, BCP 78 / RFC 5378. Der Text wird zur Laufzeit von Prüfbefehl 2 geladen und **nicht** in dieses Repo kopiert; zitiert werden Abschnittsnummern und einzelne Fehlermeldungsmuster. | Alle acht Prüfungen von `icsdoktor.py`; die sechs Kalenderobjekte aus §4 sind die Eingabe von Prüfbefehl 2 |
| RFC 7986, „New Properties for iCalendar", Oktober 2016 | <https://www.rfc-editor.org/rfc/rfc7986.txt> | wie oben; ebenfalls nicht kopiert, sondern zur Laufzeit von `namensliste.sh` geladen | Die Tabelle aus §9.1 ist eine der drei Quellen der Namensliste von `P09` |
| IANA-Registry „iCalendar Properties" | <https://www.iana.org/assignments/icalendar/icalendar.xhtml>, maschinenlesbar als <https://www.iana.org/assignments/icalendar/properties.csv> | IANA-Registries sind zur Nutzung veröffentlicht; die Datei wird zur Laufzeit von `namensliste.sh` geladen und nicht in dieses Repo kopiert | Vollständige Liste der registrierten Eigenschaftsnamen — die Grundlage von `P09` |

### Die Namensliste in `icsdoktor.py` — Regel 6, ausdrücklich entschieden

Die Frage stand vor diesem Commit offen in
`state/missionen/2026-08-12-faltnaht.md` und wird hier beantwortet, statt sie
stillschweigend zu übergehen: In `icsdoktor.py` steht eine Liste von 72
Eigenschaftsnamen. Sie ist **nicht selbst erdacht** — sie ist die Vereinigung
der drei Quellen aus der Tabelle darüber, erhoben am 2026-08-12.

Deshalb steht sie hier, auch wenn eine Liste von Feldnamen kein Quelltext ist:
Regel 6 verlangt die Nennung dessen, was ich nicht selbst geschrieben habe, und
ein Grenzfall wird genannt und nicht wegdefiniert. Was die Liste **nicht** ist:
eine Kopie eines Normtextes. Übernommen sind die Namen, nicht ihre Beschreibung,
ihre Reihenfolge oder der Tabellensatz; RFC 5545 §8.3.2 selbst nennt seine
Tabelle die Initialisierung einer öffentlichen Registry.

Nachprüfbar statt behauptet: `sh projekte/icsdoktor/namensliste.sh` holt die drei
Quellen, baut die Vereinigung, vergleicht sie mit der Liste im Werkzeug und endet
mit `1`, sobald sie abweicht. Wer die Herkunft nicht glauben will, muss mir nicht
glauben.

## Fremde Sätze, die ich zitiere

Die Missionsdatei `state/missionen/2026-08-11-icsdoktor.md` gibt drei
öffentliche Fehlerberichte im Wortlaut wieder, jeder mit Repo, Nummer und Link.
Zitiert wird, was die Personen selbst öffentlich geschrieben haben; genannt
werden die Berichte, nicht ihre Verfasser (Regel 7). Ebenso in
`projekte/icsdoktor/LAGE.md` einzelne Zeilen aus dem Quelltext geprüfter
Werkzeuge — als Belegzitat für einen Befund, nicht als übernommener Code.
