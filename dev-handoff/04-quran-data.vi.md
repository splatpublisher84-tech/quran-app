# Dữ liệu Quran

Created: 2026-11-06 · Last modified: 2026-11-06

> **Cần Hiếu duyệt scope trước khi bắt đầu.**
>
> Sinh tự động từ `prototype/public/data/quran/`, `src/domain/quran.ts`, `scripts/fetch-quran.mjs` bằng `npm run export:handoff` trong `prototype/`. Không sửa tay: sửa file nguồn rồi chạy lại.

## Nguồn

QuranEnc API. Prototype gọi `GET https://quranenc.com/api/v1/translation/sura/{translation_key}/{sura}` cho từng surah và từng bản dịch. Mỗi ayah trả về `sura`, `aya`, `arabic_text`, `translation`, `footnotes`. Trường `arabic_text` có trong kết quả nhưng không có trong tài liệu chính thức, cần xác nhận với QuranEnc.

Bản dịch prototype đang dùng:

| Ngôn ngữ | Key | Tên | Version |
|---|---|---|---|
| en | `english_saheeh` | English Translation - Noor International Center | 1.1.2 |
| vi | `vietnamese_rwwad` | Vietnamese Translation - Rowwad Translation Center | 1.0.9 |
| id | `indonesian_affairs` | Indonesian Translation - Ministry of Religious Affairs | 1.0.1 |

Điều khoản QuranEnc ảnh hưởng tới app: không sửa, thêm, bớt nội dung (footnote phải có, được thu gọn); ghi nguồn QuranEnc.com và số phiên bản; cập nhật khi có bản mới; không đặt quảng cáo không phù hợp cạnh bản dịch. Chi tiết: `05-research/content-sources.vi.md`.

Mốc Juz và tên surah lấy từ `https://api.alquran.cloud/v1/meta`, đóng gói tĩnh.

## Định dạng file

`meta.json`: 114 surah, 30 mốc Juz. Mẫu:

```json
{
  "translations": {
    "en": {
      "key": "english_saheeh",
      "title": "English Translation - Noor International Center",
      "version": "1.1.2"
    }
  },
  "surahs": [
    {
      "n": 1,
      "name": "Al-Faatiha",
      "meaning": "The Opening",
      "ar": "سُورَةُ ٱلْفَاتِحَةِ",
      "ayahs": 7,
      "place": "Meccan"
    },
    {
      "n": 2,
      "name": "Al-Baqara",
      "meaning": "The Cow",
      "ar": "سُورَةُ البَقَرَةِ",
      "ayahs": 286,
      "place": "Medinan"
    }
  ],
  "juzs": [
    {
      "surah": 1,
      "ayah": 1
    },
    {
      "surah": 2,
      "ayah": 142
    },
    {
      "surah": 2,
      "ayah": 253
    }
  ]
}
```

`NNN.json` (một file mỗi surah). `t` là bản dịch, `f` là footnote. Marker `[2011]` trong `t` trỏ tới footnote cùng số trong `f`. Mẫu surah 112, 2 ayah đầu:

```json
{
  "surah": 112,
  "arabic": [
    "قُلۡ هُوَ ٱللَّهُ أَحَدٌ",
    "ٱللَّهُ ٱلصَّمَدُ"
  ],
  "translations": {
    "en": [
      {
        "t": "Say, \"He is Allāh, [who is] One,[2011]",
        "f": "[2011] Alone, without another, indivisible with absolute and permanent unity and distinct from all else. The one and only true deity, unique in His essence, attributes and deeds."
      },
      {
        "t": "Allāh, the Eternal Refuge.[2012]",
        "f": "[2012] He who is absolute, perfect, complete, essential, self-sufficient and sufficient to meet the needs of all creation; the one eternally and constantly required and sought, depended upon by all existence and to whom all matters will ultimately return."
      }
    ],
    "vi": [
      {
        "t": "Ngươi (Thiên Sứ Muhammad) hãy nói: “Ngài là Allah, Đấng Duy Nhất.”"
      },
      {
        "t": "“Allah là Đấng Tự Hữu (Ngài không cần ai nhưng tất cả đều cần Ngài).”"
      }
    ],
    "id": [
      {
        "t": "Katakanlah (Muhammad), \"Dialah Allah, Yang Maha Esa."
      },
      {
        "t": "Allah tempat meminta segala sesuatu."
      }
    ]
  }
}
```

## Quy tắc hiển thị

- Basmala đứng đầu mọi surah trừ surah 9. Ở surah 1, basmala là ayah 1 nên không lặp lại.
- Số ayah dùng chữ số Ả Rập trong ﴿ ﴾.
- Tên Arabic từ API có chữ "سُورَةُ" ở đầu, bỏ đi khi hiển thị.
- Chỉ coi `[số]` là marker footnote; `[who is]` là chữ của bản dịch, giữ nguyên.

## quran.ts

```ts
export type Lang = "en" | "vi" | "id";
export type AyahRef = { surah: number; ayah: number };

export type SurahMeta = { n: number; name: string; meaning: string; ar: string; ayahs: number; place: string };
export type QuranMeta = {
  translations: Record<Lang, { key: string; title: string; version: string }>;
  surahs: SurahMeta[];
  juzs: AyahRef[];
};
export type SurahData = {
  surah: number;
  arabic: string[];
  translations: Record<Lang, { t: string; f?: string }[]>;
};

export const refKey = (r: AyahRef) => `${r.surah}:${r.ayah}`;
export const parseRef = (key: string): AyahRef => {
  const [surah, ayah] = key.split(":").map(Number);
  return { surah, ayah };
};

const cache = new Map<string, Promise<unknown>>();
function load<T>(path: string): Promise<T> {
  if (!cache.has(path)) cache.set(path, fetch(`/data/quran/${path}`).then((r) => r.json()));
  return cache.get(path) as Promise<T>;
}
export const loadMeta = () => load<QuranMeta>("meta.json");
export const loadSurah = (n: number) => load<SurahData>(`${String(n).padStart(3, "0")}.json`);

/** Latin name without the "surah" word in Arabic; API names start with سُورَةُ. */
export const shortArabicName = (ar: string) => ar.replace(/^سُورَةُ\s*/, "");

const AR_DIGITS = "٠١٢٣٤٥٦٧٨٩";
export const arabicNumber = (n: number) => String(n).replace(/\d/g, (d) => AR_DIGITS[+d]);

/** Ayah ranges of a Juz, grouped by surah. */
export function juzRange(meta: QuranMeta, juz: number): { surah: number; from: number; to: number }[] {
  const start = meta.juzs[juz - 1];
  const next = meta.juzs[juz];
  const out = [];
  const lastSurah = next ? (next.ayah === 1 ? next.surah - 1 : next.surah) : 114;
  for (let s = start.surah; s <= lastSurah; s++) {
    const from = s === start.surah ? start.ayah : 1;
    const to = next && s === next.surah ? next.ayah - 1 : meta.surahs[s - 1].ayahs;
    out.push({ surah: s, from, to });
  }
  return out;
}

export function juzOf(meta: QuranMeta, ref: AyahRef): number {
  let juz = 1;
  meta.juzs.forEach((j, i) => {
    if (ref.surah > j.surah || (ref.surah === j.surah && ref.ayah >= j.ayah)) juz = i + 1;
  });
  return juz;
}

/** Splits "text[12] more" into text and footnote markers, keeping "[who is]" as text. */
export function splitFootnotes(text: string): (string | { marker: string })[] {
  return text.split(/(\[\d+\])/).filter(Boolean).map((p) => (/^\[\d+\]$/.test(p) ? { marker: p.slice(1, -1) } : p));
}

/** Footnote text for one marker from the raw footnotes field. */
export function footnoteText(raw: string | undefined, marker: string): string {
  if (!raw) return "";
  const parts = raw.split(/(?=\[\d+\])/);
  const hit = parts.find((p) => p.startsWith(`[${marker}]`));
  return (hit ?? "").replace(/^\[\d+\]\s*/, "").trim();
}

/** Parses "2:255" search input. */
export function parseGoTo(q: string, meta: QuranMeta): AyahRef | null {
  const m = q.trim().match(/^(\d{1,3})\s*[:.]\s*(\d{1,3})$/);
  if (!m) return null;
  const surah = +m[1];
  const ayah = +m[2];
  const s = meta.surahs[surah - 1];
  return s && ayah >= 1 && ayah <= s.ayahs ? { surah, ayah } : null;
}
```

## Script tải dữ liệu

```js
// Tải văn bản Arabic + bản dịch từ QuranEnc về public/data/quran/. Chỉ cần chạy lại khi đổi bộ bản dịch.
import { mkdir, writeFile } from "node:fs/promises";

const OUT = new URL("../public/data/quran/", import.meta.url);
const TRANSLATIONS = { en: "english_saheeh", vi: "vietnamese_rwwad", id: "indonesian_affairs" };

async function getJson(url, tries = 4) {
  for (let i = 0; ; i++) {
    try {
      const res = await fetch(url);
      if (!res.ok) throw new Error(`${res.status} ${url}`);
      return await res.json();
    } catch (err) {
      if (i >= tries) throw err;
      await new Promise((r) => setTimeout(r, 800 * (i + 1)));
    }
  }
}

async function fetchSurah(n) {
  const langs = {};
  let arabic = [];
  for (const [lang, key] of Object.entries(TRANSLATIONS)) {
    const { result } = await getJson(`https://quranenc.com/api/v1/translation/sura/${key}/${n}`);
    langs[lang] = result.map((a) => ({ t: a.translation, f: a.footnotes || undefined }));
    arabic = result.map((a) => a.arabic_text);
  }
  await writeFile(new URL(`${String(n).padStart(3, "0")}.json`, OUT), JSON.stringify({ surah: n, arabic, translations: langs }));
  console.log("surah", n, arabic.length);
}

await mkdir(OUT, { recursive: true });

const meta = (await getJson("https://api.alquran.cloud/v1/meta")).data;
const translations = {};
for (const [lang, key] of Object.entries(TRANSLATIONS)) {
  const { translations: list } = await getJson(`https://quranenc.com/api/v1/translations/list/${lang}`);
  const hit = list.find((t) => t.key === key);
  translations[lang] = { key, title: hit.title, version: hit.version };
}
await writeFile(new URL("meta.json", OUT), JSON.stringify({
  translations,
  surahs: meta.surahs.references.map((s) => ({ n: s.number, name: s.englishName, meaning: s.englishNameTranslation, ar: s.name, ayahs: s.numberOfAyahs, place: s.revelationType })),
  juzs: meta.juzs.references.map((j) => ({ surah: j.surah, ayah: j.ayah })),
}));

const queue = Array.from({ length: 114 }, (_, i) => i + 1);
await Promise.all(Array.from({ length: 4 }, async () => {
  while (queue.length) await fetchSurah(queue.shift());
}));
```
