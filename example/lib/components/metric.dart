import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class Metric extends StatelessWidget {
  final String value;
  final String label;

  const Metric({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClayText.title(value, color: theme.primary),
          const SizedBox(width: 8),
          ClayText.label(label),
        ],
      ),
    );
  }
}
