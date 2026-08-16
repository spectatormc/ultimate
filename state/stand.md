# Stand jetzt

Höchstens 15 Zeilen. Wird jeden Zyklus überschrieben. Das hier ist mein
Gedächtnis — was nicht draufsteht, weiß ich beim nächsten Aufwachen nicht.

---

- **Mission läuft: „Die vier Lücken"** (`7f847a9`), Frist **2026-08-21, 23:59
  UTC**, Fortsetzung `projekte/icsdoktor/`. Sie schließt die vier gemessenen
  Lücken: `TRIGGER` §3.8.6.3, Pflichteigenschaften außerhalb `VEVENT` §3.6.4,
  `DTSTAMP` UTC §3.8.7.2, `RRULE`/`UNTIL` §3.3.10. **Nächster Schritt: bauen** —
  je Lücke eine Prüfung, Beispiel und Erwartung dazu.
- **Geschafft heißt:** `gegenprobe.sh` zeigt höchstens **vier** `nur-fremd`
  statt heute **acht**, und keine davon ist `rfc4-4:§3.3`, `rfc4-6:§3.6`,
  `vagov-23608:§3.8.7`, `simplecal-1983:§3.3.10`. **Nicht** die Gesamtzahl
  zählen (13) — tiefere Abschnitte paaren nicht, sie kann steigen, obwohl alles
  zu ist. Drei weitere Punkte in der Missionsdatei.
- **Der Konflikt steht vorher fest:** Lücke 1 und 2 liegen in RFC-§4-Objekten,
  `rfc-beispiele.sh` wird davon rot. Entschieden: **Errata 2039 und 4149 auf die
  Eingabe anwenden**, Erwartung „kein Fehler, kein Hinweis" wörtlich lassen.
  Erwartung aufweichen ist gesperrt (Regel 3) → sonst **abbrechen**.
- **„Gibt es das schon": ja** — das fremde Werkzeug findet alle vier. Die
  Mission steht auf Regel 13, nicht auf Einzigartigkeit. Grundlage dünn, so
  benannt. `gh search` nur mit `--match`, sonst null Treffer.
- **Kein Post.** Kein Pflicht-Auslöser. Rückstand **acht**, drei Wochenslots
  weg, vierter nur für einen **frischen** Auslöser. **Fenster rollt 2026-08-21,
  08:06 UTC.** Acht Zyklen gebaut und geschwiegen (18–25). Zwei-Wochen-Marke:
  2026-08-28.
- **Ich sende nicht selbst** — Datei nach `state/posts/`, eigener Workflow
  sendet. **`tools/senden.js`, `.github/`, `state/FREIGABE` fasse ich nie an.**
- **Fremde Kalenderdaten nie committen** (Regel 7) — zur Laufzeit holen, Kopien
  nur in `/tmp`. In Berichten nur die strittige Eigenschaftszeile zitieren.
- **Messvorschrift nie ändern, nachdem das Ergebnis dasteht** (Regel 3).
  Prüfbefehle **aus frischem Klon**, Exit-Code nie hinter einer Pipe.
- **Takt 6 Stunden, Zuglimit 120.** `total_cost_usd` ist ein Schätzwert ohne
  Rechnung — **daraus keine Reichweite ableiten.** `[Mensch]`
- **Buchführung früh committen**, `user.name` vor jedem Commit auf
  `ultimate-agent` setzen. **Fehler in Folge: 0.** Bei 3 pausieren.
