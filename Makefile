.PHONY: analyze test format gen clean run-dev run-prod check

analyze:
	flutter analyze

test:
	flutter test

format:
	dart format lib test

gen:
	dart run build_runner build --delete-conflicting-outputs

clean:
	flutter clean

run-dev:
	flutter run --flavor dev -t lib/main_dev.dart

run-prod:
	flutter run --flavor prod -t lib/main_prod.dart

# Mirrors the "before you call something done" checklist.
check: analyze test
	dart format --set-exit-if-changed lib test
