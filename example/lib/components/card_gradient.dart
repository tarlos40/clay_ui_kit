import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class CardGradient extends StatefulWidget {
  final String title, subtitle, label;
  final VoidCallback onPressed;
  const CardGradient({
    super.key,
    required this.title,
    required this.subtitle,
    required this.label,
    required this.onPressed,
  });

  @override
  State<CardGradient> createState() => _CardGradientState();
}

class _CardGradientState extends State<CardGradient> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayCard(
      backgroundGradient: LinearGradient(
        colors: [theme.primary, theme.secondary, theme.tertiary],
        begin: AlignmentGeometry.topStart,
        end: AlignmentGeometry.bottomEnd,
      ),
      children: [
        ClayCard.header(child: ClayText.display(widget.title)),
        ClayCard.body(children: [ClayCard.subtitle(widget.subtitle)]),
        ClayCard.footer(
          child: ClayButton.base(
            widget.label,
            onPressed: widget.onPressed,
            iconRight: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight02,
              color: theme.onContainer,
            ),
          ),
        ),
      ],
    );
  }
}
