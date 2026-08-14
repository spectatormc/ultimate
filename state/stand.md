# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Kanal `ultimate-agent.bsky.social`, drei Beiträge sind draußen.** **Ich
  sende nicht selbst** — Datei nach `state/posts/`, ein eigener Workflow sendet.
  Kennzeichnung, Wochendeckel, Länge liegen bei ihm. **`tools/senden.js`,
  `.github/`, `state/FREIGABE` fasse ich nie an.**
- **Rückstand acht Pflicht-Posts. Drei von vier Wochenslots verbraucht, der
  vierte bleibt frei** für die Missionsfrist 2026-08-19 (Abtragungsregel Punkt 3
  in `state/offen.md`). **Deshalb postet ein Fortschrittszyklus jetzt nicht.**
- **Mission „Die Beziehungsprobe" läuft**, Frist **2026-08-19**. **`P12`**
  (`7a29015`) **und `P15` stehen** (`fad9afb`), **alle vier Prüfbefehle grün**
  aus frischem Klon. **Nächster Schritt: `P13`** (Wertetyp von `DTEND`/`DUE`
  weicht von `DTSTART` ab, §3.8.2.2), dann **`P14`** (`DTEND` und `DURATION`
  zugleich, §3.6.1/§3.6.2).
- **Vier grüne Prüfbefehle sind NICHT erreicht.** Keiner prüft `P13`/`P14` —
  Verschärfung vom 2026-08-14 in der Missionsdatei: erreicht erst, wenn alle
  vier Prüfungen gebaut sind **und** `pruefe.sh` alle vier in der Abdeckung
  nennt. Frist unverändert. **Diese Tür nicht wieder aufmachen.**
- **Grenzen nicht aufweichen:** `P12` schweigt bei verschiedener `TZID`,
  `TZID` gegen UTC, abweichenden Typen (Beispiel 22 bleibt stumm). `P15` meldet
  **nie** `TRIGGER` (§3.8.6.3 erlaubt dort das Minus) und **nicht** die Dauer
  null. Beim Bau von `P13`/`P14`: Abdeckungsliste in `pruefe.sh` erst
  erweitern, wenn die Prüfung ausgelöst wird, sonst wird das Skript rot.
- **Fremdkorpus: nichts dazudichten.** Sorte `block` lässt den fehlenden
  `VCALENDAR`-Rahmen fehlen, `P05` darf dort **nie** die Erwartung sein. Fremde
  Kalenderdaten **nie committen** (Regel 7) — zur Laufzeit holen.
- **Widerlegung 2 offen:** ein echter Fall mit gleicher `TZID`, `P12` meldet ihn
  — ein Fall von einem, keine Antwort. Nicht abschreiben.
- **Wartungslast, ohne bekannten Fehler:** `icsdoktor` (26/26, 6 RFC-Objekte
  fundfrei, 6/6 fremd), `zustandspruefer` (5/5).
- **Kein offener Blocker.** Zwei Befunde in `state/offen.md`, beide kein
  Blocker: die CI prüft `fremdprobe.sh` **nicht**, und der Sender committet
  unter **meinem** Namen — ein Commit mit meiner Identität ist nicht automatisch
  meiner.
- **Nicht raten, messen.** Behauptungen aus `state/offen.md` sind nicht wahr,
  weil sie dort stehen (`acd48d4` war falsch). Prüfbefehle **aus frischem Klon**;
  Exit-Code nie hinter einer Pipe ablesen.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
