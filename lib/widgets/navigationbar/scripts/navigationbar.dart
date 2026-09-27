import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';
import '../../../components/texts/scripts/text.dart';

class ClayNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<ClayNavigationBar> destinations;
  final Widget? icon;
  final String? label;
  final Color? backgroundColor,
      indicatorColor,
      onIndicatorColor,
      onUnindicatorColor;

  const ClayNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.backgroundColor,
    this.indicatorColor,
    this.onIndicatorColor,
    this.onUnindicatorColor,
  }) : icon = null,
       label = null;

  const ClayNavigationBar.destination({super.key, this.icon, this.label})
    : selectedIndex = 0,
      onDestinationSelected = _emptyCallback,
      destinations = const [],
      backgroundColor = null,
      indicatorColor = null,
      onIndicatorColor = null,
      onUnindicatorColor = null;

  static void _emptyCallback(int index) {}

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    if (icon != null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          shadowSize: 2,
          borderRadius: 100,
        ),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.container,
            borderRadius: BorderRadius.circular(100),
            boxShadow: ClayShadows.external(theme: theme, offset: 3, blur: 8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: List.generate(destinations.length, (index) {
                  final destination = destinations[index];
                  return Expanded(
                    child: _buildDestination(
                      context,
                      index: index,
                      destination: destination,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDestination(
    BuildContext context, {
    required int index,
    required ClayNavigationBar destination,
  }) {
    final theme = context.clayTheme;
    final selected = selectedIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onDestinationSelected(index),
      child: Center(
        child: CustomPaint(
          foregroundPainter: selected
              ? ClayInnerShadowPainter(
                  shadowColor: theme.shadow,
                  lightColor: theme.light,
                  shadowSize: 2,
                  blurRadius: 8,
                  borderRadius: 40,
                )
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: selected ? 32 : 24,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? indicatorColor ?? theme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              boxShadow: selected
                  ? ClayShadows.external(theme: theme, offset: 2, blur: 5)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme(
                  data: IconThemeData(
                    size: 24,
                    color: selected
                        ? onIndicatorColor ?? theme.onPrimary
                        : onUnindicatorColor?.withAlpha(200) ??
                              theme.onContainer.withAlpha(200),
                  ),
                  child: destination.icon ?? const SizedBox.shrink(),
                ),

                const SizedBox(height: 4),

                ClayText.label(
                  destination.label ?? '',
                  color: selected
                      ? onIndicatorColor ?? theme.onPrimary
                      : onUnindicatorColor?.withAlpha(200) ??
                            theme.onContainer.withAlpha(200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
