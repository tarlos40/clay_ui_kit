import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';

class ClayBackground extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Gradient? gradient;

  const ClayBackground({
    super.key,
    required this.child,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    if (color != null) {
      return ColoredBox(color: color!, child: child);
    }

    if (gradient != null) {
      return DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: child,
      );
    }

    return _defaultBackground(context, theme);
  }

  Widget _defaultBackground(BuildContext context, dynamic theme) {
    final primary = Color.lerp(theme.primary, theme.background, 0.2)!;
    final secondary = Color.lerp(theme.secondary, theme.background, 0.25)!;
    final third = Color.lerp(theme.third, theme.background, 0.3)!;
    final container = Color.lerp(theme.container, theme.background, 0.35)!;

    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: theme.background),
        _Glow(
          alignment: const Alignment(-1.1, -1.1),
          color: primary,
          size: 500,
          opacity: 0.12,
        ),

        _Glow(
          alignment: const Alignment(1.1, -0.4),
          color: secondary,
          size: 450,
          opacity: 0.08,
        ),

        _Glow(
          alignment: const Alignment(0.8, 1.1),
          color: third,
          size: 500,
          opacity: 0.07,
        ),

        _Glow(
          alignment: const Alignment(-0.4, 0.6),
          color: container,
          size: 600,
          opacity: 0.08,
        ),

        child,
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final double size;
  final double opacity;

  const _Glow({
    required this.alignment,
    required this.color,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: opacity),
                color.withValues(alpha: opacity * 0.35),
                Colors.transparent,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
