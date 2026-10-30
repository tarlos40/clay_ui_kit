import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../components/navbar.dart';

import '../docs/registry.dart';

class DocumentationScreen extends StatelessWidget {
  final String slug;

  const DocumentationScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final doc = ComponentDocRegistry.resolve(context, slug);

    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: false,

      clayAppBar: Navbar(
        title: doc.title,
        subtitle: doc.subtitle,
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClayText.display(doc.title),
            const SizedBox(height: 8),
            ClayText.body(doc.description),
            const SizedBox(height: 24),
            if (doc.legends.isNotEmpty) ...[
              ClayText.label(
                'VARIANTS & STATES',
                color: context.clayTheme.onBackgroundVariant,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: doc.legends.map((legend) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(9, 7, 11, 7),
                    decoration: BoxDecoration(
                      color: legend.color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: legend.color.withValues(alpha: 0.20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: legend.color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 7),
                        ClayText.label(
                          legend.label,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            ...doc.showcases.map(
              (showcase) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: showcase,
              ),
            ),
            if (doc.props.isNotEmpty) ...[
              const SizedBox(height: 8),
              ClayPropsTable(title: 'Props', props: doc.props),
            ],
          ],
        ),
      ),
    );
  }
}
