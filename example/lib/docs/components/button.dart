import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc buttonDocumentation = ComponentDoc(
  title: 'Button',
  subtitle: 'Components',
  description: 'ClayButton provides themed actions with emphasis, feedback, text, icon, and gradient variants. Choose a size and add loading, disabled, or icon states to match the action.',
  legends: [
    DocumentationLegend(label: 'Neutral', color: ClayColors.cloud.s500),
    DocumentationLegend(label: 'Primary', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Supporting', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Success', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Warning', color: ClayColors.amber.s500),
    DocumentationLegend(label: 'Destructive', color: ClayColors.ruby.s500),
    DocumentationLegend(label: 'Text / Icon', color: ClayColors.violet.s500),
    DocumentationLegend(
      label: 'Disabled / Loading',
      color: ClayColors.slate.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Emphasis and Feedback',
      description: 'Use primary for the main action, base for a neutral action, secondary and tertiary for supporting emphasis, and success, warning, or error for status-specific actions.',
      code: '''
Wrap(
  spacing: 10,
  runSpacing: 10,
  children: [
    ClayButton.base('Base', onPressed: () {}),
    ClayButton.primary('Primary', onPressed: () {}),
    ClayButton.secondary('Secondary', onPressed: () {}),
    ClayButton.tertiary('Tertiary', onPressed: () {}),
    ClayButton.success('Save', onPressed: () {}),
    ClayButton.warning('Review', onPressed: () {}),
    ClayButton.error('Delete', onPressed: () {}),
  ],
)
''',
      preview: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ClayButton.base('Base', onPressed: () {}),
          ClayButton.primary('Primary', onPressed: () {}),
          ClayButton.secondary('Secondary', onPressed: () {}),
          ClayButton.tertiary('Tertiary', onPressed: () {}),
          ClayButton.success('Save', onPressed: () {}),
          ClayButton.warning('Review', onPressed: () {}),
          ClayButton.error('Delete', onPressed: () {}),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Text, Icon, and Gradient',
      description: 'Use iconLeft for a leading symbol and iconRight for a trailing symbol around the label. Both can be combined; ClayButton.icon is the separate icon-only variant.',
      code: '''
Wrap(
  spacing: 10,
  runSpacing: 10,
  children: [
    ClayButton.primary(
      'Create project',
      iconLeft: Icon(Icons.add_rounded),
      iconRight: Icon(Icons.arrow_forward_rounded),
      onPressed: () {},
    ),
    ClayButton.text(
      'Learn more',
      iconLeft: Icon(Icons.info_outline_rounded),
      iconRight: Icon(Icons.open_in_new_rounded),
      onPressed: () {},
    ),
    ClayButton.icon(
      Icon(Icons.favorite_rounded),
      onPressed: () {},
    ),
    ClayButton.gradient(
      'Continue',
      colors: [ClayColors.sky.s500, ClayColors.cobalt.s700],
      foregroundColor: ClayColors.sky.s50,
      onPressed: () {},
    ),
  ],
)
''',
      preview: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ClayButton.primary(
            'Create project',
            iconLeft: const Icon(Icons.add_rounded),
            iconRight: const Icon(Icons.arrow_forward_rounded),
            onPressed: () {},
          ),
          ClayButton.text(
            'Learn more',
            iconLeft: const Icon(Icons.info_outline_rounded),
            iconRight: const Icon(Icons.open_in_new_rounded),
            onPressed: () {},
          ),
          ClayButton.icon(const Icon(Icons.favorite_rounded), onPressed: () {}),
          ClayButton.gradient(
            'Continue',
            colors: [ClayColors.sky.s500, ClayColors.cobalt.s700],
            foregroundColor: ClayColors.sky.s50,
            onPressed: () {},
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Sizes and States',
      description: 'Choose small, base, or large to adjust spacing and typography. A null onPressed callback disables the button; isLoading shows a progress indicator and also prevents interaction.',
      code: '''
Wrap(
  spacing: 10,
  runSpacing: 10,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    ClayButton.primary('Small', size: ClayButtonSize.small, onPressed: () {}),
    ClayButton.primary('Base', onPressed: () {}),
    ClayButton.primary('Large', size: ClayButtonSize.large, onPressed: () {}),
    ClayButton.primary('Disabled'),
    ClayButton.primary('Loading', isLoading: true, onPressed: () {}),
  ],
)
''',
      preview: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ClayButton.primary(
            'Small',
            size: ClayButtonSize.small,
            onPressed: () {},
          ),
          ClayButton.primary('Base', onPressed: () {}),
          ClayButton.primary(
            'Large',
            size: ClayButtonSize.large,
            onPressed: () {},
          ),
          ClayButton.primary('Disabled'),
          ClayButton.primary('Loading', isLoading: true, onPressed: () {}),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'text',
      type: 'String',
      description: 'Button label. Required by all text-based variants.',
      required: true,
    ),
    ClayProp(
      name: 'onPressed',
      type: 'VoidCallback?',
      description: 'Action callback. Passing null disables the button.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'isLoading',
      type: 'bool?',
      description:
          'Shows a progress indicator and disables interaction while true.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'size',
      type: 'ClayButtonSize?',
      description: 'Button size: small, base, or large.',
      defaultValue: 'ClayButtonSize.base',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Overrides the themed background for non-gradient variants.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'foregroundColor',
      type: 'Color?',
      description: 'Overrides the themed text and icon foreground color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'iconLeft / iconRight',
      type: 'Widget?',
      description: 'Optional leading and trailing widgets around the label on text variants. They inherit the button foreground color and size; their spacing follows the selected size. Loading replaces the content temporarily.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'icon (icon variant)',
      type: 'Widget',
      description: 'Required icon widget displayed by ClayButton.icon.',
      required: true,
    ),
    ClayProp(
      name: 'iconColor',
      type: 'Color?',
      description: 'Icon color override for ClayButton.icon.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'colors',
      type: 'List<Color>',
      description: 'Required gradient color stops for ClayButton.gradient.',
      required: true,
    ),
    ClayProp(
      name: 'begin / end',
      type: 'AlignmentGeometry',
      description: 'Gradient start and end alignments for ClayButton.gradient.',
      defaultValue: 'Alignment.topLeft / Alignment.bottomRight',
    ),
  ],
);
