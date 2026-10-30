import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:flutter/material.dart';

import '../classes/models.dart';

ComponentDoc breadcrumbDocumentation = ComponentDoc(
  title: 'Breadcrumb',
  subtitle: 'Components',
  description: 'A compact navigation trail that shows the current location within a hierarchy.',
  legends: [
    DocumentationLegend(label: 'Navigable', color: ClayColors.cobalt.s500),
    DocumentationLegend(
      label: 'Current Location',
      color: ClayColors.forest.s500,
    ),
    DocumentationLegend(label: 'Overflow', color: ClayColors.amber.s500),
    DocumentationLegend(label: 'Disabled Item', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Navigation Trail',
      description: 'Provide an onTap callback for navigable items. The last item represents the current location and is not interactive.',
      code: '''
ClayBreadcrumbs(
  showHomeIcon: true,
  items: [
    ClayBreadcrumbItem(label: 'Home', onTap: () {}),
    ClayBreadcrumbItem(label: 'Components', onTap: () {}),
    ClayBreadcrumbItem(label: 'Breadcrumb'),
  ],
)
''',
      preview: ClayBreadcrumbs(
        showHomeIcon: true,
        items: const [
          ClayBreadcrumbItem(label: 'Home', onTap: _noop),
          ClayBreadcrumbItem(label: 'Components', onTap: _noop),
          ClayBreadcrumbItem(label: 'Breadcrumb'),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Overflow and Custom Separator',
      description: 'When the item count exceeds maxItems, the trail keeps the first and trailing entries and inserts the overflow label. A custom widget can replace the default chevron separator.',
      code: '''
ClayBreadcrumbs(
  maxItems: 4,
  overflowLabel: 'More',
  separator: Icon(Icons.arrow_forward_rounded, size: 14),
  items: [
    ClayBreadcrumbItem(label: 'Home', onTap: () {}),
    ClayBreadcrumbItem(label: 'Products', onTap: () {}),
    ClayBreadcrumbItem(label: 'Furniture', onTap: () {}),
    ClayBreadcrumbItem(label: 'Living room', onTap: () {}),
    ClayBreadcrumbItem(label: 'Sofas'),
  ],
)
''',
      preview: ClayBreadcrumbs(
        maxItems: 4,
        overflowLabel: 'More',
        separator: const Icon(Icons.arrow_forward_rounded, size: 14),
        items: const [
          ClayBreadcrumbItem(label: 'Home', onTap: _noop),
          ClayBreadcrumbItem(label: 'Products', onTap: _noop),
          ClayBreadcrumbItem(label: 'Furniture', onTap: _noop),
          ClayBreadcrumbItem(label: 'Living room', onTap: _noop),
          ClayBreadcrumbItem(label: 'Sofas'),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Custom Item Icons',
      description: 'Items can provide their own leading icons and can be disabled independently.',
      code: '''
ClayBreadcrumbs(
  items: [
    ClayBreadcrumbItem(
      label: 'Projects',
      icon: Icon(Icons.folder_outlined, size: 16),
      onTap: () {},
    ),
    ClayBreadcrumbItem(
      label: 'Design system',
      icon: Icon(Icons.palette_outlined, size: 16),
      enabled: false,
    ),
    ClayBreadcrumbItem(label: 'Tokens'),
  ],
)
''',
      preview: ClayBreadcrumbs(
        items: const [
          ClayBreadcrumbItem(
            label: 'Projects',
            icon: Icon(Icons.folder_outlined, size: 16),
            onTap: _noop,
          ),
          ClayBreadcrumbItem(
            label: 'Design system',
            icon: Icon(Icons.palette_outlined, size: 16),
            enabled: false,
          ),
          ClayBreadcrumbItem(label: 'Tokens'),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'items',
      type: 'List<ClayBreadcrumbItem>',
      description: 'Breadcrumb entries displayed in navigation order.',
      required: true,
    ),
    ClayProp(
      name: 'separator',
      type: 'Widget?',
      description:
          'Widget displayed between entries; defaults to a chevron icon.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'maxItems',
      type: 'int',
      description: 'Maximum number of visible trail entries before overflow truncation. Must be at least 2.',
      defaultValue: '5',
    ),
    ClayProp(
      name: 'spacing',
      type: 'double',
      description: 'Total horizontal spacing around each separator.',
      defaultValue: '8',
    ),
    ClayProp(
      name: 'itemPadding',
      type: 'EdgeInsetsGeometry',
      description: 'Padding surrounding each breadcrumb label and icon.',
      defaultValue: 'EdgeInsets.symmetric(horizontal: 8, vertical: 6)',
    ),
    ClayProp(
      name: 'borderRadius',
      type: 'double',
      description: 'Corner radius used for interactive breadcrumb items.',
      defaultValue: '10',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Background color for interactive items. Defaults to the theme container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'foregroundColor',
      type: 'Color?',
      description: 'Text and icon color for non-current items and the overflow label. Defaults to the theme variant on-background color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'currentColor',
      type: 'Color?',
      description: 'Text and icon color for the current item. Defaults to the theme on-background color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'showHomeIcon',
      type: 'bool',
      description: 'Whether to show a home icon on the first item when that item has no custom icon.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'overflowLabel',
      type: 'String',
      description:
          'Text displayed in place of hidden entries when the trail overflows.',
      defaultValue: '…',
    ),
    ClayProp(
      name: 'label (ClayBreadcrumbItem)',
      type: 'String',
      description: 'Text displayed for the breadcrumb entry.',
      required: true,
    ),
    ClayProp(
      name: 'onTap (ClayBreadcrumbItem)',
      type: 'VoidCallback?',
      description: 'Optional navigation callback. The current final item is not interactive.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'icon (ClayBreadcrumbItem)',
      type: 'Widget?',
      description: 'Optional icon displayed before the label; takes precedence over the home icon.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'enabled (ClayBreadcrumbItem)',
      type: 'bool',
      description: 'Whether this non-current item responds to taps.',
      defaultValue: 'true',
    ),
  ],
);

void _noop() {}
