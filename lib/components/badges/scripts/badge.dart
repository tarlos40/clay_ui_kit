import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';
import '../../../components/texts/scripts/text.dart';
import '../types/positions.dart';

class ClayBadge extends StatefulWidget {
  final Widget? child;
  final Widget? icon;
  final String? label;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final VoidCallback? onPressed;
  final VoidCallback? onClose;

  final EdgeInsetsGeometry? padding;
  final double? height;

  final Widget? target;

  final ClayBadgePosition? position;
  final double offset;
  final double size;

  const ClayBadge({
    super.key,
    this.child,
    this.icon,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
    this.onClose,
    this.padding,
    this.height,
  }) : target = null,
       position = null,
       offset = 0,
       size = 22,
       assert(
         child == null || label == null,
         'ClayBadge: child and label cannot be used together.',
       ),
       assert(
         child == null || icon == null,
         'ClayBadge: child and icon cannot be used together.',
       ),
       assert(
         label != null || icon != null || child != null,
         'ClayBadge: provide a child, label or icon.',
       );

  const ClayBadge.circle({
    super.key,
    required this.target,
    this.child,
    this.icon,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.position = ClayBadgePosition.topRight,
    this.offset = 0,
    this.size = 16,
  }) : onPressed = null,
       onClose = null,
       padding = null,
       height = null,
       assert(
         child == null || label == null,
         'ClayBadge.circle: child and label cannot be used together.',
       ),
       assert(
         child == null || icon == null,
         'ClayBadge.circle: child and icon cannot be used together.',
       ),
       assert(
         label == null || icon == null,
         'ClayBadge.circle: label and icon cannot be used together.',
       ),
       assert(size > 0, 'ClayBadge.circle: size must be greater than zero.'),
       assert(offset >= 0, 'ClayBadge.circle: offset cannot be negative.');

  @override
  State<ClayBadge> createState() => _ClayBadgeState();
}

class _ClayBadgeState extends State<ClayBadge> {
  bool _pressed = false;
  bool _visible = true;

  void _setPressed(bool value) {
    if (widget.onPressed == null) return;

    setState(() {
      _pressed = value;
    });
  }

  void _close() {
    if (!_visible) return;

    setState(() {
      _visible = false;
    });

    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    if (widget.target != null) {
      return _buildCircle(context);
    }

    return _buildStandard(context);
  }

  Widget _buildStandard(BuildContext context) {
    final theme = context.clayTheme;

    final background = widget.backgroundColor ?? theme.container;

    final foreground = widget.foregroundColor ?? theme.onContainer;

    final content = _buildContent(
      context,
      foreground: foreground,
      iconSize: 16,
    );

    final badge = CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: 12,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        height: widget.height ?? 32,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _pressed
              ? ClayShadows.external(theme: theme, offset: 1, blur: 3)
              : ClayShadows.external(theme: theme, offset: 2, blur: 6),
        ),
        child: content,
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.onPressed != null ? (_) => _setPressed(true) : null,
      onTapUp: widget.onPressed != null ? (_) => _setPressed(false) : null,
      onTapCancel: widget.onPressed != null ? () => _setPressed(false) : null,
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: badge,
      ),
    );
  }

  Widget _buildCircle(BuildContext context) {
    final badge = _buildCircleBadge(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.target!,

        Positioned(
          top: _topOffset(),
          right: _rightOffset(),
          bottom: _bottomOffset(),
          left: _leftOffset(),
          child: badge,
        ),
      ],
    );
  }

  Widget _buildCircleBadge(BuildContext context) {
    final theme = context.clayTheme;

    final background = widget.backgroundColor ?? theme.primary;

    final foreground = widget.foregroundColor ?? theme.onPrimary;

    return AnimatedScale(
      scale: _pressed ? 0.92 : 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: widget.size / 2,
          shadowSize: _pressed ? 1 : 1.5,
          blurRadius: _pressed ? 3 : 5,
        ),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
            boxShadow: ClayShadows.external(
              theme: theme,
              offset: _pressed ? 1 : 2,
              blur: _pressed ? 2 : 5,
            ),
          ),
          child: ClipOval(
            child: _buildCircleContent(context, foreground: foreground),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleContent(
    BuildContext context, {
    required Color foreground,
  }) {
    // Custom content has priority.
    if (widget.child != null) {
      return Center(child: widget.child!);
    }

    if (widget.icon != null) {
      return Center(
        child: IconTheme(
          data: IconThemeData(color: foreground, size: widget.size * 0.5),
          child: widget.icon!,
        ),
      );
    }

    if (widget.label != null) {
      return Center(
        child: Text(
          widget.label!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: foreground,
            fontSize: _circleFontSize(),
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  double _circleFontSize() {
    if (widget.size <= 14) return 6;

    if (widget.size <= 16) return 7;

    if (widget.size <= 20) return 8;

    if (widget.size <= 24) return 9;

    if (widget.size <= 28) return 11;

    if (widget.size <= 32) return 13;

    return widget.size * 0.4;
  }

  double? _topOffset() {
    switch (widget.position) {
      case ClayBadgePosition.topLeft:
      case ClayBadgePosition.topRight:
        return -widget.offset;

      case ClayBadgePosition.bottomLeft:
      case ClayBadgePosition.bottomRight:
        return null;

      default:
        return -widget.offset;
    }
  }

  double? _rightOffset() {
    switch (widget.position) {
      case ClayBadgePosition.topRight:
      case ClayBadgePosition.bottomRight:
        return -widget.offset;

      case ClayBadgePosition.topLeft:
      case ClayBadgePosition.bottomLeft:
        return null;

      default:
        return -widget.offset;
    }
  }

  double? _bottomOffset() {
    switch (widget.position) {
      case ClayBadgePosition.bottomLeft:
      case ClayBadgePosition.bottomRight:
        return -widget.offset;

      case ClayBadgePosition.topLeft:
      case ClayBadgePosition.topRight:
        return null;

      default:
        return null;
    }
  }

  double? _leftOffset() {
    switch (widget.position) {
      case ClayBadgePosition.topLeft:
      case ClayBadgePosition.bottomLeft:
        return -widget.offset;

      case ClayBadgePosition.topRight:
      case ClayBadgePosition.bottomRight:
        return null;

      default:
        return null;
    }
  }

  Widget _buildContent(
    BuildContext context, {
    required Color foreground,
    required double iconSize,
  }) {
    final content = <Widget>[];

    if (widget.icon != null) {
      content.add(
        IconTheme(
          data: IconThemeData(color: foreground, size: iconSize),
          child: widget.icon!,
        ),
      );
    }

    if (widget.label != null) {
      if (content.isNotEmpty) {
        content.add(const SizedBox(width: 5));
      }

      content.add(
        ClayText.label(
          widget.label!,
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (widget.child != null) {
      if (content.isNotEmpty) {
        content.add(const SizedBox(width: 5));
      }

      content.add(widget.child!);
    }

    if (widget.onClose != null) {
      if (content.isNotEmpty) {
        content.add(const SizedBox(width: 5));
      }

      content.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _close,
          child: Icon(
            Icons.close_rounded,
            size: iconSize * 0.85,
            color: foreground.withValues(alpha: 0.75),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );
  }
}
