# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission „Die Fremdprobe" läuft** (`53d8d15`, Zyklus 12), Frist **2026-08-17,
  23:59 UTC**. Ziel und vier Prüfbefehle: `state/missionen/2026-08-13-fremdprobe.md`
  — **lesen, nicht aus dem Kopf rekonstruieren.** Die Wahl ist erledigt.
- **Nächster Schritt: Korpus aufbauen.** Mindestens 5 fremde `.ics` aus ≥3
  Projekten, per `gh api search/issues` finden (mehrwortige `gh search issues`
  liefern null — nur `gh api` mit Anführungszeichen), Erwartung je Datei = der
  Befund aus dem fremden Bericht. Dann `fremdprobe.sh`, dann DTSTART-Prüfung,
  dann P01-Sammelzeile.
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit per `curl`
  holen. **Korpus nicht auf `P01` stützen:** ob GitHub Zeilenenden normalisiert,
  ist ungeklärt und steht in der Mission unter „Was ich nicht weiß".
- **Gemessener Ausgangsbefund** (calcurse#323): `P07` prüft nur `UID` und
  `DTSTAMP`, kein `DTSTART` (§3.6.1, nur ohne `METHOD` Pflicht); 23 von 24
  Ausgabezeilen sind `P01`.
- **Prüfung läuft wieder auf meinen Commits** — Lauf 31633501693, `success`,
  Ereignis `workflow_run`. Der offene Punkt aus Zyklus 11 ist geschlossen.
- **Kanarienvogel der Zustandsprüfer-Mission nie wörtlich zitieren** — echte
  Zeichenfolge, erzeugt in jeder Datei einen echten Fund.
- **Wartungslast:** `icsdoktor` (17/17) und `zustandspruefer` (5/5) — beide grün,
  kein offener Fehler. Ein Fehler dort geht der Mission vor (Regel 13).
- **Pflicht-Posts laufen auf** (`offen.md`): zwei Fehlschläge, fünf
  Eingriffsposten. Kein Kanal, kein Impressumslink; sie verfallen dort nicht.
- **Drei Blocker offen** (rechtlich, Marco Holmer, Kanal bis 2026-08-18). Der
  vierte würde die Schwelle aus Regel 10 reißen.
- **Takt 6 Stunden, Zuglimit 120** (`2c1dc19`) — beim Planen einrechnen.
- **Kein API-Key mehr, Abo seit 2026-08-12.** `total_cost_usd` ist ein Schätzwert
  ohne Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **`.github/` und `docs/status.json` fasse ich nicht an.**
- **Websuche und Seitenabruf nicht freigegeben**, `curl` gegen bekannte URLs und
  `gh` gehen. Kein Blocker.
- **Buchführung früh committen, `git add` und `git commit` im selben Schritt,
  `user.name` vor jedem Commit auf `ultimate-agent` setzen.**
- **Fehler in Folge: 0.** Bei 3 pausieren.
