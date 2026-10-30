import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc drawerDocumentation = ComponentDoc(
  title: 'Drawer',
  subtitle: 'Components',
  description: 'A themed navigation panel with section headings, selectable actions, compact nested items, and expandable groups.',
  legends: [
    DocumentationLegend(label: 'Navigation', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Selected', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Expandable', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Compose Drawer Content',
      description: 'Use title for the drawer heading, subtitle for section labels, divider and spacer for separation, and expansion for collapsible sections. Set compact on nested actions to reduce their size.',
      code: '''
ClayDrawer(
  children: [
    ClayDrawer.title(
      'Workspace',
      leading: Icon(Icons.dashboard_outlined),
      trailing: IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () {},
      ),
    ),
    ClayDrawer.subtitle('MAIN MENU'),
    ClayDrawer.action(
      icon: Icon(Icons.home_outlined),
      label: 'Overview',
      selected: true,
      trailing: Icon(Icons.chevron_right),
      onPressed: () {},
    ),
    ClayDrawer.action(
      icon: Icon(Icons.folder_outlined),
      label: 'Projects',
      onPressed: () {},
    ),
    ClayDrawer.divider(),
    ClayDrawer.expansion(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
      initiallyExpanded: true,
      children: [
        ClayDrawer.action(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
          compact: true,
          onPressed: () {},
        ),
        ClayDrawer.action(
          icon: Icon(Icons.lock_outline),
          label: 'Security',
          compact: true,
          onPressed: () {},
        ),
      ],
    ),
    ClayDrawer.spacer(16),
    ClayDrawer.subtitle('SUPPORT'),
    ClayDrawer.action(
      icon: Icon(Icons.help_outline),
      label: 'Help center',
      onPressed: () {},
    ),
  ],
)
''',
      preview: SizedBox(
        width: 280,
        height: 360,
        child: ClayDrawer(
          children: [
            ClayDrawer.title(
              'Workspace',
              leading: const Icon(Icons.dashboard_outlined),
              trailing: IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ),
            ClayDrawer.subtitle('MAIN MENU'),
            ClayDrawer.action(
              icon: const Icon(Icons.home_outlined),
              label: 'Overview',
              selected: true,
              trailing: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            ClayDrawer.action(
              icon: const Icon(Icons.folder_outlined),
              label: 'Projects',
              onPressed: () {},
            ),
            ClayDrawer.divider(),
            ClayDrawer.expansion(
              icon: const Icon(Icons.settings_outlined),
              label: 'Settings',
              initiallyExpanded: true,
              children: [
                ClayDrawer.action(
                  icon: const Icon(Icons.person_outline),
                  label: 'Profile',
                  compact: true,
                  onPressed: () {},
                ),
                ClayDrawer.action(
                  icon: const Icon(Icons.lock_outline),
                  label: 'Security',
                  compact: true,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    ClayShowcase(
      title: 'Attach Drawer to the Scaffold',
      description: 'Pass the drawer to ClayScaffold.clayDrawer. Put ClayDrawer.menuButton in the app bar leading slot; it opens the nearest scaffold drawer by default.',
      code: '''
ClayScaffold(
  clayAppBar: Builder(
    builder: (context) => ClayAppBar(
      title: 'Workspace',
      leading: ClayDrawer.menuButton(context),
    ),
  ),
  clayDrawer: ClayDrawer(
    children: [
      ClayDrawer.title('Workspace'),
      ClayDrawer.subtitle('NAVIGATION'),
      ClayDrawer.action(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
        onPressed: () {},
      ),
    ],
  ),
  body: Center(child: Text('Page content')),
)
''',
      preview: SizedBox(
        height: 280,
        child: Builder(
          builder: (context) => ClayScaffold(
            clayAppBar: ClayAppBar(
              title: 'Workspace',
              leading: ClayDrawer.menuButton(context),
            ),
            clayDrawer: ClayDrawer(
              children: [
                ClayDrawer.title('Workspace'),
                ClayDrawer.subtitle('NAVIGATION'),
                ClayDrawer.action(
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home',
                  onPressed: () {},
                ),
              ],
            ),
            body: const Center(child: Text('Tap the menu button')),
          ),
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'child / children',
      type: 'Widget? / List<Widget>?',
      description:
          'Provide custom drawer content or a list of widgets, but not both.',
    ),
    ClayProp(
      name: 'width',
      type: 'double',
      description: 'Drawer width in logical pixels.',
      defaultValue: '320',
    ),
    ClayProp(
      name: 'backgroundColor / backgroundGradient',
      type: 'Color? / Gradient?',
      description: 'Choose a solid background or gradient, not both.',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry',
      description: 'Padding around the default ListView when using children.',
      defaultValue: 'EdgeInsets.all(16)',
    ),
    ClayProp(
      name: 'ClayDrawer.title',
      type: 'static helper',
      description: 'Creates a drawer heading with optional leading, trailing, and padding.',
    ),
    ClayProp(
      name: 'ClayDrawer.subtitle',
      type: 'static helper',
      description: 'Creates an uppercase label for a navigation section.',
    ),
    ClayProp(
      name: 'ClayDrawer.action',
      type: 'Widget',
      description: 'Creates a selectable destination with required icon and label, optional trailing widget, callback, and compact layout.',
    ),
    ClayProp(
      name: 'ClayDrawer.action.selected / compact',
      type: 'bool',
      description: 'Highlights the selected destination; compact reduces its height, padding, icon size, and spacing.',
      defaultValue: 'false / false',
    ),
    ClayProp(
      name: 'ClayDrawer.expansion',
      type: 'Widget',
      description: 'Creates a collapsible section with required icon, label, and child widgets.',
    ),
    ClayProp(
      name: 'ClayDrawer.expansion.initiallyExpanded',
      type: 'bool',
      description: 'Whether the section starts expanded.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'ClayDrawer.divider / spacer',
      type: 'static helpers',
      description:
          'Add a themed divider or a fixed-height gap between drawer sections.',
    ),
    ClayProp(
      name: 'ClayDrawer.menuButton',
      type: 'static helper',
      description: 'Creates an icon button that opens the nearest Scaffold drawer by default; icon and onPressed can be customized.',
    ),
  ],
);
