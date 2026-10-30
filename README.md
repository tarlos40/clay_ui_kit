# 🧱 Clay UI Kit

A customizable Flutter component library inspired by **Claymorphism**. It provides themed surfaces, form controls, data display, feedback, and layout/navigation widgets for building consistent application interfaces.

- Documentation: https://clayuikit.vercel.app/
- GitHub: https://github.com/tarlos40/clay_ui_kit
- Pub.dev: https://pub.dev/packages/clay_ui_kit

## ✨ Features

- 🎨 Claymorphism-inspired design system
- 🧩 Reusable UI components for product interfaces
- 🌈 Customizable themes, colors and surfaces
- 🌓 Support for light and dark visual modes
- 📱 Layout, navigation, form, feedback, and data-display components
- 📖 Component and foundation documentation with examples and property references
- 🧩 Integrates with Flutter widgets and third-party icon libraries

## 📦 Installation

Install the latest published version:

```bash
flutter pub add clay_ui_kit
```

Or add it manually to your `pubspec.yaml`:

```yaml
dependencies:
  clay_ui_kit: ^1.0.3
```

Fetch dependencies after editing the manifest:

```bash
flutter pub get
```

## 🚀 Quick Start

Import the package:

```dart
import 'package:clay_ui_kit/clay_ui_kit.dart';
```

`ClayApp` installs the Clay theme in the widget tree. Provide a `ClayThemeData` seed palette, then use Clay components inside the app:

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
      title: 'Example App',
      clayThemeData: ClayThemeData(
        seedColor: ClayColors.cobalt,
      ),
      debugShowCheckedModeBanner: false,
      home: ClayScaffold(
        clayAppBar: const ClayAppBar(title: 'Welcome'),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ClayInput(
                label: 'Email',
                hintText: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              ClayButton.primary(
                'Continue',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🎨 Themes And Palettes

`ClayThemeData` generates semantic color tokens from a `ClayPalette`. Set `isDark` to use the dark color scheme, or create a new configuration with `copyWith` when the app theme changes.

```dart
ClayThemeData(
  seedColor: ClayColors.forest,
  isDark: true,
)
```

Available palettes include `aqua`, `sky`, `ocean`, `cobalt`, `violet`, `mint`, `forest`, `amber`, `coral`, `ruby`, `rose`, `cloud`, and more. Each palette exposes color steps from `s50` through `s950`.

Read the active theme from any descendant widget with `context.clayTheme`:

```dart
final theme = context.clayTheme;

Container(
  color: theme.container,
  child: Text(
    'Theme-aware content',
    style: TextStyle(color: theme.onContainer),
  ),
)
```

Prefer semantic tokens such as `primary`, `background`, `container`, `onContainer`, `success`, and `error` over fixed colors when building custom widgets.

## 🧭 Screen Composition

`ClayScaffold` composes the page body with optional app bar, drawer, tabs, bottom navigation, floating action button, scroll view, and pull-to-refresh behavior. Pass an existing scrollable widget as `body`, or set `useScrollView: true` for regular content that should scroll as one page.

```dart
ClayScaffold(
  clayAppBar: Builder(
    builder: (context) => ClayAppBar(
      title: 'Workspace',
      leading: ClayDrawer.menuButton(context),
    ),
  ),
  clayDrawer: ClayDrawer(
    children: [
      ClayDrawer.title('Workspace'),
      ClayDrawer.action(
        icon: const Icon(Icons.home_outlined),
        label: 'Home',
        selected: true,
        onPressed: () {},
      ),
    ],
  ),
  body: const Center(child: Text('Page content')),
)
```

For pull-to-refresh, provide both `useRefreshIndicator: true` and `onRefresh`. The scaffold also supports animated app bar, tabs, and navigation bar visibility while scrolling.

### Tabs

`ClayTabs` supports pills, underline, and segmented styles. Each `ClayTabItem` has a label and child; optional icons, badges, and disabled states are supported. By default, the widget manages selection and displays the selected child:

```dart
ClayTabs(
  style: ClayTabsStyle.segmented,
  tabs: const [
    ClayTabItem(
      label: 'Overview',
      icon: Icon(Icons.dashboard_outlined),
      child: Center(child: Text('Overview content')),
    ),
    ClayTabItem(
      label: 'Activity',
      icon: Icon(Icons.history_rounded),
      child: Center(child: Text('Activity content')),
    ),
  ],
)
```

Set `showContent: false` when the app supplies the page body separately, for example with an `IndexedStack`. In controlled mode, pass `index` and update it from `onChanged`. Swipe gestures are enabled by default and can be disabled with `swipeable: false`.

## 📝 Forms And Feedback

`ClayInput` accepts a controller or focus node, validation and helper text, icons, password visibility, and single- or multi-line input. `ClayInput.search` adds query callbacks, suggestions, and search submission controls.

```dart
ClayInput(
  label: 'Password',
  hintText: 'Enter your password',
  password: true,
  helperText: 'Use at least 8 characters.',
  onChanged: (value) {},
  onSubmitted: (value) {},
)
```

Additional form controls include checkboxes, radio buttons, sliders, switches, and date picking. Use `ClayToast`, feedback widgets, dialogs, sheets, or tooltips to communicate status and actions. Pass your own `TextEditingController` or `FocusNode` when the application needs to manage field state externally; otherwise, the input owns and disposes its internal state.

## 🧩 Component Catalog

All public APIs are available from one import:

```dart
import 'package:clay_ui_kit/clay_ui_kit.dart';
```

- **Foundations:** palettes and color tokens, typography, containers, shadows, themes, scaffold, and refresh indicator.
- **Layout and navigation:** `ClayAppBar`, `ClayDrawer`, `ClayScaffold`, `ClayTabs`, `ClayNavigationBar`, and `ClayFloatingActionButton`.
- **Actions and forms:** buttons, inputs and search, checkboxes, radio buttons, sliders, switches, date picker, and file upload.
- **Content and data:** text, cards, avatars, badges, breadcrumbs, menus, tables, pagination, carousels, and accordions.
- **Feedback and utilities:** toast, feedback indicators, loading, progress, skeletons, modal, sheet, tooltip, and showcase.

The [online documentation](https://clayuikit.vercel.app/) includes dedicated pages for the foundations and components, with examples, previews, and property references.

## 📋 Requirements

- Flutter SDK
- Dart SDK compatible with the package constraint `^3.13.4`

## 📄 License

See the [LICENSE](LICENSE) file for license information.

---

**Clay UI Kit**

_Soft surfaces. Thoughtful details. Better interfaces._
