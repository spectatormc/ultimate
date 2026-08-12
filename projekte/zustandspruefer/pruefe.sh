#!/bin/sh
# Zustandsprüfer — prüft den Zustand dieses Repos und meldet jede Prüfung einzeln.
#
# Mission: state/missionen/2026-08-11-zustandspruefer.md
# Ausgabe: genau fünf Zeilen, jede beginnt mit OK oder FEHLER.
# Exit:    0 wenn alle fünf OK sind, sonst 1.
#
# Aufruf:  bash projekte/zustandspruefer/pruefe.sh
#
# Keine Abhängigkeiten außer git, jq und POSIX-Shell.

set -u

# Immer vom Repo-Wurzelverzeichnis aus arbeiten, egal von wo aufgerufen wurde.
wurzel=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "FEHLER 1/5 heartbeat: kein Git-Repo — Prüfung nicht möglich"
    echo "FEHLER 2/5 mission: kein Git-Repo — Prüfung nicht möglich"
    echo "FEHLER 3/5 journal: kein Git-Repo — Prüfung nicht möglich"
    echo "FEHLER 4/5 schluesselmuster: kein Git-Repo — Prüfung nicht möglich"
    echo "FEHLER 5/5 arbeitsbaum: kein Git-Repo — Prüfung nicht möglich"
    exit 1
}
cd "$wurzel" || exit 1

fehler=0
melde() {
    # $1 = ok|fehler, $2 = Text
    if [ "$1" = ok ]; then
        echo "OK $2"
    else
        echo "FEHLER $2"
        fehler=1
    fi
}

# --- Prüfung 1: heartbeat.json existiert, ist gültiges JSON, hat ende_utc ----

hb=state/heartbeat.json
if [ ! -f "$hb" ]; then
    melde fehler "1/5 heartbeat: $hb fehlt"
elif ! command -v jq >/dev/null 2>&1; then
    melde fehler "1/5 heartbeat: jq nicht vorhanden — JSON nicht prüfbar"
elif ! jq -e . "$hb" >/dev/null 2>&1; then
    melde fehler "1/5 heartbeat: $hb ist kein gültiges JSON"
elif ! jq -e 'has("ende_utc")' "$hb" >/dev/null 2>&1; then
    melde fehler "1/5 heartbeat: $hb hat kein Feld ende_utc"
else
    melde ok "1/5 heartbeat: $hb gültig, ende_utc=$(jq -r '.ende_utc' "$hb")"
fi

# --- Prüfung 2: mission.md zeigt auf eine Datei, die existiert --------------

mi=state/mission.md
if [ ! -f "$mi" ]; then
    melde fehler "2/5 mission: $mi fehlt"
else
    # Erster Pfad in der Datei, der auf state/missionen/....md passt.
    ziel=$(grep -oE 'state/missionen/[^ `"'"'"']+\.md' "$mi" 2>/dev/null | head -n 1)
    if [ -z "$ziel" ]; then
        melde fehler "2/5 mission: $mi nennt keinen Pfad nach state/missionen/"
    elif [ ! -f "$ziel" ]; then
        melde fehler "2/5 mission: $mi zeigt auf $ziel — existiert nicht"
    else
        melde ok "2/5 mission: $mi zeigt auf $ziel"
    fi
fi

# --- Prüfung 3: mindestens ein Journaleintrag -------------------------------

anzahl_journal=0
if [ -d state/journal ]; then
    for f in state/journal/*.md; do
        [ -f "$f" ] || continue
        case $f in state/journal/README.md) continue ;; esac
        anzahl_journal=$((anzahl_journal + 1))
    done
fi
if [ "$anzahl_journal" -lt 1 ]; then
    melde fehler "3/5 journal: kein Eintrag in state/journal/"
else
    melde ok "3/5 journal: $anzahl_journal Eintrag/Einträge in state/journal/"
fi

# --- Prüfung 4: kein verfolgter Pfad trägt ein Schlüsselmuster --------------
#
# Die Muster werden zur Laufzeit zusammengesetzt, damit diese Datei die
# gesuchten Zeichenfolgen nicht selbst wörtlich enthält und sich deshalb
# nicht selbst meldet. Sie wird dadurch mitgeprüft statt ausgenommen.
#
# Zwei Arten von Muster:
#   Inhalt — Key-Präfixe, die in einer verfolgten Datei stehen könnten.
#   Pfad   — Dateien, die schon dem Namen nach nichts im Repo zu suchen haben.
#
# Ein Präfix allein ist keine Fundstelle. Bis 2026-08-12 wurde genau darauf
# gesucht, und damit meldete diese Prüfung jeden ehrlichen Bericht darüber,
# wonach sie sucht — drei Journaleinträge, deren Absatz „Sekretprüfung" das
# GitHub-Präfix nennt. Ein Werkzeug, das den Bericht über sich selbst als Leak
# meldet, belohnt Schweigen; die Begründung steht in
# wartung/2026-08-12-fehlalarm-pruefung-4.md.
#
# Gesucht wird deshalb Präfix *und* Schlüsselmaterial dahinter: Was ein echter
# Schlüssel immer trägt und eine Erwähnung nie. Die Schwellen liegen unter der
# kürzesten mir bekannten echten Länge — lieber ein Fehlalarm zu viel als ein
# Leak zu wenig. Die Muster stehen weiterhin zerteilt in der Quelle, damit diese
# Datei sich nicht selbst meldet.

m_inhalt_1="sk-""ant-[A-Za-z0-9_-]{12,}"        # Anthropic; echt deutlich länger
m_inhalt_2="ghp""_[A-Za-z0-9]{20,}"             # GitHub klassisch; echt 36
m_inhalt_3="github""_pat""_[A-Za-z0-9_]{20,}"   # GitHub fein granuliert
m_inhalt_4="-----""BEGIN[ A-Z]*PRIVATE KEY"     # PEM-Kopfzeile, nicht das Wort
m_pfad='(^|/)\.env($|\.)|\.pem$'

ausnahmen=projekte/zustandspruefer/ausnahmen.txt

ist_ausgenommen() {
    [ -f "$ausnahmen" ] || return 1
    while IFS= read -r zeile; do
        case $zeile in ''|'#'*) continue ;; esac
        [ "$zeile" = "$1" ] && return 0
    done < "$ausnahmen"
    return 1
}

anzahl_ausnahmen=0
if [ -f "$ausnahmen" ]; then
    while IFS= read -r zeile; do
        case $zeile in ''|'#'*) continue ;; esac
        anzahl_ausnahmen=$((anzahl_ausnahmen + 1))
    done < "$ausnahmen"
fi

# Verfolgte Pfade zeilenweise. Dateinamen mit Zeilenumbruch werden dadurch
# nicht korrekt behandelt — in diesem Repo gibt es keine, und -z mit
# read -d '' wäre eine Bash-Erweiterung.
treffer=""
anzahl_geprueft=0
for pfad in $(git ls-files); do
    anzahl_geprueft=$((anzahl_geprueft + 1))
    ist_ausgenommen "$pfad" && continue
    if printf '%s\n' "$pfad" | grep -qE "$m_pfad"; then
        treffer="$treffer $pfad"
        continue
    fi
    # Nur vorhandene, textartige Dateien nach Inhalt durchsuchen.
    [ -f "$pfad" ] || continue
    if grep -qIE -e "$m_inhalt_1" -e "$m_inhalt_2" -e "$m_inhalt_3" \
                 -e "$m_inhalt_4" -- "$pfad" 2>/dev/null; then
        treffer="$treffer $pfad"
    fi
done

if [ -n "$treffer" ]; then
    # Nur Pfade nennen, nie den gefundenen Inhalt — sonst leakt die Meldung,
    # was sie melden soll.
    melde fehler "4/5 schluesselmuster: Treffer in:$treffer"
else
    melde ok "4/5 schluesselmuster: kein Treffer in $anzahl_geprueft verfolgten Pfaden ($anzahl_ausnahmen dokumentierte Ausnahme(n), siehe $ausnahmen)"
fi

# --- Prüfung 5: Arbeitsbaum sauber ------------------------------------------

schmutz=$(git status --porcelain 2>/dev/null)
if [ -n "$schmutz" ]; then
    anzahl_schmutz=$(printf '%s\n' "$schmutz" | wc -l | tr -d ' ')
    melde fehler "5/5 arbeitsbaum: $anzahl_schmutz uncommittete Änderung(en)"
else
    melde ok "5/5 arbeitsbaum: sauber"
fi

exit "$fehler"
