import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';

class ClayRefreshIndicator extends StatefulWidget {
  final Widget child;
  final RefreshCallback onRefresh;

  final double triggerDistance;
  final double indicatorSize;
  final Color? color;
  final Color? backgroundColor;
  final bool enabled;

  const ClayRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.triggerDistance = 80,
    this.indicatorSize = 48,
    this.color,
    this.backgroundColor,
    this.enabled = true,
  }) : assert(triggerDistance > 0),
       assert(indicatorSize > 0);

  @override
  State<ClayRefreshIndicator> createState() => _ClayRefreshIndicatorState();
}

class _ClayRefreshIndicatorState extends State<ClayRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;

  double _pullDistance = 0;
  bool _dragging = false;
  bool _refreshing = false;

  bool get _visible => widget.enabled && (_pullDistance > 0 || _refreshing);

  double get _progress =>
      (_pullDistance / widget.triggerDistance).clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void didUpdateWidget(covariant ClayRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.enabled) {
      _dragging = false;
      _pullDistance = 0;
      _updateWaveAnimation();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _updateWaveAnimation() {
    if (_visible) {
      if (!_waveController.isAnimating) {
        _waveController.repeat();
      }
    } else {
      _waveController.stop();
      _waveController.value = 0;
    }
  }

  void _setPullDistance(double distance) {
    if (!widget.enabled || _refreshing) return;

    final double next = math.max(0.0, distance).toDouble();

    if ((next - _pullDistance).abs() < 0.5) return;

    setState(() {
      _pullDistance = next;
    });

    _updateWaveAnimation();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.enabled || _refreshing) return false;

    if (notification.depth != 0) return false;

    final metrics = notification.metrics;
    final atTop = metrics.extentBefore <= 0.5;

    if (notification is ScrollStartNotification) {
      if (notification.dragDetails != null && atTop) {
        _dragging = true;
        _setPullDistance(0);
      }
    } else if (notification is OverscrollNotification) {
      if (_dragging && atTop && notification.overscroll < 0) {
        _setPullDistance(_pullDistance - notification.overscroll);
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_dragging &&
          notification.dragDetails != null &&
          metrics.pixels < metrics.minScrollExtent) {
        _setPullDistance(
          math
              .max(_pullDistance, metrics.minScrollExtent - metrics.pixels)
              .toDouble(),
        );
      }
    } else if (notification is ScrollEndNotification) {
      if (_dragging) {
        _dragging = false;

        if (_pullDistance >= widget.triggerDistance) {
          unawaited(_performRefresh());
        } else {
          _resetIndicator();
        }
      }
    }

    return false;
  }

  Future<void> _performRefresh() async {
    if (_refreshing || !widget.enabled) return;

    setState(() {
      _refreshing = true;
      _pullDistance = widget.triggerDistance;
    });

    _updateWaveAnimation();

    try {
      await widget.onRefresh();
    } catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'clay_ui_kit',
          context: ErrorDescription(
            'while executing ClayRefreshIndicator.onRefresh',
          ),
        ),
      );
    } finally {
      if (mounted) {
        _resetIndicator();
      }
    }
  }

  void _resetIndicator() {
    if (!mounted) return;

    setState(() {
      _pullDistance = 0;
      _dragging = false;
      _refreshing = false;
    });

    _updateWaveAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final indicatorColor = widget.color ?? theme.primary;
    final surfaceColor = widget.backgroundColor ?? theme.container;

    final width = widget.indicatorSize * 1.65;
    final height = widget.indicatorSize;

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: AnimatedSlide(
                  offset: _visible ? Offset.zero : const Offset(0, -0.8),
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutBack,
                  child: AnimatedOpacity(
                    opacity: _visible ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: AnimatedScale(
                      scale: _visible ? 1 : 0.75,
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutBack,
                      child: AnimatedBuilder(
                        animation: _waveController,
                        builder: (context, child) {
                          final phase = _waveController.value;

                          final fill = _refreshing
                              ? 0.67 + math.sin(phase * 2 * math.pi) * 0.09
                              : _progress;

                          return CustomPaint(
                            foregroundPainter: ClayInnerShadowPainter(
                              shadowColor: theme.shadow,
                              lightColor: theme.light,
                              borderRadius: height / 2,
                              shadowSize: 2.5,
                              blurRadius: 7.0,
                            ),
                            child: Container(
                              width: width,
                              height: height,
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(height / 2),
                                border: Border.all(
                                  color: indicatorColor.withAlpha(45),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: indicatorColor.withAlpha(35),
                                    blurRadius: 18,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 5),
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withAlpha(90),
                                    blurRadius: 5,
                                    offset: const Offset(-2, -2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(height / 2),
                                child: CustomPaint(
                                  painter: _ClayWavePainter(
                                    color: indicatorColor,
                                    progress: fill.clamp(0.0, 1.0).toDouble(),
                                    phase: phase,
                                    refreshing: _refreshing,
                                  ),
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                          );
                        },
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
}

class _ClayWavePainter extends CustomPainter {
  final Color color;
  final double progress;
  final double phase;
  final bool refreshing;

  const _ClayWavePainter({
    required this.color,
    required this.progress,
    required this.phase,
    required this.refreshing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final clip = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(size.height / 2),
    );

    canvas.save();
    canvas.clipRRect(clip);

    final amplitude = refreshing ? 3.5 : 2.5;
    final baseY = size.height * (1 - progress * 0.78);
    final waveLength = size.width / 1.15;
    final offset = phase * waveLength;

    _drawWave(
      canvas: canvas,
      size: size,
      baseY: baseY + 3,
      amplitude: amplitude,
      waveLength: waveLength,
      offset: offset + waveLength * 0.35,
      paint: Paint()
        ..color = color.withAlpha(65)
        ..style = PaintingStyle.fill,
    );

    _drawWave(
      canvas: canvas,
      size: size,
      baseY: baseY,
      amplitude: amplitude,
      waveLength: waveLength,
      offset: offset,
      paint: Paint()
        ..color = color.withAlpha(175)
        ..style = PaintingStyle.fill,
    );

    final bubblePaint = Paint()
      ..color = color.withAlpha(150)
      ..style = PaintingStyle.fill;

    final bubblePositions = [
      Offset(size.width * 0.30, size.height * 0.28),
      Offset(size.width * 0.68, size.height * 0.40),
      Offset(size.width * 0.48, size.height * 0.19),
    ];

    for (var i = 0; i < bubblePositions.length; i++) {
      final base = bubblePositions[i];
      final movement = math.sin((phase * 2 * math.pi) + i * 1.8);

      final radius = i == 1 ? 2.0 : 1.5;

      canvas.drawCircle(
        Offset(base.dx, base.dy + movement * 2.5),
        radius,
        bubblePaint,
      );
    }

    canvas.restore();
  }

  void _drawWave({
    required Canvas canvas,
    required Size size,
    required double baseY,
    required double amplitude,
    required double waveLength,
    required double offset,
    required Paint paint,
  }) {
    final path = Path()..moveTo(0, size.height);

    for (double x = 0; x <= size.width; x += 2) {
      final y =
          baseY +
          math.sin(((x + offset) / waveLength) * 2 * math.pi) * amplitude;

      path.lineTo(x, y);
    }

    path
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ClayWavePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.progress != progress ||
        oldDelegate.phase != phase ||
        oldDelegate.refreshing != refreshing;
  }
}
