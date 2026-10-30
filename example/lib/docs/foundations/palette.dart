import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc paletteDocumentation = ComponentDoc(
  title: 'Palette',
  subtitle: 'Foundations',
  description: 'A ClayPalette is a color swatch with eleven coordinated shades. Select a palette from ClayColors, use a named shade from s50 to s950, or read the active theme palette from BuildContext.',
  showcases: [
    ClayShowcase(
      title: 'Choose a Theme Palette',
      description: 'Set seedColor in ClayThemeData to choose the palette that generates the app theme. ClayColors provides the built-in palettes; see Colors for the complete list.',
      code: '''
ClayApp(
  clayThemeData: ClayThemeData(
    seedColor: ClayColors.cobalt,
    isDark: false,
  ),
  home: const MyScreen(),
)
''',
      preview: const _PaletteScale(),
    ),
    ClayShowcase(
      title: 'Access Palette Shades',
      description: 'Use named shade getters for readable code. s50 is the lightest shade, s500 is the base color, and s950 is the darkest. ClayPalette is also a ColorSwatch<int>, so numeric indexing is available.',
      code: '''
final palette = ClayColors.cobalt;

final lightSurface = palette.s50;
final softSurface = palette.s100;
final accent = palette.s500;
final darkText = palette.s950;

// ColorSwatch access is also supported:
final baseColor = palette[500];
''',
      preview: Builder(
        builder: (context) {
          final palette = ClayColors.cobalt;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClayText.label('ClayColors.cobalt'),
              const SizedBox(height: 10),
              _PaletteScale(palette: palette),
            ],
          );
        },
      ),
    ),
    ClayShowcase(
      title: 'Read the Active Theme Palette',
      description: 'context.clayPalette returns the seed palette from the nearest ClayTheme. Use it when a component should follow the palette selected by the application instead of a fixed color family.',
      code: '''
final palette = context.clayPalette;

Container(
  color: palette.s200,
  child: Text(
    'Theme-aware surface',
    style: TextStyle(color: palette.s950),
  ),
)
''',
      preview: Builder(
        builder: (context) {
          final palette = context.clayPalette;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.s200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'This sample uses context.clayPalette.s200 and s950.',
              style: TextStyle(color: palette.s950),
            ),
          );
        },
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 's50',
      type: 'Color',
      description: 'The lightest shade in the palette.',
    ),
    ClayProp(
      name: 's100-s400',
      type: 'Color',
      description: 'Light shades for subtle surfaces and accents.',
    ),
    ClayProp(
      name: 's500',
      type: 'Color',
      description: 'The base color used to generate the palette.',
    ),
    ClayProp(
      name: 's600-s900',
      type: 'Color',
      description: 'Progressively darker shades for emphasis and contrast.',
    ),
    ClayProp(
      name: 's950',
      type: 'Color',
      description: 'The darkest shade in the palette.',
    ),
    ClayProp(
      name: 'palette[index]',
      type: 'Color?',
      description: 'ColorSwatch integer lookup, such as palette[500]. Named getters are non-null and recommended for known shades.',
      defaultValue: 'null for an unavailable index',
    ),
  ],
);

class _PaletteScale extends StatelessWidget {
  final ClayPalette? palette;

  const _PaletteScale({this.palette});

  static const _shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950];

  @override
  Widget build(BuildContext context) {
    final activePalette = palette ?? context.clayPalette;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final shade in _shades)
          _PaletteShade(shade: shade, color: activePalette[shade]!),
      ],
    );
  }
}

class _PaletteShade extends StatelessWidget {
  final int shade;
  final Color color;

  const _PaletteShade({required this.shade, required this.color});

  @override
  Widget build(BuildContext context) {
    final foreground = color.computeLuminance() > 0.42
        ? Colors.black
        : Colors.white;

    return Tooltip(
      message: 's$shade',
      child: Container(
        width: 48,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '$shade',
          style: TextStyle(
            color: foreground,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
