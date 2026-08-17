#!/bin/sh
# Pruefbefehl 2 der Mission ICS-Doktor — der eigentliche.
#
#   sh projekte/icsdoktor/rfc-beispiele.sh
#   echo "Exit-Code: $?"
#
# Laedt RFC 5545 vom RFC-Editor, schneidet aus Abschnitt 4 ("iCalendar Object
# Examples") die sechs vollstaendigen Kalenderobjekte heraus und laesst
# icsdoktor.py auf jedes einzeln los. Die Eingabe stammt also nicht aus meiner
# Hand, sondern aus dem Normtext: Ein Kalender aus dem RFC verstoesst nicht
# gegen den RFC. Meldet das Werkzeug hier einen FEHLER, hat das Werkzeug
# unrecht.
#
# Beim Herausschneiden passiert genau dreierlei:
#   - Seitenumbruecke weg: Vorschubzeichen, Kopf- und Fusszeilen, Leerzeilen.
#   - Die einheitliche Grundeinrueckung von sieben Leerzeichen weg.
#     Fortsetzungszeilen sind im RFC tiefer eingerueckt und behalten dadurch
#     ihr zusaetzliches Leerzeichen — sonst zerstoert das Entfernen der
#     Einrueckung die Faltung nach §3.1.
#   - Zeilenenden auf CRLF.
# Traegt eine Zeile im Block nicht die erwartete Einrueckung, bricht das Skript
# mit Exit-Code 2 ab, statt stillschweigend etwas anderes zu pruefen.
#
# ERRATA, seit 2026-08-17 — der wichtigste Absatz dieser Datei.
#
# Der Satz oben ("Ein Kalender aus dem RFC verstoesst nicht gegen den RFC") ist
# fuer zwei der sechs Objekte falsch, und zwar nicht nach meiner Auslegung,
# sondern nach verifizierten Errata des RFC-Editors. Objekt 4 traegt
# "TRIGGER:19980403T120000Z", wo der Standardwerttyp eine DURATION verlangt
# (§3.8.6.3); Errata-ID 2039, Status Verified, korrigiert genau diese Zeile.
#
# Entschieden wurde das nicht hier und nicht jetzt, sondern vorher, in
# state/missionen/2026-08-16-die-vier-luecken.md unter "Der Konflikt, der schon
# feststeht": Dieses Skript wendet die verifizierten Errata auf die Eingabe an,
# woertlich und mit der Errata-ID daneben, bevor es prueft. Die Erwartung "kein
# Fehler und kein Hinweis" bleibt damit Wort fuer Wort dieselbe und behaelt ihre
# Bedeutung. Verworfen wurde die naheliegende Alternative, auf Objekt 4 und 6
# Befunde zu erlauben — das waere eine Abschwaechung der Messvorschrift,
# nachdem das Ergebnis dasteht.
#
# Damit der Errata-Patch kein Versteck wird, verlangt dasselbe Skript zweierlei:
#   - Die Originalzeile muss im Ausschnitt genau einmal vorkommen. Findet der
#     Patch sie nicht, endet das Skript mit 2 statt stillschweigend nichts zu
#     tun.
#   - Auf dem UNKORRIGIERTEN Objekt muss der ICS-Doktor melden. Ein Werkzeug,
#     das nach dem Patch schweigt, weil es ueberhaupt schweigt, faellt damit
#     auf. Auch das steht so in der Missionsdatei.
#
# Angewandt wird bisher nur Erratum 2039 auf Objekt 4. Erratum 4149 ergaenzt in
# Objekt 6 das fehlende UID und DTSTAMP des VFREEBUSY (§3.6.4) und gehoert zu
# Luecke 2 derselben Mission; solange der ICS-Doktor Pflichteigenschaften nur in
# VEVENT prueft, wuerde die Verschaerfung oben fuer Objekt 6 fehlschlagen — zu
# Recht, denn er schweigt dort. Es fehlt hier also nicht aus Versehen, sondern
# weil die Pruefung dahinter noch nicht gebaut ist.
#
# Exit-Code: 0 kein Fehler und kein Hinweis in den sechs Objekten, 1 mindestens
#            eines von beidem oder ein stummer ICS-Doktor auf einem
#            unkorrigierten Objekt, 2 RFC nicht erreichbar, Ausschnitt oder
#            Errata-Fundstelle unerwartet, Umgebungsfehler.
#
# Dass auch ein Hinweis rot macht, ist die Verschaerfung aus der Mission Die
# Faltnaht: Die neuen Pruefungen P09 und P10 melden Hinweise, und ein Hinweis
# auf einem Kalender aus dem Normtext ist ein Fehlalarm.
#
# Das Netz braucht dieser Pruefbefehl, das Werkzeug selbst nicht.

set -u

verzeichnis=$(dirname "$0")
werkzeug="$verzeichnis/icsdoktor.py"
quelle="https://www.rfc-editor.org/rfc/rfc5545.txt"

if ! command -v python3 >/dev/null 2>&1; then
    echo "ABBRUCH: python3 ist nicht im PATH" >&2
    exit 2
fi
if [ ! -f "$werkzeug" ]; then
    echo "ABBRUCH: $werkzeug fehlt" >&2
    exit 2
fi

arbeit=$(mktemp -d) || exit 2
trap 'rm -rf "$arbeit"' EXIT INT TERM

if command -v curl >/dev/null 2>&1; then
    curl -sSf --max-time 60 "$quelle" > "$arbeit/rfc.txt" 2> "$arbeit/lade"
    geladen=$?
elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$arbeit/rfc.txt" "$quelle" 2> "$arbeit/lade"
    geladen=$?
else
    echo "ABBRUCH: weder curl noch wget im PATH" >&2
    exit 2
fi
if [ "$geladen" -ne 0 ] || [ ! -s "$arbeit/rfc.txt" ]; then
    echo "ABBRUCH: $quelle ist nicht erreichbar." >&2
    [ -s "$arbeit/lade" ] && sed 's/^/  /' "$arbeit/lade" >&2
    echo "Dieser Pruefbefehl braucht Netz. Kein Ergebnis ist kein gruenes" >&2
    echo "Ergebnis." >&2
    exit 2
fi

if ! grep -q '^4\.  iCalendar Object Examples' "$arbeit/rfc.txt"; then
    echo "ABBRUCH: Abschnitt 4 im geladenen Text nicht gefunden." >&2
    echo "Geladen wurden $(wc -c < "$arbeit/rfc.txt") Oktette." >&2
    exit 2
fi

tr -d '\014' < "$arbeit/rfc.txt" > "$arbeit/ohne-vorschub.txt"
awk '/^4\.  iCalendar Object Examples/,/^5\.  Recommended Practices/' \
    "$arbeit/ohne-vorschub.txt" > "$arbeit/abschnitt4.txt"

awk -v ziel="$arbeit" '
    /^ +BEGIN:VCALENDAR[[:space:]]*$/ { n++; drin = 1 }
    drin {
        if ($0 ~ /^[[:space:]]*$/) next
        if ($0 ~ /^Desruisseaux/) next
        if ($0 ~ /^RFC 5545/) next
        if (substr($0, 1, 7) != "       ") { schlecht++; next }
        printf "%s\r\n", substr($0, 8) > (ziel "/objekt-" n ".ics")
    }
    /^ +END:VCALENDAR[[:space:]]*$/ { drin = 0 }
    END {
        print n + 0 > (ziel "/anzahl")
        print schlecht + 0 > (ziel "/schlecht")
    }
' "$arbeit/abschnitt4.txt"

anzahl=$(cat "$arbeit/anzahl")
schlecht=$(cat "$arbeit/schlecht")

if [ "$schlecht" != "0" ]; then
    echo "ABBRUCH: $schlecht Zeilen im Ausschnitt tragen nicht die erwartete" >&2
    echo "Grundeinrueckung von sieben Leerzeichen. Das Herausschneiden passt" >&2
    echo "nicht zum Text, und geprueft wuerde etwas anderes als gemeint." >&2
    exit 2
fi
if [ "$anzahl" != "6" ]; then
    echo "ABBRUCH: $anzahl vollstaendige Kalenderobjekte gefunden, erwartet 6." >&2
    echo "RFC 5545 ist unveraenderlich; diese Zahl kann sich nicht aendern." >&2
    exit 2
fi

# --- Errata anwenden, mit Verschaerfung davor -------------------------------
#
# Eine Zeile je Erratum, tabulatorgetrennt:
#   Objektnummer <TAB> Errata-ID <TAB> Originalzeile <TAB> korrigierte Zeile
#
# Original- und Ersatztext sind woertlich die des RFC-Editors, nachzulesen
# unter https://www.rfc-editor.org/errata_search.php?rfc=5545.

errata_stumm=0
while IFS='	' read -r e_nr e_id e_alt e_neu; do
    case "$e_nr" in ''|'#'*) continue ;; esac
    objekt="$arbeit/objekt-$e_nr.ics"

    # Verschaerfung: Auf dem unkorrigierten Objekt muss etwas gemeldet werden.
    python3 "$werkzeug" "$objekt" > "$arbeit/vorher" 2>&1
    vorher=$(grep -c '^FEHLER \|^HINWEIS ' "$arbeit/vorher" || true)
    if [ "$vorher" -eq 0 ]; then
        printf 'STUMM: Objekt %s ist nach Erratum %s fehlerhaft, der ' \
            "$e_nr" "$e_id"
        printf 'ICS-Doktor meldet dort aber nichts.\n'
        errata_stumm=$((errata_stumm + 1))
    else
        printf 'Erratum %s, Objekt %s: unkorrigiert %d Befund(e) — ' \
            "$e_id" "$e_nr" "$vorher"
        printf 'die Verschaerfung greift\n'
    fi

    # Patchen. Die Originalzeile muss genau einmal vorkommen.
    python3 - "$objekt" "$e_id" "$e_alt" "$e_neu" <<'PY' || exit 2
import sys
pfad, e_id, alt, neu = sys.argv[1:5]
with open(pfad, "rb") as f:
    daten = f.read()
alt_z = (alt + "\r\n").encode("utf-8")
neu_z = (neu + "\r\n").encode("utf-8")
anzahl = daten.count(alt_z)
if anzahl != 1:
    sys.stderr.write(
        "ABBRUCH: Erratum %s findet seine Originalzeile %dmal in %s, "
        "erwartet genau einmal.\n" % (e_id, anzahl, pfad))
    sys.stderr.write("  gesucht: %s\n" % alt)
    sys.stderr.write(
        "Ein Patch, der nichts trifft, prueft stillschweigend den "
        "unkorrigierten Text.\n")
    sys.exit(2)
with open(pfad, "wb") as f:
    f.write(daten.replace(alt_z, neu_z))
PY
    printf 'Erratum %s auf Objekt %s angewandt: %s\n' "$e_id" "$e_nr" "$e_neu"
done <<'ERRATA'
4	2039	TRIGGER:19980403T120000Z	TRIGGER;VALUE=DATE-TIME:19980403T120000Z
ERRATA

fehler_gesamt=0
hinweise_gesamt=0
nr=1
while [ "$nr" -le "$anzahl" ]; do
    objekt="$arbeit/objekt-$nr.ics"
    zeilen=$(python3 -c 'import sys;print(open(sys.argv[1],"rb").read().count(b"\r\n"))' "$objekt")
    python3 "$werkzeug" "$objekt" > "$arbeit/ausgabe" 2>&1
    code=$?
    fehler=$(grep -c '^FEHLER ' "$arbeit/ausgabe" || true)
    hinweise=$(grep -c '^HINWEIS ' "$arbeit/ausgabe" || true)
    printf 'Objekt %d: %2d Zeilen, %d Fehler, %d Hinweise, Exit %d\n' \
        "$nr" "$zeilen" "$fehler" "$hinweise" "$code"
    [ -s "$arbeit/ausgabe" ] && sed 's/^/  /' "$arbeit/ausgabe"
    fehler_gesamt=$((fehler_gesamt + fehler))
    hinweise_gesamt=$((hinweise_gesamt + hinweise))
    nr=$((nr + 1))
done

printf '%d Beispiele aus RFC 5545 §4 geprüft, %d Fehler, %d Hinweise\n' \
    "$anzahl" "$fehler_gesamt" "$hinweise_gesamt"

# Verschaerfung der Mission Die Faltnaht (2026-08-12): Ein Hinweis auf einem
# Kalender aus dem Normtext ist ein Fehlalarm und darf nicht gruen sein. Die
# Vormission verlangte hier nur 0 Fehler.
[ "$fehler_gesamt" -eq 0 ] || exit 1
[ "$hinweise_gesamt" -eq 0 ] || exit 1
# Verschaerfung der Mission Die vier Luecken (2026-08-17): Ein Objekt, das nach
# einem verifizierten Erratum fehlerhaft ist, muss vor dem Patch einen Befund
# ausloesen. Sonst ist die 0 oben nur die Stille des Werkzeugs.
[ "$errata_stumm" -eq 0 ] || exit 1
exit 0
