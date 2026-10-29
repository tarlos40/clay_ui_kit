import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import './classes/models.dart';
import './components/button.dart';

class ComponentDocRegistry {
  static final Map<String, ComponentDoc> docs = {'button': buttonDocumentation};

  static ComponentDoc resolve(BuildContext context, String slug) {
    final theme = context.clayTheme;

    final normalized = slug.trim().toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9-]+'),
      '-',
    );

    return docs[normalized] ??
        ComponentDoc(
          title: _humanize(normalized),
          subtitle: 'Documentation',
          description: 'This documentation has not yet been added, but the generic structure is already in place to receive the next component.',
          legends: [
            DocumentationLegend(label: 'Not Available', color: theme.error),
          ],
          showcases: const [],
          props: const [
            ClayProp(
              name: 'TODO',
              type: 'dynamic',
              description: 'Fill in the component properties here.',
              defaultValue: 'null',
            ),
          ],
        );
  }

  static String _humanize(String value) {
    if (value.isEmpty) return 'Component';

    final words = value
        .split('-')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .toList();

    if (words.isEmpty) return 'Component';
    return words.join(' ');
  }
}
