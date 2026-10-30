import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:flutter/material.dart';

import '../classes/models.dart';

ComponentDoc accordionDocumentation = ComponentDoc(
  title: 'Accordion',
  subtitle: 'Components',
  description:
      'Expandable sections that organize content and reveal details on demand.',
  legends: [
    DocumentationLegend(label: 'Single Open', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Multiple Open', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Disabled Item', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Single-Item Expansion',
      description: 'By default, opening an item closes any other open item. Set initiallyExpanded on an item to show it when the accordion is first built.',
      code: '''
ClayAccordion(
  items: [
    ClayAccordionItem(
      title: 'What is claymorphism?',
      content: ClayText.body('A 3D design style with soft shadows.'),
      initiallyExpanded: true,
    ),
    ClayAccordionItem(
      title: 'Is it responsive?',
      content: ClayText.body('Yes, it adapts to the available width.'),
    ),
    ClayAccordionItem(
      title: 'Does it support dark mode?',
      content: ClayText.body('Yes, it supports light and dark themes.'),
    ),
  ],
),
''',
      preview: ClayAccordion(
        items: [
          ClayAccordionItem(
            title: 'What is claymorphism?',
            content: ClayText.body('A 3D design style with soft shadows.'),
            initiallyExpanded: true,
          ),
          ClayAccordionItem(
            title: 'Is it responsive?',
            content: ClayText.body('Yes, it adapts to the available width.'),
          ),
          ClayAccordionItem(
            title: 'Does it support dark mode?',
            content: ClayText.body('Yes, it supports light and dark themes.'),
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Multiple-Item Expansion',
      description: 'Set allowMultiple to true to let users expand several sections at the same time.',
      code: '''
ClayAccordion(
  allowMultiple: true,
  items: [
    ClayAccordionItem(
      title: 'Shipping',
      content: ClayText.body('Orders usually arrive within 3-5 business days.'),
      initiallyExpanded: true,
    ),
    ClayAccordionItem(
      title: 'Returns',
      content: ClayText.body('Eligible items can be returned within 30 days.'),
      initiallyExpanded: true,
    ),
  ],
),
''',
      preview: ClayAccordion(
        allowMultiple: true,
        items: [
          ClayAccordionItem(
            title: 'Shipping',
            content: ClayText.body(
              'Orders usually arrive within 3-5 business days.',
            ),
            initiallyExpanded: true,
          ),
          ClayAccordionItem(
            title: 'Returns',
            content: ClayText.body(
              'Eligible items can be returned within 30 days.',
            ),
            initiallyExpanded: true,
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Item Options and Dividers',
      description: 'Accordion items can include subtitles and leading widgets, and can be disabled. The expansion callback receives the item index and its new state.',
      code: '''
ClayAccordion(
  showDividers: true,
  onExpansionChanged: (change) {
        debugPrint('Section \${change.index} expanded: \${change.expanded}');
  },
  items: [
    ClayAccordionItem(
      title: 'Account details',
      subtitle: 'Manage your profile settings',
      leading: Icon(Icons.person_outline),
      content: ClayText.body('Update your name and contact information.'),
      initiallyExpanded: true,
    ),
    ClayAccordionItem(
      title: 'Archived settings',
      subtitle: 'This section is unavailable',
      leading: Icon(Icons.archive_outlined),
      content: ClayText.body('Archived settings are read-only.'),
      enabled: false,
    ),
  ],
),
''',
      preview: ClayAccordion(
        showDividers: true,
        onExpansionChanged: (change) {
          debugPrint('Section ${change.index} expanded: ${change.expanded}');
        },
        items: [
          ClayAccordionItem(
            title: 'Account details',
            subtitle: 'Manage your profile settings',
            leading: const Icon(Icons.person_outline),
            content: ClayText.body('Update your name and contact information.'),
            initiallyExpanded: true,
          ),
          ClayAccordionItem(
            title: 'Archived settings',
            subtitle: 'This section is unavailable',
            leading: const Icon(Icons.archive_outlined),
            content: ClayText.body('Archived settings are read-only.'),
            enabled: false,
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'items',
      type: 'List<ClayAccordionItem>',
      description: 'The sections displayed by the accordion.',
      required: true,
    ),
    ClayProp(
      name: 'allowMultiple',
      type: 'bool',
      description: 'Whether more than one section can stay expanded.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'initiallyExpandedIndices',
      type: 'Set<int>',
      description: 'Indices of sections to expand when the accordion is first built. Invalid indices are ignored.',
      defaultValue: 'const <int>{}',
    ),
    ClayProp(
      name: 'onExpansionChanged',
      type: 'ValueChanged<({int index, bool expanded})>?',
      description: 'Called when an enabled section changes state, with its index and new expanded state.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry',
      description: 'Padding around the contents of each section.',
      defaultValue: 'EdgeInsets.symmetric(vertical: 4)',
    ),
    ClayProp(
      name: 'contentPadding',
      type: 'EdgeInsetsGeometry',
      description: 'Padding around the expanded section content.',
      defaultValue: 'EdgeInsets.fromLTRB(16, 0, 16, 16)',
    ),
    ClayProp(
      name: 'borderRadius',
      type: 'double',
      description: 'Corner radius applied to each section.',
      defaultValue: '16',
    ),
    ClayProp(
      name: 'spacing',
      type: 'double',
      description: 'Vertical space between sections, or the divider height when showDividers is true.',
      defaultValue: '10',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Base section color. Defaults to the current Clay theme container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'expandedColor',
      type: 'Color?',
      description: 'Color of expanded sections. Defaults to backgroundColor or the theme container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'titleColor',
      type: 'Color?',
      description: 'Section title color and the basis for the section border. Defaults to the theme on-background color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'subtitleColor',
      type: 'Color?',
      description: 'Subtitle and divider color. Defaults to the theme variant on-background color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'iconColor',
      type: 'Color?',
      description: 'Expansion icon color. Defaults to the theme variant on-background color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'showDividers',
      type: 'bool',
      description:
          'Whether to show dividers between sections instead of spacing.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'title (ClayAccordionItem)',
      type: 'String',
      description: 'The required heading shown in the section header.',
      required: true,
    ),
    ClayProp(
      name: 'content (ClayAccordionItem)',
      type: 'Widget',
      description: 'The required widget shown while the section is expanded.',
      required: true,
    ),
    ClayProp(
      name: 'subtitle (ClayAccordionItem)',
      type: 'String?',
      description: 'Optional secondary text displayed below the title.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'leading (ClayAccordionItem)',
      type: 'Widget?',
      description: 'Optional widget displayed before the title.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'enabled (ClayAccordionItem)',
      type: 'bool',
      description: 'Whether the section can be toggled. Disabled sections cannot be opened or closed.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'initiallyExpanded (ClayAccordionItem)',
      type: 'bool',
      description: 'Whether this section starts expanded. With allowMultiple false, only one section can be initially expanded.',
      defaultValue: 'false',
    ),
  ],
);
