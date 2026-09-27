import 'package:flutter/material.dart';

import "../types/palette.dart";

abstract final class ClayColors {
  static ClayPalette createPaletteFromBase(Color base500) {
    final hsl = HSLColor.fromColor(base500);

    Color getShade(double saturationFactor, double lightness) {
      return hsl
          .withSaturation((hsl.saturation * saturationFactor).clamp(0.0, 1.0))
          .withLightness(lightness)
          .toColor();
    }

    final swatch = <int, Color>{
      50: getShade(0.88, 0.96),
      100: getShade(0.92, 0.91),
      200: getShade(0.95, 0.81),
      300: getShade(0.98, 0.71),
      400: getShade(1.00, 0.64),
      500: base500,
      600: getShade(1.00, 0.48),
      700: getShade(0.98, 0.38),
      800: getShade(0.92, 0.28),
      900: getShade(0.85, 0.18),
      950: getShade(0.78, 0.10),
    };

    return ClayPalette.fromRGBO(
      (base500.r * 255).round(),
      (base500.g * 255).round(),
      (base500.b * 255).round(),
      1.0,
      swatch,
    );
  }

  static final ClayPalette sky = createPaletteFromBase(
    const Color.fromRGBO(56, 189, 248, 1.0),
  );

  static final ClayPalette peach = createPaletteFromBase(
    const Color.fromRGBO(245, 73, 39, 1.0),
  );

  static final ClayPalette rose = createPaletteFromBase(
    const Color.fromRGBO(255, 0, 127, 1.0),
  );

  static final ClayPalette mint = createPaletteFromBase(
    const Color.fromRGBO(173, 235, 179, 1.0),
  );
}
