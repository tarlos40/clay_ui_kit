import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/styles.dart';
import '../../../theme/scripts/shadows.dart';
import '../../text/scripts/text.dart';

class ClayLoading extends StatefulWidget {
  const ClayLoading({
    super.key,
    this.label,
    this.icon,
    this.size = 52,
    this.color,
    this.labelColor,
    this.style = ClayLoadingStyle.orbit,
    this.gap = 14,
    this.strokeWidth = 3.5,
  });

  final String? label;
  final Widget? icon;
  final double size;
  final Color? color;
  final Color? labelColor;
  final ClayLoadingStyle style;
  final double gap;
  final double strokeWidth;

  static Future<void> show(
    BuildContext context, {
    String? label,
    Widget? icon,
    double size = 54,
    Color? color,
    Color? labelColor,
    ClayLoadingStyle style = ClayLoadingStyle.orbit,
    bool barrierDismissible = false,
    bool useRootNavigator = true,
    Color? barrierColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 28,
      vertical: 24,
    ),
    double borderRadius = 24,
  }) {
    final theme = context.clayTheme;

    return showDialog<void>(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black.withValues(alpha: .28),
      builder: (dialogContext) => PopScope(
        canPop: barrierDismissible,
        child: Center(
          child: CustomPaint(
            foregroundPainter: ClayInnerShadowPainter(
              shadowColor: theme.shadow,
              lightColor: theme.light,
              borderRadius: borderRadius,
              shadowSize: 2.5,
              blurRadius: 7.0,
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: const BoxConstraints(minWidth: 150, maxWidth: 320),
                padding: padding,
                decoration: BoxDecoration(
                  color: dialogContext.clayTheme.container,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: dialogContext.clayTheme.onBackground.withValues(
                      alpha: .07,
                    ),
                  ),
                  boxShadow: ClayShadows.external(
                    theme: theme,
                    offset: 2.5,
                    blur: 7,
                  ),
                ),
                child: ClayLoading(
                  label: label,
                  icon: icon,
                  size: size,
                  color: color,
                  labelColor: labelColor,
                  style: style,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context, {bool useRootNavigator = true}) {
    final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
    if (navigator.canPop()) navigator.pop();
  }

  @override
  State<ClayLoading> createState() => _ClayLoadingState();
}

class _ClayLoadingState extends State<ClayLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1250),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final color = widget.color ?? theme.primary;
    final labelColor = widget.labelColor ?? theme.onBackground;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => switch (widget.style) {
              ClayLoadingStyle.orbit => _buildOrbit(color),
              ClayLoadingStyle.dots => _buildDots(color),
              ClayLoadingStyle.pulse => _buildPulse(color),
            },
          ),
        ),
        if (widget.label != null && widget.label!.trim().isNotEmpty) ...[
          SizedBox(height: widget.gap),
          ClayText.label(
            widget.label!,
            textAlign: TextAlign.center,
            color: labelColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ],
      ],
    );
  }

  Widget _buildOrbit(Color color) {
    final angle = _controller.value * math.pi * 2;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: widget.size * .78,
          height: widget.size * .78,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: .16),
              width: widget.strokeWidth,
            ),
          ),
        ),
        Transform.rotate(
          angle: angle,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: widget.size * .20,
              height: widget.size * .20,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: .25), blurRadius: 9),
                ],
              ),
            ),
          ),
        ),
        if (widget.icon != null)
          SizedBox(
            width: widget.size * .40,
            height: widget.size * .40,
            child: FittedBox(child: widget.icon),
          ),
      ],
    );
  }

  Widget _buildDots(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final phase = (_controller.value * 2 * math.pi) - (index * 1.25);
        final scale = .62 + ((math.sin(phase) + 1) / 2) * .38;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.size * .035),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: widget.size * .19,
              height: widget.size * .19,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .72 + scale * .28),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: .15),
                    blurRadius: 6,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPulse(Color color) {
    final pulse = .72 + (math.sin(_controller.value * math.pi * 2) + 1) * .14;
    return Center(
      child: Transform.scale(
        scale: pulse,
        child: Container(
          width: widget.size * .68,
          height: widget.size * .68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .13 + (_controller.value * .10)),
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: .5),
              width: widget.strokeWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: .14),
                blurRadius: 14,
                spreadRadius: 2,
              ),
            ],
          ),
          child:
              widget.icon ??
              Icon(
                Icons.hourglass_top_rounded,
                color: color,
                size: widget.size * .30,
              ),
        ),
      ),
    );
  }
}
