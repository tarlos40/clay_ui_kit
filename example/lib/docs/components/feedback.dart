import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc feedbackDocumentation = ComponentDoc(
  title: 'Feedback',
  subtitle: 'Components',
  description: 'Status panels for success, warning, error, information, empty, and loading states, with optional actions and custom visuals.',
  legends: [
    DocumentationLegend(label: 'Success', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Warning', color: ClayColors.amber.s500),
    DocumentationLegend(label: 'Error', color: ClayColors.ruby.s500),
    DocumentationLegend(label: 'Info / Loading', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Empty', color: ClayColors.violet.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Status Message Panel',
      description: 'Use ClayFeedback for action-oriented status messaging. Provide a status, title, optional message, and an action when the user can continue.',
      code: '''
ClayFeedback(
  status: ClayFeedbackStatus.success,
  title: 'Everything is synced',
  message: 'Your files were uploaded successfully.',
  actionLabel: 'Open',
  onAction: () {},
)
''',
      preview: ClayFeedback(
        status: ClayFeedbackStatus.success,
        title: 'Everything is synced',
        message: 'Your files were uploaded successfully.',
        actionLabel: 'Open',
        onAction: () {},
      ),
    ),
    ClayShowcase(
      title: 'Compact Error State',
      description: 'Compact mode reduces icon, heading, message, and action spacing for inline forms or smaller content areas.',
      code: '''
ClayFeedback(
  status: ClayFeedbackStatus.error,
  title: 'No connection',
  message: 'Check your internet and try again.',
  compact: true,
  showIcon: true,
)
''',
      preview: ClayFeedback(
        status: ClayFeedbackStatus.error,
        title: 'No connection',
        message: 'Check your internet and try again.',
        compact: true,
      ),
    ),
    ClayShowcase(
      title: 'Empty and Loading States',
      description: 'Use empty when a result set has no content and loading while work is in progress. Each status supplies a default title; loading shows a progress indicator in place of its status icon.',
      code: '''
ClayFeedback(
  status: ClayFeedbackStatus.empty,
  message: 'Create an item to see it here.',
  showIcon: true,
)

ClayFeedback(
  status: ClayFeedbackStatus.loading,
  title: 'Loading results',
  message: 'This usually takes a few seconds.',
  compact: true,
)
''',
      preview: Column(
        children: [
          ClayFeedback(
            status: ClayFeedbackStatus.empty,
            message: 'Create an item to see it here.',
            compact: true,
          ),
          const SizedBox(height: 12),
          ClayFeedback(
            status: ClayFeedbackStatus.loading,
            title: 'Loading results',
            message: 'This usually takes a few seconds.',
            compact: true,
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Customize the Visual and Action',
      description: 'A custom illustration replaces the status icon or loading indicator. The action button is shown only when both actionLabel and onAction are provided; set animate to false to render without the entry animation.',
      code: '''
ClayFeedback(
  status: ClayFeedbackStatus.info,
  title: 'Review your settings',
  message: 'You can change these preferences at any time.',
  illustration: Icon(Icons.tune_rounded, size: 48),
  actionLabel: 'Review settings',
  onAction: _openSettings,
  animate: false,
  padding: EdgeInsets.all(20),
  borderRadius: 16,
)
''',
      preview: ClayFeedback(
        status: ClayFeedbackStatus.info,
        title: 'Review your settings',
        message: 'You can change these preferences at any time.',
        illustration: const Icon(Icons.tune_rounded, size: 48),
        actionLabel: 'Review settings',
        onAction: () {},
        animate: false,
        padding: const EdgeInsets.all(20),
        borderRadius: 16,
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'status',
      type: 'ClayFeedbackStatus',
      description: 'Current state: success, error, warning, info, empty, or loading. Each state supplies a themed accent, icon, and default title.',
      defaultValue: 'loading',
      required: true,
    ),
    ClayProp(
      name: 'title / message',
      type: 'String? / String?',
      description:
          'Main heading and supporting text shown inside the feedback panel.',
    ),
    ClayProp(
      name: 'icon / color / illustration',
      type: 'Widget? / Color? / Widget?',
      description: 'icon replaces the built-in symbol (loading uses a progress indicator); color overrides the status accent; illustration replaces the whole visual area, including loading.',
    ),
    ClayProp(
      name: 'compact / animate / showIcon',
      type: 'bool / bool / bool',
      description: 'Tighten spacing, enable entry and content-update animations, and show or hide the visual area.',
      defaultValue: 'false / true / true',
    ),
    ClayProp(
      name: 'actionLabel / onAction',
      type: 'String? / VoidCallback?',
      description:
          'Displays a CTA only when both the label and callback are provided.',
      defaultValue: 'null / null',
    ),
    ClayProp(
      name: 'padding / borderRadius',
      type: 'EdgeInsetsGeometry / double',
      description: 'Inner spacing and rounded corners of the panel.',
      defaultValue: 'EdgeInsets.all(24) / 24',
    ),
  ],
);
