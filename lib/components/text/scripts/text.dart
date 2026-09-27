import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/typography.dart';
import '../types/variants.dart';

class ClayText extends StatelessWidget {
  final String text;
  final ClayTextVariants _variant;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontWeight? fontWeight;

  const ClayText.display(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
  }) : _variant = ClayTextVariants.display;

  const ClayText.title(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
  }) : _variant = ClayTextVariants.title;

  const ClayText.body(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
  }) : _variant = ClayTextVariants.body;

  const ClayText.label(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
  }) : _variant = ClayTextVariants.label;

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final defaultColor = color ?? theme.onBackground;

    TextStyle baseStyle;
    switch (_variant) {
      case ClayTextVariants.display:
        baseStyle = ClayTextTypography.display(color: defaultColor);
        break;
      case ClayTextVariants.title:
        baseStyle = ClayTextTypography.title(color: defaultColor);
        break;
      case ClayTextVariants.body:
        baseStyle = ClayTextTypography.body(color: defaultColor);
        break;
      case ClayTextVariants.label:
        baseStyle = ClayTextTypography.label(color: defaultColor);
        break;
    }

    if (fontWeight != null) {
      baseStyle = baseStyle.copyWith(fontWeight: fontWeight);
    }

    return Text(
      text,
      style: baseStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
