import 'package:flutter/material.dart';

import '../../texts/scripts/text.dart';
import '../../../app/scripts/context.dart';
import '../types/variants.dart';
import '../types/sizes.dart';
import '../../../theme/scripts/shadows.dart';

class ClayButton extends StatefulWidget {
  final String text;
  final ClayButtonVariants _variant;
  final ClayButtonSizes? size;
  final VoidCallback? onPressed;
  final Color? backgroundColor, foregroundColor, iconColor;
  final bool? isLoading;
  final Gradient? gradient;
  final Widget? iconLeft, iconRight, icon;

  const ClayButton.base(
    this.text, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.backgroundColor,
    this.foregroundColor,
    this.iconLeft,
    this.iconRight,
  }) : icon = null,
       iconColor = null,
       _variant = ClayButtonVariants.base,
       gradient = null;

  const ClayButton.primary(
    this.text, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.backgroundColor,
    this.foregroundColor,
    this.iconLeft,
    this.iconRight,
  }) : icon = null,
       iconColor = null,
       _variant = ClayButtonVariants.primary,
       gradient = null;

  const ClayButton.secondary(
    this.text, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.backgroundColor,
    this.foregroundColor,
    this.iconLeft,
    this.iconRight,
  }) : icon = null,
       iconColor = null,
       _variant = ClayButtonVariants.secondary,
       gradient = null;

  const ClayButton.third(
    this.text, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.backgroundColor,
    this.foregroundColor,
    this.iconLeft,
    this.iconRight,
  }) : icon = null,
       iconColor = null,
       _variant = ClayButtonVariants.third,
       gradient = null;

  const ClayButton.text(
    this.text, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.backgroundColor,
    this.foregroundColor,
    this.iconLeft,
    this.iconRight,
  }) : icon = null,
       iconColor = null,
       _variant = ClayButtonVariants.text,
       gradient = null;

  const ClayButton.icon(
    this.icon, {
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.backgroundColor,
    this.iconColor,
  }) : text = '',
       iconLeft = null,
       iconRight = null,
       foregroundColor = null,
       _variant = ClayButtonVariants.icon,
       gradient = null;

  ClayButton.gradient(
    this.text, {
    super.key,
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    this.onPressed,
    this.isLoading = false,
    this.size = ClayButtonSizes.base,
    this.foregroundColor,
    this.iconLeft,
    this.iconRight,
  }) : icon = null,
       iconColor = null,
       _variant = ClayButtonVariants.primary,
       backgroundColor = null,
       gradient = LinearGradient(colors: colors, begin: begin, end: end);

  @override
  State<ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed == null || (widget.isLoading ?? false)) return;
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _onTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final isDisabled = widget.onPressed == null || (widget.isLoading ?? false);
    final isTextVariant = widget._variant == ClayButtonVariants.text;

    Color backgroundColor;
    Color textColor;
    Color shadowColor;
    Color lightColor;
    Color borderColor;

    switch (widget._variant) {
      case ClayButtonVariants.base:
        backgroundColor = widget.backgroundColor ?? theme.container;
        textColor = widget.foregroundColor ?? theme.onContainer;
        shadowColor = theme.shadow;
        lightColor = theme.light;
        borderColor = theme.border;
        break;
      case ClayButtonVariants.primary:
        backgroundColor = widget.backgroundColor ?? theme.primary;
        textColor = widget.foregroundColor ?? theme.onPrimary;
        shadowColor = theme.shadow;
        lightColor = theme.light;
        borderColor = theme.border;
        break;
      case ClayButtonVariants.secondary:
        backgroundColor = widget.backgroundColor ?? theme.secondary;
        textColor = widget.foregroundColor ?? theme.onSecondary;
        shadowColor = theme.shadow;
        lightColor = theme.light;
        borderColor = theme.border;
        break;
      case ClayButtonVariants.third:
        backgroundColor = widget.backgroundColor ?? theme.third;
        textColor = widget.foregroundColor ?? theme.onThird;
        shadowColor = theme.shadow;
        lightColor = theme.light;
        borderColor = theme.border;
        break;
      case ClayButtonVariants.text:
        backgroundColor = widget.backgroundColor ?? Colors.transparent;
        textColor = widget.foregroundColor ?? theme.primary;
        shadowColor = Colors.transparent;
        lightColor = Colors.transparent;
        borderColor = Colors.transparent;
        break;
      case ClayButtonVariants.icon:
        backgroundColor = widget.backgroundColor ?? theme.container;
        textColor = widget.iconColor ?? theme.primary;
        shadowColor = theme.shadow;
        lightColor = theme.light;
        borderColor = theme.border;
        break;
    }

    EdgeInsets padding;
    double borderRadius;
    double loaderSize;
    double iconSpacing;

    switch (widget.size ?? ClayButtonSizes.base) {
      case ClayButtonSizes.base:
        padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 14);
        borderRadius = 38.0;
        loaderSize = 20.0;
        iconSpacing = 8.0;
        break;
      case ClayButtonSizes.small:
        padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 8);
        borderRadius = 28.0;
        loaderSize = 16.0;
        iconSpacing = 6.0;
        break;
      case ClayButtonSizes.large:
        padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 18);
        borderRadius = 44.0;
        loaderSize = 24.0;
        iconSpacing = 10.0;
        break;
    }

    if (widget._variant == ClayButtonVariants.icon) {
      switch (widget.size ?? ClayButtonSizes.base) {
        case ClayButtonSizes.small:
          padding = const EdgeInsets.all(8);
          break;
        case ClayButtonSizes.base:
          padding = const EdgeInsets.all(12);
          break;
        case ClayButtonSizes.large:
          padding = const EdgeInsets.all(16);
          break;
      }
    }

    final hasGradient = widget.gradient != null && !isTextVariant;

    return CustomPaint(
      foregroundPainter: !isDisabled && !isTextVariant
          ? ClayInnerShadowPainter(
              shadowColor: shadowColor,
              lightColor: _isPressed ? shadowColor : lightColor,
              borderRadius: borderRadius,
              shadowSize: 2.5,
              blurRadius: 7.0,
            )
          : null,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: isDisabled ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: widget._variant == ClayButtonVariants.icon
                ? EdgeInsets.all(12)
                : padding,
            decoration: BoxDecoration(
              color: hasGradient
                  ? null
                  : (isTextVariant
                        ? Colors.transparent
                        : (isDisabled
                              ? backgroundColor.withAlpha(173)
                              : backgroundColor)),
              gradient: hasGradient
                  ? (isDisabled
                        ? _applyOpacityToGradient(widget.gradient!, 0.68)
                        : widget.gradient)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
              border: isTextVariant
                  ? null
                  : Border.all(color: borderColor, width: .3),
              boxShadow: _isPressed || isDisabled || isTextVariant
                  ? []
                  : ClayShadows.external(
                      theme: theme,
                      offset: isDisabled ? -1.0 : 4.0,
                      blur: 7.0,
                    ),
            ),
            child: widget.isLoading ?? false
                ? SizedBox(
                    width: loaderSize,
                    height: loaderSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: textColor,
                    ),
                  )
                : _buildContent(textColor, isDisabled, iconSpacing),
          ),
        ),
      ),
    );
  }

  Gradient _applyOpacityToGradient(Gradient gradient, double opacity) {
    if (gradient is LinearGradient) {
      return LinearGradient(
        colors: gradient.colors
            .map((c) => c.withValues(alpha: opacity))
            .toList(),
        begin: gradient.begin,
        end: gradient.end,
        stops: gradient.stops,
        tileMode: gradient.tileMode,
        transform: gradient.transform,
      );
    }
    return gradient;
  }

  Widget _buildContent(Color textColor, bool isDisabled, double iconSpacing) {
    final finalColor = isDisabled ? textColor.withAlpha(173) : textColor;

    if (widget._variant == ClayButtonVariants.icon) {
      return IconTheme(
        data: IconThemeData(color: finalColor, size: _getIconSize()),
        child: widget.isLoading ?? false
            ? SizedBox(
                width: _getIconSize(),
                height: _getIconSize(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: finalColor,
                ),
              )
            : widget.icon!,
      );
    }

    return IconTheme(
      data: IconThemeData(color: finalColor, size: _getIconSize()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.iconLeft != null) ...[
            widget.iconLeft!,
            SizedBox(width: iconSpacing),
          ],

          _buildText(finalColor),

          if (widget.iconRight != null) ...[
            SizedBox(width: iconSpacing),
            widget.iconRight!,
          ],
        ],
      ),
    );
  }

  double _getIconSize() {
    switch (widget.size ?? ClayButtonSizes.base) {
      case ClayButtonSizes.small:
        return 16.0;
      case ClayButtonSizes.base:
        return 20.0;
      case ClayButtonSizes.large:
        return 24.0;
    }
  }

  Widget _buildText(Color finalColor) {
    switch (widget.size ?? ClayButtonSizes.base) {
      case ClayButtonSizes.small:
        return ClayText.label(
          widget.text,
          color: finalColor,
          fontWeight: FontWeight.w700,
        );
      case ClayButtonSizes.base:
        return ClayText.body(
          widget.text,
          color: finalColor,
          fontWeight: FontWeight.w700,
        );
      case ClayButtonSizes.large:
        return ClayText.title(
          widget.text,
          color: finalColor,
          fontWeight: FontWeight.w700,
        );
    }
  }
}
