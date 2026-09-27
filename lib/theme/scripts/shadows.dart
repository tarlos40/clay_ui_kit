import 'package:flutter/material.dart';

import 'data.dart';

abstract class ClayShadows {
  static List<BoxShadow> external({
    required ClayThemeData theme,
    double offset = 6.0,
    double blur = 12.0,
  }) {
    return [
      BoxShadow(
        color: theme.light,
        offset: Offset(-offset, -offset),
        blurRadius: blur,
      ),
      BoxShadow(
        color: theme.shadow,
        offset: Offset(offset, offset),
        blurRadius: blur,
      ),
    ];
  }
}

class ClayInnerShadowPainter extends CustomPainter {
  final Color shadowColor, lightColor;
  final double borderRadius;
  final double shadowSize;
  final double blurRadius;

  ClayInnerShadowPainter({
    required this.shadowColor,
    required this.lightColor,
    required this.borderRadius,
    this.shadowSize = 8.0,
    this.blurRadius = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rtree = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    canvas.clipRRect(rtree);

    final darkPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    final darkShadowRect = Rect.fromLTRB(
      -blurRadius,
      size.height - shadowSize,
      size.width + blurRadius * 2,
      size.height + blurRadius * 2,
    );
    canvas.drawRect(darkShadowRect, darkPaint);

    final darkLeftRect = Rect.fromLTRB(
      size.width - shadowSize,
      -blurRadius,
      size.width + blurRadius * 2,
      size.height + blurRadius * 2,
    );
    canvas.drawRect(darkLeftRect, darkPaint);

    final lightPaint = Paint()
      ..color = lightColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    final lightBottomRect = Rect.fromLTRB(
      -blurRadius * 2,
      -blurRadius * 2,
      size.width + blurRadius,
      shadowSize,
    );
    canvas.drawRect(lightBottomRect, lightPaint);

    final lightRightRect = Rect.fromLTRB(
      -blurRadius * 2,
      -blurRadius * 2,
      shadowSize,
      size.height + blurRadius,
    );
    canvas.drawRect(lightRightRect, lightPaint);
  }

  @override
  bool shouldRepaint(covariant ClayInnerShadowPainter oldDelegate) {
    return oldDelegate.shadowColor != shadowColor ||
        oldDelegate.lightColor != lightColor ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.shadowSize != shadowSize ||
        oldDelegate.blurRadius != blurRadius;
  }
}
