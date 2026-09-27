import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../utils/random_colors.dart';
import '../../../theme/scripts/shadows.dart';

class ClaySwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  final String? label;
  final String? description;

  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final Color? foregroundColor;

  final bool randomColor;
  final int? randomSeed;
  final bool enabled;

  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  const ClaySwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.foregroundColor,
    this.randomColor = false,
    this.randomSeed,
    this.enabled = true,
    this.width = 48,
    this.height = 28,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  }) : assert(width > 0),
       assert(height > 0),
       assert(width >= height);

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final random = randomColor
        ? RandomColors.random(context, seed: randomSeed)
        : null;

    final active = activeColor ?? random?.backgroundColor ?? theme.primary;

    final foreground =
        foregroundColor ?? random?.backgroundColor ?? theme.primary;

    final inactive = inactiveColor ?? theme.container;
    final thumb = thumbColor ?? theme.onPrimary;

    final canChange = enabled && onChanged != null;

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Padding(
        padding: padding,
        child: Semantics(
          label: label,
          hint: description,
          toggled: value,
          enabled: canChange,
          child: InkWell(
            borderRadius: BorderRadius.circular(height),
            onTap: canChange ? () => onChanged!(!value) : null,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      borderRadius: height,
                      shadowSize: 0.5,
                      blurRadius: 7.0,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOutCubic,
                      width: width,
                      height: height,
                      padding: EdgeInsets.all(height * 0.10),
                      decoration: BoxDecoration(
                        color: value ? active : inactive,
                        borderRadius: BorderRadius.circular(height),
                        border: Border.all(
                          color: value ? active : theme.border,
                        ),
                        boxShadow: ClayShadows.external(
                          theme: theme,
                          offset: value ? 0 : 2,
                          blur: value ? 1 : 4,
                        ),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOutCubic,
                        alignment: value
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: height * 0.80,
                          height: height * 0.80,
                          decoration: BoxDecoration(
                            color: thumb,
                            shape: BoxShape.circle,
                            boxShadow: ClayShadows.external(
                              theme: theme,
                              offset: 1,
                              blur: 3,
                            ),
                          ),
                          child: value
                              ? Icon(
                                  Icons.check_rounded,
                                  size: height * 0.48,
                                  color: foreground,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
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
