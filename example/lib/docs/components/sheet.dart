import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc sheetDocumentation = ComponentDoc(
  title: 'Sheet',
  subtitle: 'Components',
  description: 'An overlay panel that slides from an edge and can be dragged between configurable snap points.',
  legends: [
    DocumentationLegend(label: 'Bottom / Top', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Side Sheet', color: ClayColors.sky.s500),
    DocumentationLegend(
      label: 'Draggable Snap Points',
      color: ClayColors.amber.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Present a Sheet',
      description: 'Call ClaySheet.show from a user action. The returned Future completes when the sheet closes; snap points are fractions of the available extent.',
      code: '''
ClaySheet.show(
  context,
  position: ClaySheetPosition.bottom,
  snapPoints: const [0.3, 0.6, 1.0],
  initialSnapPoint: 0.6,
  child: const ClayText.title('Filters'),
)
''',
      preview: Builder(
        builder: (context) => ClayButton.primary(
          'Open filters',
          onPressed: () => ClaySheet.show(
            context,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClayText.title('Filters'),
                ClayText.body('Choose options for your results.'),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'context / child',
      type: 'BuildContext / Widget',
      description: 'Context for the overlay and required sheet content.',
      required: true,
    ),
    ClayProp(
      name: 'position',
      type: 'ClaySheetPosition',
      description: 'Edge from which the sheet appears.',
      defaultValue: 'bottom',
    ),
    ClayProp(
      name: 'snapPoints / initialSnapPoint',
      type: 'List<double> / double',
      description: 'Allowed extent fractions and the initial extent.',
      defaultValue: '[0.25, 0.5, 1.0] / 0.5',
    ),
    ClayProp(
      name: 'isDismissible / enableDrag / showDragHandle',
      type: 'bool',
      description: 'Configure barrier dismissal, dragging, and the handle.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'onOpened / onClosed',
      type: 'VoidCallback?',
      description: 'Optional lifecycle callbacks.',
    ),
  ],
);