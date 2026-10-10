import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';
import '../types/positions.dart';

class ClaySheet {
  const ClaySheet._();

  static Future<void> show(
    BuildContext context, {
    required Widget child,
    ClaySheetPosition position = ClaySheetPosition.bottom,
    List<double> snapPoints = const [0.25, 0.5, 1.0],
    double initialSnapPoint = 0.5,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragHandle = true,
    Color? backgroundColor,
    Gradient? backgroundGradient,
    Color? barrierColor,
    double borderRadius = 26,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
    Duration duration = const Duration(milliseconds: 380),
    VoidCallback? onOpened,
    VoidCallback? onClosed,
  }) {
    assert(
      backgroundColor == null || backgroundGradient == null,
      'ClaySheet: use backgroundColor ou backgroundGradient, não ambos.',
    );

    assert(
      snapPoints.isNotEmpty,
      'ClaySheet: snapPoints não pode estar vazio.',
    );

    assert(
      initialSnapPoint > 0 && initialSnapPoint <= 1,
      'ClaySheet: initialSnapPoint deve estar entre 0 e 1.',
    );

    final overlay = Overlay.of(context, rootOverlay: true);
    final completer = Completer<void>();

    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _ClaySheetOverlay(
        position: position,
        snapPoints: snapPoints,
        initialSnapPoint: initialSnapPoint,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        backgroundGradient: backgroundGradient,
        barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.30),
        borderRadius: borderRadius,
        padding: padding,
        duration: duration,
        onOpened: onOpened,
        onClosed: onClosed,
        child: child,
        onDismissed: () {
          entry.remove();

          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      ),
    );

    overlay.insert(entry);

    return completer.future;
  }
}

class _ClaySheetOverlay extends StatefulWidget {
  final ClaySheetPosition position;
  final List<double> snapPoints;
  final double initialSnapPoint;

  final bool isDismissible;
  final bool enableDrag;
  final bool showDragHandle;

  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color barrierColor;

  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Duration duration;

  final Widget child;

  final VoidCallback? onOpened;
  final VoidCallback? onClosed;
  final VoidCallback onDismissed;

  const _ClaySheetOverlay({
    required this.position,
    required this.snapPoints,
    required this.initialSnapPoint,
    required this.isDismissible,
    required this.enableDrag,
    required this.showDragHandle,
    required this.backgroundColor,
    required this.backgroundGradient,
    required this.barrierColor,
    required this.borderRadius,
    required this.padding,
    required this.duration,
    required this.child,
    required this.onDismissed,
    this.onOpened,
    this.onClosed,
  });

  @override
  State<_ClaySheetOverlay> createState() => _ClaySheetOverlayState();
}

class _ClaySheetOverlayState extends State<_ClaySheetOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _openController;
  late final AnimationController _snapController;
  late final AnimationController _waveController;

  late Animation<double> _snapAnimation;
  late List<double> _snapPoints;

  double _extent = 0.5;
  double _wave = 0;
  double _waveOrigin = 0;

  bool _closing = false;
  bool _dragging = false;

  bool get _isVertical =>
      widget.position == ClaySheetPosition.bottom ||
      widget.position == ClaySheetPosition.top;

  double get _minExtent => _snapPoints.first;

  double get _maxExtent => _snapPoints.last;

  @override
  void initState() {
    super.initState();

    _snapPoints =
        widget.snapPoints
            .where((point) => point > 0 && point <= 1)
            .toSet()
            .toList()
          ..sort();

    if (_snapPoints.isEmpty) {
      _snapPoints = const [0.25, 0.5, 1.0];
    }

    _extent = _nearestSnap(widget.initialSnapPoint);

    _openController = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: Duration(
        milliseconds: (widget.duration.inMilliseconds * 0.8).round(),
      ),
    );

    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    )..addListener(_tickWave);

    _snapAnimation = AlwaysStoppedAnimation<double>(_extent);

    _snapController.addListener(() {
      if (!mounted) return;

      setState(() {
        _extent = _snapAnimation.value;
      });
    });

    _openController.forward().then((_) {
      if (mounted && !_closing) {
        widget.onOpened?.call();
      }
    });
  }

  void _tickWave() {
    if (!mounted) return;

    final t = _waveController.value;
    final decay = 1 - Curves.easeOut.transform(t);

    final oscillation = t >= 1
        ? 0.0
        : (1 - t) * 0.20 * math.sin(t * 6 * math.pi);

    setState(() {
      _wave = _waveOrigin * (decay + oscillation);

      if (t >= 1) {
        _wave = 0;
      }
    });
  }

  double _nearestSnap(double value) {
    return _snapPoints.reduce(
      (a, b) => (a - value).abs() <= (b - value).abs() ? a : b,
    );
  }

  Future<void> _close() async {
    if (_closing) return;

    _closing = true;

    _snapController.stop();
    _waveController.stop();

    if (mounted) {
      setState(() {
        _dragging = false;
        _wave = 0;
      });
    }

    await _openController.reverse();

    if (!mounted) return;

    widget.onClosed?.call();
    widget.onDismissed();
  }

  void _startDrag() {
    if (!widget.enableDrag || _closing || !_openController.isCompleted) {
      return;
    }

    _snapController.stop();
    _waveController.stop();

    setState(() {
      _dragging = true;
    });
  }

  void _updateDrag(Offset delta, double axisLength) {
    if (!widget.enableDrag ||
        _closing ||
        axisLength <= 0 ||
        !_openController.isCompleted) {
      return;
    }

    final change = switch (widget.position) {
      ClaySheetPosition.bottom => -delta.dy / axisLength,
      ClaySheetPosition.top => delta.dy / axisLength,
      ClaySheetPosition.left => delta.dx / axisLength,
      ClaySheetPosition.right => -delta.dx / axisLength,
    };

    final movement = _isVertical ? delta.dy : delta.dx;

    setState(() {
      final next = _extent + change;

      if (next < 0) {
        _extent = next * 0.18;
      } else if (next > _maxExtent) {
        _extent = _maxExtent + (next - _maxExtent) * 0.12;
      } else {
        _extent = next;
      }

      _wave = (movement * 0.85).clamp(-18.0, 18.0).toDouble();
    });
  }

  void _endDrag(Offset velocity, double axisLength) {
    if (!widget.enableDrag || _closing || axisLength <= 0) {
      return;
    }

    final primaryVelocity = _isVertical ? velocity.dy : velocity.dx;

    final outwardVelocity = switch (widget.position) {
      ClaySheetPosition.bottom => primaryVelocity,
      ClaySheetPosition.top => -primaryVelocity,
      ClaySheetPosition.left => -primaryVelocity,
      ClaySheetPosition.right => primaryVelocity,
    };

    final velocityExtent = switch (widget.position) {
      ClaySheetPosition.bottom => -primaryVelocity / axisLength,
      ClaySheetPosition.top => primaryVelocity / axisLength,
      ClaySheetPosition.left => primaryVelocity / axisLength,
      ClaySheetPosition.right => -primaryVelocity / axisLength,
    };

    final projectedExtent = (_extent + velocityExtent * 0.16)
        .clamp(0.0, _maxExtent)
        .toDouble();

    final shouldDismiss =
        widget.isDismissible &&
        (_extent < _minExtent * 0.55 || outwardVelocity > 850);

    _waveOrigin = _wave;

    _waveController.forward(from: 0);

    setState(() {
      _dragging = false;
    });

    if (shouldDismiss) {
      _close();
      return;
    }

    _animateTo(_nearestSnap(projectedExtent));
  }

  void _animateTo(double target) {
    _snapAnimation =
        Tween<double>(
          begin: _extent.clamp(0.0, _maxExtent).toDouble(),
          end: target,
        ).animate(
          CurvedAnimation(parent: _snapController, curve: Curves.easeOutCubic),
        );

    _snapController.forward(from: 0);
  }

  Alignment _alignment() {
    return switch (widget.position) {
      ClaySheetPosition.bottom => Alignment.bottomCenter,
      ClaySheetPosition.top => Alignment.topCenter,
      ClaySheetPosition.left => Alignment.centerLeft,
      ClaySheetPosition.right => Alignment.centerRight,
    };
  }

  Offset _exitOffset() {
    return switch (widget.position) {
      ClaySheetPosition.bottom => const Offset(0, 1),
      ClaySheetPosition.top => const Offset(0, -1),
      ClaySheetPosition.left => const Offset(-1, 0),
      ClaySheetPosition.right => const Offset(1, 0),
    };
  }

  BorderRadius _panelBorderRadius() {
    return switch (widget.position) {
      ClaySheetPosition.bottom => BorderRadius.vertical(
        top: Radius.circular(widget.borderRadius),
      ),
      ClaySheetPosition.top => BorderRadius.vertical(
        bottom: Radius.circular(widget.borderRadius),
      ),
      ClaySheetPosition.left => BorderRadius.horizontal(
        right: Radius.circular(widget.borderRadius),
      ),
      ClaySheetPosition.right => BorderRadius.horizontal(
        left: Radius.circular(widget.borderRadius),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final axisLength = _isVertical
                ? constraints.maxHeight
                : constraints.maxWidth;

            return AnimatedBuilder(
              animation: _openController,
              builder: (context, _) {
                final progress = Curves.easeOutCubic.transform(
                  _openController.value,
                );

                final currentExtent = _extent.clamp(0.08, _maxExtent);

                return Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: widget.isDismissible ? _close : null,
                        child: ColoredBox(
                          color: widget.barrierColor.withValues(
                            alpha: widget.barrierColor.a * progress,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: _alignment(),
                      child: FractionalTranslation(
                        translation: Offset(
                          _exitOffset().dx * (1 - progress),
                          _exitOffset().dy * (1 - progress),
                        ),
                        child: CustomPaint(
                          foregroundPainter: ClayInnerShadowPainter(
                            shadowColor: theme.shadow,
                            lightColor: theme.light,
                            borderRadius: widget.borderRadius,
                            shadowSize: 2.5,
                            blurRadius: 7,
                          ),
                          child: Container(
                            width: _isVertical
                                ? constraints.maxWidth
                                : axisLength * currentExtent,
                            height: _isVertical
                                ? axisLength * currentExtent
                                : constraints.maxHeight,
                            decoration: BoxDecoration(
                              color: widget.backgroundGradient == null
                                  ? widget.backgroundColor ?? theme.container
                                  : null,
                              gradient: widget.backgroundGradient,
                              borderRadius: _panelBorderRadius(),
                              boxShadow: ClayShadows.external(
                                theme: theme,
                                offset: 5,
                                blur: 22,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: _panelBorderRadius(),
                              child: _buildContent(context, axisLength),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, double axisLength) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableAxis = _isVertical
            ? constraints.maxHeight
            : constraints.maxWidth;

        final minimumContentSize = widget.showDragHandle ? 48.0 : 1.0;

        if (availableAxis < minimumContentSize) {
          return const SizedBox.shrink();
        }

        final handle = widget.showDragHandle
            ? _buildDragHandle(context, axisLength)
            : const SizedBox.shrink();

        return ClipRect(
          child: SafeArea(
            top: widget.position != ClaySheetPosition.bottom,
            bottom: widget.position != ClaySheetPosition.top,
            left: widget.position != ClaySheetPosition.left,
            right: widget.position != ClaySheetPosition.right,
            child: switch (widget.position) {
              ClaySheetPosition.bottom => Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (widget.showDragHandle)
                    SizedBox(height: 48, child: handle),
                  Expanded(
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                ],
              ),

              ClaySheetPosition.top => Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                  if (widget.showDragHandle)
                    SizedBox(height: 48, child: handle),
                ],
              ),

              ClaySheetPosition.left => Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                  if (widget.showDragHandle) SizedBox(width: 48, child: handle),
                ],
              ),

              ClaySheetPosition.right => Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (widget.showDragHandle) SizedBox(width: 48, child: handle),
                  Expanded(
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            },
          ),
        );
      },
    );
  }

  Widget _buildDragHandle(BuildContext context, double axisLength) {
    final theme = context.clayTheme;
    final isVertical = _isVertical;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      dragStartBehavior: DragStartBehavior.down,
      onPanStart: widget.enableDrag ? (_) => _startDrag() : null,
      onPanUpdate: widget.enableDrag
          ? (details) => _updateDrag(details.delta, axisLength)
          : null,
      onPanEnd: widget.enableDrag
          ? (details) => _endDrag(details.velocity.pixelsPerSecond, axisLength)
          : null,
      child: SizedBox(
        width: isVertical ? double.infinity : 48,
        height: isVertical ? 48 : double.infinity,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            width: isVertical ? (_dragging ? 56 : 42) : 12,
            height: isVertical ? 12 : (_dragging ? 56 : 42),
            child: CustomPaint(
              painter: _ClayWaveHandlePainter(
                color: theme.onBackground.withValues(
                  alpha: _dragging ? 0.48 : 0.25,
                ),
                lightColor: theme.light,
                wave: _wave,
                isVertical: isVertical,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _openController.dispose();
    _snapController.dispose();
    _waveController.dispose();
    super.dispose();
  }
}

class _ClayWaveHandlePainter extends CustomPainter {
  final Color color;
  final Color lightColor;
  final double wave;
  final bool isVertical;

  const _ClayWaveHandlePainter({
    required this.color,
    required this.lightColor,
    required this.wave,
    required this.isVertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isVertical) {
      _paintHorizontal(canvas, Offset.zero & size);
    } else {
      canvas.save();
      canvas.translate(size.width, 0);
      canvas.rotate(math.pi / 2);

      _paintHorizontal(canvas, Rect.fromLTWH(0, 0, size.height, size.width));

      canvas.restore();
    }
  }

  void _paintHorizontal(Canvas canvas, Rect rect) {
    final path = Path()
      ..moveTo(rect.left + 5, rect.center.dy)
      ..quadraticBezierTo(
        rect.center.dx,
        rect.center.dy + wave,
        rect.right - 5,
        rect.center.dy,
      );

    final lightPaint = Paint()
      ..color = lightColor.withValues(alpha: 0.72)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final handlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, lightPaint);
    canvas.drawPath(path, handlePaint);
  }

  @override
  bool shouldRepaint(covariant _ClayWaveHandlePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.lightColor != lightColor ||
        oldDelegate.wave != wave ||
        oldDelegate.isVertical != isVertical;
  }
}
