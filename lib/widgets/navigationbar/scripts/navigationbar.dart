import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/types/typography.dart';
import '../../../theme/scripts/shadows.dart';

class ClayNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<ClayNavigationBar> destinations;
  final Widget? icon;
  final String? label;
  final Color? backgroundColor,
      indicatorColor,
      indicatorIconColor,
      unindicatorColor;

  const ClayNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.backgroundColor,
    this.indicatorColor,
    this.indicatorIconColor,
    this.unindicatorColor,
  }) : icon = null,
       label = null;

  const ClayNavigationBar.destination({super.key, this.icon, this.label})
    : selectedIndex = 0,
      onDestinationSelected = _emptyCallback,
      destinations = const [],
      backgroundColor = null,
      indicatorColor = null,
      indicatorIconColor = null,
      unindicatorColor = null;

  static void _emptyCallback(int index) {}

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    if (icon != null) {
      return NavigationDestination(icon: icon!, label: label ?? "");
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.light,
          lightColor: theme.shadow,
          shadowSize: 2,
          borderRadius: 100,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: backgroundColor ?? theme.container,
              elevation: 0,
              height: 44,

              indicatorColor: indicatorColor ?? theme.primary,

              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return ClayTextTypography.label(
                    color: indicatorColor ?? theme.primary,
                  );
                }

                return ClayTextTypography.label(
                  color:
                      unindicatorColor?.withAlpha(200) ??
                      theme.onContainer.withAlpha(200),
                );
              }),

              iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return IconThemeData(
                    color: indicatorIconColor ?? theme.onPrimary,
                  );
                }

                return IconThemeData(
                  color:
                      unindicatorColor?.withAlpha(200) ??
                      theme.onContainer.withAlpha(200),
                );
              }),
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: destinations
                  .map(
                    (destination) => NavigationDestination(
                      icon: destination.icon ?? const SizedBox.shrink(),
                      label: destination.label ?? '',
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
