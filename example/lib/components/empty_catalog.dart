import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class EmptyCatalog extends StatelessWidget {
  final String query;
  final VoidCallback onClear;

  const EmptyCatalog({super.key, required this.query, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedSearching,
              color: theme.primary,
              size: 36,
            ),
            const SizedBox(height: 12),
            ClayText.title('No matching items'),
            const SizedBox(height: 6),
            ClayText.body(
              query.isEmpty
                  ? 'Try another category.'
                  : 'Try a different search term or clear the filters.',
              color: theme.onBackground.withValues(alpha: .65),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClayButton.base('Clear filters', onPressed: onClear),
          ],
        ),
      ),
    );
  }
}
