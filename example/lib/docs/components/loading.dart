import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc loadingDocumentation = ComponentDoc(
  title: 'Loading',
  subtitle: 'Components',
  description: 'Animated progress feedback for inline content or blocking operations. Choose an animation style, add context, and use the modal helpers to show and dismiss an operation state.',
  legends: [
    DocumentationLegend(label: 'Orbit', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Dots', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Pulse', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Modal', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Inline Loading Styles',
      description: 'Use orbit, dots, or pulse inline while a section or page is loading. Labels are optional; icon appears in the center of orbit and pulse styles.',
      code: '''
ClayLoading(
  style: ClayLoadingStyle.orbit,
  label: 'Syncing your workspace',
  size: 52,
)

await ClayLoading.show(context, label: 'Uploading...');
''',
      preview: Wrap(
        spacing: 28,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: const [
          ClayLoading(style: ClayLoadingStyle.orbit, label: 'Orbit'),
          ClayLoading(style: ClayLoadingStyle.dots, label: 'Dots'),
          ClayLoading(style: ClayLoadingStyle.pulse, label: 'Pulse'),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Modal Loading During an Operation',
      description: 'Call show without awaiting it before starting the operation: its Future completes only after the dialog is dismissed. In a finally block, call hide with the same navigator choice so the modal closes on success or failure.',
      code: '''
Future<void> uploadFiles(BuildContext context) async {
  ClayLoading.show(
    context,
    label: 'Uploading files...',
    style: ClayLoadingStyle.dots,
    icon: Icon(Icons.cloud_upload_outlined),
    barrierDismissible: false,
  );

  try {
    await repository.upload();
  } finally {
    if (context.mounted) ClayLoading.hide(context);
  }
}
''',
      preview: Builder(
        builder: (context) => ClayButton.primary(
          'Preview modal loading',
          onPressed: () async {
            ClayLoading.show(context, label: 'Uploading files...');
            await Future<void>.delayed(const Duration(milliseconds: 900));
            if (context.mounted) ClayLoading.hide(context);
          },
        ),
      ),
    ),
    ClayShowcase(
      title: 'Configure the Modal',
      description: 'The modal can be barrier-dismissible, use the root or nearest navigator, and customize its barrier, panel padding, corner radius, style, color, size, and label.',
      code: '''
ClayLoading.show(
  context,
  label: 'Preparing report...',
  style: ClayLoadingStyle.pulse,
  size: 48,
  color: ClayColors.cobalt.s600,
  labelColor: ClayColors.slate.s700,
  barrierDismissible: true,
  useRootNavigator: false,
  barrierColor: Colors.black26,
  padding: EdgeInsets.all(20),
  borderRadius: 18,
);

ClayLoading.hide(context, useRootNavigator: false);
''',
      preview: ClayLoading(
        style: ClayLoadingStyle.pulse,
        label: 'Preparing report...',
        size: 48,
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'style',
      type: 'ClayLoadingStyle',
      description: 'Animation style: orbit, dots, or pulse.',
      defaultValue: 'orbit',
    ),
    ClayProp(
      name: 'label',
      type: 'String?',
      description: 'Optional status text displayed below the animation.',
    ),
    ClayProp(
      name: 'size / strokeWidth / gap',
      type: 'double',
      description: 'Configure animation dimensions and label spacing.',
      defaultValue: '52 / 3.5 / 14',
    ),
    ClayProp(
      name: 'color / labelColor / icon',
      type: 'Color? / Widget?',
      description: 'Customize animation and label colors. icon is rendered inside orbit and pulse styles; dots has no center icon.',
    ),
    ClayProp(
      name: 'ClayLoading.show',
      type: 'Future<void>',
      description: 'Opens a modal and returns a Future that completes when dismissed. Do not await it before the operation finishes; call hide in finally. Supports label, icon, size, colors, style, barrierDismissible, useRootNavigator, barrierColor, padding, and borderRadius.',
      defaultValue: 'orbit / 54 / barrierDismissible false / root navigator / horizontal 28, vertical 24 / radius 24',
    ),
    ClayProp(
      name: 'ClayLoading.hide',
      type: 'void',
      description: 'Pops the current route when possible. Pass the same useRootNavigator value used by show so it dismisses the matching dialog.',
      defaultValue: 'useRootNavigator: true',
    ),
  ],
);
