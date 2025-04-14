# Multi Language App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter application with multi-language support, created using Very Good CLI.

## Screenshots 📱

<p align="center">
  <img src="assets/screenshots/Simulator Screenshot 1.png" width="200" alt="Screenshot 1">
  <img src="assets/screenshots/Simulator Screenshot 2.png" width="200" alt="Screenshot 2">
  <img src="assets/screenshots/Simulator Screenshot 3.png" width="200" alt="Screenshot 3">
  <img src="assets/screenshots/Simulator Screenshot 4.png" width="200" alt="Screenshot 4">
</p>

## Project Setup 🚀

### Prerequisites
- Flutter SDK (version ^3.5.0)
- Dart SDK (version ^3.5.0)
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/multi_language_app.git
   cd multi_language_app
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Run the app in your preferred flavor:
   ```sh
   # Development
   flutter run --flavor development --target lib/main_development.dart

   # Staging
   flutter run --flavor staging --target lib/main_staging.dart

   # Production
   flutter run --flavor production --target lib/main_production.dart
   ```

## Key Features ✨

- **Multi-language Support**: Includes English, Spanish, and Bengali translations
- **Language Switching**: Users can switch between languages at runtime
- **Splash Screen**: Custom splash screen implementation
- **Flavor Configuration**: Separate development, staging, and production environments
- **BLoC Pattern**: State management using the BLoC architecture
- **Persistent Settings**: User language preferences saved using Hive
- **Cross-platform**: Works on iOS, Android, Web, and Windows

## Architecture & Design 🏗️

The app follows a clean architecture approach with:
- **BLoC Pattern**: For state management
- **Repository Pattern**: For data access
- **Dependency Injection**: For loose coupling between components
- **Feature-first Organization**: Code organized by feature rather than type

## Testing 🧪

Run tests with:
```sh
flutter test --coverage --test-randomize-ordering-seed random
```

View coverage report:
```sh
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

## Limitations & Assumptions 🔍

- **Minimum OS Versions**: iOS 12+, Android API 21+
- **Internet Connection**: Some features may require internet connectivity
- **Device Compatibility**: Optimized for phones and tablets, limited testing on web/desktop
- **RTL Languages**: Basic RTL support, but may need additional testing for perfect layout

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:multi_language_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
