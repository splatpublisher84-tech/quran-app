# Copy

Created: 2026-11-06 · Last modified: 2026-11-06

> Sinh tự động từ các file `.tsx` trong `prototype/src/` (bỏ `shell/`) bằng `npm run export:handoff` trong `prototype/`. Không sửa tay: sửa file nguồn rồi chạy lại.

Bản nháp tiếng Anh, chưa qua review. Khi code, đưa vào `assets/i18n/*.json` theo cách Bible làm. Không dùng em dash. `${...}` là biến (tên salah, giờ, thời lượng...).

Danh sách trích tự động từ code nên có thể lẫn vài chuỗi không hiển thị, hoặc thiếu chuỗi được ghép từ nhiều phần. Khi nghi ngờ, mở đúng màn trên prototype để đối chiếu.

## `App.tsx`

- : top ?
- “Quran” Would Like to Send You Notifications
- Prayer alerts and daily ayahs. You can change this in Settings.
- Don’t Allow
- Allow
- Alerts are off. Turn them on from Home
- Prayer alerts are on

## `features/TabBar.tsx`

- Home
- Quran
- Ayah of the day
- Settings
- Tabs

## `features/ayah/AyahScreen.tsx`

- That’s today’s three
- New ayahs after Fajr tomorrow.
- Read the Quran
- Tap to reveal
- Open in Quran
- Today’s ayahs
- Share

## `features/home/EventCards.tsx`

- Read Surah Al-Kahf
- A Friday tradition · 110 ayahs
- Share an Eid greeting
- With today’s ayahs
- Tap to reveal

## `features/home/NotificationsStrip.tsx`

- Prayer alerts are off
- Turn on

## `features/home/PrayerTimeline.tsx`

- Iftar
- + Tarawih
- Adhan voice and all alerts
- ${prayerName(id, scenario)} alert: ${ALERT_META[alert].label}
- All five set to ${ALERT_META[state.alerts[editing]].label}

## `features/home/StatusBanner.tsx`

- It’s time
- Pray
- I’ve prayed
- Next prayer
- Undo
- Suhoor ends in
- Finish eating by Imsak
- Fasting · Iftar in
- Break your fast at Maghrib
- Next Imsak in
- Suhoor before dawn
- ${name} marked as prayed

## `features/onboarding/OnboardingFlow.tsx`

- Prayer times, the Quran, and three ayahs a day
- Quiet by design. No ads during prayer or reading.
- Get started
- Prayer times for your city
- Your location stays on this device. We only use it to calculate prayer times.
- Use my location
- Choose a city instead
- Never miss a prayer time
- Turn on prayer alerts
- Not now
- Allow “Quran” to use your location?
- Used to calculate prayer times and the Qibla direction.
- Don’t Allow
- Allow While Using

## `features/pray/Compass.tsx`

- Drag the ring to simulate turning your phone
- Phone direction

## `features/pray/PrayScreen.tsx`

- Listen
- Done
- Undo
- Close
- Surah
- ${name} marked as prayed

## `features/quran/QuranScreen.tsx`

- Loading
- Continue reading
- No surah found
- No saved ayahs yet
- Tap an ayah while reading, then Save.
- Quran
- Saved ayahs
- Surah name or 2:255
- Search
- Clear
- Browse
- Surah
- Juz
- Saved

## `features/quran/ReaderScreen.tsx`

- Share
- Translation language
- Text size
- Ayah ${refKey(selected)}
- Close
- Translator’s note
- Arabic text size
- Small
- Medium
- Large

## `features/settings/AlertsScreen.tsx`

- Notifications are off for this app.
- Turn on
- Prayer alerts
- All five
- Each prayer
- ${prayerName(p, scenario)} alert
- Adhan voice

## `features/settings/SettingsScreen.tsx`

- Settings
- Prayer times
- Location
- Calculation
- Asr time
- Hijri date
- Notifications
- Prayer alerts
- Daily ayahs
- Pause prayer prompts
- Hides Pray and alerts for a while
- Quran
- Translation
- Arabic text size
- Appearance
- Rate us
- Sources and licenses
- Privacy Policy
- Terms of Use
- Opens the store review prompt
- Opens Privacy Policy
- Opens Terms of Use

## `features/settings/SourcesScreen.tsx`

- Translations are shown as published, without changes.
- Sources and licenses
- Translations · QuranEnc.com
- Version ${t.version}
- Icons and fonts
- Material Symbols Rounded
- Google, Apache 2.0
- Onest, Literata, Amiri
- SIL Open Font License

## `features/share/ShareSheet.tsx`

- App name
- Hide App name watermark
- PREMIUM
- Gradient
- Solid
- Pattern
- Night
- Instagram
- Facebook
- X
- Messages
- More
- Share ayah
- Close
- Hide watermark
- Opens ${t.label}
- Opens the paywall

## `store.tsx`

- Partial
- Adhan
- Plays the full call to prayer
- Notify
- A banner with a short sound
- Off
- No alert. The time still shows here

## `ui/index.tsx`

- Back
- Close
