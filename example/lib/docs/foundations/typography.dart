import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc typographyDocumentation = ComponentDoc(
  title: 'Typography',
  subtitle: 'Foundations',
  description: 'ClayText provides a consistent type scale for hierarchy and readability. Display and title use Crimson Text; body and label use Inter. Text uses the current Clay theme onBackground color by default, and each style can be customized when needed.',
  showcases: [
    ClayShowcase(
      title: 'Type Scale',
      description: 'Use display for prominent page headings, title for section headings, body for paragraphs, and label for compact supporting text.',
      code: '''
ClayText.display('A clear visual hierarchy')
ClayText.title('Section heading')
ClayText.body('Body text is designed for comfortable reading.')
ClayText.label('SUPPORTING LABEL')
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClayText.label(
            'DISPLAY  |  CRIMSON TEXT  |  32 PX  |  WEIGHT 700  |  LINE 1.2',
          ),
          const SizedBox(height: 4),
          ClayText.display('A clear visual hierarchy'),
          const SizedBox(height: 18),
          ClayText.label(
            'TITLE  |  CRIMSON TEXT  |  22 PX  |  WEIGHT 600  |  LINE 1.3',
          ),
          const SizedBox(height: 4),
          ClayText.title('Section heading'),
          const SizedBox(height: 18),
          ClayText.label(
            'BODY  |  INTER  |  16 PX  |  WEIGHT 500  |  LINE 1.5',
          ),
          const SizedBox(height: 4),
          ClayText.body(
            'Body text is designed for comfortable reading across paragraphs and descriptions.',
          ),
          const SizedBox(height: 18),
          ClayText.label(
            'LABEL  |  INTER  |  12 PX  |  WEIGHT 400  |  LINE 1.2',
          ),
          const SizedBox(height: 4),
          ClayText.label('COMPACT SUPPORTING TEXT'),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Customize a Style',
      description: 'Every variant accepts the same optional Text properties. Overrides are applied on top of that variant’s default style.',
      code: '''
ClayText.body(
  'Emphasized body text',
  color: ClayColors.cobalt.s700,
  fontSize: 18,
  fontWeight: FontWeight.w700,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
''',
      preview: ClayText.body(
        'Emphasized body text with a custom color, size, and weight.',
        color: ClayColors.cobalt.s700,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'text',
      type: 'String',
      description: 'The text content displayed by the widget.',
      required: true,
    ),
    ClayProp(
      name: 'color',
      type: 'Color?',
      description:
          'Text color. Defaults to the current Clay theme onBackground color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'textAlign',
      type: 'TextAlign?',
      description: 'How the text is aligned within its available width.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'overflow',
      type: 'TextOverflow?',
      description: 'How visual overflow is handled when the text does not fit.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'maxLines',
      type: 'int?',
      description: 'The maximum number of lines to display.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'fontWeight',
      type: 'FontWeight?',
      description:
          'Overrides the default weight for the selected text variant.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'fontSize',
      type: 'double?',
      description:
          'Overrides the default font size for the selected text variant.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'height',
      type: 'double?',
      description: 'Overrides the line height for the selected text variant.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'letterSpacing',
      type: 'double?',
      description: 'Overrides the spacing between characters. Values are logical pixels.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'fontFeatures',
      type: 'List<FontFeature>?',
      description: 'OpenType font features applied to the text.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'softWrap',
      type: 'bool?',
      description: 'Whether text wraps at soft line breaks. When null, the Flutter Text default is used.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'textDirection',
      type: 'TextDirection?',
      description: 'The direction used to resolve alignment and text order. When null, ambient direction is used.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'textHeightBehavior',
      type: 'TextHeightBehavior?',
      description:
          'Controls how leading is applied to the first and last lines.',
      defaultValue: 'null',
    ),
  ],
);
