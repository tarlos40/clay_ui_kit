import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class CatalogCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const CatalogCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final route = item['route'] as String? ?? '/${item['value']}';
    final category = item['category'] as String;

    return ClayCard(
      onTap: () => Navigator.pushNamed(context, route),
      children: [
        ClayCard.header(
          leading: HugeIcon(
            icon: item['icon'] as IconData,
            color: theme.primary,
            size: 25,
          ),
          action: Icon(
            category == 'Components'
                ? Icons.widgets_outlined
                : Icons.tune_rounded,
            color: theme.onContainer.withValues(alpha: .45),
            size: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClayText.title(item['title'] as String),
              ClayText.label(category.toUpperCase(), color: theme.primary),
            ],
          ),
        ),
        ClayCard.body(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          children: [
            SizedBox(
              height: 42,
              child: ClayText.body(
                item['description'] as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                color: theme.onContainer.withValues(alpha: .7),
              ),
            ),
          ],
        ),
        ClayCard.footer(
          child: Row(
            children: [
              Expanded(
                child: ClayText.label(
                  'View documentation',
                  color: theme.primary,
                ),
              ),
              Icon(Icons.arrow_forward_rounded, color: theme.primary, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
