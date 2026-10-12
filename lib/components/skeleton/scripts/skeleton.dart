import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/shapes.dart';

/// Shimmering placeholder used while content is being fetched.
class ClaySkeleton extends StatefulWidget {
  const ClaySkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.shape = ClaySkeletonShape.rectangle,
    this.borderRadius = 12,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1400),
    this.enabled = true,
    this.child,
  });

  const ClaySkeleton.circle({
    super.key,
    required double size,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1400),
    this.enabled = true,
    this.child,
  }) : width = size,
       height = size,
       shape = ClaySkeletonShape.circle,
       borderRadius = 999;

  const ClaySkeleton.text({
    super.key,
    this.width,
    this.height = 13,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1400),
    this.enabled = true,
  }) : shape = ClaySkeletonShape.pill,
       borderRadius = 999,
       child = null;

  final double? width;
  final double height;
  final ClaySkeletonShape shape;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  final bool enabled;
  final Widget? child;

  @override
  State<ClaySkeleton> createState() => _ClaySkeletonState();
}

class _ClaySkeletonState extends State<ClaySkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void didUpdateWidget(covariant ClaySkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration)
      _controller.duration = widget.duration;
    if (widget.enabled && !_controller.isAnimating) _controller.repeat();
    if (!widget.enabled && _controller.isAnimating) _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final base =
        widget.baseColor ?? theme.onBackgroundVariant.withValues(alpha: .12);
    final highlight =
        widget.highlightColor ?? theme.onBackground.withValues(alpha: .06);
    final radius = switch (widget.shape) {
      ClaySkeletonShape.circle => BorderRadius.circular(999),
      ClaySkeletonShape.pill => BorderRadius.circular(999),
      ClaySkeletonShape.rectangle => BorderRadius.circular(widget.borderRadius),
    };

    Widget placeholder = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: base,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: .20),
            offset: const Offset(-1, -1),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),
            offset: const Offset(1, 2),
            blurRadius: 4,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.child,
    );

    if (!widget.enabled) return placeholder;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          final position = (_controller.value * 2.4) - .7;
          return LinearGradient(
            begin: Alignment(position - 1, 0),
            end: Alignment(position + 1, 0),
            colors: [base, Color.lerp(base, highlight, .95) ?? highlight, base],
            stops: const [0.25, 0.5, 0.75],
          ).createShader(bounds);
        },
        child: child,
      ),
      child: placeholder,
    );
  }
}

/// Convenience layout for a typical avatar + text skeleton row.
class ClaySkeletonListTile extends StatelessWidget {
  const ClaySkeletonListTile({
    super.key,
    this.avatarSize = 44,
    this.titleWidth = 150,
    this.subtitleWidth = 105,
    this.spacing = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  final double avatarSize;
  final double titleWidth;
  final double subtitleWidth;
  final double spacing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Row(
      children: [
        ClaySkeleton.circle(size: avatarSize),
        SizedBox(width: spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClaySkeleton.text(width: titleWidth, height: 14),
              const SizedBox(height: 8),
              ClaySkeleton.text(width: subtitleWidth, height: 11),
            ],
          ),
        ),
      ],
    ),
  );
}
