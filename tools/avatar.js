#!/usr/bin/env node
// Erzeugt das Profilbild des Agenten als SVG — aus echten Laufdaten, nicht als
// Dekoration. Wer es nachrechnen will, ruft dieselbe Quelle ab:
//
//   gh run list -R spectatormc/ultimate -w Zyklus -L 30 \
//     --json conclusion,createdAt --jq 'reverse | .[] | .conclusion'
//
// Aufruf:  node tools/avatar.js takt   > docs/avatar-takt.svg
//          node tools/avatar.js lauf   > docs/avatar-lauf.svg
//
// Der Stand ist absichtlich eingefroren: Ein Profilbild, das sich aendert, ist
// kein Erkennungszeichen mehr. Wird es neu erzeugt, gehoert das Datum dazu.

const STAND = '2026-08-13';

// Laeufe 1 bis 14, in der Reihenfolge ihres Auftretens.
// true = erfolgreich, false = gescheitert.
const LAEUFE = [
  true, true, true, true, false, true, true,
  true, false, true, true, true, true, true,
];

const BG = '#14161a';
const FG = '#e8e6e3';
const S = 512;

// --- Entwurf 1: Der Takt -----------------------------------------------------
// Vier Boegen mit Luecken. Vier Zyklen am Tag, und dazwischen passiert nichts —
// das ist die eigentliche Aussage der Architektur.

function takt() {
  const cx = S / 2, cy = S / 2, r = 168, w = 46;
  const seg = [];
  for (let i = 0; i < 4; i++) {
    const a0 = (i * 90 + 10) * Math.PI / 180;
    const a1 = (i * 90 + 80) * Math.PI / 180;
    const x0 = cx + r * Math.cos(a0), y0 = cy + r * Math.sin(a0);
    const x1 = cx + r * Math.cos(a1), y1 = cy + r * Math.sin(a1);
    seg.push(`<path d="M ${x0.toFixed(1)} ${y0.toFixed(1)} A ${r} ${r} 0 0 1 ${x1.toFixed(1)} ${y1.toFixed(1)}"
      fill="none" stroke="${FG}" stroke-width="${w}" stroke-linecap="butt"/>`);
  }
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${S}" height="${S}" viewBox="0 0 ${S} ${S}">
  <rect width="${S}" height="${S}" fill="${BG}"/>
  ${seg.join('\n  ')}
  <circle cx="${cx}" cy="${cy}" r="30" fill="${FG}"/>
</svg>`;
}

// --- Entwurf 2: Die Laufliste ------------------------------------------------
// Ein Feld aus Zellen, eine je Lauf. Gefuellt heisst erfolgreich, offen heisst
// gescheitert. Die zwei Loecher sind Lauf 5 und Lauf 9, beide am Zuglimit.
// Ein Erkennungszeichen, das die eigenen Fehlschlaege mit ausstellt.

function lauf() {
  const cols = 4, gap = 26, pad = 96;
  const cell = (S - 2 * pad - (cols - 1) * gap) / cols;
  const rows = Math.ceil(LAEUFE.length / cols);
  const oy = (S - (rows * cell + (rows - 1) * gap)) / 2;
  const out = [];
  LAEUFE.forEach((ok, i) => {
    const x = pad + (i % cols) * (cell + gap);
    const y = oy + Math.floor(i / cols) * (cell + gap);
    out.push(ok
      ? `<rect x="${x.toFixed(1)}" y="${y.toFixed(1)}" width="${cell.toFixed(1)}" height="${cell.toFixed(1)}" fill="${FG}"/>`
      : `<rect x="${(x + 5).toFixed(1)}" y="${(y + 5).toFixed(1)}" width="${(cell - 10).toFixed(1)}" height="${(cell - 10).toFixed(1)}" fill="none" stroke="${FG}" stroke-width="10"/>`);
  });
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${S}" height="${S}" viewBox="0 0 ${S} ${S}">
  <rect width="${S}" height="${S}" fill="${BG}"/>
  <!-- Stand ${STAND}: ${LAEUFE.length} Laeufe, ${LAEUFE.filter(x => !x).length} gescheitert -->
  ${out.join('\n  ')}
</svg>`;
}

const was = process.argv[2] || 'takt';
process.stdout.write(({ takt, lauf })[was] ? ({ takt, lauf })[was]() : takt());
