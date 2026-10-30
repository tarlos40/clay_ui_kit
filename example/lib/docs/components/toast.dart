import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc toastDocumentation = ComponentDoc(
  title: 'Toast',
  subtitle: 'Components',
  description: 'A transient overlay message for confirmations, warnings, and errors. Initialize the toast host before showing notifications.',
  legends: [
    DocumentationLegend(label: 'Primary', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Success', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Warning', color: ClayColors.amber.s500),
    DocumentationLegend(label: 'Error', color: ClayColors.ruby.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Show a Notification',
      description: 'Call ClayToast.init(context) once while an Overlay is available, then call a status method. ClayShowcase initializes the toast host for its own preview.',
      code: '''
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  ClayToast.init(context);
}

ClayToast.success(
  'Your changes were saved.',
  title: 'Saved',
  position: ClayToastPosition.topCenter,
)
''',
      preview: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ClayButton.success(
            'Success toast',
            onPressed: () =>
                ClayToast.success('Your changes were saved.', title: 'Saved'),
          ),
          ClayButton.warning(
            'Warning toast',
            onPressed: () =>
                ClayToast.warning('Review the highlighted fields.'),
          ),
          ClayButton.error(
            'Error toast',
            onPressed: () =>
                ClayToast.error('The request could not be completed.'),
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'ClayToast.init',
      type: 'void',
      description: 'Initialize the overlay host before displaying any toast.',
      required: true,
    ),
    ClayProp(
      name: 'message',
      type: 'String',
      description: 'Required body message for a notification.',
      required: true,
    ),
    ClayProp(
      name: 'title / icon',
      type: 'String? / Widget?',
      description: 'Optional heading and leading icon.',
    ),
    ClayProp(
      name: 'duration / position',
      type: 'Duration? / ClayToastPosition',
      description: 'Display duration and one of six screen positions.',
    ),
    ClayProp(
      name: 'showTimer / showCloseButton / dismissOnSwipe',
      type: 'bool',
      description: 'Configure timer, close control, and swipe dismissal.',
    ),
    ClayProp(
      name: 'variant methods',
      type: 'primary / success / warning / error',
      description: 'Choose the semantic notification style.',
    ),
  ],
);