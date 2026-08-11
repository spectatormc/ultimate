#!/bin/sh
# Leitet docs/status.json aus dem Repo ab.
#
# Wird vom Monitor-Workflow bei jedem Push auf main ausgefuehrt, nicht vom
# Agenten. Das ist Absicht: ein Monitor, dessen Zahlen vom Ueberwachten
# geliefert werden, ueberwacht nichts. Hier wird nur gezaehlt, was im Repo
# steht — keine Bewertung, keine Prognose.
#
# Abhaengigkeiten: git, jq, POSIX-Shell.

set -u

wurzel=$(git rev-parse --show-toplevel) || exit 1
cd "$wurzel" || exit 1

jetzt_s=$(date -u +%s)
jetzt=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# --- Takt aus dem Workflow lesen, statt ihn hier zu wiederholen -------------
# "17 */3 * * *" -> 3. Faellt das Muster weg, bleibt der Takt unbekannt.
takt=$(grep -oE 'cron: *"[0-9]+ \*/[0-9]+' .github/workflows/zyklus.yml 2>/dev/null \
        | grep -oE '\*/[0-9]+' | tr -d '*/' | head -n 1)
[ -n "${takt:-}" ] || takt=null

# --- Lebenszeichen ----------------------------------------------------------

hb=state/heartbeat.json
if [ -f "$hb" ] && jq -e . "$hb" >/dev/null 2>&1; then
    hb_ende=$(jq -r '.ende_utc // ""' "$hb")
    if [ -n "$hb_ende" ]; then
        hb_s=$(date -u -d "$hb_ende" +%s 2>/dev/null || echo 0)
        alter_min=$(( (jetzt_s - hb_s) / 60 ))
    else
        alter_min=-1
    fi
    lebenszeichen=$(jq --argjson alter "$alter_min" \
        '{lauf, ende_utc, ergebnis, lauf_url, alter_minuten: $alter}' "$hb")
else
    lebenszeichen='null'
    alter_min=-1
fi

# Zustand: ok bis zum doppelten Takt, dann spaet, ab dem vierfachen ueberfaellig.
if [ "$alter_min" -lt 0 ] || [ "$takt" = null ]; then
    zustand=unbekannt
elif [ "$alter_min" -le $(( takt * 60 * 2 )) ]; then
    zustand=ok
elif [ "$alter_min" -le $(( takt * 60 * 4 )) ]; then
    zustand=spaet
else
    zustand=ueberfaellig
fi

# --- Mission ----------------------------------------------------------------

mission_datei=$(grep -oE 'state/missionen/[^ `"]+\.md' state/mission.md 2>/dev/null | head -n 1)
if [ -n "${mission_datei:-}" ] && [ -f "$mission_datei" ]; then
    m_titel=$(grep -m1 '^# ' "$mission_datei" | sed 's/^# *//')
    m_frist=$(grep -m1 -A2 '^## Frist' "$mission_datei" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}[^ ]*' | head -n 1)
    if [ -n "${m_frist:-}" ]; then
        f_s=$(date -u -d "${m_frist} 23:59:59" +%s 2>/dev/null || echo 0)
        m_tage=$(( (f_s - jetzt_s) / 86400 ))
    else
        m_frist=""; m_tage=null
    fi
    # "(offen" im Abschlussblock heisst: laeuft noch.
    if sed -n '/^## Abschluss/,$p' "$mission_datei" | grep -q '(offen'; then
        m_status=laufend
    else
        m_status=abgeschlossen
    fi
    m_ziel=$(sed -n '/^## Was „geschafft" bedeutet/,/^## /p' "$mission_datei" \
             | sed '1d;$d' | sed '/^$/d' | head -n 20)
else
    mission_datei=""; m_titel=""; m_frist=""; m_tage=null
    m_status=keine; m_ziel=""
fi

# --- Zaehlungen -------------------------------------------------------------

zyklen=$(git log --author=ultimate-agent --format=%H -- state/journal 2>/dev/null | wc -l | tr -d ' ')
journaleintraege=$(ls state/journal/*.md 2>/dev/null | wc -l | tr -d ' ')
eingriffe=$(grep -cE '^[0-9]{4}-[0-9]{2}-[0-9]{2} —' state/eingriffe.md 2>/dev/null || echo 0)
commits_agent=$(git log --author=ultimate-agent --format=%H 2>/dev/null | wc -l | tr -d ' ')
commits_gesamt=$(git log --format=%H 2>/dev/null | wc -l | tr -d ' ')

kodex=$(grep -oE 'Version [0-9]+\.[0-9]+ — in Kraft' KODEX.md 2>/dev/null \
        | grep -oE '[0-9]+\.[0-9]+' | head -n 1)
[ -n "${kodex:-}" ] || kodex="unbekannt"

# --- Soll/Ist: der Zustandspruefer, sofern vorhanden -------------------------
# Das ist die einzige Stelle mit einer echten Messung statt einer Zaehlung.

pruefer=projekte/zustandspruefer/pruefe.sh
if [ -f "$pruefer" ]; then
    p_ausgabe=$(sh "$pruefer" 2>&1)
    p_code=$?
    pruefung=$(printf '%s\n' "$p_ausgabe" | jq -R . | jq -s \
        --argjson code "$p_code" '{zeilen: ., exit_code: $code}')
else
    pruefung=null
fi

# --- Offene Punkte ----------------------------------------------------------

offen=$(grep -E '^## ' state/offen.md 2>/dev/null \
        | sed 's/^## *//' \
        | jq -R '{titel: ., erledigt: (test("erledigt|~~"))}' | jq -s '.')
[ -n "${offen:-}" ] || offen='[]'

# --- Letzte Journaleintraege ------------------------------------------------

journal=$(ls -1 state/journal/*.md 2>/dev/null | sort -r | head -n 8 \
          | while IFS= read -r f; do
                titel=$(grep -m1 '^# ' "$f" | sed 's/^# *//')
                jq -n --arg d "$(basename "$f")" --arg t "$titel" '{datei:$d, titel:$t}'
            done | jq -s '.')
[ -n "${journal:-}" ] || journal='[]'

# --- Projekte ---------------------------------------------------------------

projekte=$(ls -1d projekte/*/ 2>/dev/null | sed 's|projekte/||; s|/$||' \
           | jq -R . | jq -s '.')
[ -n "${projekte:-}" ] || projekte='[]'

# --- Zusammensetzen ---------------------------------------------------------

mkdir -p docs
jq -n \
  --arg erzeugt "$jetzt" \
  --arg commit "$(git rev-parse --short HEAD)" \
  --arg zustand "$zustand" \
  --argjson takt "$takt" \
  --argjson lebenszeichen "$lebenszeichen" \
  --arg m_datei "$mission_datei" \
  --arg m_titel "$m_titel" \
  --arg m_frist "$m_frist" \
  --argjson m_tage "${m_tage:-null}" \
  --arg m_status "$m_status" \
  --arg m_ziel "$m_ziel" \
  --argjson zyklen "${zyklen:-0}" \
  --argjson journaleintraege "${journaleintraege:-0}" \
  --argjson eingriffe "${eingriffe:-0}" \
  --argjson commits_agent "${commits_agent:-0}" \
  --argjson commits_gesamt "${commits_gesamt:-0}" \
  --arg kodex "$kodex" \
  --argjson pruefung "$pruefung" \
  --argjson offen "$offen" \
  --argjson journal "$journal" \
  --argjson projekte "$projekte" \
  '{
     erzeugt_utc: $erzeugt,
     commit: $commit,
     takt_stunden: $takt,
     zustand: $zustand,
     lebenszeichen: $lebenszeichen,
     kodex_version: $kodex,
     mission: {
       datei: $m_datei, titel: $m_titel, frist: $m_frist,
       tage_bis_frist: $m_tage, status: $m_status, ziel: $m_ziel
     },
     zahlen: {
       zyklen: $zyklen, journaleintraege: $journaleintraege,
       eingriffe: $eingriffe, commits_agent: $commits_agent,
       commits_gesamt: $commits_gesamt
     },
     pruefung: $pruefung,
     offen: $offen,
     journal: $journal,
     projekte: $projekte
   }' > docs/status.json

echo "docs/status.json geschrieben — Zustand: $zustand, Zyklen: $zyklen"
