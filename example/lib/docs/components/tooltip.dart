import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc tooltipDocumentation = ComponentDoc(
  title: 'Tooltip',
  subtitle: 'Components',
  description: 'A contextual hint anchored to a widget, shown on hover for desktop or on long press for touch.',
  legends: [
    DocumentationLegend(label: 'Message', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Custom Content', color: ClayColors.violet.s500),
    DocumentationLegend(
      label: 'Top / Bottom / Side',
      color: ClayColors.sky.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Add a Tooltip to a Control',
      description: 'Provide either a message string or a custom content widget. Position, wait duration, display duration, and enabled state are configurable.',
      code: '''
ClayTooltip(
  message: 'Save your changes',
  position: ClayTooltipPosition.top,
  child: ClayButton.icon(
    Icon(Icons.save_outlined),
    onPressed: () {},
  ),
)
''',
      preview: ClayTooltip(
        message: 'Save your changes',
        child: ClayButton.icon(
          const Icon(Icons.save_outlined),
          onPressed: () {},
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'child',
      type: 'Widget',
      description: 'Widget that anchors the tooltip.',
      required: true,
    ),
    ClayProp(
      name: 'message / content',
      type: 'String? / Widget?',
      description: 'Provide a plain-text message or custom content; at least one is required.',
    ),
    ClayProp(
      name: 'position',
      type: 'ClayTooltipPosition',
      description: 'Preferred placement: top, bottom, left, or right.',
      defaultValue: 'top',
    ),
    ClayProp(
      name: 'waitDuration / showDuration',
      type: 'Duration',
      description: 'Delay before showing and duration on touch platforms.',
    ),
    ClayProp(
      name: 'backgroundColor / foregroundColor',
      type: 'Color?',
      description: 'Override tooltip surface and content colors.',
    ),
    ClayProp(
      name: 'enabled / preferBelow',
      type: 'bool',
      description:
          'Enable display and express the preferred vertical placement.',
      defaultValue: 'true / false',
    ),
  ],
);