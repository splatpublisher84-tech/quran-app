# Quran App

Flutter app for iOS and Android. Offline first Quran reader, prayer times, Qibla, prayer alerts and daily ayahs. Light theme is the default.

## Read first

| File | What it owns |
|---|---|
| `docs/PLAN.md` | Full plan: decisions, architecture, steps and definition of done for M0 to M8. |
| `docs/PROGRESS.md` | Milestone checklist (tick as you go). |
| `docs/CHANGELOG.md` | One line per behaviour change, newest first. |

Code is the source of truth for behaviour. Changing behaviour requires a changelog line, not a doc rewrite.

## Hard rules

- **Never hardcode design values.** No raw hex colors, no numeric `EdgeInsets`, radius or text style outside `lib/core/design_system/`. Enforced by `test/architecture/design_value_test.dart`.
- **Offline first.** Quran data ships in `assets/data/quran/`. Every screen must render without network.
- **Light mode is the default.** Every screen must be correct in both themes.
- **No em dash** in any user facing string. Use a comma or a full stop.
- **No city picker.** Time and timezone come from the device through the injected `Clock`.
- **Everything that touches the platform sits behind an interface in `lib/core/platform/`** (location, notifications, compass, clock, audio) and is faked in tests.

## Architecture

```
lib/
  main_dev.dart  main_prod.dart  bootstrap.dart
  app/        app.dart  config/  router/
  core/       di/  error/  network/  storage/  platform/  design_system/  l10n/  utils/
  shared/widgets/
  features/<feature>/{domain,data,presentation,di}
```

- `domain`: pure Dart (freezed entities, repository interfaces, use cases). No Flutter, Riverpod, Dio or drift imports.
- `data`: datasources, DTOs, mappers, repository implementations.
- `presentation`: notifiers, screens, widgets. Uses use cases or repository interfaces through providers only. Never imports `data` or `di`.
- `di`: the only place that knows the implementation classes. Returns interfaces.
- A feature may import another feature's `domain` only.
- State: `flutter_riverpod` 3, hand written `Notifier` / `AsyncNotifier`. No `StateProvider`.
- The provider container is the only DI mechanism. No static holders.
- Entities and state use `freezed`. DTOs use `json_serializable`.

## Flavors

Two flavors, `dev` and `prod`.

```bash
make run-dev     # flutter run --flavor dev -t lib/main_dev.dart
make run-prod    # flutter run --flavor prod -t lib/main_prod.dart
```

Never edit a shared entry point to switch flavor. Use the matching `main_*.dart`.

## Commands

```bash
make analyze     # flutter analyze, must be clean
make test        # flutter test, must pass
make format      # dart format lib test
make gen         # build_runner (freezed, json, drift, slang)
make check       # analyze + test + format check
```

Run `make check` before calling a milestone done.
