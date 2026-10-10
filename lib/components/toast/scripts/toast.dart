import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';
import '../types/positions.dart';
import '../types/variants.dart';

class _ClayToastData {
  final int id;
  final String message;
  final String? title;
  final ClayToastVariant variant;
  final ClayToastPosition position;
  final Duration? duration;
  final bool showTimer;
  final bool showCloseButton;
  final bool dismissOnSwipe;
  final bool marquee;
  final Widget? icon;

  _ClayToastData({
    required this.id,
    required this.message,
    required this.variant,
    required this.position,
    required this.duration,
    required this.showTimer,
    required this.showCloseButton,
    required this.dismissOnSwipe,
    required this.marquee,
    this.title,
    this.icon,
  });
}

class ClayToast {
  ClayToast._();

  static OverlayState? _overlay;
  static OverlayEntry? _entry;
  static bool _initScheduled = false;
  static int _nextId = 0;

  static final ValueNotifier<List<_ClayToastData>> _toasts =
      ValueNotifier<List<_ClayToastData>>([]);

  static void init(BuildContext context) {
    final targetOverlay = Overlay.of(context, rootOverlay: true);

    if (identical(_overlay, targetOverlay) && _entry != null) {
      return;
    }

    _overlay = targetOverlay;

    if (_initScheduled) return;

    _initScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initScheduled = false;

      final overlay = _overlay;

      if (overlay == null || !overlay.mounted) return;

      final previousEntry = _entry;
      _entry = null;

      if (previousEntry != null) {
        previousEntry.remove();
      }

      final entry = OverlayEntry(
        builder: (_) => _ClayToastHost(toasts: _toasts, onDismiss: dismiss),
      );

      _entry = entry;
      overlay.insert(entry);
    });
  }

  static int primary(
    String message, {
    String? title,
    Widget? icon,
    Duration? duration = const Duration(seconds: 4),
    ClayToastPosition position = ClayToastPosition.topCenter,
    bool showTimer = false,
    bool showCloseButton = true,
    bool dismissOnSwipe = true,
    bool marquee = false,
  }) {
    return _show(
      message,
      variant: ClayToastVariant.primary,
      title: title,
      icon: icon,
      duration: duration,
      position: position,
      showTimer: showTimer,
      showCloseButton: showCloseButton,
      dismissOnSwipe: dismissOnSwipe,
      marquee: marquee,
    );
  }

  static int success(
    String message, {
    String? title,
    Widget? icon,
    Duration? duration = const Duration(seconds: 4),
    ClayToastPosition position = ClayToastPosition.topCenter,
    bool showTimer = false,
    bool showCloseButton = true,
    bool dismissOnSwipe = true,
    bool marquee = false,
  }) {
    return _show(
      message,
      variant: ClayToastVariant.success,
      title: title,
      icon: icon,
      duration: duration,
      position: position,
      showTimer: showTimer,
      showCloseButton: showCloseButton,
      dismissOnSwipe: dismissOnSwipe,
      marquee: marquee,
    );
  }

  static int error(
    String message, {
    String? title,
    Widget? icon,
    Duration? duration = const Duration(seconds: 5),
    ClayToastPosition position = ClayToastPosition.topCenter,
    bool showTimer = false,
    bool showCloseButton = true,
    bool dismissOnSwipe = true,
    bool marquee = false,
  }) {
    return _show(
      message,
      variant: ClayToastVariant.error,
      title: title,
      icon: icon,
      duration: duration,
      position: position,
      showTimer: showTimer,
      showCloseButton: showCloseButton,
      dismissOnSwipe: dismissOnSwipe,
      marquee: marquee,
    );
  }

  static int warning(
    String message, {
    String? title,
    Widget? icon,
    Duration? duration = const Duration(seconds: 4),
    ClayToastPosition position = ClayToastPosition.topCenter,
    bool showTimer = false,
    bool showCloseButton = true,
    bool dismissOnSwipe = true,
    bool marquee = false,
  }) {
    return _show(
      message,
      variant: ClayToastVariant.warning,
      title: title,
      icon: icon,
      duration: duration,
      position: position,
      showTimer: showTimer,
      showCloseButton: showCloseButton,
      dismissOnSwipe: dismissOnSwipe,
      marquee: marquee,
    );
  }

  static int _show(
    String message, {
    required ClayToastVariant variant,
    required ClayToastPosition position,
    required Duration? duration,
    required bool showTimer,
    required bool showCloseButton,
    required bool dismissOnSwipe,
    required bool marquee,
    String? title,
    Widget? icon,
  }) {
    assert(
      _overlay != null,
      'ClayToast: call ClayToast.init(context) before displaying notifications.',
    );

    final id = ++_nextId;

    final toast = _ClayToastData(
      id: id,
      message: message,
      variant: variant,
      position: position,
      duration: duration,
      showTimer: showTimer,
      showCloseButton: showCloseButton,
      dismissOnSwipe: dismissOnSwipe,
      marquee: marquee,
      title: title,
      icon: icon,
    );

    _toasts.value = [..._toasts.value, toast];

    return id;
  }

  static void dismiss(int id) {
    final remaining = _toasts.value
        .where((toast) => toast.id != id)
        .toList(growable: false);

    if (remaining.length == _toasts.value.length) return;

    _toasts.value = remaining;
  }

  static void dismissAll() {
    if (_toasts.value.isEmpty) return;

    _toasts.value = [];
  }
}

class _ClayToastHost extends StatelessWidget {
  final ValueListenable<List<_ClayToastData>> toasts;
  final ValueChanged<int> onDismiss;

  const _ClayToastHost({required this.toasts, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ValueListenableBuilder<List<_ClayToastData>>(
        valueListenable: toasts,
        builder: (context, items, _) {
          final positions = <ClayToastPosition, int>{};

          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (final toast in items)
                Builder(
                  key: ValueKey(toast.id),
                  builder: (context) {
                    final index = positions[toast.position] ?? 0;
                    positions[toast.position] = index + 1;

                    return _positionToast(
                      context,
                      toast,
                      index,
                      () => onDismiss(toast.id),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _positionToast(
    BuildContext context,
    _ClayToastData toast,
    int index,
    VoidCallback onDismiss,
  ) {
    const spacing = 12.0;
    const estimatedHeight = 82.0;
    final offset = 48 + index * (estimatedHeight + spacing);

    final isTop =
        toast.position == ClayToastPosition.topLeft ||
        toast.position == ClayToastPosition.topCenter ||
        toast.position == ClayToastPosition.topRight;

    final isLeft =
        toast.position == ClayToastPosition.topLeft ||
        toast.position == ClayToastPosition.bottomLeft;

    final isRight =
        toast.position == ClayToastPosition.topRight ||
        toast.position == ClayToastPosition.bottomRight;

    final isCenter =
        toast.position == ClayToastPosition.topCenter ||
        toast.position == ClayToastPosition.bottomCenter;

    return Positioned(
      top: isTop ? offset : null,
      bottom: isTop ? null : offset,
      left: isLeft ? 16 : (isCenter ? 16 : null),
      right: isRight ? 16 : (isCenter ? 16 : null),
      child: isCenter
          ? Align(
              alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
              heightFactor: 1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: _ClayToastCard(toast: toast, onDismiss: onDismiss),
              ),
            )
          : ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: _ClayToastCard(toast: toast, onDismiss: onDismiss),
            ),
    );
  }
}

class _ClayToastCard extends StatefulWidget {
  final _ClayToastData toast;
  final VoidCallback onDismiss;

  const _ClayToastCard({required this.toast, required this.onDismiss});

  @override
  State<_ClayToastCard> createState() => _ClayToastCardState();
}

class _ClayToastCardState extends State<_ClayToastCard>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final AnimationController _timerController;
  Timer? _timer;

  double _dragX = 0;
  bool _closing = false;

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _timerController = AnimationController(
      vsync: this,
      duration: widget.toast.duration ?? const Duration(seconds: 4),
    );

    if (widget.toast.duration != null) {
      _timerController.forward();

      _timer = Timer(widget.toast.duration!, _dismiss);
    }
  }

  Future<void> _dismiss() async {
    if (_closing) return;
    _closing = true;

    _timer?.cancel();

    await _entrance.reverse();

    if (mounted) widget.onDismiss();
  }

  Color _accent(BuildContext context) {
    final theme = context.clayTheme;

    switch (widget.toast.variant) {
      case ClayToastVariant.success:
        return theme.success;
      case ClayToastVariant.error:
        return theme.error;
      case ClayToastVariant.warning:
        return theme.warning;
      case ClayToastVariant.primary:
        return theme.primary;
    }
  }

  Color _accentIcon(BuildContext context) {
    final theme = context.clayTheme;

    switch (widget.toast.variant) {
      case ClayToastVariant.success:
        return theme.onSuccess;
      case ClayToastVariant.error:
        return theme.onError;
      case ClayToastVariant.warning:
        return theme.onWarning;
      case ClayToastVariant.primary:
        return theme.onPrimary;
    }
  }

  IconData _defaultIcon() {
    switch (widget.toast.variant) {
      case ClayToastVariant.success:
        return Icons.check_circle_rounded;
      case ClayToastVariant.error:
        return Icons.error_rounded;
      case ClayToastVariant.warning:
        return Icons.warning_rounded;
      case ClayToastVariant.primary:
        return Icons.notifications_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final accent = _accent(context);
    final accentIcon = _accentIcon(context);

    return AnimatedBuilder(
      animation: _entrance,
      builder: (context, child) {
        final value = Curves.easeOutCubic.transform(_entrance.value);

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - value)),
            child: Transform.translate(offset: Offset(_dragX, 0), child: child),
          ),
        );
      },
      child: GestureDetector(
        onHorizontalDragUpdate: widget.toast.dismissOnSwipe
            ? (details) {
                setState(() {
                  _dragX += details.delta.dx;
                });
              }
            : null,
        onHorizontalDragEnd: widget.toast.dismissOnSwipe
            ? (_) {
                if (_dragX.abs() > 80) {
                  _dismiss();
                } else {
                  setState(() => _dragX = 0);
                }
              }
            : null,
        child: CustomPaint(
          foregroundPainter: ClayInnerShadowPainter(
            shadowColor: theme.shadow,
            lightColor: theme.light,
            borderRadius: 20,
            shadowSize: 2.5,
            blurRadius: 7.0,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.container,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
              boxShadow: ClayShadows.external(
                theme: theme,
                offset: 4,
                blur: 14,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 10, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPaint(
                        foregroundPainter: ClayInnerShadowPainter(
                          shadowColor: theme.shadow,
                          lightColor: theme.light,
                          borderRadius: 12,
                          shadowSize: 2.5,
                          blurRadius: 7.0,
                        ),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: ClayShadows.external(
                              theme: theme,
                              offset: 2.5,
                              blur: 7,
                            ),
                          ),
                          child: Center(
                            child: IconTheme(
                              data: IconThemeData(color: accentIcon, size: 21),
                              child: widget.toast.icon ?? Icon(_defaultIcon()),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.toast.title != null) ...[
                              Text(
                                widget.toast.title!,
                                style: TextStyle(
                                  color: theme.onContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            if (widget.toast.marquee)
                              _ClayMarqueeText(
                                text: widget.toast.message,
                                color: theme.onContainer,
                              )
                            else
                              Text(
                                widget.toast.message,
                                style: TextStyle(
                                  color: theme.onContainer.withValues(
                                    alpha: 0.8,
                                  ),
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (widget.toast.showCloseButton) ...[
                        const SizedBox(width: 8),
                        CustomPaint(
                          foregroundPainter: ClayInnerShadowPainter(
                            shadowColor: theme.shadow,
                            lightColor: theme.light,
                            borderRadius: 100,
                            shadowSize: 2.5,
                            blurRadius: 7.0,
                          ),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _dismiss,
                            child: AnimatedScale(
                              scale: 1,
                              duration: const Duration(milliseconds: 120),
                              curve: Curves.easeOutCubic,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: theme.error,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: ClayShadows.external(
                                    theme: theme,
                                    offset: 2,
                                    blur: 6,
                                  ),
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 19,
                                  color: theme.onError,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.toast.showTimer && widget.toast.duration != null)
                  AnimatedBuilder(
                    animation: _timerController,
                    builder: (_, _) {
                      return LinearProgressIndicator(
                        value: 1 - _timerController.value,
                        minHeight: 3,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _entrance.dispose();
    _timerController.dispose();
    super.dispose();
  }
}

class _ClayMarqueeText extends StatefulWidget {
  final String text;
  final Color color;

  const _ClayMarqueeText({required this.text, required this.color});

  @override
  State<_ClayMarqueeText> createState() => _ClayMarqueeTextState();
}

class _ClayMarqueeTextState extends State<_ClayMarqueeText> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_started) return;
    _started = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _startMarquee();
    });
  }

  Future<void> _startMarquee() async {
    while (mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 900));

      if (!mounted || !_controller.hasClients) return;

      final max = _controller.position.maxScrollExtent;

      if (max <= 0) return;

      await _controller.animateTo(
        max,
        duration: Duration(milliseconds: (max * 30).round().clamp(800, 8000)),
        curve: Curves.linear,
      );

      await Future<void>.delayed(const Duration(milliseconds: 500));

      if (!mounted || !_controller.hasClients) return;

      await _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Text(
        widget.text,
        maxLines: 1,
        softWrap: false,
        style: TextStyle(
          color: widget.color.withValues(alpha: 0.8),
          fontSize: 13,
          height: 1.4,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
