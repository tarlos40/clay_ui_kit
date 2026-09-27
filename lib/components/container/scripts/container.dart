import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';

class ClayContainer extends StatelessWidget {
  final Widget? child;

  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry borderRadius;

  final Border? border;

  final List<BoxShadow>? boxShadow;

  final AlignmentGeometry? alignment;

  final double? width;
  final double? height;

  final BoxConstraints? constraints;

  final Clip clipBehavior;

  const ClayContainer({
    super.key,
    this.child,
    this.backgroundColor,
    this.backgroundGradient,
    this.padding,
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.border,
    this.boxShadow,
    this.alignment,
    this.width,
    this.height,
    this.constraints,
    this.clipBehavior = Clip.none,
  }) : assert(
         backgroundColor == null || backgroundGradient == null,
         'Cannot provide both backgroundColor and backgroundGradient. '
         'Please choose one.',
       );

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final shadows =
        boxShadow ?? ClayShadows.external(theme: theme, offset: 3, blur: 8);

    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      alignment: alignment,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.container,
        gradient: backgroundGradient,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
