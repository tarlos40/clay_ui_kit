import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc showCaseDocumentation = ComponentDoc(
  title: 'Show Case',
  subtitle: 'Components',
  description: 'A documentation surface that pairs a live preview and explanatory text with a toggleable, copyable code sample.',
  legends: [
    DocumentationLegend(label: 'Live Preview', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Code View', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Copy Snippet', color: ClayColors.forest.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Present a Reusable Example',
      description: 'Provide a title and code, then optionally add a live preview and description. Set showOnlyCode for installation or configuration snippets.',
      code: '''
ClayShowcase(
  title: 'Primary action',
  description: 'The main action in this section.',
  preview: ClayButton.primary('Continue', onPressed: () {}),
  code: "ClayButton.primary('Continue', onPressed: () {})",
)
''',
      preview: ClayText.body(
        'This documentation page uses ClayShowcase for every example.',
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'title / code',
      type: 'String',
      description: 'Showcase heading and code sample.',
      required: true,
    ),
    ClayProp(
      name: 'preview / description',
      type: 'Widget? / String?',
      description: 'Optional live widget and supporting explanation.',
    ),
    ClayProp(
      name: 'showCode / initiallyShowCode / showOnlyCode',
      type: 'bool',
      description: 'Control code visibility and code-only presentation.',
      defaultValue: 'true / false / false',
    ),
    ClayProp(
      name: 'showCopyButton / copyToastMessage',
      type: 'bool / String?',
      description: 'Control copy action and confirmation message.',
    ),
    ClayProp(
      name: 'fileName / codeLanguage',
      type: 'String?',
      description: 'Optional snippet file name and language label.',
    ),
    ClayProp(
      name: 'padding / headerTrailing',
      type: 'EdgeInsetsGeometry / Widget?',
      description: 'Preview spacing and optional header content.',
    ),
  ],
);
