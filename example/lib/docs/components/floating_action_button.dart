import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc floatingActionButtonDocumentation = ComponentDoc(
  title: 'Floating Action Button',
  subtitle: 'Components',
  description: 'A prominent action anchored to a screen. Place it in ClayScaffold, choose an icon or custom child, and optionally add a label, size, colors, and Hero transition.',
  legends: [
    DocumentationLegend(label: 'Icon Action', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Extended', color: ClayColors.forest.s500),
    DocumentationLegend(
      label: 'Small / Base / Large',
      color: ClayColors.amber.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Place the Main Action in a Screen',
      description: 'ClayScaffold places the FAB in the standard floating action button slot. Supply exactly one of icon or child. A label creates the extended layout; extend: true also requests that layout and requires a label.',
      code: '''
ClayScaffold(
  clayFloatingActionButton: ClayFloatingActionButton(
    icon: Icon(Icons.add_rounded),
    label: 'Create project',
    extend: true,
    onPressed: () {},
  ),
  body: const Center(child: Text('Projects')),
)
''',
      preview: ClayFloatingActionButton(
        icon: const Icon(Icons.add_rounded),
        label: 'Create project',
        extend: true,
        onPressed: () {},
      ),
    ),
    ClayShowcase(
      title: 'Sizes, Colors, and Custom Content',
      description: 'Choose small, base, or large for a 48, 56, or 64 pixel control. Use child for custom content instead of icon; set padding and theme colors to adapt the action to its task.',
      code: '''
Wrap(
  spacing: 12,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    ClayFloatingActionButton(
      icon: Icon(Icons.edit_outlined),
      size: ClayFloatingActionButtonSize.small,
      heroTag: 'edit-fab',
      onPressed: _edit,
    ),
    ClayFloatingActionButton(
      child: Icon(Icons.send_rounded),
      label: 'Send invite',
      backgroundColor: ClayColors.forest.s600,
      foregroundColor: ClayColors.ocean.s50,
      padding: EdgeInsets.symmetric(horizontal: 24),
      onPressed: _sendInvite,
    ),
  ],
)
''',
      preview: Wrap(
        spacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ClayFloatingActionButton(
            icon: const Icon(Icons.edit_outlined),
            size: ClayFloatingActionButtonSize.small,
            heroTag: 'edit-fab-preview',
            onPressed: () {},
          ),
          ClayFloatingActionButton(
            label: 'Send invite',
            backgroundColor: ClayColors.forest.s600,
            foregroundColor: ClayColors.ocean.s50,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            onPressed: () {},
            child: const Icon(Icons.send_rounded),
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'onPressed',
      type: 'VoidCallback?',
      description: 'Required callback parameter. Pass null to make the FAB non-interactive.',
      defaultValue: 'required',
    ),
    ClayProp(
      name: 'icon / child',
      type: 'Widget?',
      description: 'Supply exactly one: icon for a standard icon slot, or child for custom content. Providing both or neither triggers an assertion.',
      defaultValue: 'one is required',
    ),
    ClayProp(
      name: 'label',
      type: 'String?',
      description: 'Optional text. Any label creates the extended layout; extend: true also requires a label.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'size',
      type: 'ClayFloatingActionButtonSize',
      description: 'Preset diameter: small (48), base (56), or large (64).',
      defaultValue: 'base',
    ),
    ClayProp(
      name: 'backgroundColor / foregroundColor',
      type: 'Color?',
      description: 'Override the themed surface and content colors; defaults are theme primary and onPrimary.',
      defaultValue: 'theme.primary / theme.onPrimary',
    ),
    ClayProp(
      name: 'heroTag',
      type: 'Object?',
      description: 'Wraps the FAB in a Hero for route transitions. Use distinct tags when multiple FABs coexist in the same route.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'extend',
      type: 'bool',
      description: 'Forces extended layout; the label is required when this is true. A non-null label also extends the layout without this flag.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry?',
      description: 'Overrides content insets in either layout. Defaults to 20 horizontal pixels for extended FABs and zero horizontal inset for icon-only FABs; vertical padding is zero.',
      defaultValue: 'horizontal 20 for extended / null for icon-only',
    ),
  ],
);
