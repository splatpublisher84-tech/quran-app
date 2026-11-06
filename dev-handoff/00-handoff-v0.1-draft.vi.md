# Handoff cho dev: Quran app v1

Created: 2026-11-06 · Last modified: 2026-11-06

> **Cần Hiếu duyệt scope trước khi bắt đầu.**
>
> **Prototype:** https://quran-prototype.vercel.app (bấm thử được, mỗi trạng thái có link riêng, xem mục 1).
>
> Bản nháp. Chỗ **[CẦN QUYẾT ĐỊNH]** là chỗ chưa chốt. Dev làm theo prototype và tài liệu này. Không có file Figma; khi prototype và tài liệu lệch nhau thì báo lại, đừng tự chọn một bên.

## 0. Nguồn cần đọc

Folder này gồm tài liệu handoff và bản Markdown của các file nguồn được nhắc tới, để đọc được mà không cần mở code:

| File | Nội dung | Sinh từ |
|---|---|---|
| `00-handoff-v0.1-draft.vi.md` | Tài liệu này | Viết tay |
| [`01-design-tokens.vi.md`](01-design-tokens.vi.md) | Màu light/dark, kiểu chữ, spacing, radius, font bản dịch, alias của prototype | `03-design/tokens/*.json`, `prototype/src/design/base.css` |
| [`02-ui-spec.vi.md`](02-ui-spec.vi.md) | Số đo component và từng màn | CSS module trong `prototype/src/` |
| [`03-prayer-logic.vi.md`](03-prayer-logic.vi.md) | Logic khung giờ, trạng thái banner, test, dữ liệu giả | `prototype/src/domain/prayer.ts`, `prayer.test.ts`, `scenarios.ts` |
| [`04-quran-data.vi.md`](04-quran-data.vi.md) | API QuranEnc, định dạng file, quy tắc hiển thị | `prototype/public/data/quran/`, `src/domain/quran.ts`, `scripts/fetch-quran.mjs` |
| [`05-copy.vi.md`](05-copy.vi.md) | Toàn bộ chữ trên màn, theo file | Các file `.tsx` trong `prototype/src/` |
| [`06-icons-assets.vi.md`](06-icons-assets.vi.md) | Icon đang dùng ở đâu, asset còn thiếu | `prototype/public/assets/` |

File 01 đến 06 sinh tự động. Khi prototype hoặc token đổi, chạy `npm run export:handoff` trong `prototype/` để cập nhật, không sửa tay. File JSON token gốc để chép vào app vẫn nằm ở `03-design/tokens/`.

Nguồn khác:

| Nguồn | Dùng để |
|---|---|
| Prototype live: https://quran-prototype.vercel.app | Xem giao diện và bấm thử flow |
| Code prototype: `prototype/` trong repo [hoangmai07/quran](https://github.com/hoangmai07/quran), commit `b234474` | Đọc kích thước, màu, logic. Đây là bản gốc của tài liệu này |
| `03-design/tokens/` | Token màu, chữ, spacing, radius. Cùng định dạng JSON với Bible, chép thẳng vào `assets/design_tokens/` |
| Code Bible Widget (`lumen-bible`) | Dùng lại component, service, cách tổ chức code |
| [`mvp-scope-v0.1-draft.vi.md`](../mvp-scope-v0.1-draft.vi.md) | Phạm vi MVP. Có vài chỗ lệch với prototype, xem mục 9 |
| [`content-sources.vi.md`](../../05-research/content-sources.vi.md) | Nguồn nội dung và điều khoản QuranEnc |

**Prototype làm chuẩn cho:** bố cục, kích thước, màu, chữ, nội dung trên màn, thứ tự flow, logic trạng thái giờ salah.

**Prototype không làm chuẩn cho:** hành vi native (thông báo, cảm biến, audio, quyền, widget), hiệu năng, phần tải và lưu dữ liệu. Các phần này theo mục 4.

## 1. Cấu trúc app

4 tab, tab bar dạng viên thuốc nổi ở đáy, chỉ có icon, giống Bible:

| Tab | Icon (Material Symbols Rounded) | Nội dung |
|---|---|---|
| Home | `home` | Banner trạng thái, thẻ sự kiện, timeline 5 giờ salah |
| Quran | `book_5` | Mục lục Surah / Juz, nút Saved, Reader |
| Ayah of the day | `amp_stories` | 3 thẻ mỗi ngày |
| Settings | `settings` | Cài đặt |

Tab đang chọn dùng bản đặc (`-fill`) màu `text/primary`. Tab còn lại dùng bản viền, màu `text/secondary`.

Màn đẩy lên trên tab (ẩn tab bar): Pray, Reader, Saved, Prayer alerts, các màn chọn trong Settings, Sources. Overlay: Share sheet, bottom sheet, toast, dialog quyền hệ thống.

### Danh sách màn và link prototype

Mỗi trạng thái có link riêng: `https://quran-prototype.vercel.app/#<id>`.

| Màn | Trạng thái | Link id |
|---|---|---|
| Onboarding | Chào → vị trí → thông báo | `onboarding` |
| Home | Chờ giờ / Đã tới giờ / Còn giờ / Đã cầu nguyện / Hết khung Isha / Tạm dừng nhắc | `home-waiting`, `home-now`, `home-still`, `home-prayed`, `home-night`, `home-paused` |
| Home | Đã tắt thông báo | `notifications-off` |
| Pray | La bàn + đọc/nghe | `pray` |
| Quran | Mục lục, Saved, Reader theo Surah, Reader theo Juz | `quran`, `saved`, `reader`, `reader-juz` |
| Ayah of the day | Thẻ úp, đã mở thẻ đầu, đã mở hết, Share | `ayah`, `ayah-open`, `ayah-done`, `share` |
| Settings | Settings, Prayer alerts | `settings`, `alerts` |
| Sự kiện | Thứ Sáu, Ramadan ban ngày, Ramadan đêm, Eid al-Fitr | `friday`, `ramadan-day`, `ramadan-night`, `eid` |

## 2. Phần chỉ có trong prototype, không làm

| Trong prototype | App thật |
|---|---|
| Bảng review bên trái, thanh kéo giờ, nút Sang ngày mới | Không có. Giờ lấy từ đồng hồ máy |
| Kéo vòng la bàn để giả lập xoay máy | Dùng cảm biến hướng thật (mục 4.3) |
| Nút Listen chạy highlight theo nhịp 4 giây/câu, không có tiếng | Phát audio thật qua API (mục 4.4) |
| Dialog xin quyền vẽ bằng HTML | Dialog hệ thống thật. Trước dialog có màn giải thích (priming) như onboarding |
| Nút share chỉ hiện toast | Mở app đích thật (mục 4.6) |
| Nút Premium ở dòng watermark chỉ hiện toast | Mở paywall, như Bible. Paywall chưa chốt (mục 8) |
| Giờ cầu nguyện, ngày Hijri, thành phố là giá trị mẫu cho Đà Nẵng | Tính trên máy (mục 4.1) |
| Đổi cách tính hoặc Asr chỉ cộng trừ vài phút cố định | Tính lại thật bằng thư viện |
| 3 ayah mỗi ngày là danh sách tạm | Lấy từ danh sách đã duyệt (mục 6) |
| State lưu trong `sessionStorage`, mất khi đóng tab | Lưu bền trên máy (mục 4.7) |

## 3. Giao diện

### 3.1 Token

- Màu, chữ, spacing, radius: bảng ở [`01-design-tokens.vi.md`](01-design-tokens.vi.md), file JSON ở `03-design/tokens/`. Đọc [`03-design/tokens/README.md`](../../03-design/tokens/README.md) trước, mục "Khi đưa vào app" có các chỗ phải sửa khi đưa vào code Bible (`AppFontResolver` thêm Literata và Amiri, parser đọc `lineHeight`, getter cho token mới).
- Chữ: UI dùng Onest. Bản dịch Quran dùng Literata (`reading/serif/*`). Arabic dùng `arabic/*`, font tạm Amiri chờ Q-03.
- Bản dịch có chữ ngoài Latin (Urdu, Bengali, Hindi...) dùng font trong `translation-fonts.json`.
- Kích thước trong prototype tính bằng pt trên màn 393×852, giống Figma của Bible. Dùng `flutter_screenutil` như Bible.
- Có vài alias chỉ có trong prototype, chưa vào token: `--group-bg`, `--toast-bg`, `--card-gradient` (`prototype/src/design/base.css`). **[CẦN QUYẾT ĐỊNH]** có đưa vào token không; đề xuất có, vì nền thẻ ayah và nền share dùng lại nhiều chỗ.

### 3.2 Đối chiếu component với Bible

| Prototype (`src/ui/`) | Bible (`lib/shared/widgets/`) | Việc cần làm |
|---|---|---|
| `Button` primary, secondary, tertiary, glass, text | `BbButton` | Dùng lại. Nút large cao 52, small cao 44, radius `radius-m` |
| `Button` inverse (nền trắng, chữ xanh trên banner xanh) | Chưa có | Thêm variant |
| `Button` outline (viền 1px màu chữ 40%) | Chưa có | Thêm variant. Dùng cho "I’ve prayed" |
| `IconButton` 44, filled / outline / plain / glass | `BbIconButton` | Dùng lại, thêm outline |
| `TabBar` 4 tab | `BbTabBar` (3 tab) | Thêm tab thứ tư |
| `NavBar` | `BbSecondaryNavBar` | Dùng lại |
| `Toast`, có icon và nút hành động (Undo) | `BbToast` | Dùng lại. Thêm kiểu có nút Undo nếu chưa có |
| `LargeHeader` (tiêu đề 34 + nút bên phải) | Header của Home Bible | Dùng lại |
| `Group` / `Row` / `Switch` | Settings của Bible | Dùng lại |
| `Segmented` | Chưa thấy trong shared | Thêm |
| `Sheet` (bottom sheet, radius 24, nút đóng) | Các sheet của Bible | Dùng lại |
| Share sheet | `share_flow_sheet.dart` | Dùng lại layout và 5 nút share. Thay nền ảnh bằng nền màu (mục 4.6) |

Quy tắc của Bible vẫn áp dụng: không hardcode màu và kích thước, đi qua design system, chuỗi hiển thị nằm trong `assets/i18n/*.json`, không có em dash trong copy, light mode là mặc định.

### 3.3 Chi tiết từng màn

Số đo chính xác nằm ở [`02-ui-spec.vi.md`](02-ui-spec.vi.md) (bản Markdown của CSS đi cùng mỗi màn). Dưới đây chỉ ghi những điểm dễ làm sai.

**Home** (`features/home/`)
- Banner có 4 kiểu nền: chờ giờ (`--group-bg`), đã tới giờ (`brand/default`), còn giờ (nền `background/default`, viền 1.5px `accent/default`), Ramadan (gradient thẻ).
- Hai nút Pray và I’ve prayed chia đôi bề ngang banner, cách nhau 8, cao 44.
- Timeline: cột giờ bên trái, đường dọc 2px, chấm tròn. Sunrise và Imsak là dòng phụ: không chuông, chữ nhỏ.
- Hàng đang trong khung giờ có nền `brand/soft`. Hàng đã cầu nguyện có chấm xanh và dấu tick.
- Chuông: 40×40. Off thì nền trong suốt, màu chữ phụ.

**Pray** (`features/pray/`)
- La bàn 204×204. Mũi tên chuyển `status/success` khi lệch dưới 5°. Hình Kaaba nằm trên vòng, ở hướng Qibla.
- Chip chọn chương: Al-Fatihah, Al-Ikhlas, Al-Falaq, An-Nas.
- Nút Done dính đáy màn.

**Quran** (`features/quran/`)
- Header có nút tim 44 mở Saved, không có nút settings bên cạnh.
- Số surah nằm trong ngôi sao 8 cánh (`brand/seal.svg`).
- Reader: Arabic căn phải, đọc phải sang trái, số ayah dạng ﴿١﴾ màu accent. Bản dịch bên dưới, có số ayah nhỏ đứng đầu.
- Chạm ayah thì hiện thanh nổi ở đáy: số ayah, Save, Share, đóng.
- Footnote hiện thành nhãn nhỏ "note" trong câu, chạm vào mở sheet.
- Header Reader: hai nút tròn 44 viền mảnh, một nút là mã ngôn ngữ (EN/VI/ID), một nút là icon `text_fields` cỡ 20.

**Ayah of the day** (`features/ayah/`)
- Thẻ chiếm hết chiều cao còn lại, radius 20, nền gradient xanh và họa tiết.
- Thẻ úp: ngôi sao 8 cánh và "Tap to reveal". Thẻ đã mở: Arabic, bản dịch, tham chiếu.
- Đáy thẻ có 3 nút: tim, Open in Quran, share. Bố cục giống thẻ Verse of the day của Bible.
- Vuốt quá 56pt thì sang thẻ. Chạm (không kéo) vào thẻ úp thì mở.

**Share** (`features/share/`)
- Layout như Bible: carousel thẻ, 5 nút (Instagram, Facebook, X, Messages, More) 56×56 radius 16, đường kẻ, dòng ẩn watermark có nhãn PREMIUM.
- 4 nền: Gradient, Solid, Pattern, Night. Không dùng ảnh.

## 4. Hành vi native

### 4.1 Tính giờ cầu nguyện

- Tính trên máy, không gọi server. Đề xuất thư viện `adhan` (Dart, MIT). **[CẦN QUYẾT ĐỊNH]** dev xác nhận thư viện.
- Tham số: phương pháp tính (tự chọn theo quốc gia, user đổi được), Asr Standard / Hanafi, chỉnh ±phút từng giờ (mvp-scope có, prototype chưa có màn), quy tắc cho vùng vĩ độ cao.
- Tính lại khi đổi vị trí, đổi ngày, đổi múi giờ, đổi cài đặt.
- Nghiệm thu: khớp lịch chính thức ở Jakarta, Karachi, Cairo, London, New York trong ±2 phút.

### 4.2 Trạng thái banner

Logic đã viết và có test, xem [`03-prayer-logic.vi.md`](03-prayer-logic.vi.md). Port nguyên logic này sang Dart, kèm test.

| Trạng thái | Điều kiện |
|---|---|
| Đã tới giờ | Đang trong khung giờ, chưa đánh dấu, chưa quá 30 phút từ lúc bắt đầu. 30 phút để trong remote config |
| Còn giờ | Đang trong khung giờ, chưa đánh dấu, đã quá 30 phút |
| Chờ giờ | Ngoài mọi khung giờ, hoặc đã đánh dấu, hoặc đang tạm dừng nhắc |

Khung giờ:

| Salah | Hết khung khi |
|---|---|
| Fajr | Mặt trời mọc (Sunrise) |
| Dhuhr | Asr bắt đầu |
| Asr | Maghrib bắt đầu |
| Maghrib | Isha bắt đầu |
| Isha | Nửa đêm Hồi giáo: điểm giữa Maghrib và Fajr hôm sau |

- Thứ Sáu: Dhuhr hiển thị là "Jumu’ah", logic giữ nguyên.
- Ramadan: khi không ở trạng thái Đã tới giờ, banner đếm ngược theo thứ tự: tới Imsak (trước bình minh), tới Iftar (Maghrib, ban ngày), tới Imsak hôm sau (sau Iftar). Nếu đang Còn giờ thì vẫn có nút Pray.
- Ngày Hijri đổi lúc Maghrib, không đổi lúc 0h.
- **[CẦN QUYẾT ĐỊNH]** danh sách "đã cầu nguyện" reset lúc nào. Đề xuất reset lúc Fajr, không phải 0h, vì khung Isha có thể kéo qua nửa đêm.
- **[CẦN QUYẾT ĐỊNH]** mốc hết khung Isha cần người review tôn giáo xác nhận (Q-04).

### 4.3 Qibla

- Hướng tính từ vị trí đã lưu tới Kaaba (21.4225, 39.8262), không cần GPS liên tục.
- Dùng la bàn của máy. Lệch dưới 5° thì báo đúng hướng.
- Cần thêm: hướng dẫn hiệu chỉnh khi cảm biến kém chính xác, cảnh báo khi gần kim loại, máy không có cảm biến thì chỉ hiện số độ. Prototype chưa có các trạng thái này.

### 4.4 Audio

- **Listen ở màn Pray:** dùng API audio của Hoàng. **[CẦN QUYẾT ĐỊNH]** Hoàng gửi URL, cách gọi, định dạng, có timing theo ayah không (để highlight câu đang đọc).
- Không tự phát khi mở màn. Dừng khi rời màn. Không phát cùng lúc với adhan.
- **Adhan:** 2–3 giọng, file audio có license. **[CẦN QUYẾT ĐỊNH]** nguồn file. Fajr có bản adhan riêng.

### 4.5 Thông báo và adhan

Phần rủi ro cao nhất. Cần pre-mortem riêng (Q-07) trước khi code.

- Mỗi giờ salah có 3 kiểu báo: **Adhan** (phát adhan đầy đủ), **Notify** (banner kèm âm ngắn), **Off**. Mặc định Adhan cho cả 5.
- Bấm chuông trên Home hay vào Settings > Prayer alerts đều sửa cùng một dữ liệu.
- Android:
  - Lên lịch bằng exact alarm, xin quyền `SCHEDULE_EXACT_ALARM`.
  - Phát adhan dài bằng foreground service.
  - Lên lịch lại khi khởi động lại máy, đổi giờ hệ thống hoặc đổi múi giờ.
  - Hướng dẫn tắt battery optimization theo từng hãng (Samsung, Xiaomi, Oppo, Vivo).
- iOS: âm thông báo tối đa 30 giây, nên adhan đầy đủ chỉ phát được khi app đang mở. **[CẦN QUYẾT ĐỊNH]** cách xử lý trên iOS (cắt bản 30 giây, hoặc chỉ phát câu đầu).
- Xin quyền: sau màn giải thích ở onboarding. Nếu user từ chối thì Home hiện dòng "Prayer alerts are off · Turn on" và chuông chuyển sang Off.
- Thông báo khác: 3 ayah mỗi ngày (sau Fajr hoặc sau Maghrib, user chọn), suhoor và iftar trong Ramadan, Jumu’ah sớm 30 phút (tùy chọn).
- Nghiệm thu: adhan kêu đúng giờ trên ≥95% máy test, kể cả sau khi khởi động lại và đổi múi giờ.

### 4.6 Share

- Dùng lại `share_flow_sheet.dart`, `share_image_exporter.dart`, `share_dispatcher.dart` của Bible.
- Ảnh xuất 1080×1920: Arabic, bản dịch, tham chiếu, tên app. Chữ vẽ bằng font, không dùng ảnh có sẵn chữ.
- Nền: 4 nền màu như prototype. Không dùng bộ ảnh nền của Bible (lý do ở proposal v2).
- Watermark: ẩn được với Premium, giống Bible.
- **[CẦN QUYẾT ĐỊNH]** mvp-scope đề xuất đưa WhatsApp lên đầu danh sách share (thị trường ID, PK). Prototype đang giữ 5 nút như Bible.

### 4.7 Dữ liệu và lưu trữ

| Dữ liệu | Nguồn | Lưu |
|---|---|---|
| Văn bản Arabic + bản dịch | QuranEnc API, endpoint `/api/v1/translation/sura/{key}/{sura}`. Trả về `arabic_text`, `translation`, `footnotes`. Trường `arabic_text` không có trong tài liệu, cần xác nhận với QuranEnc | Đóng gói sẵn bản mặc định trong app để đọc offline; kiểm tra version qua API |
| Mốc Juz, tên surah | Bảng tĩnh trong app, định dạng ở [`04-quran-data.vi.md`](04-quran-data.vi.md) | Đóng gói |
| Saved, vị trí đọc dở, cài đặt, kiểu báo từng giờ | Trên máy | `drift` hoặc `shared_preferences` như Bible |
| Đã cầu nguyện hôm nay | Trên máy | Chỉ ngày hiện tại, không lịch sử |
| Thẻ đã mở hôm nay | Trên máy | Reset khi có bộ ayah mới |

- Bản dịch mặc định theo ngôn ngữ máy; nếu không có thì dùng tiếng Anh.
- Prototype đang dùng 3 bản dịch: `english_saheeh`, `vietnamese_rwwad`, `indonesian_affairs`. Danh sách v1 theo mvp-scope (EN, ID, UR, TR) và Q-01.
- Điều khoản QuranEnc: không sửa nội dung (footnote phải có, được thu gọn), ghi nguồn và số phiên bản (màn Sources), không đặt ads cạnh bản dịch.

### 4.8 Quyền riêng tư

Tính giờ trên máy. Không gửi tọa độ chính xác lên server. Không dùng SDK data broker.

## 5. Trạng thái prototype chưa có, cần thiết kế khi code

| Trạng thái | Gợi ý xử lý |
|---|---|
| Đang tải surah, mất mạng khi tải lần đầu | Skeleton như danh sách Saved; lỗi thì có nút thử lại |
| Từ chối quyền vị trí | Ô tìm thành phố (Settings > Location đang chỉ có danh sách mẫu) |
| Thông báo bị tắt trong Settings của hệ thống | Như trạng thái `notifications-off` |
| Cảm biến la bàn kém hoặc không có | Mục 4.3 |
| Chữ phóng to (Dynamic Type, font scale Android) | Banner, timeline, thẻ ayah phải xuống dòng được, không cắt chữ |
| Ayah dài trên thẻ Ayah of the day và trên ảnh share | Thẻ cuộn được (prototype đã có); ảnh share cần giảm cỡ chữ theo độ dài |
| Vĩ độ cao, Isha kéo qua nửa đêm | Mục 4.1 và 4.2 |
| Khác biệt iOS / Android | Dialog quyền, sheet, haptic theo nền tảng |
| Dark mode | Prototype có dark mode, bật bằng nút Dark trong bảng review. Kiểm tra từng màn bằng cách chuyển theme, không suy đoán |

## 6. Nội dung và copy

- Copy tiếng Anh trong prototype là bản nháp. Chuyển vào `assets/i18n/*.json` theo cách Bible làm. Không em dash.
- Ngôn ngữ UI v1 theo mvp-scope: EN, ID, UR, AR. AR và UR là RTL, toàn bộ layout phải lật. Prototype chưa thể hiện RTL cho UI.
- Danh sách khoảng 300 ayah cho Ayah of the day: đội soạn, người review tôn giáo duyệt (Q-04). Tránh ayah về luật lệ, chiến tranh hoặc cần bối cảnh mới hiểu đúng.
- Copy UI, nền share, họa tiết phải qua người review trước khi ship.
- Không có nội dung do AI viết hay dịch (DECISIONS).

Copy chính (bản nháp, lấy từ prototype):

| Chỗ | Copy |
|---|---|
| Banner chờ giờ | NEXT PRAYER · {prayer} · in {duration} |
| Banner đã tới giờ | IT’S TIME · {prayer} · Started {time} · Pray · I’ve prayed |
| Banner còn giờ | {PRAYER} TIME · {duration} left · Ends at {time} |
| Ramadan | Suhoor ends in / Fasting · Iftar in / Next Imsak in |
| Đánh dấu xong | {prayer} marked as prayed · Undo |
| Sheet chuông | Adhan: Plays the full call to prayer · Notify: A banner with a short sound · Off: No alert. The time still shows here |
| Thông báo tắt | Prayer alerts are off · Turn on |
| Thẻ ayah | Ayah {n} of 3 · Tap to reveal · Open in Quran · That’s today’s three · New ayahs after Fajr tomorrow. |

Copy đầy đủ: [`05-copy.vi.md`](05-copy.vi.md).

## 7. Việc cần có trước khi dev bắt đầu

| Việc | Ai | Trạng thái |
|---|---|---|
| Design widget: Next prayer (S, M, lock screen iOS), Ayah of the day (S, M). DECISIONS đã chốt MVP có widget, prototype chưa có | Hoàng / design | Chưa có |
| App icon, splash, logo, bản chính thức của họa tiết và ngôi sao 8 cánh | Design | Đang dùng bản vẽ tạm, xem [`06-icons-assets.vi.md`](06-icons-assets.vi.md) |
| File audio adhan có license | Hoàng | Chưa có |
| API audio Listen | Hoàng | Chưa có thông tin |
| Font Arabic có license (Q-03) | Hoàng | Todo |
| License bản dịch (Q-01) và audio (Q-02) | Hoàng | Todo |
| Người review tôn giáo (Q-04) | Hoàng | Todo |
| Event taxonomy (Q-09) | PM | Todo. Event đề xuất: `prayer_logged`, `adhan_fired`, `adhan_failed`, `qibla_opened`, `quran_audio_play`, `widget_added` |
| Pre-mortem adhan Android (Q-07) | PM + dev | Todo |

## 8. Chưa chốt, chưa handoff được

- Paywall: có hay không, đặt ở đâu, giá bao nhiêu.
- Ads: có chạy không, trên nền tảng nào. Nếu có thì theo luật cứng trong mvp-scope (không ads ở reader, khi adhan, ±10 phút quanh giờ salah).
- Tên app và tên store.
- Code đặt ở `mobile/` trong project hay repo riêng.

## 9. Chỗ lệch giữa prototype và mvp-scope

Prototype làm theo proposal v2 (đã duyệt sau mvp-scope). Hoàng chốt từng dòng trước khi dev làm.

| Chủ đề | mvp-scope v0.1 | Prototype | Đề xuất |
|---|---|---|---|
| Theo dõi salah | Prayer log, streak cơ bản | Chỉ đánh dấu hôm nay, không streak | Theo prototype |
| Onboarding | 6 màn (splash, ngôn ngữ, vị trí, giờ cầu nguyện, adhan, xong) | 3 bước: chào, vị trí, thông báo | Theo prototype; phương pháp tính tự chọn, đổi trong Settings |
| Qibla | Màn riêng | Nằm trong màn Pray | Theo prototype |
| Reader | Phiên âm, audio qari theo ayah, copy | Không phiên âm, không audio, không copy | **[CẦN QUYẾT ĐỊNH]** |
| Chỉnh ±phút từng giờ | Có | Chưa có màn | Thêm vào Settings > Prayer alerts |
| Share | WhatsApp đứng đầu | 5 nút như Bible | **[CẦN QUYẾT ĐỊNH]** |
| Ayah of the day | 1 thẻ trên Today | Tab riêng, 3 thẻ | Theo prototype |
| Tạm dừng nhắc (kỳ kinh) | Để sau MVP | Có trong Settings | **[CẦN QUYẾT ĐỊNH]** |

## 10. Nghiệm thu

- [ ] Mọi trạng thái trong bảng ở mục 1 đúng như prototype, ở cả light và dark.
- [ ] Logic banner pass toàn bộ test port từ `prayer.test.ts`.
- [ ] Giờ cầu nguyện khớp lịch chính thức ở 5 thành phố mẫu trong ±2 phút.
- [ ] Adhan kêu đúng giờ trên ≥95% máy test (Samsung, Xiaomi, Oppo, Vivo, iPhone), kể cả sau khởi động lại và đổi múi giờ.
- [ ] Văn bản Arabic khớp 100% nguồn (so tự động).
- [ ] Không hardcode màu, kích thước; chuỗi nằm trong i18n.
- [ ] License và người review đã duyệt (Q-01 đến Q-04).
