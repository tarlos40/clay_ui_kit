import 'package:flutter/material.dart';

class ClayPalette extends ColorSwatch<int> {
  const ClayPalette(super.primary, super.swatch);

  ClayPalette.fromRGBO(
    int r,
    int g,
    int b,
    double opacity,
    Map<int, Color> swatch,
  ) : super(Color.fromRGBO(r, g, b, opacity).toARGB32(), swatch);

  ClayPalette.fromColor(Color color, Map<int, Color> swatch)
    : super(color.toARGB32(), swatch);

  Color get s50 => this[50]!;
  Color get s100 => this[100]!;
  Color get s200 => this[200]!;
  Color get s300 => this[300]!;
  Color get s400 => this[400]!;
  Color get s500 => this[500]!;
  Color get s600 => this[600]!;
  Color get s700 => this[700]!;
  Color get s800 => this[800]!;
  Color get s900 => this[900]!;
  Color get s950 => this[950]!;
}
