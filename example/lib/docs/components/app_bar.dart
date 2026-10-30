import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:flutter/material.dart';

import '../classes/models.dart';

ComponentDoc appBarDocumentation = ComponentDoc(
  title: 'App Bar',
  subtitle: 'Components',
  description: 'A themed top app bar for screen titles, supporting text, navigation, and actions.',
  legends: [
    DocumentationLegend(label: 'Screen Title', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Leading Control', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Actions', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Title, Subtitle, and Actions',
      description: 'Use the standard constructor for a screen heading, a custom leading widget, and trailing action widgets.',
      code: '''
ClayAppBar(
  title: 'Workspace',
  subtitle: 'Project settings',
  leading: Icon(Icons.dashboard_outlined),
  actions: [
    ClayAppBar.action(
      Icon(Icons.search_rounded),
      onPressed: () {},
    ),
  ],
)
''',
      preview: SizedBox(
        width: 720,
        height: 80,
        child: ClayAppBar(
          title: 'Workspace',
          subtitle: 'Project settings',
          leading: const Icon(Icons.dashboard_outlined),
          actions: [
            ClayAppBar.action(
              const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
    ClayShowcase(
      title: 'Leading Icon Button',
      description: 'Use ClayAppBar.leading for a compact icon button, commonly used for back navigation.',
      code: '''
ClayAppBar.leading(
  Icon(Icons.arrow_back_rounded),
  onPressed: () {},
)
''',
      preview: ClayAppBar.leading(
        const Icon(Icons.arrow_back_rounded),
        onPressed: () {},
      ),
    ),
    ClayShowcase(
      title: 'Action Icon Button',
      description: 'Use ClayAppBar.action for a compact action button, such as search or more options.',
      code: '''
ClayAppBar.action(
  Icon(Icons.more_horiz_rounded),
  onPressed: () {},
  size: ClayButtonSize.small,
)
''',
      preview: ClayAppBar.action(
        const Icon(Icons.more_horiz_rounded),
        onPressed: () {},
        size: ClayButtonSize.small,
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'title (ClayAppBar)',
      type: 'String?',
      description: 'The primary screen title.',
      defaultValue: "''",
    ),
    ClayProp(
      name: 'subtitle',
      type: 'String?',
      description: 'Optional supporting text displayed above the title.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Background color for the app bar or icon button.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'leading',
      type: 'Widget?',
      description:
          'Custom widget displayed before the title in the standard app bar.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'actions',
      type: 'List<Widget>?',
      description: 'Widgets displayed after the title in the standard app bar.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'elevation',
      type: 'double?',
      description:
          'Elevation of the standard app bar when it is not transparent.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'transparent',
      type: 'bool?',
      description: 'Whether to force a transparent background and zero elevation on the standard app bar.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'automaticallyImplyLeading',
      type: 'bool?',
      description: 'Whether the underlying AppBar should automatically add a leading navigation control.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'icon (ClayAppBar.leading / action)',
      type: 'Widget',
      description: 'The icon widget displayed by an icon-button variant.',
      required: true,
    ),
    ClayProp(
      name: 'onPressed (icon variants)',
      type: 'VoidCallback?',
      description: 'Callback invoked when the icon button is pressed.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'iconColor (icon variants)',
      type: 'Color?',
      description: 'Color applied to the icon in an icon-button variant.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'isLoading (icon variants)',
      type: 'bool?',
      description: 'Whether the icon button displays its loading state.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'size (icon variants)',
      type: 'ClayButtonSize?',
      description: 'Size of the icon button.',
      defaultValue: 'null',
    ),
  ],
);
