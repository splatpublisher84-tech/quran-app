# Icon và asset

Created: 2026-11-06 · Last modified: 2026-11-06

> Sinh tự động từ `prototype/public/assets/` bằng `npm run export:handoff` trong `prototype/`. Không sửa tay: sửa file nguồn rồi chạy lại.

Bộ icon: Material Symbols Rounded, weight 400 (Apache-2.0). Trong Flutter dùng package `material_symbols_icons`. Tên trong bảng là tên Material Symbols; `-fill` là bản đặc, dùng cho trạng thái đang chọn. Các icon `share-*` lấy từ Bible (`assets/icons/32px/`), không phải Material.

Một số tên xuất hiện trong code dưới dạng ghép chuỗi (ví dụ tab bar dùng `${icon}-fill` khi đang chọn), nên cột "Dùng ở" có thể thiếu file.

| Icon | Dùng ở |
|---|---|
| `amp_stories` | `features/TabBar.tsx`, `features/home/EventCards.tsx`, `features/settings/SettingsScreen.tsx` |
| `amp_stories-fill` | Tab bar, khi đang chọn |
| `arrow_back` | `ui/index.tsx` |
| `battery_alert` | Chưa dùng, có sẵn để dùng sau |
| `bedtime` | Chưa dùng, có sẵn để dùng sau |
| `book_5` | `features/TabBar.tsx`, `features/home/EventCards.tsx` |
| `book_5-fill` | `features/quran/QuranScreen.tsx` |
| `bookmark` | Chưa dùng, có sẵn để dùng sau |
| `calculate` | `features/settings/SettingsScreen.tsx` |
| `calendar_month` | `features/settings/SettingsScreen.tsx` |
| `chat_bubble` | Chưa dùng, có sẵn để dùng sau |
| `check` | `features/home/PrayerTimeline.tsx`, `ui/index.tsx` |
| `check_circle-fill` | Chưa dùng, có sẵn để dùng sau |
| `chevron_right` | `features/home/EventCards.tsx`, `features/home/PrayerTimeline.tsx`, `features/quran/QuranScreen.tsx`, `shell/ReviewPanel.tsx`, `ui/index.tsx` |
| `close` | `features/pray/PrayScreen.tsx`, `features/quran/QuranScreen.tsx`, `features/quran/ReaderScreen.tsx`, `features/share/ShareSheet.tsx`, `ui/index.tsx` |
| `contrast` | `features/settings/SettingsScreen.tsx` |
| `dark_mode` | Chưa dùng, có sẵn để dùng sau |
| `description` | `features/settings/SettingsScreen.tsx` |
| `do_not_disturb_on` | Chưa dùng, có sẵn để dùng sau |
| `explore` | Chưa dùng, có sẵn để dùng sau |
| `favorite` | `features/quran/QuranScreen.tsx` |
| `favorite-fill` | `features/quran/ReaderScreen.tsx`, `store.tsx` |
| `format_quote-fill` | Chưa dùng, có sẵn để dùng sau |
| `history` | Chưa dùng, có sẵn để dùng sau |
| `home` | `features/TabBar.tsx` |
| `home-fill` | Tab bar, khi đang chọn |
| `info` | Chưa dùng, có sẵn để dùng sau |
| `ios_share` | `features/ayah/AyahScreen.tsx`, `features/quran/ReaderScreen.tsx` |
| `keyboard_arrow_down` | Chưa dùng, có sẵn để dùng sau |
| `library_books` | `features/settings/SettingsScreen.tsx` |
| `location_on` | `features/home/HomeScreen.tsx`, `features/onboarding/OnboardingFlow.tsx`, `features/settings/SettingsScreen.tsx` |
| `more_horiz` | Chưa dùng, có sẵn để dùng sau |
| `more_vert` | Chưa dùng, có sẵn để dùng sau |
| `mosque` | Chưa dùng, có sẵn để dùng sau |
| `my_location` | `features/onboarding/OnboardingFlow.tsx` |
| `nightlight` | `features/home/EventCards.tsx` |
| `notifications` | `features/settings/SettingsScreen.tsx`, `store.tsx` |
| `notifications-fill` | `App.tsx` |
| `notifications_active` | Chưa dùng, có sẵn để dùng sau |
| `notifications_off` | `features/home/NotificationsStrip.tsx`, `store.tsx` |
| `open_in_new` | `features/quran/QuranScreen.tsx` |
| `pause-fill` | Chưa dùng, có sẵn để dùng sau |
| `pause_circle` | `features/settings/SettingsScreen.tsx` |
| `play_arrow-fill` | Chưa dùng, có sẵn để dùng sau |
| `policy` | `features/settings/SettingsScreen.tsx` |
| `record_voice_over` | `features/settings/AlertsScreen.tsx` |
| `restart_alt` | Chưa dùng, có sẵn để dùng sau |
| `schedule` | `features/settings/SettingsScreen.tsx` |
| `science` | Chưa dùng, có sẵn để dùng sau |
| `search` | `features/quran/QuranScreen.tsx` |
| `settings` | `features/TabBar.tsx` |
| `settings-fill` | Tab bar, khi đang chọn |
| `share-facebook` | `features/share/ShareSheet.tsx` |
| `share-instagram` | `features/share/ShareSheet.tsx` |
| `share-messages` | `features/share/ShareSheet.tsx` |
| `share-more` | `features/share/ShareSheet.tsx` |
| `share-x` | `features/share/ShareSheet.tsx` |
| `signal_cellular_alt` | `shell/PhoneFrame.tsx` |
| `stacks` | Chưa dùng, có sẵn để dùng sau |
| `star` | `features/settings/SettingsScreen.tsx` |
| `swipe` | Chưa dùng, có sẵn để dùng sau |
| `text_fields` | `features/quran/ReaderScreen.tsx`, `features/settings/SettingsScreen.tsx` |
| `translate` | `features/settings/SettingsScreen.tsx` |
| `volume_off` | Chưa dùng, có sẵn để dùng sau |
| `volume_up` | `features/onboarding/OnboardingFlow.tsx`, `store.tsx` |
| `volume_up-fill` | Chưa dùng, có sẵn để dùng sau |
| `wb_twilight` | Chưa dùng, có sẵn để dùng sau |
| `wifi` | `shell/PhoneFrame.tsx` |

Đè file cùng tên là prototype đổi theo, không cần sửa code.

| Folder | Nội dung | Ghi chú |
|---|---|---|
| `icons/` | Material Symbols Rounded, weight 400, license Apache 2.0 | `icons.json` liệt kê bộ đang dùng. Thêm tên vào đó rồi chạy `npm run sync`. Tên `-fill` là bản đặc, dùng cho trạng thái đang chọn |
| `icons/share-*.svg` | 5 icon share (Instagram, Facebook, X, Messages, More) | Chép từ Bible Widget, `assets/icons/32px/` |
| `patterns/star-grid.svg` | Họa tiết hình học trên thẻ ayah và nền share | Vẽ tạm, chờ feedback |
| `brand/seal.svg` | Ngôi sao 8 cánh trên thẻ úp và số surah | Vẽ tạm, chưa phải logo |

Chưa có: audio adhan, audio recitation, ảnh nền share dạng photo, logo app.

Dữ liệu Quran nằm ở `public/data/quran/`, tải từ QuranEnc bằng `npm run fetch:quran`.
