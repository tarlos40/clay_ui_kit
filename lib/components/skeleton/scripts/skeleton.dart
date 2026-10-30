import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/shapes.dart';
import '../../../palette/types/colors.dart';

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
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ClaySkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BorderRadius _getBorderRadius() {
    return switch (widget.shape) {
      ClaySkeletonShape.circle => BorderRadius.circular(999),
      ClaySkeletonShape.pill => BorderRadius.circular(999),
      ClaySkeletonShape.rectangle => BorderRadius.circular(widget.borderRadius),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final base =
        widget.baseColor ?? theme.onBackgroundVariant.withValues(alpha: 0.10);

    final highlight =
        widget.highlightColor ?? Color.lerp(base, theme.onBackground, 0.18)!;

    final radius = _getBorderRadius();

    final placeholder = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: base,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: ClayColors.ocean.s50.withValues(alpha: 0.18),
            offset: const Offset(-1, -1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: ClayColors.slate.s950.withValues(alpha: 0.025),
            offset: const Offset(1, 2),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.child,
    );

    if (!widget.enabled || MediaQuery.disableAnimationsOf(context)) {
      return placeholder;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: placeholder,
      builder: (context, child) {
        final progress = Curves.easeInOut.transform(_controller.value);

        // A faixa de luz percorre toda a superfície suavemente.
        final start = -1.6 + (progress * 3.2);

        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(start, 0),
              end: Alignment(start + 1.4, 0),
              colors: [
                base,
                Color.lerp(base, highlight, 0.45)!,
                highlight,
                Color.lerp(base, highlight, 0.45)!,
                base,
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}

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
  Widget build(BuildContext context) {
    return Padding(
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
}
