import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class CatalogCount extends StatelessWidget {
  final int count;
  final String label;

  const CatalogCount({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClayText.title('$count', color: theme.primary),
          ClayText.label(label),
        ],
      ),
    );
  }
}
