#!/usr/bin/env node
// Sendet vorbereitete Beitraege nach Bluesky. Kein npm, keine Abhaengigkeiten —
// nur die HTTP-Schnittstelle des AT-Protokolls.
//
// Gelesen werden Dateien in state/posts/ mit `status: geplant`. Gesendet wird
// eine nach der anderen; nach jedem Senden wird der Status auf `gesendet`
// gesetzt und committet, bevor der naechste drankommt. Ein Absturz dazwischen
// kostet hoechstens einen Doppelpost-Verdacht, nie einen stillen Doppelpost:
// der Idempotenz-Schluessel steht im Eintrag und wird vor dem Senden gegen die
// eigene Zeitleiste geprueft.
//
// Was hier bewusst NICHT passiert:
// - Der Beitragstext wird nicht ausgegeben. Sonst haette ein Mensch ihn im Log
//   gelesen, und die Zusage "ohne menschliche Pruefung veroeffentlicht" waere
//   unwahr.
// - Der Wochendeckel wird hier gezaehlt, nicht vom Modell. Eine Grenze, die
//   sich der Zaehlende selbst setzt, ist ein Wunsch.
// - Die Kennzeichnung wird hier angehaengt, nicht vom Modell geschrieben.
//   Sie kann damit nicht vergessen werden.

const fs = require('fs');
const path = require('path');

const DIENST = 'https://bsky.social';
const POSTS = 'state/posts';
const GRENZE = 300;          // Graphemes je Beitrag, Vorgabe der Plattform
const WOCHE = 4;             // Regel 12. Nicht vom Agenten aenderbar.
const TAGE = 7;              // rollend

// Kennzeichnung an jedem Beitrag (Regel 5). Traegt zwei Dinge zugleich: den
// Hinweis auf automatisierte Erstellung und Versendung, und den auf KI-Text
// ohne Pruefung.
const FUSS = 'Automatisiert erstellt und versandt von einem Programm, das dieses Konto steuert. KI-Text, ungeprüft.';

const handle = process.env.KANAL_HANDLE;
const passwort = process.env.KANAL_PASSWORT;
const trocken = process.env.TROCKENLAUF === 'ja';

if (!handle) fehler('KANAL_HANDLE fehlt.');
if (!passwort && !trocken) fehler('KANAL_PASSWORT fehlt.');

function fehler(m) { console.error('FEHLER: ' + m); process.exit(1); }

// --- Graphemes zaehlen, nicht Bytes und nicht Codepoints --------------------
const segmenter = new Intl.Segmenter('de', { granularity: 'grapheme' });
const graphemes = (s) => [...segmenter.segment(s)].length;

// --- Front-Matter -----------------------------------------------------------
function lesen(datei) {
  const roh = fs.readFileSync(datei, 'utf8');
  const m = roh.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!m) return null;
  const kopf = {};
  for (const zeile of m[1].split('\n')) {
    const t = zeile.match(/^([a-z_]+):\s*(.*)$/);
    if (t) kopf[t[1]] = t[2].trim();
  }
  return { kopf, text: m[2].trim(), datei };
}

function schreiben(e, neu) {
  const kopf = Object.entries({ ...e.kopf, ...neu })
    .map(([k, v]) => `${k}: ${v}`).join('\n');
  fs.writeFileSync(e.datei, `---\n${kopf}\n---\n\n${e.text}\n`);
}

// --- Links als Facets: der sichtbare Anker ist kuerzer als das Ziel ----------
// Erkannt wird die Form [Anker](url). Bluesky zaehlt nur den Anker gegen die
// 300 Graphemes, das Ziel steht im Facet.
function facetten(text) {
  const enc = new TextEncoder();
  let aus = '';
  const facets = [];
  const re = /\[([^\]]+)\]\((https?:\/\/[^)\s]+)\)/g;
  let letzte = 0, m;
  while ((m = re.exec(text)) !== null) {
    aus += text.slice(letzte, m.index);
    const start = enc.encode(aus).length;
    aus += m[1];
    facets.push({
      index: { byteStart: start, byteEnd: enc.encode(aus).length },
      features: [{ $type: 'app.bsky.richtext.facet#link', uri: m[2] }],
    });
    letzte = m.index + m[0].length;
  }
  aus += text.slice(letzte);
  return { text: aus, facets };
}

async function ruf(pfad, koerper, jwt) {
  const r = await fetch(`${DIENST}/xrpc/${pfad}`, {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
      ...(jwt ? { authorization: `Bearer ${jwt}` } : {}),
    },
    body: JSON.stringify(koerper),
  });
  const j = await r.json().catch(() => ({}));
  if (!r.ok) throw new Error(`${pfad}: ${r.status} ${j.error || ''} ${j.message || ''}`);
  return j;
}

// --- Wochendeckel: gezaehlt an dem, was tatsaechlich gesendet wurde ----------
function gesendetInWoche() {
  const grenze = Date.now() - TAGE * 86400000;
  let n = 0;
  for (const f of fs.readdirSync(POSTS)) {
    if (!f.endsWith('.md')) continue;
    const e = lesen(path.join(POSTS, f));
    if (!e || e.kopf.status !== 'gesendet' || !e.kopf.gesendet_am) continue;
    if (Date.parse(e.kopf.gesendet_am) >= grenze) n++;
  }
  return n;
}

(async () => {
  if (!fs.existsSync(POSTS)) { console.log('Kein Verzeichnis ' + POSTS + '. Nichts zu tun.'); return; }

  const offen = fs.readdirSync(POSTS)
    .filter(f => f.endsWith('.md'))
    .map(f => lesen(path.join(POSTS, f)))
    .filter(e => e && e.kopf.status === 'geplant' && (e.kopf.plattform || 'bluesky') === 'bluesky')
    .sort((a, b) => a.datei.localeCompare(b.datei));

  if (!offen.length) { console.log('Keine Beitraege mit status: geplant.'); return; }

  let deckel = gesendetInWoche();
  console.log(`${offen.length} geplant, ${deckel} von ${WOCHE} in den letzten ${TAGE} Tagen gesendet.`);

  // Vorpruefung ohne Anmeldung: Laenge und Idempotenz-Schluessel.
  for (const e of offen) {
    const { text } = facetten(e.text);
    const voll = `${text}\n\n${FUSS}`;
    const n = graphemes(voll);
    console.log(`  ${path.basename(e.datei)}: ${n} Graphemes ${n > GRENZE ? '— ZU LANG' : 'ok'}, Schluessel ${e.kopf.idempotenz ? 'da' : 'FEHLT'}`);
    if (n > GRENZE) fehler(`${e.datei} ist ${n - GRENZE} Graphemes zu lang. Nicht gekuerzt — kuerzen ist Sache des Verfassers.`);
    if (!e.kopf.idempotenz) fehler(`${e.datei} hat keinen Idempotenz-Schluessel.`);
  }

  if (trocken) { console.log('Trockenlauf. Nichts gesendet.'); return; }

  const sitzung = await ruf('com.atproto.server.createSession', { identifier: handle, password: passwort });
  console.log(`Angemeldet als ${sitzung.handle}.`);

  // Was in den letzten 24 Stunden schon draussen ist — gegen Doppelposts nach
  // einem Absturz zwischen Senden und Notieren.
  const feed = await fetch(`https://public.api.bsky.app/xrpc/app.bsky.feed.getAuthorFeed?actor=${sitzung.did}&limit=30`)
    .then(r => r.json()).catch(() => ({ feed: [] }));
  const draussen = (feed.feed || []).map(x => (x.post?.record?.text || ''));

  for (const e of offen) {
    if (deckel >= WOCHE) {
      console.log(`Wochendeckel erreicht. ${path.basename(e.datei)} bleibt geplant.`);
      schreiben(e, { status: 'zurueckgestellt', zurueckgestellt_am: new Date().toISOString() });
      continue;
    }

    const { text, facets } = facetten(e.text);
    const voll = `${text}\n\n${FUSS}`;

    if (draussen.some(t => t.startsWith(text.slice(0, 60)))) {
      console.log(`${path.basename(e.datei)} steht bereits in der Zeitleiste. Nur nachtragen.`);
      schreiben(e, { status: 'gesendet', gesendet_am: new Date().toISOString(), hinweis: 'nachgetragen, war bereits gesendet' });
      deckel++;
      continue;
    }

    const rec = await ruf('com.atproto.repo.createRecord', {
      repo: sitzung.did,
      collection: 'app.bsky.feed.post',
      record: {
        $type: 'app.bsky.feed.post',
        text: voll,
        facets,
        langs: ['de'],
        createdAt: new Date().toISOString(),
      },
    }, sitzung.accessJwt);

    const id = rec.uri.split('/').pop();
    schreiben(e, {
      status: 'gesendet',
      gesendet_am: new Date().toISOString(),
      uri: rec.uri,
      url: `https://bsky.app/profile/${sitzung.handle}/post/${id}`,
    });
    deckel++;
    console.log(`Gesendet: ${path.basename(e.datei)} -> ${id}`);
  }
})().catch(e => fehler(e.message));
