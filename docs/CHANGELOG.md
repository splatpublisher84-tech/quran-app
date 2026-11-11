# Changelog

Newest first. One line per behaviour change.

- 2026-11-10: M3 prayer times and Home. Home shows the six prayer banners, a Hijri date (Umm al-Qura, rolls at Maghrib), the prayer timeline, and a warning when times are estimated from the time zone.
- 2026-11-10: Quran index. Saved is a heart on the header. Surah and Juz sit above Continue reading, with radius-m corners.
- 2026-11-09: M2 reader. Quran tab lists Surah, Juz and Saved, searches by name or `2:255`, and opens a reader with translation, footnotes, Arabic size, Urdu RTL and saved ayahs. Share on an ayah shows a notice until the share sheet exists.
- 2026-11-08: M1.5 text. Text styles follow the handoff table (UI Onest, Literata reading, Amiri Arabic, Urdu Nastaliq font). Icon button gains plain, filled, outline and glass variants. Visual change: UI heading sizes now match the prototype (34, 22, 17 pt).
- 2026-11-08: M1.5 colors. `AppColors` now uses the handoff semantic tokens (light and dark), incl. group, toast, dialog, card gradient and share colors. Visual change: tab bar selected icon is text/primary (not brand green), surface and background roles swapped to match the prototype.
- 2026-11-08: Plan integrated with `dev-handoff/`. Scope: no city picker, Adhan clip max 5 seconds, Quran translations EN/ID/UR/TR (VI dropped), home widget and paywall (stub, Premium only removes ads and the share watermark) and ads added to v1 (no ads on screens that show translation, none near prayer times), prayed list resets at Fajr, token refactor (M1.5) before M2. Milestones renumbered: M8 widget, M9 paywall and ads, M10 polish.

- 2026-11-06: M1 core. Light and dark theme tokens, shared widgets, slang i18n (en, vi, id), 4 tab shell with onboarding redirect, typed Failure and Result.
- 2026-11-05: M0 scaffold. Dev and prod flavors (entry points, Android product flavors, iOS schemes), placeholder app shell, architecture and design value tests.
