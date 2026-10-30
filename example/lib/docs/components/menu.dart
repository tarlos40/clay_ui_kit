import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc menuDocumentation = ComponentDoc(
  title: 'Menu',
  subtitle: 'Components',
  description: 'An anchored contextual menu with pointer and touch triggers, keyboard navigation, per-item shortcuts, separators, and destructive or disabled actions.',
  legends: [
    DocumentationLegend(
      label: 'Tap / Long Press',
      color: ClayColors.cobalt.s500,
    ),
    DocumentationLegend(
      label: 'Keyboard Shortcuts',
      color: ClayColors.sky.s500,
    ),
    DocumentationLegend(
      label: 'Destructive Action',
      color: ClayColors.ruby.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Attach a Menu to a Trigger',
      description: 'Wrap any widget in ClayMenu. Items render in the supplied order; use icons, trailing widgets, dividers, and destructive styling to clarify each action.',
      code: '''
ClayMenu(
  child: ClayButton.secondary('More actions', onPressed: () {}),
  items: [
    ClayMenuItem(
      label: 'Duplicate',
      icon: Icon(Icons.copy_rounded),
      onPressed: () {},
    ),
    const ClayMenuItem.divider(),
    ClayMenuItem(
      label: 'Delete',
      icon: Icon(Icons.delete_outline_rounded),
      destructive: true,
      onPressed: () {},
    ),
  ],
)
''',
      preview: ClayMenu(
        items: [
          ClayMenuItem(
            label: 'Duplicate',
            icon: const Icon(Icons.copy_rounded),
            onPressed: () {},
          ),
          const ClayMenuItem.divider(),
          ClayMenuItem(
            label: 'Delete',
            icon: const Icon(Icons.delete_outline_rounded),
            destructive: true,
            onPressed: () {},
          ),
        ],
        child: ClayButton.secondary('More actions', onPressed: () {}),
      ),
    ),
    ClayShowcase(
      title: 'Add Keyboard Shortcuts',
      description: 'Assign a ShortcutActivator to an enabled item with a callback. SingleActivator supports modifier keys such as control, meta, alt, and shift; showShortcuts controls the visible hint and enableShortcuts controls shortcut handling.',
      code: '''
ClayMenu(
  showShortcuts: true,
  enableShortcuts: true,
  items: [
    ClayMenuItem(
      label: 'Copy',
      shortcut: SingleActivator(
        LogicalKeyboardKey.keyC,
        control: true,
      ),
      onPressed: _copy,
    ),
    ClayMenuItem(
      label: 'Paste',
      shortcut: SingleActivator(
        LogicalKeyboardKey.keyV,
        control: true,
      ),
      onPressed: _paste,
    ),
  ],
  child: ClayButton.secondary('Edit', onPressed: () {}),
)
''',
      preview: ClayMenu(
        showShortcuts: true,
        enableShortcuts: true,
        items: [
          ClayMenuItem(
            label: 'Copy',
            shortcut: const SingleActivator(
              LogicalKeyboardKey.keyC,
              control: true,
            ),
            onPressed: () {},
          ),
          ClayMenuItem(
            label: 'Paste',
            shortcut: const SingleActivator(
              LogicalKeyboardKey.keyV,
              control: true,
            ),
            onPressed: () {},
          ),
        ],
        child: ClayButton.secondary('Edit', onPressed: () {}),
      ),
    ),
    ClayShowcase(
      title: 'Navigate the Open Menu with Keys',
      description: 'When open, Up and Down move focus through actionable items, Home and End jump to the first or last item, Enter or Space selects the focused item, and Escape closes the menu. Disabled or callback-less entries are skipped.',
      code: '''
ClayMenu(
  triggers: {ClayMenuTrigger.tap},
  closeOnSelection: false,
  items: [
    ClayMenuItem(label: 'First action', onPressed: _first),
    ClayMenuItem(label: 'Second action', onPressed: _second),
  ],
  child: ClayButton.primary('Choose action', onPressed: () {}),
)
''',
      preview: ClayMenu(
        triggers: const {ClayMenuTrigger.tap},
        closeOnSelection: false,
        items: [
          ClayMenuItem(label: 'First action', onPressed: () {}),
          ClayMenuItem(label: 'Second action', onPressed: () {}),
        ],
        child: ClayButton.primary('Choose action', onPressed: () {}),
      ),
    ),
    ClayShowcase(
      title: 'Configure Triggers and Item States',
      description: 'Tap toggles the menu; long press and secondary tap open it. Hover opens and closes it only on desktop platforms. An item is actionable only when enabled and onPressed are both set.',
      code: '''
ClayMenu(
  triggers: {
    ClayMenuTrigger.tap,
    ClayMenuTrigger.secondaryTap,
    ClayMenuTrigger.hover,
  },
  width: 260,
  radius: 16,
  itemPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  animationDuration: Duration(milliseconds: 240),
  items: [
    ClayMenuItem(
      label: 'Archive',
      trailing: Icon(Icons.archive_outlined),
      onPressed: _archive,
    ),
    ClayMenuItem(
      label: 'Delete permanently',
      destructive: true,
      enabled: false,
      onPressed: _delete,
    ),
  ],
  child: Icon(Icons.more_horiz),
)
''',
      preview: ClayMenu(
        triggers: const {
          ClayMenuTrigger.tap,
          ClayMenuTrigger.secondaryTap,
          ClayMenuTrigger.hover,
        },
        width: 260,
        radius: 16,
        itemPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        animationDuration: const Duration(milliseconds: 240),
        items: [
          ClayMenuItem(
            label: 'Archive',
            trailing: const Icon(Icons.archive_outlined),
            onPressed: () {},
          ),
          ClayMenuItem(
            label: 'Delete permanently',
            destructive: true,
            enabled: false,
            onPressed: () {},
          ),
        ],
        child: const Icon(Icons.more_horiz),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'child',
      type: 'Widget',
      description: 'Widget that anchors and opens the menu.',
      required: true,
    ),
    ClayProp(
      name: 'items',
      type: 'List<ClayMenuItem>',
      description: 'Menu actions and optional dividers.',
      required: true,
    ),
    ClayProp(
      name: 'triggers',
      type: 'Set<ClayMenuTrigger>',
      description: 'Allowed gestures: tap, longPress, secondaryTap, and hover. Hover works only on web and desktop platforms.',
      defaultValue: '{tap, longPress, secondaryTap}',
    ),
    ClayProp(
      name: 'closeOnSelection',
      type: 'bool',
      description: 'Whether selecting an item closes the menu.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'showShortcuts / enableShortcuts',
      type: 'bool',
      description: 'showShortcuts renders each item shortcut hint; enableShortcuts registers activators for enabled items with callbacks. Keyboard navigation is available while the menu is open.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'backgroundColor / foregroundColor / borderColor',
      type: 'Color?',
      description: 'Customize the menu panel, regular item text/icons, and optional outline. Destructive item text uses the theme error color.',
      defaultValue: 'theme.container / theme.onContainer / null',
    ),
    ClayProp(
      name: 'width / radius',
      type: 'double',
      description: 'Set the panel minimum width and corner radius. The panel can grow to fit a larger width and is capped vertically at 75% of the screen.',
      defaultValue: '220 / 18',
    ),
    ClayProp(
      name: 'padding / itemPadding',
      type: 'EdgeInsetsGeometry',
      description: 'Panel inset and padding inside each menu item.',
      defaultValue: 'EdgeInsets.symmetric(vertical: 8) / EdgeInsets.symmetric(horizontal: 12, vertical: 10)',
    ),
    ClayProp(
      name: 'animationDuration',
      type: 'Duration',
      description: 'Duration for menu panel and item animations.',
      defaultValue: '200 milliseconds',
    ),
    ClayProp(
      name: 'ClayMenuItem.label / icon / trailing',
      type: 'String / Widget? / Widget?',
      description: 'Item text is required; optional leading icon and trailing widget decorate the row.',
    ),
    ClayProp(
      name: 'ClayMenuItem.shortcut',
      type: 'ShortcutActivator?',
      description: 'Optional keyboard accelerator, commonly SingleActivator(LogicalKeyboardKey.keyC, control: true). Enabled items with callbacks can be activated by it.',
    ),
    ClayProp(
      name: 'ClayMenuItem.onPressed / enabled / destructive',
      type: 'VoidCallback? / bool / bool',
      description: 'Callback, actionable state, and error-color styling. An item is disabled if enabled is false or onPressed is null.',
      defaultValue: 'null / true / false',
    ),
    ClayProp(
      name: 'ClayMenuItem.divider',
      type: 'const constructor',
      description: 'Inserts a visual divider between item groups; it is not an actionable entry.',
    ),
  ],
);
