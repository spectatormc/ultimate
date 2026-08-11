# Offen

Was ich nicht selbst lösen kann und ein Mensch tun muss. Jeder Eintrag hat ein
Datum, einen konkreten Satz, was zu tun ist, und eine Frist.

---

## ~~2026-08-11 — API-Key und Spend-Limit~~ — erledigt 2026-08-11

Workspace `ultimate` angelegt, API-Key darin erzeugt, als Repo-Secret
`ANTHROPIC_API` hinterlegt, Spend-Limit gesetzt. Vom Betreiber bestätigt.

Der Secret-Name ist `ANTHROPIC_API`, nicht `ANTHROPIC_API_KEY` wie in den
meisten Beispielen — `zyklus.yml` ist entsprechend angepasst. Wer den einen
ändert, muss den anderen mitändern.

**Noch zu prüfen, nach dem ersten Lauf:** Taucht der Verbrauch im Workspace
`ultimate` auf und nicht im Default? Wenn er im Default landet, greift der
Deckel nicht — und das merkt man sonst erst an der Abrechnung.

---

## ~~2026-08-11 — Zeitplan aktivieren~~ — erledigt 2026-08-11

Beide Zeitpläne aktiv: Zyklus alle 3 Stunden (`17 */3 * * *`), Wächter alle 6
(`40 */6 * * *`). Vom Betreiber entschieden, im Wissen um die Kosten.

**Damit läuft der 48-Stunden-Testlauf bis 2026-08-13.** Er beantwortet drei
Fragen, und zwar messbar statt gefühlt: Wacht der Trigger zuverlässig auf?
Findet ein Zyklus ohne Gedächtnis über `state/` zurück in den Kontext? Hält der
Not-Aus?

**Nach dem Test zu entscheiden:** Takt und Effort. Bei 3 Stunden kostet der
Dauerbetrieb rund 314 USD im Monat und reißt das 50-USD-Limit nach etwa fünf
Tagen. Der Test ist mit rund 21 USD gedeckt; der Dauerbetrieb ist es nicht.
Diese Entscheidung soll auf den Daten aus dem Test beruhen, nicht auf einer
Hochrechnung aus einem einzigen Lauf.

---

## 2026-08-11 — Entscheidung über Kodex v0.2

**Zu tun:** `KODEX-v0.2-vorschlag.md` lesen und entscheiden, was davon in Kraft
geht. In Kraft ist derzeit v0.1 (`KODEX.md`).

**Frist:** vor dem ersten Post, nicht vor dem ersten Zyklus.

**Warum ein Mensch:** Änderungen am Kodex kann nur ein Mensch beschließen. Ich
kann sie vorschlagen, und das habe ich.

---

## 2026-08-11 — Rechtliche Klärung vor dem ersten Post

**Zu tun:** Klären, ob und wie Anbieterkennzeichnung, benannter
Verantwortlicher und KI-Kennzeichnungspflicht für diesen Kanal gelten.
Belastbar, nicht aus zweiter Hand.

**Frist:** vor dem ersten Post.

**Warum ein Mensch:** Rechtsfragen. Ich habe zu diesem Punkt nur
Sekundärquellen gefunden und werde deshalb keine Paragrafen behaupten.
