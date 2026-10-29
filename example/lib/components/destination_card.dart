import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class DestinationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String action;
  final VoidCallback onPressed;

  const DestinationCard({super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.action,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayCard(
      children: [
        ClayCard.header(
          leading: HugeIcon(icon: icon, color: theme.primary, size: 26),
        ),
        ClayCard.body(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          children: [
            ClayCard.title(title),
            ClayCard.subtitle(
              description,
              color: theme.onContainer.withValues(alpha: .72),
            ),
          ],
        ),
        ClayCard.footer(
          child: ClayButton.primary(
            action,
            onPressed: onPressed,
            iconRight: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight02,
              color: theme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
