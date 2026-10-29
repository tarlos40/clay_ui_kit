import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class GuideStep extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;

  const GuideStep({
    super.key,
    required this.number,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          HugeIcon(icon: icon, color: theme.primary, size: 20),
          const SizedBox(width: 10),
          ClayText.label(number, color: theme.primary),
          const SizedBox(width: 8),
          Expanded(child: ClayText.body(title)),
        ],
      ),
    );
  }
}
