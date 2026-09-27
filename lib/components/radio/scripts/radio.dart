import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../utils/random_colors.dart';
import '../../../theme/scripts/shadows.dart';

class ClayRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  final String? label;
  final String? description;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? activeColor;

  final bool randomColor;
  final int? randomSeed;
  final bool enabled;

  final double size;
  final EdgeInsetsGeometry padding;

  const ClayRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.activeColor,
    this.randomColor = false,
    this.randomSeed,
    this.enabled = true,
    this.size = 22,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  }) : assert(size > 0);

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final selected = value == groupValue;

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

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Padding(
        padding: padding,
        child: Semantics(
          label: label,
          hint: description,
          checked: selected,
          enabled: enabled && onChanged != null,
          inMutuallyExclusiveGroup: true,
          child: GestureDetector(
            onTap: enabled && onChanged != null
                ? () => onChanged!(value)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      borderRadius: 100,
                      shadowSize: 0.5,
                      blurRadius: 7.0,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? active : theme.border,
                          width: selected ? 2 : 1,
                        ),
                        boxShadow: ClayShadows.external(
                          theme: theme,
                          offset: selected ? 0 : 2,
                          blur: selected ? 1 : 4,
                        ),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutBack,
                          decoration: BoxDecoration(
                            color: selected ? active : surface,
                            shape: BoxShape.circle,
                          ),
                          child: selected
                              ? Center(
                                  child: Container(
                                    width: size * 0.40,
                                    height: size * 0.40,
                                    decoration: BoxDecoration(
                                      color: foreground,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
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
