import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc switchDocumentation = ComponentDoc(
  title: 'Switch',
  subtitle: 'Components',
  description: 'An animated, controlled on/off control for an immediate binary setting. Customize its track and thumb colors, dimensions, spacing, and optionally generate a repeatable palette color.',
  legends: [
    DocumentationLegend(label: 'On', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Off', color: ClayColors.cloud.s500),
    DocumentationLegend(label: 'Disabled', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Bind a Setting',
      description: 'Pass the current value and update it from onChanged. The callback is required by the constructor, but can be null to make the switch non-interactive. The control also responds to taps on its label and exposes its value and description to accessibility semantics.',
      code: '''
ClaySwitch(
  value: notificationsEnabled,
  label: 'Notifications',
  description: 'Receive product updates',
  onChanged: (value) => setState(() => notificationsEnabled = value),
)
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClaySwitch(
            value: true,
            label: 'Notifications',
            description: 'Receive product updates',
            onChanged: _ignoreBool,
          ),
          ClaySwitch(
            value: false,
            label: 'Sound effects',
            onChanged: _ignoreBool,
          ),
          ClaySwitch(
            value: false,
            label: 'Unavailable option',
            enabled: false,
            onChanged: _ignoreBool,
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Customize Colors and Spacing',
      description: 'Set activeColor, inactiveColor, thumbColor, and foregroundColor to control the on track, off track, thumb, and check icon. randomColor generates an active palette color; randomSeed makes that choice repeatable between rebuilds. Explicit activeColor and foregroundColor values take precedence over generated colors.',
      code: '''
ClaySwitch(
  value: true,
  label: 'Random accent',
  description: 'The generated color stays stable with a seed.',
  randomColor: true,
  randomSeed: 42,
  width: 56,
  height: 32,
  padding: EdgeInsets.symmetric(vertical: 10),
  onChanged: (value) => setState(() => enabled = value),
)

ClaySwitch(
  value: true,
  label: 'Explicit colors',
  activeColor: ClayColors.cobalt.s500,
  inactiveColor: ClayColors.cloud.s200,
  thumbColor: Colors.white,
  foregroundColor: ClayColors.cobalt.s700,
  onChanged: (value) => setState(() => enabled = value),
)
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClaySwitch(
            value: true,
            label: 'Random accent',
            description: 'Repeatable generated color',
            randomColor: true,
            randomSeed: 42,
            width: 56,
            height: 32,
            padding: EdgeInsets.symmetric(vertical: 10),
            onChanged: _ignoreBool,
          ),
          ClaySwitch(
            value: true,
            label: 'Explicit colors',
            activeColor: ClayColors.cobalt.s500,
            inactiveColor: ClayColors.cloud.s200,
            thumbColor: Colors.white,
            foregroundColor: ClayColors.cobalt.s700,
            onChanged: _ignoreBool,
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'value',
      type: 'bool',
      description: 'Current on/off state. ClaySwitch is controlled; update value in the parent when onChanged is called.',
      required: true,
    ),
    ClayProp(
      name: 'onChanged',
      type: 'ValueChanged<bool>?',
      description: 'Required constructor argument called with the next value when tapped. Pass null to prevent interaction.',
      required: true,
    ),
    ClayProp(
      name: 'label / description',
      type: 'String?',
      description: 'Optional visible text beside the switch. Also supplies the semantic label and hint, respectively.',
    ),
    ClayProp(
      name: 'enabled',
      type: 'bool',
      description: 'Whether the control is enabled. Disabled switches are dimmed and cannot be changed by tapping, even when onChanged is provided.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'activeColor',
      type: 'Color?',
      description: 'Track color while on. Precedence: explicit color, generated color when randomColor is true, then theme primary.',
    ),
    ClayProp(
      name: 'inactiveColor',
      type: 'Color?',
      description: 'Track color while off. Defaults to theme container.',
    ),
    ClayProp(
      name: 'thumbColor',
      type: 'Color?',
      description:
          'Thumb surface color in both states. Defaults to theme onPrimary.',
    ),
    ClayProp(
      name: 'foregroundColor',
      type: 'Color?',
      description: 'Check icon color while on. Defaults to the generated color when randomColor is enabled, otherwise theme primary.',
    ),
    ClayProp(
      name: 'randomColor / randomSeed',
      type: 'bool / int?',
      description: 'When true, chooses a generated palette color for the active track and check icon. Without a seed it may change on rebuild; a fixed randomSeed makes the selection repeatable. Defaults: false / null.',
      defaultValue: 'false / null',
    ),
    ClayProp(
      name: 'width / height',
      type: 'double',
      description: 'Track dimensions in logical pixels. Both must be positive and width must be at least height.',
      defaultValue: '48 / 28',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry',
      description:
          'Outer padding around the tappable switch and its optional text.',
      defaultValue: 'EdgeInsets.symmetric(vertical: 6)',
    ),
  ],
);

void _ignoreBool(bool value) {}
