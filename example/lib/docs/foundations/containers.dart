import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc containersDocumentation = ComponentDoc(
  title: 'Containers',
  subtitle: 'Foundations',
  description: 'ClayContainer is a ready-to-use surface with a claymorphism appearance. It wraps your content in a raised, softly inset box that adapts to the active Clay theme.',
  showcases: [
    ClayShowcase(
      title: 'ClayContainer',
      description: 'Wrap any widget in ClayContainer to give it a soft clay surface. By default it uses the theme container color, a 20 px corner radius, and coordinated external and inner shadows. Adjust its size, spacing, color, border, alignment, or shadow as needed.',
      code: '''
ClayContainer(
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClayText.title('Account summary'),
      ClayText.body('Your content goes inside the container.'),
    ],
  ),
)
''',
      preview: ClayContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClayText.title('Account summary'),
            const SizedBox(height: 8),
            ClayText.body('Your content goes inside the container.'),
          ],
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'child',
      type: 'Widget?',
      description: 'The widget displayed inside the clay surface.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description:
          'Surface color. Defaults to the active theme container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundGradient',
      type: 'Gradient?',
      description: 'Optional surface gradient. Cannot be provided together with backgroundColor.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'padding',
      type: 'EdgeInsetsGeometry?',
      description: 'Insets around the child.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'margin',
      type: 'EdgeInsetsGeometry?',
      description: 'Insets outside the clay surface.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'borderRadius',
      type: 'double',
      description: 'Corner radius used by the surface and its inset shadow.',
      defaultValue: '20',
    ),
    ClayProp(
      name: 'border',
      type: 'Border?',
      description: 'Optional border drawn around the surface.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'boxShadow',
      type: 'List<BoxShadow>?',
      description: 'Custom external shadows. Replaces the default external shadow; the inset shadow painter remains enabled.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'alignment',
      type: 'AlignmentGeometry?',
      description: 'How the child is aligned inside the surface.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'width',
      type: 'double?',
      description: 'Requested surface width.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'height',
      type: 'double?',
      description: 'Requested surface height.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'constraints',
      type: 'BoxConstraints?',
      description: 'Additional constraints applied to the surface.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'clipBehavior',
      type: 'Clip',
      description: 'How the surface clips its child.',
      defaultValue: 'Clip.none',
    ),
  ],
);
