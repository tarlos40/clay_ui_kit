import 'package:flutter/material.dart';

import '../../palette/types/palette.dart';

class ClayThemeData {
  final ClayPalette seedColor;
  final bool isDark;

  late final Color background, onBackground, onBackgroundVariant;
  late final Color primary, onPrimary;
  late final Color secondary, onSecondary;
  late final Color third, onThird;
  late final Color container, onContainer;
  late final Color light, shadow, border;

  ClayThemeData({required this.seedColor, this.isDark = false}) {
    _generateThemeColors();
  }

  void _generateThemeColors() {
    if (!isDark) {
      background = seedColor.s100;
      onBackground = seedColor.s950;
      onBackgroundVariant = seedColor.s800;

      container = seedColor.s50;
      onContainer = seedColor.s950;

      primary = seedColor.s400;
      onPrimary = seedColor.s50;

      secondary = seedColor.s300;
      onSecondary = seedColor.s50;

      third = seedColor.s200;
      onThird = seedColor.s950;

      light = Colors.white.withAlpha(100);
      shadow = Colors.black.withAlpha(100);
      border = seedColor.s50.withAlpha(175);
    } else {
      background = seedColor.s950;
      onBackground = seedColor.s50;
      onBackgroundVariant = seedColor.s200;

      container = seedColor.s900;
      onContainer = seedColor.s50;

      primary = seedColor.s600;
      onPrimary = seedColor.s50;

      secondary = seedColor.s700;
      onSecondary = seedColor.s100;

      third = seedColor.s800;
      onThird = seedColor.s200;

      light = Colors.white.withAlpha(25);
      shadow = Colors.black.withAlpha(150);
      border = seedColor.s950.withAlpha(200);
    }
  }

  ClayThemeData copyWith({ClayPalette? seedColor, bool? isDark}) {
    return ClayThemeData(
      seedColor: seedColor ?? this.seedColor,
      isDark: isDark ?? this.isDark,
    );
  }
}
