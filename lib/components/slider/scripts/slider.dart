import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';

class ClaySlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;

  final double min;
  final double max;
  final int? divisions;

  final String? label;
  final String? description;

  final bool showValue;
  final bool showMinMax;
  final bool enabled;

  final Color? activeColor;

  final Color? thumbColor;
  final Color? foregroundColor;

  final double height;
  final double thumbRadius;

  const ClaySlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.label,
    this.description,
    this.showValue = false,
    this.showMinMax = false,
    this.enabled = true,
    this.activeColor,
    this.thumbColor,
    this.foregroundColor,
    this.height = 36,
    this.thumbRadius = 10,
  }) : assert(max > min),
       assert(divisions == null || divisions > 0),
       assert(value >= min && value <= max),
       assert(height > 0),
       assert(thumbRadius > 0);

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final active = activeColor ?? theme.primary;

    final foreground = foregroundColor ?? theme.onPrimary;

    final thumb = thumbColor ?? active;

    final canChange = enabled && onChanged != null;

    final slider = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: active,
        inactiveTrackColor: active.withAlpha(40),
        secondaryActiveTrackColor: active.withAlpha(120),
        thumbColor: thumb,
        overlayColor: active.withAlpha(25),
        trackHeight: 16,
        thumbShape: _ClaySliderThumbShape(
          radius: thumbRadius,
          theme: theme,
          foreground: foreground,
        ),
        overlayShape: RoundSliderOverlayShape(overlayRadius: thumbRadius * 2),
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: active.withAlpha(0),
        inactiveTickMarkColor: theme.background.withAlpha(0),
        valueIndicatorColor: active,
        valueIndicatorTextStyle: TextStyle(color: foreground),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: showValue ? value.toStringAsFixed(0) : label,
        onChanged: canChange ? onChanged : null,
        onChangeStart: canChange ? onChangeStart : null,
        onChangeEnd: canChange ? onChangeEnd : null,
      ),
    );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || showValue)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Flexible(
                    child: Text(
                      label!,
                      style: TextStyle(
                        color: theme.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (showValue)
                  Text(
                    value.toStringAsFixed(0),
                    style: TextStyle(
                      color: active,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
              ],
            ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: TextStyle(color: theme.onBackgroundVariant, fontSize: 12),
            ),
          ],
          SizedBox(height: height, child: slider),
          if (showMinMax)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    min.toStringAsFixed(0),
                    style: TextStyle(
                      color: theme.onBackgroundVariant,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    max.toStringAsFixed(0),
                    style: TextStyle(
                      color: theme.onBackgroundVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ClaySliderThumbShape extends SliderComponentShape {
  final double radius;
  final dynamic theme;
  final Color foreground;

  const _ClaySliderThumbShape({
    required this.radius,
    required this.theme,
    required this.foreground,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius + 3);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius + 2, paint);

    final highlight = Paint()
      ..color = foreground.withAlpha(0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawCircle(center.translate(-1, -1), radius, highlight);

    final border = Paint()
      ..color = theme.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    canvas.drawCircle(center, radius + 2, border);
  }
}
