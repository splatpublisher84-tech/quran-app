# UI spec: component và màn

Created: 2026-11-06 · Last modified: 2026-11-06

> Sinh tự động từ CSS module của prototype bằng `npm run export:handoff` trong `prototype/`. Không sửa tay: sửa file nguồn rồi chạy lại.

Số đo tính bằng pt trên màn 393×852. `var(--space-400)` là token spacing 16, `var(--radius-m)` là radius 12 (bảng ở `01-design-tokens.vi.md`). Tên class là tên phần tử trong component cùng folder (`.tsx`).

## Component dùng chung

Nguồn: `prototype/src/ui/ui.module.css`

```css
.icon { display: inline-block; flex: none; background: currentColor; -webkit-mask: center / contain no-repeat; mask: center / contain no-repeat; }
.full { width: 100%; }

/* Button: Bible BbButton, radius-m, 52 high */
.btn { display: inline-flex; align-items: center; justify-content: center; gap: var(--space-200); border: 0; border-radius: var(--radius-m); cursor: pointer; transition: background .15s, opacity .15s, transform .1s; }
.btn:active { transform: scale(.985); }
.btn:disabled { cursor: default; }
.btn-large { height: 52px; padding-inline: var(--space-400); }
.btn-small { height: 44px; padding-inline: var(--space-400); }
.btn-primary { background: var(--button-primary); color: var(--text-inverse); }
.btn-primary:active { background: var(--button-primary-pressed); }
.btn-primary:disabled { background: var(--button-primary-disabled); }
.btn-secondary { background: var(--group-bg); color: var(--text-primary); }
.btn-tertiary { background: transparent; color: var(--text-primary); border: 1px solid var(--border-default); }
.btn-inverse { background: #fff; color: #1f5e4e; }
.btn-glass { background: rgba(255,255,255,.16); color: #fff; border: 1px solid rgba(255,255,255,.28); }
.btn-outline { background: transparent; color: inherit; border: 1px solid color-mix(in srgb, currentColor 40%, transparent); }
.btn-text { background: none; color: var(--text-secondary); }

/* Icon button: Bible BbIconButton */
.iconBtn { display: inline-grid; place-items: center; flex: none; border-radius: 50%; border: 0; background: none; color: var(--text-primary); cursor: pointer; padding: 0; }
.iconBtn-filled { background: var(--group-bg); }
.iconBtn-outline { background: none; border: 1px solid var(--border-default); }
.iconBtn-glass { background: rgba(255,255,255,.14); color: #fff; }
.iconActive { color: var(--accent-default); }

/* Headers */
.largeHeader { display: grid; gap: var(--space-100); padding: var(--space-100) var(--space-400) var(--space-300); }
.largeTitleRow { display: flex; align-items: center; justify-content: space-between; gap: var(--space-200); min-height: 48px; }
.largeTitleRow h1 { margin: 0; }
.trailing { display: flex; gap: var(--space-200); }
.navBar { display: grid; grid-template-columns: 44px minmax(0, 1fr) minmax(44px, auto); align-items: center; gap: var(--space-100); padding: 0 var(--space-200); min-height: 48px; flex: none; }
.navTitle { text-align: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.navTrailing { display: flex; justify-content: flex-end; gap: var(--space-100); }

/* Grouped rows: Bible Settings */
.groupWrap { display: grid; gap: var(--space-200); }
.groupTitle { margin: 0; padding-inline: var(--space-100); color: var(--text-secondary); }
.group { background: var(--group-bg); border-radius: var(--radius-l); overflow: hidden; }
.row { display: flex; align-items: center; gap: var(--space-300); width: 100%; min-height: 56px; padding: var(--space-200) var(--space-400); border: 0; background: none; color: var(--text-primary); text-align: start; position: relative; }
.row + .row::before { content: ""; position: absolute; top: 0; inset-inline: var(--space-400) 0; height: 1px; background: var(--border-subtle); opacity: .7; }
.rowBtn { cursor: pointer; }
.rowBtn:active { background: var(--brand-soft); }
.rowIcon { color: var(--text-secondary); }
.rowText { flex: 1; min-width: 0; display: grid; gap: 2px; }
.rowSub, .rowValue, .rowChevron { color: var(--text-secondary); }
.rowValue { text-align: end; }
.rowCheck { color: var(--button-primary); }

.switch { width: 50px; height: 30px; border-radius: 15px; border: 0; background: var(--button-primary-disabled); position: relative; cursor: pointer; flex: none; padding: 0; transition: background .18s; }
.switch span { position: absolute; top: 2px; left: 2px; width: 26px; height: 26px; border-radius: 50%; background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,.25); transition: left .18s; }
.switchOn { background: var(--button-primary); }
.switchOn span { left: 22px; }

.segmented { display: flex; gap: 2px; padding: 2px; border-radius: var(--radius-m); background: var(--group-bg); }
.segment { flex: 1; height: 36px; border: 0; border-radius: 10px; background: none; color: var(--text-secondary); cursor: pointer; }
.segmentOn { background: var(--segment-on); color: var(--text-primary); font-weight: 600; box-shadow: 0 1px 2px rgba(0,0,0,.08); }

/* Sheet */
.sheetRoot { position: absolute; inset: 0; z-index: 40; display: flex; flex-direction: column; justify-content: flex-end; }
.backdrop { position: absolute; inset: 0; background: rgba(21,18,13,.5); opacity: 0; transition: opacity .22s; }
.sheet { position: relative; max-height: 88%; display: flex; flex-direction: column; background: var(--background-surface); color: var(--text-primary); border-radius: var(--radius-xxl) var(--radius-xxl) 0 0; transform: translateY(100%); transition: transform .24s cubic-bezier(.2,.8,.2,1); }
.sheetTall { height: 88%; }
.sheetShown .backdrop { opacity: 1; }
.sheetShown .sheet { transform: none; }
.sheetHead { display: flex; align-items: center; justify-content: space-between; gap: var(--space-200); padding: var(--space-400) var(--space-400) var(--space-200); }
.sheetHead h2 { margin: 0; }
.sheetBody { padding: var(--space-100) var(--space-400) calc(var(--space-800) + 8px); overflow-y: auto; display: grid; gap: var(--space-400); }

/* System permission dialog mock */
.dialogRoot { position: absolute; inset: 0; z-index: 60; display: grid; place-items: center; background: rgba(0,0,0,.32); padding: var(--space-800); }
.dialog { width: 100%; max-width: 270px; background: var(--dialog-bg); color: var(--text-primary); border-radius: 16px; overflow: hidden; backdrop-filter: blur(24px); }
.dialogText { display: grid; gap: var(--space-100); padding: var(--space-400); text-align: center; }
.dialogText h2, .dialogText p { margin: 0; }
.dialogActions { display: grid; grid-template-columns: 1fr 1fr; border-top: 1px solid var(--border-default); }
.dialogActions button { height: 44px; border: 0; background: none; color: #0a7aff; cursor: pointer; }
.dialogActions button + button { border-inline-start: 1px solid var(--border-default); }

.toast { position: absolute; left: var(--space-400); right: var(--space-400); bottom: 104px; z-index: 50; display: flex; align-items: center; gap: var(--space-200); min-height: 48px; padding: var(--space-200) var(--space-300) var(--space-200) var(--space-400); border-radius: var(--radius-m); background: var(--toast-bg); color: var(--text-primary); box-shadow: 0 6px 18px rgba(21,18,13,.14); animation: toastIn .2s ease-out; }
.toast span:not(.icon) { flex: 1; }
.toast button { border: 0; background: none; color: inherit; cursor: pointer; padding: var(--space-100); }
.toastIcon { color: var(--accent-default); }
@keyframes toastIn { from { opacity: 0; transform: translateY(6px); } }
```

## Tab bar

Nguồn: `prototype/src/features/TabBar.module.css`

```css
.bar { position: absolute; left: 50%; bottom: 22px; transform: translateX(-50%); z-index: 20; display: flex; gap: var(--space-200); height: 68px; align-items: center; padding: 0 var(--space-300); border-radius: var(--radius-round); background: var(--background-default); border: 1px solid var(--border-default); box-shadow: 0 6px 20px rgba(21,18,13,.06); }
.tab { width: 48px; height: 48px; display: grid; place-items: center; border: 0; background: none; color: var(--text-secondary); cursor: pointer; border-radius: 24px; transition: color .15s; padding: 0; }
.on { color: var(--text-primary); }
```

## Home

Nguồn: `prototype/src/features/home/home.module.css`

```css
.screen { flex: 1; min-height: 0; overflow-y: auto; padding-bottom: 104px; scrollbar-width: none; }
.screen::-webkit-scrollbar { display: none; }
.content { display: grid; gap: var(--space-300); padding-inline: var(--space-400); }
.city { display: inline-flex; align-items: center; gap: 4px; height: 36px; padding: 0 var(--space-300) 0 var(--space-200); border: 0; border-radius: var(--radius-round); background: var(--group-bg); font: 500 13px "Onest", sans-serif; cursor: pointer; }
.date { color: var(--text-secondary); }
.hijri { color: var(--accent-default); font-weight: 500; }
.muted { color: var(--text-secondary); }

.banner { border-radius: var(--radius-xl); padding: var(--space-400); display: grid; gap: var(--space-200); transition: background .2s; }
.bannerWait { background: var(--group-bg); }
.bannerStill { background: var(--background-default); border: 1.5px solid var(--accent-default); }
.bannerNow { background: var(--brand-default); color: var(--text-inverse); }
.bannerFast { background: var(--card-gradient); color: var(--card-text); }
.cap { opacity: .8; }
.capAccent { color: var(--accent-default); opacity: 1; }
.bannerRow { display: flex; align-items: flex-end; justify-content: space-between; gap: var(--space-200); }
.bannerMain { display: grid; gap: 2px; }
.big { font: 600 30px/1.15 "Onest", sans-serif; letter-spacing: -.01em; }
.time { font: 600 24px/1 "Onest", sans-serif; font-variant-numeric: tabular-nums; }
.actions { display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-200); margin-top: var(--space-100); }

.eventCard { display: flex; align-items: center; gap: var(--space-300); width: 100%; min-height: 60px; padding: var(--space-200) var(--space-300) var(--space-200) var(--space-400); border: 1px solid var(--border-default); border-radius: var(--radius-l); background: var(--background-default); text-align: start; cursor: pointer; color: inherit; }
.eventIcon { color: var(--accent-default); }
.eventText { flex: 1; min-width: 0; display: grid; gap: 4px; }
.progress { display: block; height: 4px; border-radius: 2px; background: var(--border-default); overflow: hidden; }
.progress i { display: block; height: 100%; background: var(--accent-default); }

.strip { display: flex; align-items: center; gap: var(--space-200); padding: var(--space-200) var(--space-200) var(--space-200) var(--space-400); border-radius: var(--radius-l); background: var(--brand-soft); }
.stripText { flex: 1; }

.timeline { list-style: none; margin: var(--space-100) 0 0; padding: 0; position: relative; }
.timeline::before { content: ""; position: absolute; inset-inline-start: 62px; top: 24px; bottom: 24px; width: 2px; background: var(--border-default); }
.tlRow { position: relative; display: grid; grid-template-columns: 46px 16px minmax(0, 1fr) 44px; align-items: center; gap: var(--space-200); min-height: 56px; padding-inline: var(--space-100); margin-inline: calc(var(--space-100) * -1); border-radius: var(--radius-m); }
.tlTime { color: var(--text-secondary); font-variant-numeric: tabular-nums; text-align: end; letter-spacing: 0; }
.tlNode { position: relative; z-index: 1; justify-self: center; width: 12px; height: 12px; border-radius: 50%; border: 2px solid var(--border-default); background: var(--background-surface); display: grid; place-items: center; color: var(--text-inverse); }
.tlName { display: flex; align-items: baseline; gap: var(--space-200); min-width: 0; flex-wrap: wrap; }
.tlAr { color: var(--accent-default); }
.tlTag { color: var(--text-secondary); }
.tlMinor { color: var(--text-secondary); grid-column: 3 / -1; }

.minor { min-height: 34px; }
.minor .tlNode { width: 6px; height: 6px; border: 0; background: var(--border-default); }
.past .tlName b { color: var(--text-secondary); }
.past .tlNode { background: var(--border-default); }
.done .tlNode { width: 18px; height: 18px; border: 0; background: var(--button-primary); }
.done .tlName b { color: var(--text-secondary); }
.current { background: var(--brand-soft); }
.current .tlTime { color: var(--text-primary); font-weight: 600; }
.current .tlNode { border-color: var(--button-primary); background: var(--button-primary); box-shadow: 0 0 0 4px color-mix(in srgb, var(--button-primary) 22%, transparent); }

.bell { width: 40px; height: 40px; justify-self: end; display: grid; place-items: center; border-radius: 50%; border: 0; background: var(--group-bg); color: var(--text-primary); cursor: pointer; padding: 0; }
.current .bell { background: var(--background-surface); }
.bell-off { background: transparent; color: var(--text-secondary); }
.allAlerts { display: inline-flex; align-items: center; justify-content: center; gap: 2px; width: 100%; padding: var(--space-200); border: 0; background: none; color: var(--text-secondary); cursor: pointer; }
```

## Pray

Nguồn: `prototype/src/features/pray/pray.module.css`

```css
.screen { flex: 1; min-height: 0; display: flex; flex-direction: column; }
.bar { display: grid; grid-template-columns: 44px 1fr 44px; align-items: center; padding: 0 var(--space-400); min-height: 52px; text-align: center; flex: none; }
.barSpacer { width: 44px; }
.scroll { flex: 1; min-height: 0; overflow-y: auto; padding: 0 var(--space-400) var(--space-400); display: flex; flex-direction: column; gap: var(--space-300); scrollbar-width: none; }
.scroll > * { flex-shrink: 0; }
.scroll::-webkit-scrollbar { display: none; }
.compassWrap { display: grid; justify-items: center; gap: 2px; }
.compass { width: 204px; height: 204px; touch-action: none; cursor: grab; border-radius: 50%; }
.compass:active { cursor: grabbing; }
.compass svg { width: 100%; height: 100%; display: block; }
.needle { fill: var(--text-secondary); transition: fill .2s; }
.compassOk .needle { fill: var(--status-success); }
.compassState { min-height: 22px; }
.stateOk { color: var(--status-success); }
.compassHint { color: var(--text-secondary); }
.chips { display: flex; gap: var(--space-200); overflow-x: auto; scrollbar-width: none; margin-inline: calc(var(--space-400) * -1); padding-inline: var(--space-400); }
.chips::-webkit-scrollbar { display: none; }
.chip { flex: none; height: 34px; padding: 0 var(--space-300); border-radius: var(--radius-round); border: 1px solid var(--border-default); background: none; color: var(--text-secondary); cursor: pointer; }
.chipOn { background: var(--text-primary); border-color: var(--text-primary); color: var(--background-surface); }
.player { display: flex; align-items: center; gap: var(--space-300); padding: var(--space-200) var(--space-300); border-radius: var(--radius-l); background: var(--brand-soft); }
.play { width: 40px; height: 40px; display: grid; place-items: center; flex: none; border: 0; border-radius: 50%; background: var(--button-primary); color: var(--text-inverse); cursor: pointer; padding: 0; }
.playerText { flex: 1; display: grid; gap: 6px; }
.track { height: 3px; border-radius: 2px; background: color-mix(in srgb, var(--text-primary) 14%, transparent); overflow: hidden; display: block; }
.track i { display: block; height: 100%; background: var(--button-primary); }
.verses { display: grid; }
.verse { display: grid; gap: var(--space-100); padding: var(--space-200); margin-inline: calc(var(--space-200) * -1); border-radius: var(--radius-m); transition: background .2s; }
.verseOn { background: var(--brand-soft); }
.arabic { text-align: right; }
.anum { color: var(--accent-default); font-size: .8em; }
.cta { padding: var(--space-200) var(--space-400) 28px; flex: none; }
```

## Quran, Saved, Reader

Nguồn: `prototype/src/features/quran/quran.module.css`

```css
.screen { flex: 1; min-height: 0; overflow-y: auto; padding-bottom: 104px; scrollbar-width: none; }
.screen::-webkit-scrollbar { display: none; }
.controls { display: grid; gap: var(--space-200); padding: 0 var(--space-400) var(--space-300); }
.search { display: flex; align-items: center; gap: var(--space-200); height: 44px; padding: 0 var(--space-300); border-radius: var(--radius-m); background: var(--group-bg); color: var(--text-secondary); }
.search input { flex: 1; min-width: 0; border: 0; outline: 0; background: none; color: var(--text-primary); }
.search input::placeholder { color: var(--text-secondary); }
.search button { display: grid; border: 0; background: none; padding: 2px; color: inherit; cursor: pointer; }
.loading { text-align: center; color: var(--text-secondary); padding: var(--space-800); }
.continue { display: flex; align-items: center; gap: var(--space-300); width: calc(100% - var(--space-800)); margin: 0 var(--space-400) var(--space-200); padding: var(--space-300) var(--space-300) var(--space-300) var(--space-400); border: 0; border-radius: var(--radius-l); background: var(--brand-soft); color: inherit; text-align: start; cursor: pointer; }
.continueIcon { color: var(--button-primary); }
.grow { flex: 1; min-width: 0; display: grid; gap: 2px; }
.muted { color: var(--text-secondary); }
.list { list-style: none; margin: 0; padding: 0 var(--space-400); }
.item { display: flex; align-items: center; gap: var(--space-300); width: 100%; min-height: 64px; padding: var(--space-200) 0; border: 0; border-bottom: 1px solid var(--border-subtle); background: none; color: inherit; text-align: start; cursor: pointer; }
.num { width: 34px; height: 34px; flex: none; display: grid; place-items: center; color: var(--accent-default); background: center / contain no-repeat; position: relative; }
.num::before { content: ""; position: absolute; inset: 0; background: var(--accent-default); opacity: .55; -webkit-mask: url(/assets/brand/seal.svg) center / contain no-repeat; mask: url(/assets/brand/seal.svg) center / contain no-repeat; }
.arName { font-size: 19px; color: var(--text-primary); flex: none; }
.empty { display: grid; justify-items: center; gap: var(--space-200); padding: var(--space-1200) var(--space-400); text-align: center; color: var(--text-primary); list-style: none; }
.saved { display: grid; gap: var(--space-200); width: 100%; padding: var(--space-400); margin-bottom: var(--space-200); border: 0; border-radius: var(--radius-l); background: var(--group-bg); color: inherit; text-align: start; cursor: pointer; }
.savedSkeleton { height: 140px; margin-bottom: var(--space-200); border-radius: var(--radius-l); background: var(--group-bg); list-style: none; }
.savedRef { color: var(--accent-default); }
.savedAr { text-align: right; display: block; }
.savedTr { display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 3; overflow: hidden; }

.reader { flex: 1; min-height: 0; display: flex; flex-direction: column; position: relative; }
.langBtn { width: 44px; height: 44px; border-radius: 50%; border: 1px solid var(--border-default); background: none; cursor: pointer; font-weight: 600; letter-spacing: .2px; }
.readerScroll { flex: 1; min-height: 0; overflow-y: auto; padding: 0 var(--space-400) 110px; position: relative; scrollbar-width: none; }
.readerScroll::-webkit-scrollbar { display: none; }
.surahHead { display: grid; justify-items: center; gap: 0; padding: var(--space-300) 0 var(--space-200); text-align: center; }
.surahAr { line-height: 1.5; }
.basmala { text-align: center; padding-bottom: var(--space-200); }
.ayah { padding: var(--space-300); margin-inline: calc(var(--space-300) * -1); border-radius: var(--radius-m); cursor: pointer; transition: background .25s; display: grid; gap: var(--space-200); }
.ayahSel, .ayahFlash { background: var(--brand-soft); }
.ayahAr { text-align: right; }
.anum { color: var(--accent-default); font-size: .72em; white-space: nowrap; }
.ayahTr { line-height: 1.5; }
.ayahNum { color: var(--text-secondary); font-size: 13px; font-weight: 700; }
.fn { display: inline; margin-inline: 3px; padding: 0 5px; border: 1px solid var(--border-default); border-radius: 5px; background: none; font: 500 11px "Onest", sans-serif; color: var(--accent-default); vertical-align: 2px; cursor: pointer; }
.savedMark { color: var(--accent-default); margin-inline-start: 6px; vertical-align: -2px; }
.attribution { padding: var(--space-600) var(--space-200) 0; text-align: center; color: var(--text-secondary); }

.actionBar { position: absolute; left: 50%; bottom: 26px; transform: translateX(-50%); display: flex; align-items: center; gap: var(--space-100); padding: var(--space-100) var(--space-100) var(--space-100) var(--space-400); border-radius: var(--radius-round); background: var(--background-default); border: 1px solid var(--border-default); box-shadow: 0 8px 24px rgba(21,18,13,.14); z-index: 10; animation: rise .18s ease-out; white-space: nowrap; }
.actionRef { color: var(--text-secondary); margin-inline-end: var(--space-200); font-variant-numeric: tabular-nums; }
.action { display: inline-flex; align-items: center; gap: var(--space-100); height: 44px; padding: 0 var(--space-300); border: 0; border-radius: var(--radius-round); background: none; cursor: pointer; }
.actionOn { color: var(--accent-default); }
.actionClose { width: 44px; height: 44px; display: grid; place-items: center; border: 0; border-radius: 50%; background: var(--group-bg); cursor: pointer; padding: 0; }
@keyframes rise { from { opacity: 0; transform: translate(-50%, 8px); } }
```

## Ayah of the day

Nguồn: `prototype/src/features/ayah/ayah.module.css`

```css
.screen { flex: 1; min-height: 0; display: flex; flex-direction: column; padding-bottom: 104px; overflow: hidden; }
.deck { position: relative; flex: 1; min-height: 0; margin: 0 var(--space-400); touch-action: pan-y; user-select: none; cursor: grab; outline-offset: 4px; border-radius: var(--radius-xl); }
.deck:active { cursor: grabbing; }
.slot { position: absolute; inset: 0; transition: transform .28s cubic-bezier(.2,.8,.2,1), opacity .2s; }
.card { position: absolute; inset: 0; border-radius: var(--radius-xl); padding: var(--space-400); display: flex; flex-direction: column; background: var(--card-gradient); color: var(--card-text); overflow: hidden; }
.card::before { content: ""; position: absolute; inset: 0; background: url(/assets/patterns/star-grid.svg); opacity: .8; pointer-events: none; }
.card > * { position: relative; }
.sealed { align-items: center; justify-content: center; gap: var(--space-300); text-align: center; animation: none; }
.cap { opacity: .75; position: absolute !important; top: var(--space-600); }
.sealIcon { width: 72px; height: 72px; background: #d8b26a; -webkit-mask: url(/assets/brand/seal.svg) center / contain no-repeat; mask: url(/assets/brand/seal.svg) center / contain no-repeat; }
.revealed { animation: reveal .32s ease-out; }
.revealed::before { opacity: .35; }
@keyframes reveal { from { opacity: 0; transform: scale(.98); } }
.ayahBody { flex: 1; min-height: 0; overflow-y: auto; display: flex; flex-direction: column; justify-content: center; gap: var(--space-300); text-align: center; scrollbar-width: none; padding-block: var(--space-200); }
.ayahBody::-webkit-scrollbar { display: none; }
.ayahAr { line-height: 1.8; }
.anum { font-size: .7em; color: #d8b26a; white-space: nowrap; }
.ayahTr { line-height: 1.5; opacity: .95; }
.ref { opacity: .75; }
.cardBar { display: flex; align-items: center; gap: var(--space-200); padding-top: var(--space-200); flex: none; }
.endCard { align-items: center; justify-content: center; gap: var(--space-200); text-align: center; }
.endAction { margin-top: var(--space-300); }
.dots { display: flex; justify-content: center; gap: 6px; padding-top: var(--space-300); flex: none; }
.dots i { width: 7px; height: 7px; border-radius: 4px; background: var(--border-default); transition: width .2s, background .2s; }
.dots .dotOn { width: 18px; background: var(--text-primary); }
```

## Share

Nguồn: `prototype/src/features/share/share.module.css`

```css
.root { position: absolute; inset: 0; z-index: 45; display: flex; flex-direction: column; justify-content: flex-end; }
.backdrop { position: absolute; inset: 0; background: rgba(21,18,13,.5); animation: fade .2s; }
.sheet { position: relative; display: flex; flex-direction: column; background: var(--background-surface); border-radius: var(--radius-xxl) var(--radius-xxl) 0 0; padding-bottom: 34px; animation: up .24s cubic-bezier(.2,.8,.2,1); }
@keyframes fade { from { opacity: 0; } }
@keyframes up { from { transform: translateY(100%); } }
.head { display: flex; justify-content: flex-end; padding: var(--space-300) var(--space-400) var(--space-200); }
.rail { display: flex; overflow-x: auto; scroll-snap-type: x mandatory; padding-inline: 42px; scrollbar-width: none; }
.rail::-webkit-scrollbar { display: none; }
.cardSlot { flex: none; width: 100%; padding-inline: 6px; scroll-snap-align: center; }
.card { position: relative; height: 448px; border-radius: var(--radius-xl); padding: var(--space-600) var(--space-400) var(--space-400); display: flex; flex-direction: column; text-align: center; color: #fbf9f4; overflow: hidden; }
.cardBody { flex: 1; min-height: 0; display: flex; flex-direction: column; justify-content: center; gap: var(--space-300); overflow: hidden; }
.ar { font: 400 26px/1.8 "Amiri", serif; }
.tr { font: 400 15px/1.5 "Literata", serif; }
.ref { font: 500 12px "Onest", sans-serif; letter-spacing: .08em; text-transform: uppercase; opacity: .75; }
.mark { font: 600 13px "Onest", sans-serif; opacity: .8; flex: none; }
.gradient { background: var(--card-gradient); }
.solid { background: #1f5e4e; }
.pattern { background: #173a31 url(/assets/patterns/star-grid.svg); }
.night { background: linear-gradient(180deg, #15120d, #2a3125); }
.actions { display: grid; gap: var(--space-800); padding: var(--space-600) 24px 0; }
.targets { display: flex; justify-content: center; gap: var(--space-300); }
.target { width: 56px; height: 56px; display: grid; place-items: center; border: 0; border-radius: var(--radius-l); background: var(--group-bg); color: var(--text-primary); cursor: pointer; padding: 0; }
.watermark { display: flex; align-items: center; gap: var(--space-200); padding-top: 20px; border-top: 1px solid var(--border-default); }
.watermarkText { min-width: 0; }
.premium { padding: 4px 8px; margin-inline-end: auto; border-radius: var(--radius-s); background: linear-gradient(90deg, #fcc852, #e5a000); color: #fff; font: 600 10px/13px "Onest", sans-serif; letter-spacing: 1px; }
```

## Settings, Prayer alerts

Nguồn: `prototype/src/features/settings/settings.module.css`

```css
.screen { flex: 1; min-height: 0; overflow-y: auto; padding-bottom: 104px; scrollbar-width: none; }
.screen::-webkit-scrollbar { display: none; }
.content { display: grid; gap: var(--space-400); padding: var(--space-100) var(--space-400) 0; }
.note { color: var(--text-secondary); padding-inline: var(--space-100); }
.notice { display: flex; align-items: center; gap: var(--space-200); padding: var(--space-200) var(--space-200) var(--space-200) var(--space-400); border-radius: var(--radius-l); background: var(--brand-soft); }
.notice p { flex: 1; }
.pickRow { padding: var(--space-300); }
.alertRow { display: grid; gap: var(--space-200); padding: var(--space-300); }
.alertRow + .alertRow { border-top: 1px solid var(--border-subtle); }
.alertHead { display: flex; justify-content: space-between; align-items: baseline; padding-inline: var(--space-100); }
.alertName { display: flex; align-items: baseline; gap: var(--space-200); }
.ar { color: var(--accent-default); }
.alertTime { color: var(--text-secondary); font-variant-numeric: tabular-nums; }
.picker { display: flex; gap: 2px; padding: 2px; border-radius: 11px; background: color-mix(in srgb, var(--text-primary) 6%, transparent); }
.pick { flex: 1; display: flex; align-items: center; justify-content: center; gap: 5px; height: 36px; border: 0; border-radius: 9px; background: none; color: var(--text-secondary); cursor: pointer; }
.pickOn { background: var(--background-surface); color: var(--text-primary); font-weight: 600; box-shadow: 0 1px 2px rgba(0,0,0,.08); }
.pickAdhan { background: var(--button-primary); color: var(--text-inverse); }
```

## Onboarding

Nguồn: `prototype/src/features/onboarding/onboarding.module.css`

```css
.screen { flex: 1; min-height: 0; display: flex; flex-direction: column; position: relative; }
.welcome { background: var(--card-gradient); color: var(--card-text); margin-top: -54px; padding-top: 54px; }
.welcome::before { content: ""; position: absolute; inset: 0; background: url(/assets/patterns/star-grid.svg); opacity: .5; }
.welcome > * { position: relative; }
.center { flex: 1; display: flex; flex-direction: column; justify-content: center; align-items: center; gap: var(--space-300); padding-inline: var(--space-600); text-align: center; }
.bismillah { font: 400 52px/1.6 "Amiri", serif; color: #d8b26a; }
.sub { opacity: .8; }
.dots { display: flex; gap: 5px; justify-content: center; padding-top: var(--space-200); flex: none; }
.dots i { width: 7px; height: 7px; border-radius: 4px; background: var(--border-default); }
.dots .on { width: 18px; background: var(--button-primary); }
.body { flex: 1; min-height: 0; display: flex; flex-direction: column; gap: var(--space-300); padding: var(--space-800) var(--space-600) 0; }
.hero { color: var(--button-primary); }
.muted { color: var(--text-secondary); }
.ar { color: var(--accent-default); flex: 1; }
.preview { list-style: none; margin: var(--space-200) 0 0; padding: var(--space-100) var(--space-400); border-radius: var(--radius-l); background: var(--group-bg); }
.preview li { display: flex; align-items: center; gap: var(--space-300); min-height: 52px; }
.preview li + li { border-top: 1px solid var(--border-subtle); }
.preview li > span:first-child { color: var(--text-secondary); font-variant-numeric: tabular-nums; }
.cta { display: grid; gap: var(--space-100); padding: var(--space-300) var(--space-400) 36px; flex: none; }
```
