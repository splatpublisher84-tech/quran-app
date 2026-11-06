# Design tokens

Created: 2026-11-06 · Last modified: 2026-11-06

> Sinh tự động từ `03-design/tokens/*.json` bằng `npm run export:handoff` trong `prototype/`. Không sửa tay: sửa file nguồn rồi chạy lại.

Toàn bộ token của app. File JSON gốc nằm ở `03-design/tokens/`; file này chỉ để đọc. Đơn vị là pt trên màn chuẩn 393×852. Mặc định là light mode, mọi màn phải đúng ở cả dark mode.

## Màu

| Token | Light | Dark | Dùng cho |
|---|---|---|---|
| `background/default` | `#FFFFFF` | `#43403B` | Nền card, ô nhập, tab bar |
| `background/surface` | `#FBF9F4` | `#15120D` | Nền màn hình |
| `background/elevated` | `#F1EFEA` | `#84827D` | Nền nhóm cài đặt, nút phụ (light) |
| `background/overlay` | `#15120D` | `#15120D` | Lớp phủ sau sheet |
| `text/primary` | `#15120D` | `#FFFFFF` | Chữ chính |
| `text/secondary` | `#84827D` | `#CECBC6` | Chữ phụ, giờ, icon chưa chọn |
| `text/tertiary` | `#B3B1AC` | `#B3B1AC` |  |
| `text/disabled` | `#CECBC6` | `#84827D` |  |
| `text/inverse` | `#FFFFFF` | `#15120D` | Chữ trên nút chính |
| `border/default` | `#E5E3DD` | `#84827D` | Viền, đường timeline |
| `border/subtle` | `#EDEDED` | `#84827D` | Đường kẻ giữa các hàng |
| `button/primary` | `#1F5E4E` | `#6FB39B` | Nút chính (CTA), switch bật, dấu chọn |
| `button/primary-disabled` | `#CECBC6` | `#B3B1AC` | Nút chính khi tắt, switch tắt |
| `button/secondary` | `#F1EFEA` | `#84827D` |  |
| `button/secondary-border` | `#E5E3DD` | `#84827D` |  |
| `button/icon-button` | `#84827D` | `#EDEDED` |  |
| `button/primary-pressed` | `#184A3E` | `#8CC5B0` | Nút chính khi nhấn |
| `status/success` | `#009951` | `#00C464` | Báo thành công, la bàn đúng hướng. Không dùng màu nút chính cho việc này |
| `status/error` | `#C00F0C` | `#FF4444` |  |
| `status/warning` | `#E5A000` | `#FFB020` |  |
| `status/success-surface` | `#009951` | `#00C464` |  |
| `status/error-surface` | `#C00F0C` | `#FF4444` |  |
| `status/warning-surface` | `#E5A000` | `#FFB020` |  |
| `input/background` | `#FFFFFF` | `#43403B` |  |
| `input/border-default` | `#E5E3DD` | `#84827D` |  |
| `input/border-focus` | `#15120D` | `#FFFFFF` |  |
| `input/placeholder` | `#B3B1AC` | `#B3B1AC` |  |
| `brand/default` | `#1F5E4E` | `#6FB39B` | Banner “It’s time” |
| `brand/soft` | `#E1ECE6` | `#1E3A31` | Hàng salah đang trong giờ, thanh Listen, ayah đang chọn, Continue reading |
| `accent/default` | `#8A6128` | `#D8B26A` | Ngày Hijri, số ayah, tên Arabic, họa tiết, viền banner “Còn giờ” |

Màu primitive (token semantic ở trên trỏ tới các giá trị này):

| Tên | Giá trị |
|---|---|
| `Neutral/100` | `#15120D` |
| `Neutral/200` | `#43403B` |
| `Neutral/300` | `#84827D` |
| `Neutral/400` | `#B3B1AC` |
| `Neutral/350` | `#84827D` |
| `Neutral/500` | `#CECBC6` |
| `Neutral/600` | `#E5E3DD` |
| `Neutral/700` | `#F1EFEA` |
| `Status/green` | `#009951` |
| `Status/red` | `#C00F0C` |
| `Status/yellow` | `#E5A000` |
| `Neutral/800` | `#FBF9F4` |
| `Neutral/1000` | `#FFFFFF` |
| `Neutral/900` | `#EDEDED` |
| `Neutral/100-overlay` | `#15120D` |
| `Status/green-sf` | `#009951` |
| `Status/red-sf` | `#C00F0C` |
| `Status/yellow-sf` | `#E5A000` |
| `Status/light-green` | `#00C464` |
| `Status/light-red` | `#FF4444` |
| `Status/light-yellow` | `#FFB020` |
| `Status/light-green-sf` | `#00C464` |
| `Status/light-red-sf` | `#FF4444` |
| `Status/light-yellow-sf` | `#FFB020` |
| `Brand/700` | `#1F5E4E` |
| `Brand/800` | `#184A3E` |
| `Brand/300` | `#6FB39B` |
| `Brand/200` | `#8CC5B0` |
| `Brand/soft-light` | `#E1ECE6` |
| `Brand/soft-dark` | `#1E3A31` |
| `Accent/600` | `#8A6128` |
| `Accent/300` | `#D8B26A` |

## Font

| Vai trò | Font |
|---|---|
| Giao diện | Onest |
| Bản dịch Quran | Literata |
| Văn bản Arabic | Amiri (tạm thời, chờ font Uthmani có license) |

Bản dịch có chữ ngoài Latin dùng font riêng theo ngôn ngữ. Mặc định Literata, ltr, line height 150%:

| Ngôn ngữ | Font | Hướng | Line height |
|---|---|---|---|
| `ur` | Noto Nastaliq Urdu | rtl | 220% |
| `fa` | Noto Naskh Arabic | rtl | 180% |
| `bn` | Noto Serif Bengali | ltr | 160% |
| `hi` | Noto Serif Devanagari | ltr | 160% |
| `ta` | Noto Serif Tamil | ltr | 160% |
| `th` | Noto Serif Thai | ltr | 160% |
| `zh` | Noto Serif SC | ltr | 160% |
| `ja` | Noto Serif JP | ltr | 160% |
| `ko` | Noto Serif KR | ltr | 160% |

## Kiểu chữ

Line height để trống là mặc định của font.

| Style | Font | Weight | Size | Line height | Letter spacing | Case | Dùng cho |
|---|---|---|---|---|---|---|---|
| `UI/heading/large` | Onest | SemiBold | 34 |  | 0.4px |  | Giao diện |
| `UI/heading/medium` | Onest | SemiBold | 22 |  | 0.4px |  | Giao diện |
| `UI/heading/small` | Onest | SemiBold | 17 |  | 0 |  | Giao diện |
| `UI/body/regular` | Onest | Regular | 17 |  | 0.4px |  | Giao diện |
| `UI/body/emphasized` | Onest | SemiBold | 17 |  | -0.4px |  | Giao diện |
| `UI/label/regular` | Onest | Regular | 15 |  | -0.4px |  | Giao diện |
| `UI/label/emphasized` | Onest | SemiBold | 15 |  | 0 |  | Giao diện |
| `UI/footnote/default` | Onest | Regular | 13 |  | 0 |  | Giao diện |
| `UI/footnote/uppercase` | Onest | Medium | 13 |  | 0.6px | IN HOA | Giao diện |
| `UI/caption/regular` | Onest | Regular | 12 |  | -0.4px |  | Giao diện |
| `UI/caption/Emphasized` | Onest | SemiBold | 12 |  | -0.4px |  | Giao diện |
| `UI/button/large` | Onest | SemiBold | 17 |  | 0.4px |  | Giao diện |
| `UI/button/medium` | Onest | SemiBold | 15 |  | 0 |  | Giao diện |
| `reading/sans/small` | Onest | Regular | 17 |  | 0 |  | Chưa dùng ở v1 |
| `reading/sans/small-bold` | Onest | Bold | 17 |  | 0 |  | Chưa dùng ở v1 |
| `reading/sans/medium` | Onest | Regular | 20 |  | 0 |  | Chưa dùng ở v1 |
| `reading/sans/medium-bold` | Onest | Bold | 20 |  | 0 |  | Chưa dùng ở v1 |
| `reading/sans/large` | Onest | Regular | 24 |  | 0 |  | Chưa dùng ở v1 |
| `reading/sans/large-bold` | Onest | Bold | 24 |  | 0 |  | Chưa dùng ở v1 |
| `reading/serif/small` | Literata | Regular | 17 |  | 0 |  | Bản dịch Quran (nhỏ, vừa, lớn) |
| `reading/serif/small-bold` | Literata | Bold | 17 |  | 0 |  | Bản dịch Quran (nhỏ, vừa, lớn) |
| `reading/serif/medium` | Literata | Regular | 20 |  | 0 |  | Bản dịch Quran (nhỏ, vừa, lớn) |
| `reading/serif/medium-bold` | Literata | Bold | 20 |  | 0 |  | Bản dịch Quran (nhỏ, vừa, lớn) |
| `reading/serif/large` | Literata | Regular | 24 |  | 0 |  | Bản dịch Quran (nhỏ, vừa, lớn) |
| `reading/serif/large-bold` | Literata | Bold | 24 |  | 0 |  | Bản dịch Quran (nhỏ, vừa, lớn) |
| `arabic/reader/small` | Amiri | Regular | 24 | 190% | 0 |  | Văn bản Arabic |
| `arabic/reader/medium` | Amiri | Regular | 28 | 190% | 0 |  | Văn bản Arabic |
| `arabic/reader/large` | Amiri | Regular | 34 | 190% | 0 |  | Văn bản Arabic |
| `arabic/card` | Amiri | Regular | 32 | 190% | 0 |  | Văn bản Arabic |
| `arabic/basmala` | Amiri | Regular | 26 | 190% | 0 |  | Văn bản Arabic |
| `arabic/label` | Amiri | Regular | 17 | 130% | 0 |  | Văn bản Arabic |

## Spacing

| Token | pt |
|---|---|
| `Space/0` | 0 |
| `Space/100` | 4 |
| `Space/150` | 6 |
| `Space/200` | 8 |
| `Space/300` | 12 |
| `Space/400` | 16 |
| `Space/600` | 24 |
| `Space/800` | 32 |
| `Space/1200` | 48 |
| `Space/1600` | 64 |
| `Space/2400` | 96 |
| `Space/4000` | 160 |
| `Space/050` | 2 |

## Radius

| Token | pt |
|---|---|
| `radius-none` | 0 |
| `radius-xs` | 4 |
| `radius-s` | 8 |
| `radius-m` | 12 |
| `radius-l` | 16 |
| `radius-xl` | 20 |
| `radius-round` | 999 |
| `radius-xxl` | 24 |

## Token tạm (chưa có trong JSON)

Prototype đang dùng thêm các giá trị dưới đây. Chưa chốt có đưa vào bộ token chính không.

```css
:root {
  --group-bg: var(--background-elevated);
  --segment-on: var(--background-default);
  --toast-bg: var(--background-elevated);
  --dialog-bg: rgba(245, 245, 245, .94);
  --card-text: #fbf9f4;
  --card-gradient: linear-gradient(165deg, #0f3b31 0%, #1f5e4e 62%, #2c6f5c 100%);
}
[data-theme="dark"] {
  --group-bg: var(--background-default);
  --segment-on: var(--background-surface);
  --toast-bg: var(--background-default);
  --dialog-bg: rgba(52, 50, 46, .94);
}
```
