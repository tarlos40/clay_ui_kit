import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc progressDocumentation = ComponentDoc(
  title: 'Progress',
  subtitle: 'Components',
  description: 'Animated progress in bar, circular, or liquid-wave form. Provide a value from 0 to 1, or null for indeterminate progress.',
  legends: [
    DocumentationLegend(label: 'Bar', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Circular', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Wave', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Indeterminate', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Choose a Progress Form',
      description: 'Use the named constructors to select a bar, circle, or wave. The bar can show a label and percentage; circle and wave can wrap custom child content.',
      code: '''
ClayProgress.bar(value: 0.68, label: 'Uploading files', showPercentage: true)
ClayProgress.circle(value: 0.68, showPercentage: true)
ClayProgress.wave(value: 0.68, child: const Text('68%'))

// null value displays indeterminate progress
ClayProgress.bar(value: null)
''',
      preview: Wrap(
        spacing: 20,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 260,
            child: ClayProgress.bar(
              value: 0.68,
              label: 'Uploading files',
              showPercentage: true,
            ),
          ),
          const ClayProgress.circle(value: 0.68, showPercentage: true),
          const ClayProgress.wave(value: 0.68, child: Text('68%')),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'value',
      type: 'double?',
      description: 'Progress fraction from 0 to 1; null displays an indeterminate treatment.',
      required: true,
    ),
    ClayProp(
      name: 'color / backgroundColor',
      type: 'Color?',
      description:
          'Progress and track colors; default to theme primary and container.',
    ),
    ClayProp(
      name: 'ClayProgress.bar',
      type: 'constructor',
      description: 'Supports width, height, radius, label, and showPercentage.',
    ),
    ClayProp(
      name: 'ClayProgress.circle',
      type: 'constructor',
      description: 'Supports size, strokeWidth, showPercentage, and child.',
    ),
    ClayProp(
      name: 'ClayProgress.wave',
      type: 'constructor',
      description:
          'Supports size, radius, child, waveAmplitude, and waveSpeed.',
    ),
    ClayProp(
      name: 'duration',
      type: 'Duration',
      description: 'Animation duration for determinate value changes.',
      defaultValue: '450 ms',
    ),
  ],
);