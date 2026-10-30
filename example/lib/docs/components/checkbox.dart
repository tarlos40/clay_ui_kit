import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc checkboxDocumentation = ComponentDoc(
  title: 'Checkbox',
  subtitle: 'Components',
  description: 'A controlled binary choice with optional semantic text, disabled state, and configurable appearance.',
  legends: [
    DocumentationLegend(label: 'Unchecked', color: ClayColors.slate.s500),
    DocumentationLegend(label: 'Checked', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Disabled', color: ClayColors.cloud.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Bind a Checkbox Value',
      description: 'The checkbox is controlled by value; update that value in your state when onChanged reports the new selection. Label and description are also exposed as semantic label and hint.',
      code: '''
ClayCheckbox(
  value: accepted,
  label: 'Accept terms',
  description: 'Required before continuing',
  onChanged: (value) => setState(() => accepted = value),
)
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClayCheckbox(
            value: false,
            label: 'Email notifications',
            onChanged: (_) {},
          ),
          ClayCheckbox(
            value: true,
            label: 'Product updates',
            onChanged: (_) {},
          ),
          const ClayCheckbox(
            value: false,
            label: 'Unavailable option',
            enabled: false,
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Appearance and Disabled State',
      description: 'Set the checkbox size, corner radius, and padding. Use explicit colors or enable a repeatable generated color with randomSeed.',
      code: '''
ClayCheckbox(
  value: true,
  label: 'Use custom colors',
  description: 'The seed keeps generated colors repeatable.',
  randomColor: true,
  randomSeed: 42,
  size: 28,
  radius: 8,
  padding: EdgeInsets.symmetric(vertical: 10),
  onChanged: (value) => setState(() => selected = value),
)

ClayCheckbox(
  value: false,
  label: 'Unavailable option',
  enabled: false,
  onChanged: (value) {},
)
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClayCheckbox(
            value: true,
            label: 'Use custom colors',
            description: 'Generated colors use a repeatable seed.',
            randomColor: true,
            randomSeed: 42,
            size: 28,
            radius: 8,
          ),
          ClayCheckbox(
            value: true,
            label: 'Explicit colors',
            activeColor: ClayColors.cobalt.s500,
            foregroundColor: ClayColors.ocean.s50,
            backgroundColor: ClayColors.cloud.s100,
            onChanged: (_) {},
          ),
          const ClayCheckbox(
            value: false,
            label: 'Unavailable option',
            description: 'This option cannot be changed.',
            enabled: false,
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'value',
      type: 'bool',
      description: 'Whether the checkbox is selected.',
      required: true,
    ),
    ClayProp(
      name: 'onChanged',
      type: 'ValueChanged<bool>?',
      description: 'Called with the toggled value. A null callback makes the control non-interactive.',
    ),
    ClayProp(
      name: 'label / description',
      type: 'String?',
      description:
          'Optional visible text; also used as the semantic label and hint.',
    ),
    ClayProp(
      name: 'enabled',
      type: 'bool',
      description: 'Whether user interaction is enabled.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'activeColor',
      type: 'Color?',
      description: 'Selected fill color. Falls back to backgroundColor, generated color, then theme primary.',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Unchecked surface color and fallback selected fill color.',
    ),
    ClayProp(
      name: 'foregroundColor',
      type: 'Color?',
      description: 'Checkmark color; falls back to generated foreground, then theme onPrimary.',
    ),
    ClayProp(
      name: 'size / radius',
      type: 'double',
      description: 'Control dimensions and corner radius.',
      defaultValue: '24 / 7',
    ),
    ClayProp(
      name: 'randomColor / randomSeed',
      type: 'bool / int?',
      description: 'Opt into generated fill and checkmark colors; a seed makes the colors repeatable.',
      defaultValue: 'false / null',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry',
      description: 'Outer padding around the tappable checkbox and its text.',
      defaultValue: 'EdgeInsets.symmetric(vertical: 6)',
    ),
  ],
);
