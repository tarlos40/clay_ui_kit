import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';
import '../../../components/texts/scripts/text.dart';
import '../types/sizes.dart';

class ClayFloatingActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Widget? icon;
  final String? label;
  final Color? backgroundColor;
  final Color? onBackgroundColor;
  final ClayFloatingActionButtonSize size;
  final String? tooltip;
  final Object? heroTag;
  final bool extend;
  final EdgeInsetsGeometry? padding;

  const ClayFloatingActionButton({
    super.key,
    required this.onPressed,
    this.child,
    this.icon,
    this.label,
    this.backgroundColor,
    this.onBackgroundColor,
    this.size = ClayFloatingActionButtonSize.base,
    this.tooltip,
    this.heroTag,
    this.extend = false,
    this.padding,
  }) : assert(
         child != null || icon != null,
         'ClayFloatingActionButton: `icon` or `child` must be provided.',
       ),
       assert(
         child == null || icon == null,
         'ClayFloatingActionButton: use `child` or `icon`, not both.',
       ),
       assert(
         !extend || label != null,
         'ClayFloatingActionButton: `label` is required when extend is true.',
       );

  @override
  State<ClayFloatingActionButton> createState() =>
      _ClayFloatingActionButtonState();
}

class _ClayFloatingActionButtonState extends State<ClayFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _scale;
  late final Animation<double> _translateY;

  bool get _pressed => _animationController.value > 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      reverseDuration: const Duration(milliseconds: 220),
    );

    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeOutCubic,
    );

    _scale = Tween<double>(begin: 1.0, end: 0.94).animate(curve);

    _translateY = Tween<double>(begin: 0.0, end: 2.0).animate(curve);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed == null) return;

    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  double _size() {
    switch (widget.size) {
      case ClayFloatingActionButtonSize.small:
        return 48.0;
      case ClayFloatingActionButtonSize.base:
        return 56.0;
      case ClayFloatingActionButtonSize.large:
        return 64.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final backgroundColor = widget.backgroundColor ?? theme.primary;
    final onBackground = widget.onBackgroundColor ?? theme.onPrimary;
    final size = _size();

    final content = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _translateY.value),
          child: Transform.scale(scale: _scale.value, child: child),
        );
      },
      child: _buildButton(
        context,
        background: backgroundColor,
        onBackground: onBackground,
        size: size,
      ),
    );

    final button = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: content,
    );

    final hero = widget.heroTag != null
        ? Hero(tag: widget.heroTag!, child: button)
        : button;

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: hero);
    }

    return hero;
  }

  Widget _buildButton(
    BuildContext context, {
    required Color background,
    required Color onBackground,
    required double size,
  }) {
    final theme = context.clayTheme;
    final isExtended = widget.extend || widget.label != null;
    final radius = BorderRadius.circular(isExtended ? 28 : size / 2);

    return CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: isExtended ? 28 : size / 2,
        shadowSize: _pressed ? 1.5 : 2,
        blurRadius: _pressed ? 5 : 8,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        constraints: BoxConstraints(
          minWidth: isExtended ? 0 : size,
          maxWidth: isExtended ? double.infinity : size,
          minHeight: size,
          maxHeight: size,
        ),
        padding:
            widget.padding ??
            EdgeInsets.symmetric(horizontal: isExtended ? 20 : 0, vertical: 0),
        decoration: BoxDecoration(
          color: background,
          borderRadius: radius,
          boxShadow: _pressed
              ? ClayShadows.external(theme: theme, offset: 1, blur: 3)
              : ClayShadows.external(theme: theme, offset: 3, blur: 8),
        ),
        child: _buildContent(onBackground, isExtended),
      ),
    );
  }

  Widget _buildContent(Color onBackground, bool isExtended) {
    final icon = widget.icon ?? widget.child ?? const SizedBox.shrink();

    if (!isExtended) {
      return Center(
        child: IconTheme(
          data: IconThemeData(size: 24, color: onBackground),
          child: icon,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconTheme(
          data: IconThemeData(color: onBackground),
          child: icon,
        ),

        if (widget.label != null) ...[
          const SizedBox(width: 8),

          ClayText.label(
            widget.label!,
            color: onBackground,
            fontWeight: FontWeight.w800,
          ),
        ],
      ],
    );
  }
}
