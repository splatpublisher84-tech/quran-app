# Progress

Tick items as they are done. Milestones follow the plan in order. Full plan and per step details: `docs/PLAN.md`.

Status: M0 and M1 done. Next: M2 (Quran data and reader).

## M0. Scaffold và công cụ

- [x] M0.1 Create project at `~/projects/6apps/quran/quran_app`, `git init`, flutter create (ios, android)
- [x] M0.2 Main and dev dependencies, `pub get`
- [x] M0.3 Flavors dev and prod: Android product flavors, iOS schemes, `main_dev.dart`, `main_prod.dart`, `AppConfig`, `AppFlavor`
- [x] M0.4 `analysis_options.yaml`, `build.yaml`, `Makefile`
- [x] M0.5 Architecture test (import scan), design value test (raw Color and EdgeInsets)
- [x] M0.6 `CLAUDE.md`, `docs/PROGRESS.md`, `docs/CHANGELOG.md`

DoD: app builds for two flavors, architecture tests pass on an empty shell.

## M1. Core, design system, shell

- [x] 1. Infrastructure providers (config, prefs, clock, dio). Drift database deferred to M2.
- [x] 2. Bootstrap with prefs and config overrides
- [x] 3. `core/error` (Failure, AppException, Result)
- [x] 4. Design tokens (light and dark), fonts (Onest, Literata, Amiri)
- [x] 5. i18n with slang (en, vi, id)
- [x] 6. Shared widgets
- [x] 7. Router with 4 tabs and onboarding redirect
- [x] 8. Widget and smoke tests for shell, tab bar and both themes (no golden image tests, smoke tests cover light and dark)

## M2 to M8

- [ ] M2. Quran data and reader
- [ ] M3. Prayer times and Home
- [ ] M4. Onboarding and prayer alerts
- [ ] M5. Pray flow and Qibla
- [ ] M6. Daily ayahs and share
- [ ] M7. Settings
- [ ] M8. Polish
