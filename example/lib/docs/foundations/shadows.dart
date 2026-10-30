import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc shadowsDocumentation = ComponentDoc(
  title: 'Shadows',
  subtitle: 'Foundations',
  description: 'Clay shadows combine a light source with a soft dark edge to make surfaces feel tactile. Use the provided helpers as a foundation for custom components, and tune their values to match each component’s role.',
  showcases: [
    ClayShowcase(
      title: 'Build a Custom Clay Component',
      description: 'Use CustomPaint with ClayInnerShadowPainter for inset highlights and shadows, then apply ClayShadows.external to the child decoration for raised depth. Read light and shadow from the active Clay theme so the component adapts to light and dark modes. The values below are an example profile, not the helpers’ defaults.',
      code: '''
final theme = context.clayTheme;
const radius = 16.0;

CustomPaint(
  foregroundPainter: ClayInnerShadowPainter(
    shadowColor: theme.shadow,
    lightColor: theme.light,
    borderRadius: radius,
    shadowSize: 2.5,
    blurRadius: 7,
  ),
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: theme.container,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: ClayShadows.external(
        theme: theme,
        offset: 2.5,
        blur: 7,
      ),
    ),
    child: const Text('A custom clay surface'),
  ),
)
''',
      preview: Builder(
        builder: (context) {
          final theme = context.clayTheme;
          const radius = 16.0;

          return CustomPaint(
            foregroundPainter: ClayInnerShadowPainter(
              shadowColor: theme.shadow,
              lightColor: theme.light,
              borderRadius: radius,
              shadowSize: 2.5,
              blurRadius: 7,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.container,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: ClayShadows.external(
                  theme: theme,
                  offset: 2.5,
                  blur: 7,
                ),
              ),
              child: const Text('A custom clay surface'),
            ),
          );
        },
      ),
    ),
    ClayShowcase(
      title: 'Component Shadow Profiles',
      description: 'The helpers have general-purpose defaults, while each built-in component passes values tuned to its shape and interaction. Buttons remove their outer shadow while pressed, disabled, or rendered as text.',
      code: '''
// ClayShadows.external defaults: offset 6, blur 12
// ClayInnerShadowPainter defaults: shadowSize 8, blurRadius 6

// ClayContainer: outer 2.5 / 7, inner 2.5 / 7
// ClayCard: outer 1 / 4, inner 2.5 / 7
// Enabled ClayButton: outer 4 / 7, inner 2.5 / 7
''',
      preview: Wrap(
        spacing: 16,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 220,
            child: ClayCard(
              children: [
                ClayCard.body(
                  children: [ClayText.body('Card: softer outer elevation')],
                ),
              ],
            ),
          ),
          ClayButton.primary('Raised button', onPressed: () {}),
        ],
      ),
    ),
  ],
);
