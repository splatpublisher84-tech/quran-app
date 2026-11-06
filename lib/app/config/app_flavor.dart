/// Build flavors. Each value maps to an Android product flavor, an iOS
/// scheme (`dev` / `prod`) and an entry point (`main_dev.dart` / `main_prod.dart`).
enum AppFlavor {
  dev,
  prod;

  String get nativeName => name;
}
