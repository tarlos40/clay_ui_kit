import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../utils/random_colors.dart';
import '../../../theme/scripts/shadows.dart';

class ClayCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  final String? label;
  final String? description;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? activeColor;

  final bool randomColor;
  final int? randomSeed;
  final bool enabled;

  final double size;
  final double radius;
  final EdgeInsetsGeometry padding;

  const ClayCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.activeColor,
    this.randomColor = false,
    this.randomSeed,
    this.enabled = true,
    this.size = 24,
    this.radius = 7,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  }) : assert(size > 0),
       assert(radius >= 0);

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final random = randomColor
        ? RandomColors.random(context, seed: randomSeed)
        : null;

    final active =
        activeColor ??
        backgroundColor ??
        random?.backgroundColor ??
        theme.primary;

    final foreground =
        foregroundColor ?? random?.foregroundColor ?? theme.onPrimary;

    final surface = backgroundColor ?? theme.container;
    final borderColor = theme.border;

    final checkbox = CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: radius,
        shadowSize: 0.5,
        blurRadius: 7.0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? active : surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: value ? active : borderColor, width: 1),
          boxShadow: ClayShadows.external(
            theme: theme,
            offset: value ? 0 : 2,
            blur: value ? 1 : 4,
          ),
        ),
        child: AnimatedScale(
          scale: value ? 1 : 0.5,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutBack,
          child: AnimatedOpacity(
            opacity: value ? 1 : 0,
            duration: const Duration(milliseconds: 120),
            child: Icon(
              Icons.check_rounded,
              size: size * 0.76,
              color: foreground,
            ),
          ),
        ),
      ),
    );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Padding(
        padding: padding,
        child: Semantics(
          label: label,
          hint: description,
          checked: value,
          enabled: enabled && onChanged != null,
          inMutuallyExclusiveGroup: false,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius + 8),
            onTap: enabled && onChanged != null
                ? () => onChanged!(!value)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  checkbox,
                  if (label != null || description != null) ...[
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (label != null)
                            Text(
                              label!,
                              style: TextStyle(
                                color: theme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (description != null)
                            Text(
                              description!,
                              style: TextStyle(
                                color: theme.onBackgroundVariant,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
