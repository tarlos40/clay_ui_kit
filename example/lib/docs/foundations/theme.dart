import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc themeDocumentation = ComponentDoc(
  title: 'Theme',
  subtitle: 'Foundations',
  description: 'ClayThemeData creates the color tokens used throughout the interface. Configure a seed palette and a light or dark mode on ClayApp, then read the active tokens from BuildContext to keep custom widgets consistent.',
  showcases: [
    ClayShowcase(
      title: 'Configure the App Theme',
      description: 'ClayApp provides ClayThemeData to the widget tree. Changing isDark updates the generated surface and content colors while retaining the selected seed palette.',
      code: '''
ClayApp(
  title: 'My App',
  clayThemeData: ClayThemeData(
    seedColor: ClayColors.cobalt,
    isDark: false,
  ),
  home: const MyScreen(),
)
''',
      preview: const _ThemeTokensPreview(),
    ),
    ClayShowcase(
      title: 'Read Theme Tokens',
      description: 'Use context.clayTheme in a widget to access the active theme. Prefer semantic roles such as primary, background, and onContainer over hard-coded colors.',
      code: '''
final theme = context.clayTheme;

Container(
  color: theme.container,
  child: Text(
    'Theme-aware content',
    style: TextStyle(color: theme.onContainer),
  ),
)
''',
      preview: Builder(
        builder: (context) {
          final theme = context.clayTheme;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.container,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.border),
              boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 4),
            ),
            child: Text(
              'This surface reads container and onContainer from the active theme.',
              style: TextStyle(color: theme.onContainer),
            ),
          );
        },
      ),
    ),
    ClayShowcase(
      title: 'Switch Theme Mode',
      description: 'Use copyWith to create a theme configuration with a different mode or seed palette. Rebuild ClayApp with the returned value to apply the change.',
      code: '''
final darkTheme = currentTheme.copyWith(isDark: true);
final forestTheme = currentTheme.copyWith(
  seedColor: ClayColors.forest,
);
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClayText.body('Keep the current palette and enable dark mode:'),
          const SizedBox(height: 8),
          ClayText.label('currentTheme.copyWith(isDark: true)'),
          const SizedBox(height: 16),
          ClayText.body('Keep the current mode and change the seed palette:'),
          const SizedBox(height: 8),
          ClayText.label('currentTheme.copyWith(seedColor: ClayColors.forest)'),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'seedColor',
      type: 'ClayPalette',
      description: 'Required base palette used to derive background, surface, and primary color roles.',
      required: true,
    ),
    ClayProp(
      name: 'isDark',
      type: 'bool',
      description: 'Whether dark-mode token values should be generated.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'background / onBackground / onBackgroundVariant',
      type: 'Color',
      description: 'Main page surface and its primary and secondary foreground colors. Derived from seedColor and isDark.',
    ),
    ClayProp(
      name: 'container / onContainer',
      type: 'Color',
      description: 'Raised surface color and the foreground color intended for content on that surface.',
    ),
    ClayProp(
      name: 'primary / onPrimary',
      type: 'Color',
      description: 'Primary action color and its readable foreground. Derived from the seed palette.',
    ),
    ClayProp(
      name: 'secondary / onSecondary',
      type: 'Color',
      description: 'Secondary emphasis color and its intended foreground. Derived from the seed palette.',
    ),
    ClayProp(
      name: 'tertiary / onTertiary',
      type: 'Color',
      description: 'Additional emphasis color and its intended foreground. Derived from the seed palette.',
    ),
    ClayProp(
      name: 'success / onSuccess',
      type: 'Color',
      description: 'Success status color and its intended foreground. Based on the forest palette.',
    ),
    ClayProp(
      name: 'warning / onWarning',
      type: 'Color',
      description: 'Warning status color and its intended foreground. Based on the amber palette.',
    ),
    ClayProp(
      name: 'error / onError',
      type: 'Color',
      description: 'Error status color and its intended foreground. Based on the ruby palette.',
    ),
    ClayProp(
      name: 'light / shadow / border',
      type: 'Color',
      description: 'Theme-aware highlight, shadow, and border colors used by clay surfaces and components.',
    ),
    ClayProp(
      name: 'copyWith',
      type: 'ClayThemeData Function({ClayPalette? seedColor, bool? isDark})',
      description: 'Creates a new theme configuration, preserving current values for arguments not supplied.',
    ),
  ],
);

class _ThemeTokensPreview extends StatelessWidget {
  const _ThemeTokensPreview();

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final tokens = <({String name, Color color})>[
      (name: 'background', color: theme.background),
      (name: 'container', color: theme.container),
      (name: 'primary', color: theme.primary),
      (name: 'secondary', color: theme.secondary),
      (name: 'tertiary', color: theme.tertiary),
      (name: 'success', color: theme.success),
      (name: 'warning', color: theme.warning),
      (name: 'error', color: theme.error),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final token in tokens)
          _ThemeTokenSwatch(name: token.name, color: token.color),
      ],
    );
  }
}

class _ThemeTokenSwatch extends StatelessWidget {
  final String name;
  final Color color;

  const _ThemeTokenSwatch({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    final foreground = color.computeLuminance() > 0.42
        ? Colors.black
        : Colors.white;

    return Container(
      width: 112,
      height: 68,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
