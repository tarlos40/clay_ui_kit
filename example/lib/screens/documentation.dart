import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../docs/registry.dart';

class ComponentDocumentationScreen extends StatelessWidget {
  final String slug;

  const ComponentDocumentationScreen({
    super.key,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    final doc = ComponentDocRegistry.resolve(slug);

    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: false,
      clayAppBar: ClayAppBar(
        title: 'Component docs',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClayText.display(doc.title),
            const SizedBox(height: 8),
            ClayText.body(doc.description),
            const SizedBox(height: 24),
            if (doc.legends.isNotEmpty) ...[
              ClayText.label('Legends'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: doc.legends.map((legend) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: legend.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: legend.color.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: legend.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ClayText.label(legend.label),
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
              ClayPropsTable(
                title: 'Props',
                props: doc.props,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
