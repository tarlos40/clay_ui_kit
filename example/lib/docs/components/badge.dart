import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:flutter/material.dart';

import '../classes/models.dart';

ComponentDoc badgeDocumentation = ComponentDoc(
  title: 'Badge',
  subtitle: 'Components',
  description: 'Compact labels and status indicators for highlighting metadata or annotating a target widget.',
  legends: [
    DocumentationLegend(label: 'Inline Label', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Icon / Dismiss', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Count Indicator', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Labels, Icons, and Dismissal',
      description: 'A standard badge requires a label, icon, or custom child. Labels and icons can be combined, and onClose adds a dismiss control.',
      code: '''
Wrap(
  spacing: 12,
  children: [
    ClayBadge(label: 'New'),
    ClayBadge(
      icon: Icon(Icons.notifications_none_rounded),
      label: 'Updates',
    ),
    ClayBadge(label: 'Dismissible', onClose: () {}),
  ],
)
''',
      preview: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          ClayBadge(label: 'New'),
          ClayBadge(
            icon: const Icon(Icons.notifications_none_rounded),
            label: 'Updates',
          ),
          ClayBadge(label: 'Dismissible', onClose: () {}),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Circular Target Badge',
      description: 'Use ClayBadge.circle to position a compact label or icon around a target widget.',
      code: '''
ClayBadge.circle(
  target: Icon(Icons.notifications_none_rounded, size: 36),
  label: '3',
  position: ClayBadgePosition.topRight,
  size: 20,
)
''',
      preview: ClayBadge.circle(
        target: const Icon(Icons.notifications_none_rounded, size: 36),
        label: '3',
        position: ClayBadgePosition.topRight,
        size: 20,
      ),
    ),
    ClayShowcase(
      title: 'Custom Target Indicator',
      description: 'A circular badge can use an icon or custom child instead of a text label and can be offset from the target.',
      code: '''
ClayBadge.circle(
  target: Icon(Icons.mail_outline_rounded, size: 36),
  icon: Icon(Icons.priority_high_rounded),
  position: ClayBadgePosition.topLeft,
  offset: 4,
  size: 18,
)
''',
      preview: ClayBadge.circle(
        target: const Icon(Icons.mail_outline_rounded, size: 36),
        icon: const Icon(Icons.priority_high_rounded),
        position: ClayBadgePosition.topLeft,
        offset: 4,
        size: 18,
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'child (ClayBadge)',
      type: 'Widget?',
      description: 'Custom badge content. Cannot be combined with label or icon in the standard constructor.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'icon (ClayBadge)',
      type: 'Widget?',
      description: 'Optional icon displayed before the label. Cannot be combined with child.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'label (ClayBadge)',
      type: 'String?',
      description: 'Optional text displayed in the badge. Can be combined with icon, but not child.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor (ClayBadge)',
      type: 'Color?',
      description: 'Standard badge background color. Defaults to the theme container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'foregroundColor (ClayBadge)',
      type: 'Color?',
      description: 'Standard badge content color. Defaults to the theme on-container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'onPressed',
      type: 'VoidCallback?',
      description:
          'Optional callback that makes a standard badge respond to taps.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'onClose',
      type: 'VoidCallback?',
      description: 'Adds a close control; tapping it hides the badge and invokes this callback.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry?',
      description: 'Padding around standard badge content.',
      defaultValue: 'EdgeInsets.symmetric(horizontal: 10)',
    ),
    ClayProp(
      name: 'height',
      type: 'double?',
      description: 'Height of a standard badge.',
      defaultValue: '32',
    ),
    ClayProp(
      name: 'target (ClayBadge.circle)',
      type: 'Widget',
      description: 'Required widget around which the circular badge is placed.',
      required: true,
    ),
    ClayProp(
      name: 'child (ClayBadge.circle)',
      type: 'Widget?',
      description: 'Custom content for the circular badge. Use only one of child, icon, or label.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'icon (ClayBadge.circle)',
      type: 'Widget?',
      description: 'Icon displayed inside the circular badge. Use only one of child, icon, or label.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'label (ClayBadge.circle)',
      type: 'String?',
      description: 'Text displayed inside the circular badge. Use only one of child, icon, or label.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor (ClayBadge.circle)',
      type: 'Color?',
      description: 'Circular badge background color. Defaults to the theme primary color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'foregroundColor (ClayBadge.circle)',
      type: 'Color?',
      description: 'Circular badge content color. Defaults to the theme on-primary color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'position',
      type: 'ClayBadgePosition?',
      description: 'Position of the circular badge relative to its target: topLeft, topCenter, topRight, centerLeft, centerRight, bottomLeft, bottomCenter, or bottomRight.',
      defaultValue: 'ClayBadgePosition.topRight',
    ),
    ClayProp(
      name: 'offset',
      type: 'double',
      description: 'Distance in logical pixels that the badge extends outward from the target. Must not be negative.',
      defaultValue: '0',
    ),
    ClayProp(
      name: 'size',
      type: 'double',
      description: 'Diameter of the circular badge. Must be greater than zero.',
      defaultValue: '16',
    ),
  ],
);
