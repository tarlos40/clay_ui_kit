import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc colorsDocumentation = ComponentDoc(
  title: 'Colors',
  subtitle: 'Foundations',
  description: 'Explore every color family in Clay UI Kit. Each palette includes a range of shades from the lightest (s50) to the darkest (s950), available through ClayColors.',
  showcases: [
    ClayShowcase(
      title: 'ClayColors palettes',
      description: 'Use a palette directly or select an individual shade. Hover or tap a swatch to see its accessor and hexadecimal value.',
      code: '''
final palette = ClayColors.cobalt;

final lightSurface = ClayColors.cobalt.s50;
final baseColor = ClayColors.cobalt.s500;
final darkText = ClayColors.cobalt.s950;
''',
      preview: const _ClayColorsGallery(),
    ),
  ],
);

class _ColorFamily {
  final String name;
  final ColorSwatch<int> palette;

  const _ColorFamily(this.name, this.palette);
}

class _ClayColorsGallery extends StatelessWidget {
  const _ClayColorsGallery();

  static const _shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950];

  static final _families = <_ColorFamily>[
    _ColorFamily('aqua', ClayColors.aqua),
    _ColorFamily('sky', ClayColors.sky),
    _ColorFamily('ocean', ClayColors.ocean),
    _ColorFamily('cobalt', ClayColors.cobalt),
    _ColorFamily('lavender', ClayColors.lavender),
    _ColorFamily('violet', ClayColors.violet),
    _ColorFamily('grape', ClayColors.grape),
    _ColorFamily('mint', ClayColors.mint),
    _ColorFamily('forest', ClayColors.forest),
    _ColorFamily('lime', ClayColors.lime),
    _ColorFamily('lemon', ClayColors.lemon),
    _ColorFamily('amber', ClayColors.amber),
    _ColorFamily('tangerine', ClayColors.tangerine),
    _ColorFamily('coral', ClayColors.coral),
    _ColorFamily('peach', ClayColors.peach),
    _ColorFamily('ruby', ClayColors.ruby),
    _ColorFamily('mocha', ClayColors.mocha),
    _ColorFamily('bubblegum', ClayColors.bubblegum),
    _ColorFamily('rose', ClayColors.rose),
    _ColorFamily('ivory', ClayColors.ivory),
    _ColorFamily('cream', ClayColors.cream),
    _ColorFamily('cloud', ClayColors.cloud),
    _ColorFamily('sage', ClayColors.sage),
    _ColorFamily('sand', ClayColors.sand),
    _ColorFamily('silver', ClayColors.silver),
    _ColorFamily('stone', ClayColors.stone),
    _ColorFamily('slate', ClayColors.slate),
    _ColorFamily('charcoal', ClayColors.charcoal),
    _ColorFamily('obsidian', ClayColors.obsidian),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final family in _families) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'ClayColors.${family.name}',
              style: TextStyle(
                color: theme.onBackground,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final shade in _shades)
                _ColorSwatch(
                  familyName: family.name,
                  shade: shade,
                  color: family.palette[shade]!,
                ),
            ],
          ),
          const SizedBox(height: 18),
        ],
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String familyName;
  final int shade;
  final Color color;

  const _ColorSwatch({
    required this.familyName,
    required this.shade,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = color.computeLuminance() > 0.42
        ? Colors.black
        : Colors.white;
    final hex = (color.toARGB32() & 0xFFFFFF)
        .toRadixString(16)
        .padLeft(6, '0')
        .toUpperCase();

    return Tooltip(
      message: 'ClayColors.$familyName.s$shade  #$hex',
      child: Semantics(
        label: '$familyName shade $shade, hex $hex',
        child: Container(
          width: 48,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
          ),
          child: Text(
            '$shade',
            style: TextStyle(
              color: labelColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
