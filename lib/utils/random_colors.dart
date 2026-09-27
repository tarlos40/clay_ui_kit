import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../palette/types/colors.dart';
import '../../palette/types/palette.dart';
import './class/random_color.dart';

class RandomColors {
  static List<ClayPalette> palettes() {
    return [ClayColors.sky, ClayColors.mint, ClayColors.rose, ClayColors.peach];
  }

  static List<RandomColor> _colors(
    ClayPalette palette, {
    required bool isDark,
  }) {
    if (!isDark) {
      return [
        RandomColor(backgroundColor: palette.s400, foregroundColor: palette.s50),
        RandomColor(backgroundColor: palette.s300, foregroundColor: palette.s50),
        RandomColor(backgroundColor: palette.s200, foregroundColor: palette.s950),
      ];
    }

    return [
      RandomColor(backgroundColor: palette.s600, foregroundColor: palette.s50),
      RandomColor(backgroundColor: palette.s700, foregroundColor: palette.s100),
      RandomColor(backgroundColor: palette.s800, foregroundColor: palette.s200),
    ];
  }

  static RandomColor random(BuildContext context, {int? seed}) {
    final theme = context.clayTheme;
    final palettes = RandomColors.palettes();

    final random = seed == null ? Random() : Random(seed);

    final palette = palettes[random.nextInt(palettes.length)];

    final colors = _colors(palette, isDark: theme.isDark);

    return colors[random.nextInt(colors.length)];
  }
}
