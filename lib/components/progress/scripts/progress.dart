import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/variants.dart';
import '../../../theme/scripts/shadows.dart';

class ClayProgress extends StatefulWidget {
  const ClayProgress.bar({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.height = 12,
    this.width,
    this.radius = 999,
    this.duration = const Duration(milliseconds: 450),
    this.showPercentage = false,
    this.label,
  }) : _variant = ClayProgressVariant.bar,
       size = 0,
       strokeWidth = 0,
       child = null,
       waveAmplitude = 5,
       waveSpeed = 1;

  const ClayProgress.circle({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.size = 64,
    this.strokeWidth = 7,
    this.duration = const Duration(milliseconds: 450),
    this.showPercentage = false,
    this.child,
  }) : _variant = ClayProgressVariant.circle,
       height = 0,
       width = null,
       radius = 0,
       label = null,
       waveAmplitude = 5,
       waveSpeed = 1;

  const ClayProgress.wave({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.size = 120,
    this.radius = 100,
    this.duration = const Duration(milliseconds: 450),
    this.child,
    this.waveAmplitude = 5,
    this.waveSpeed = 1,
  }) : _variant = ClayProgressVariant.wave,
       height = 0,
       width = null,
       strokeWidth = 0,
       showPercentage = false,
       label = null;

  final ClayProgressVariant _variant;
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final double? width;
  final double size;
  final double strokeWidth;
  final double radius;
  final Duration duration;
  final bool showPercentage;
  final String? label;
  final Widget? child;
  final double waveAmplitude;
  final double waveSpeed;

  @override
  State<ClayProgress> createState() => _ClayProgressState();
}

class _ClayProgressState extends State<ClayProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;
  bool get _reduceMotion =>
      MediaQuery.maybeOf(context)?.disableAnimations ?? false;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget._variant == ClayProgressVariant.wave && widget.value != null) {
      _waveController.repeat();
    } else if (widget.value == null) {
      _waveController.repeat(period: const Duration(milliseconds: 1200));
    }
  }

  @override
  void didUpdateWidget(covariant ClayProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null || widget._variant == ClayProgressVariant.wave) {
      if (!_waveController.isAnimating && !_reduceMotion) {
        _waveController.repeat();
      }
    } else {
      _waveController.stop();
      _waveController.value = 0;
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  double get _normalizedValue => (widget.value ?? 0).clamp(0.0, 1.0).toDouble();

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final foreground = widget.color ?? theme.primary;
    final track = widget.backgroundColor ?? theme.container;

    switch (widget._variant) {
      case ClayProgressVariant.bar:
        return _buildBar(foreground, track);
      case ClayProgressVariant.circle:
        return _buildCircle(foreground, track);
      case ClayProgressVariant.wave:
        return _buildWave(foreground, track);
    }
  }

  Widget _buildBar(Color foreground, Color track) {
    final theme = context.clayTheme;
    final value = _normalizedValue;
    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.label != null || widget.showPercentage) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.label != null)
                  Flexible(
                    child: Text(
                      widget.label!,
                      style: TextStyle(color: theme.onBackground, fontSize: 12),
                    ),
                  ),
                if (widget.showPercentage)
                  Text(
                    widget.value == null ? '…' : '${(value * 100).round()}%',
                    style: TextStyle(
                      color: theme.onBackground,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
          ],
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: track,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            clipBehavior: Clip.antiAlias,
            child: widget.value == null
                ? AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, _) {
                      final progress = _reduceMotion
                          ? 0.35
                          : _waveController.value;
                      return Align(
                        alignment: Alignment(-1 + progress * 2, 0),
                        child: FractionallySizedBox(
                          widthFactor: 0.32,
                          heightFactor: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: foreground,
                              borderRadius: BorderRadius.circular(
                                widget.radius,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: value),
                    duration: widget.duration,
                    curve: Curves.easeOutCubic,
                    builder: (context, animatedValue, _) => Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: animatedValue,
                        heightFactor: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.radius),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                foreground.withValues(alpha: 0.78),
                                foreground,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color foreground, Color track) {
    final value = _normalizedValue;
    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, _) => CustomPaint(
              size: Size.square(widget.size),
              painter: _CircleProgressPainter(
                value: widget.value == null
                    ? (_reduceMotion
                          ? 0.28
                          : 0.28 + 0.48 * _waveController.value)
                    : value,
                foreground: foreground,
                track: track,
                strokeWidth: widget.strokeWidth,
                indeterminate: widget.value == null,
              ),
            ),
          ),
          if (widget.child != null)
            widget.child!
          else if (widget.showPercentage)
            Text(
              widget.value == null ? '…' : '${(value * 100).round()}%',
              style: TextStyle(
                color: context.clayTheme.onBackground,
                fontSize: widget.size * 0.19,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWave(Color foreground, Color track) {
    final value = _normalizedValue;
    final theme = context.clayTheme;

    return CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: widget.radius,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: SizedBox.square(
        dimension: widget.size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: track,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  offset: const Offset(3, 4),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  offset: const Offset(-3, -3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, _) => CustomPaint(
                    size: Size.square(widget.size),
                    painter: _WaveProgressPainter(
                      value: widget.value == null
                          ? (_reduceMotion
                                ? 0.45
                                : 0.35 +
                                      0.2 *
                                          math.sin(
                                            _waveController.value * math.pi * 2,
                                          ))
                          : value,
                      phase: _reduceMotion
                          ? 0
                          : _waveController.value *
                                math.pi *
                                2 *
                                widget.waveSpeed,
                      color: foreground,
                      amplitude: widget.waveAmplitude,
                    ),
                  ),
                ),
                if (widget.child != null)
                  widget.child!
                else
                  Text(
                    widget.value == null ? '…' : '${(value * 100).round()}%',
                    style: TextStyle(
                      color: value > 0.55
                          ? Colors.white
                          : context.clayTheme.onBackground,
                      fontWeight: FontWeight.w700,
                      fontSize: widget.size * 0.18,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  const _CircleProgressPainter({
    required this.value,
    required this.foreground,
    required this.track,
    required this.strokeWidth,
    required this.indeterminate,
  });

  final double value;
  final Color foreground;
  final Color track;
  final double strokeWidth;
  final bool indeterminate;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final inset = strokeWidth / 2 + 1;
    final arcRect = rect.deflate(inset);
    final trackPaint = Paint()
      ..color = track.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [foreground.withValues(alpha: 0.65), foreground],
      ).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(arcRect.center, arcRect.width / 2, trackPaint);
    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      math.pi * 2 * value,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.foreground != foreground ||
      oldDelegate.track != track ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.indeterminate != indeterminate;
}

class _WaveProgressPainter extends CustomPainter {
  const _WaveProgressPainter({
    required this.value,
    required this.phase,
    required this.color,
    required this.amplitude,
  });

  final double value;
  final double phase;
  final Color color;
  final double amplitude;

  @override
  void paint(Canvas canvas, Size size) {
    if (value <= 0) return;
    final level = size.height * (1 - value.clamp(0.0, 1.0));
    final waveAmplitude = math.min(amplitude, size.height * 0.08);
    final path = Path()..moveTo(0, level);
    for (double x = 0; x <= size.width + 1; x += 1) {
      final y =
          level +
          math.sin((x / size.width * math.pi * 2) + phase) * waveAmplitude;
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);

    final highlight = Paint()..color = Colors.white.withValues(alpha: 0.13);
    final secondPath = Path()..moveTo(0, level + waveAmplitude * 0.35);
    for (double x = 0; x <= size.width + 1; x += 1) {
      final y =
          level +
          waveAmplitude * 0.35 +
          math.sin((x / size.width * math.pi * 2) + phase + 1.3) *
              waveAmplitude *
              0.5;
      secondPath.lineTo(x, y);
    }
    secondPath
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(secondPath, highlight);
  }

  @override
  bool shouldRepaint(covariant _WaveProgressPainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.phase != phase ||
      oldDelegate.color != color ||
      oldDelegate.amplitude != amplitude;
}
