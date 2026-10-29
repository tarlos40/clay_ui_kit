# 🧱 Clay UI Kit

A modern Flutter UI library inspired by the **Claymorphism** design style, focused on creating beautiful, consistent, and customizable user interfaces.

- GitHub: https://github.com/tarlos40/clay_ui_kit
- Pub.dev: https://pub.dev/packages/clay_ui_kit

## ✨ Features

- 🎨 Claymorphism-inspired design system
- 🧩 Reusable UI components for product interfaces
- 🌈 Customizable themes, colors and surfaces
- 🌓 Support for light and dark visual modes
- 📱 Ready for modern Flutter apps and prototypes
- ⚡ Easy to extend and integrate into design systems

## 📦 Installation

Add the package to your Flutter project:

```bash
flutter pub add clay_ui_kit
```

Or add it manually to your `pubspec.yaml`:

```yaml
dependencies:
  clay_ui_kit: ^1.0.2
```

Then sync dependencies:

```bash
flutter pub get
```

## 🚀 Basic usage

Import the package:

```dart
import 'package:clay_ui_kit/clay_ui_kit.dart';
```

Create a simple button and theme usage:

```dart
import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClayApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ClayButton.primary(
            'Continue',
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
```

## 🧩 API overview

The package exposes a unified setup for components and styling, for example:

```dart
ClayButton.primary('Primary', onPressed: () {});
ClayButton.secondary('Secondary', onPressed: () {});
ClayButton.success('Success', onPressed: () {});
ClayButton.error('Error', onPressed: () {});

ClayInput(
  label: 'Email',
  hintText: 'you@example.com',
);

ClayToast.success('Saved successfully');
```

You can also use the theme system directly:

```dart
final theme = context.clayTheme;
```

## 📋 Requirements

- Flutter SDK
- Dart SDK

## 📄 License

See the [LICENSE](LICENSE) file for license information.

---

**Clay UI Kit**

*Soft surfaces. Thoughtful details. Better interfaces.*