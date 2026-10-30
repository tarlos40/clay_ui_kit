import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc propsTableDocumentation = ComponentDoc(
  title: 'Props Table',
  subtitle: 'Components',
  description: 'A horizontally scrollable API reference that presents each property’s name, type, default, required status, and explanation in aligned columns.',
  legends: [
    DocumentationLegend(label: 'Type', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Default', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Required', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Describe a Component API',
      description: 'Create one ClayProp per API entry. Name, type, and description are required; defaultValue and required are optional. The table scrolls horizontally on narrow screens so its columns remain readable.',
      code: '''
ClayPropsTable(
  title: 'Upload properties',
  props: const [
    ClayProp(
      name: 'files',
      type: 'List<PlatformFile>',
      description: 'Files selected for upload.',
      required: true,
    ),
    ClayProp(
      name: 'maxFiles',
      type: 'int?',
      description: 'Maximum number of files allowed.',
      defaultValue: '5',
    ),
    ClayProp(
      name: 'onUpload',
      type: 'ValueChanged<List<PlatformFile>>?',
      description: 'Called with the selected files.',
    ),
  ],
)
''',
      preview: ClayPropsTable(
        title: 'Upload properties',
        props: const [
          ClayProp(
            name: 'files',
            type: 'List<PlatformFile>',
            description: 'Files selected for upload.',
            required: true,
          ),
          ClayProp(
            name: 'maxFiles',
            type: 'int?',
            description: 'Maximum number of files allowed.',
            defaultValue: '5',
          ),
          ClayProp(
            name: 'onUpload',
            type: 'ValueChanged<List<PlatformFile>>?',
            description: 'Called with the selected files.',
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Choose Which Columns to Show',
      description: 'Keep all columns for a complete reference or hide type, default, or required columns for a shorter table. Property and description columns are always shown.',
      code: '''
ClayPropsTable(
  title: 'Compact API reference',
  showType: false,
  showDefault: true,
  showRequired: false,
  padding: EdgeInsets.all(12),
  props: const [
    ClayProp(
      name: 'value',
      type: 'bool',
      description: 'Whether the option is selected.',
      required: true,
    ),
    ClayProp(
      name: 'enabled',
      type: 'bool',
      description: 'Whether the option can be changed.',
      defaultValue: 'true',
    ),
  ],
)
''',
      preview: ClayPropsTable(
        title: 'Compact API reference',
        showType: false,
        showDefault: true,
        showRequired: false,
        padding: const EdgeInsets.all(12),
        props: const [
          ClayProp(
            name: 'value',
            type: 'bool',
            description: 'Whether the option is selected.',
            required: true,
          ),
          ClayProp(
            name: 'enabled',
            type: 'bool',
            description: 'Whether the option can be changed.',
            defaultValue: 'true',
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'props',
      type: 'List<ClayProp>',
      description: 'Rows to display in the API table.',
      required: true,
    ),
    ClayProp(
      name: 'title',
      type: 'String?',
      description: 'Optional table heading.',
    ),
    ClayProp(
      name: 'showType / showDefault / showRequired',
      type: 'bool',
      description: 'Show or hide the type, default, and required columns. Property and description columns remain visible.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry',
      description: 'Padding around the table surface.',
      defaultValue: 'EdgeInsets.all(16)',
    ),
    ClayProp(
      name: 'ClayProp.name / type / description',
      type: 'String',
      description: 'Required property identifier, language/API type, and human-readable explanation.',
      required: true,
    ),
    ClayProp(
      name: 'ClayProp.defaultValue / required',
      type: 'String? / bool',
      description: 'Optional default text and required marker. The table displays an em dash when defaultValue is null.',
      defaultValue: 'null / false',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry',
      description: 'Inset around the table content inside its surface.',
      defaultValue: 'EdgeInsets.all(16)',
    ),
    ClayProp(
      name: 'Horizontal layout',
      type: 'behavior',
      description: 'The table uses fixed-width columns inside a horizontal scroll view; on narrow screens, scroll horizontally to inspect remaining columns.',
    ),
  ],
);
