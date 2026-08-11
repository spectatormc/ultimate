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

## ~~2026-08-11 — Entscheidung über Kodex v0.2~~ — erledigt 2026-08-11

Kodex v0.2 in Kraft, beschlossen von `spectatormc`, dokumentiert im Merge des
Branches `kodex-v0.2`. Der Wortlaut von v0.1 bleibt in der Git-Historie.

Dreizehn Regeln statt zehn. Für den laufenden Betrieb ändern sich vor allem
zwei Dinge: Anweisungen erreichen mich nur über das Repo (Regel 11), und
öffentliches Fragen nach Ideen ist erlaubt, gezieltes Ansprechen Einzelner
nicht.

---

## 2026-08-11 — Rechtliche Klärung vor dem ersten Post

**Zu tun:** Prüfen lassen, ob `IMPRESSUM.md` für diesen Kanal ausreicht — ob
eine Anbieterkennzeichnung greift, ob zusätzlich ein Verantwortlicher im
medienrechtlichen Sinne zu benennen ist, ob die Kontaktwege genügen, und ob
KI-generierte Beiträge über Regel 5 hinaus zu kennzeichnen sind.

**Frist:** vor dem ersten Post. Regel 5 und der Abschnitt „Wer verantwortet"
sperren das Posten ohnehin, solange der Impressumslink nicht in jedem Profil
steht — die Sperre greift also von allein, falls das hier liegen bleibt.

**Warum ein Mensch:** Rechtsfragen. Ich habe dazu nur Sekundärquellen gefunden
und behaupte keine Paragrafen.

---

## 2026-08-11 — Marco Holmer über den Betrieb informieren

**Zu tun:** Dem zweiten Vertretungsberechtigten der Gartenschmiede GmbH sagen,
dass die Gesellschaft als Anbieterin dieses Kanals im Impressum steht und damit
für die Beiträge eines autonom postenden KI-Agenten einsteht.

**Frist:** vor dem ersten Post.

**Warum ein Mensch:** Ich darf niemanden von mir aus ansprechen — das ist eine
der fünf Ausnahmen, und an dieser Grenze ändert auch v0.2 nichts. Die
Entscheidung, die GmbH einzusetzen, hat ein Vertretungsberechtigter getroffen
und ist damit gedeckt; dass der andere davon erfährt, kann ich nicht
übernehmen.
