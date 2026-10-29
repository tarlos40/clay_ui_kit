import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class CategoryFilter extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const CategoryFilter({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: '$label, $count items',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ClayContainer(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          backgroundColor: selected ? theme.tertiary : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClayText.label(
                label,
                color: selected ? theme.onTertiary : theme.onContainer,
              ),
              const SizedBox(width: 8),
              ClayText.label(
                '$count',
                color: selected
                    ? theme.onTertiary.withValues(alpha: .7)
                    : theme.onContainer.withValues(alpha: .56),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
