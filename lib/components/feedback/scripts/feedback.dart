import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/status.dart';
import '../../../theme/scripts/shadows.dart';
import '../../text/scripts/text.dart';
import '../../button/scripts/button.dart';

class ClayFeedback extends StatefulWidget {
  final ClayFeedbackStatus status;
  final String? title;
  final String? message;
  final IconData? icon;
  final Color? color;
  final bool compact;
  final bool animate;
  final bool showIcon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Widget? illustration;

  const ClayFeedback({
    super.key,
    this.status = ClayFeedbackStatus.loading,
    this.title,
    this.message,
    this.icon,
    this.color,
    this.compact = false,
    this.animate = true,
    this.showIcon = true,
    this.actionLabel,
    this.onAction,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 24,
    this.illustration,
  });

  @override
  State<ClayFeedback> createState() => _ClayFeedbackState();
}

class _ClayFeedbackState extends State<ClayFeedback>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _scale = Tween<double>(
      begin: 0.82,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant ClayFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.status != widget.status ||
        oldWidget.title != widget.title ||
        oldWidget.message != widget.message) {
      if (widget.animate) {
        _controller.forward(from: 0);
      } else {
        _controller.value = 1;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _statusColor() {
    if (widget.color != null) return widget.color!;

    switch (widget.status) {
      case ClayFeedbackStatus.success:
        return context.clayTheme.success;
      case ClayFeedbackStatus.error:
        return context.clayTheme.error;
      case ClayFeedbackStatus.warning:
        return context.clayTheme.warning;
      case ClayFeedbackStatus.info:
        return context.clayTheme.primary;
      case ClayFeedbackStatus.empty:
        return context.clayTheme.tertiary;
      case ClayFeedbackStatus.loading:
        return context.clayTheme.primary;
    }
  }

  Color _statusForegroundColor() {
    if (widget.color != null) return widget.color!;

    switch (widget.status) {
      case ClayFeedbackStatus.success:
        return context.clayTheme.onSuccess;
      case ClayFeedbackStatus.error:
        return context.clayTheme.onError;
      case ClayFeedbackStatus.warning:
        return context.clayTheme.onWarning;
      case ClayFeedbackStatus.info:
        return context.clayTheme.onPrimary;
      case ClayFeedbackStatus.empty:
        return context.clayTheme.onTertiary;
      case ClayFeedbackStatus.loading:
        return context.clayTheme.onPrimary;
    }
  }

  IconData _statusIcon() {
    if (widget.icon != null) return widget.icon!;

    switch (widget.status) {
      case ClayFeedbackStatus.success:
        return Icons.check_rounded;
      case ClayFeedbackStatus.error:
        return Icons.close_rounded;
      case ClayFeedbackStatus.warning:
        return Icons.priority_high_rounded;
      case ClayFeedbackStatus.info:
        return Icons.info_outline_rounded;
      case ClayFeedbackStatus.empty:
        return Icons.inbox_rounded;
      case ClayFeedbackStatus.loading:
        return Icons.hourglass_top_rounded;
    }
  }

  String _defaultTitle() {
    switch (widget.status) {
      case ClayFeedbackStatus.success:
        return 'Tudo certo!';
      case ClayFeedbackStatus.error:
        return 'Algo deu errado';
      case ClayFeedbackStatus.warning:
        return 'Atenção';
      case ClayFeedbackStatus.info:
        return 'Informação';
      case ClayFeedbackStatus.empty:
        return 'Nada por aqui';
      case ClayFeedbackStatus.loading:
        return 'Carregando...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final accent = _statusColor();
    final accentForeground = _statusForegroundColor();
    final isCompact = widget.compact;

    final title = widget.title ?? _defaultTitle();

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: widget.borderRadius,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Container(
          width: double.infinity,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: theme.container,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: (theme.border).withValues(alpha: 0.65)),
            boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showIcon) ...[
                if (widget.illustration != null)
                  widget.illustration!
                else if (widget.status == ClayFeedbackStatus.loading)
                  SizedBox(
                    width: isCompact ? 32 : 54,
                    height: isCompact ? 32 : 54,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: accent,
                    ),
                  )
                else
                  CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      borderRadius: 100,
                      shadowSize: 2.5,
                      blurRadius: 7.0,
                    ),
                    child: Container(
                      width: isCompact ? 40 : 64,
                      height: isCompact ? 40 : 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accent,
                        border: Border.all(color: accent),
                        boxShadow: ClayShadows.external(
                          theme: theme,
                          offset: 1,
                          blur: 4,
                        ),
                      ),
                      child: Icon(
                        _statusIcon(),
                        color: accentForeground,
                        size: isCompact ? 23 : 34,
                      ),
                    ),
                  ),
                SizedBox(height: isCompact ? 12 : 20),
              ],
              ClayText.title(
                title,
                textAlign: TextAlign.center,
                color: theme.onContainer,
                fontSize: isCompact ? 20 : 24,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
              if (widget.message != null) ...[
                const SizedBox(height: 8),
                ClayText.body(
                  widget.message!,
                  textAlign: TextAlign.center,
                  color: theme.onBackgroundVariant,
                  fontSize: isCompact ? 12 : 16,
                  height: 1.55,
                ),
              ],
              if (widget.actionLabel != null && widget.onAction != null) ...[
                SizedBox(height: isCompact ? 14 : 22),
                ClayButton.primary(
                  widget.actionLabel!,
                  onPressed: widget.onAction,
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (!widget.animate) return content;

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(scale: _scale, child: content),
      ),
    );
  }
}
