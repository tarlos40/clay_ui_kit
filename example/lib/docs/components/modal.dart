import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc modalDocumentation = ComponentDoc(
  title: 'Modal',
  subtitle: 'Components',
  description: 'A focused dialog for decisions, forms, and short tasks. It returns a typed result, supports custom content and actions, and can configure dismissal, scrolling, alignment, and safe-area behavior.',
  legends: [
    DocumentationLegend(label: 'Dismissible', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Actions', color: ClayColors.cobalt.s500),
    DocumentationLegend(
      label: 'Scrollable Content',
      color: ClayColors.amber.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Show a Confirmation Dialog',
      description: 'Call ClayModal.show from an event callback. Its Future completes with the value passed to Navigator.pop, or null when dismissed without a result.',
      code: '''
final confirmed = await ClayModal.show<bool>(
  context: context,
  title: 'Delete project?',
  description: 'This action cannot be undone.',
  child: const ClayText.body('The project and its files will be removed.'),
  actions: [
    ClayButton.tertiary(
      'Cancel',
      onPressed: () => Navigator.pop(context, false),
    ),
    ClayButton.error(
      'Delete',
      onPressed: () => Navigator.pop(context, true),
    ),
  ],
);

if (confirmed == true) {
  await deleteProject();
}
''',
      preview: Builder(
        builder: (context) => ClayButton.primary(
          'Open confirmation',
          onPressed: () => ClayModal.show<void>(
            context: context,
            title: 'Save changes?',
            description: 'Your edits are ready to be saved.',
            child: const ClayText.body('You can continue editing later.'),
            actions: [
              ClayButton.primary(
                'Save',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Use Custom Content and a Leading Icon',
      description: 'Use child for a form or custom widget tree, and leading for an icon beside the title. Return an object or enum from an action when the caller needs more than a yes/no answer.',
      code: '''
enum ProjectAction { save, discard }

final action = await ClayModal.show<ProjectAction>(
  context: context,
  title: 'Unsaved changes',
  description: 'Choose what to do with your edits.',
  leading: Icon(Icons.edit_note_rounded),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClayText.label('Project name'),
      const SizedBox(height: 8),
      ClayInput(label: 'Name', hintText: 'New project'),
    ],
  ),
  actionsAlignment: MainAxisAlignment.spaceBetween,
  actions: [
    ClayButton.text(
      'Discard',
      onPressed: () => Navigator.pop(context, ProjectAction.discard),
    ),
    ClayButton.primary(
      'Save changes',
      iconLeft: Icon(Icons.save_outlined),
      onPressed: () => Navigator.pop(context, ProjectAction.save),
    ),
  ],
);
''',
      preview: Builder(
        builder: (context) => ClayButton.secondary(
          'Open edit dialog',
          onPressed: () => ClayModal.show<void>(
            context: context,
            title: 'Unsaved changes',
            description: 'Choose what to do with your edits.',
            leading: const Icon(Icons.edit_note_rounded),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClayText.label('Project name'),
                SizedBox(height: 8),
                ClayInput(label: 'Name', hintText: 'New project'),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              ClayButton.text(
                'Discard',
                onPressed: () => Navigator.pop(context),
              ),
              ClayButton.primary(
                'Save changes',
                iconLeft: const Icon(Icons.save_outlined),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Long Content and Dismissal Rules',
      description: 'Scrollable content is enabled by default and the dialog is limited to 85% of screen height. Disable barrierDismissible to block outside taps; closeOnEscape controls back/Escape, independently of the close button.',
      code: '''
ClayModal.show<void>(
  context: context,
  title: 'Terms and conditions',
  description: 'Review the details before continuing.',
  child: const TermsContent(),
  scrollable: true,
  barrierDismissible: false,
  showCloseButton: false,
  closeOnEscape: false,
  useSafeArea: true,
)
''',
      preview: Builder(
        builder: (context) => ClayButton.tertiary(
          'Open long-content modal',
          onPressed: () => ClayModal.show<void>(
            context: context,
            title: 'Terms and conditions',
            description: 'This content scrolls inside the dialog.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                8,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ClayText.body(
                    'Section ${index + 1}: Review the terms that apply to your account and workspace.',
                  ),
                ),
              ),
            ),
            scrollable: true,
            barrierDismissible: false,
            closeOnEscape: false,
            actions: [
              ClayButton.primary(
                'Close',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Adjust Layout and Appearance',
      description: 'Set panel width, radius, padding, colors, drag handle, and content/action alignment. Actions wrap when they do not fit on one row.',
      code: '''
ClayModal.show<void>(
  context: context,
  title: 'Quick note',
  showDragHandle: true,
  maxWidth: 560,
  radius: 20,
  padding: EdgeInsets.all(20),
  backgroundColor: ClayColors.cobalt.s50,
  foregroundColor: ClayColors.slate.s950,
  contentAlignment: CrossAxisAlignment.center,
  actionsAlignment: MainAxisAlignment.center,
  actions: [ClayButton.primary('Done', onPressed: () => Navigator.pop(context))],
)
''',
      preview: Builder(
        builder: (context) => ClayButton.primary(
          'Open styled modal',
          onPressed: () => ClayModal.show<void>(
            context: context,
            title: 'Quick note',
            showDragHandle: true,
            maxWidth: 560,
            radius: 20,
            padding: const EdgeInsets.all(20),
            backgroundColor: ClayColors.cobalt.s50,
            foregroundColor: ClayColors.slate.s950,
            contentAlignment: CrossAxisAlignment.center,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ClayButton.primary(
                'Done',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'context',
      type: 'BuildContext',
      description: 'Context used to present the dialog.',
      required: true,
    ),
    ClayProp(
      name: 'title / description / child',
      type: 'String? / String? / Widget?',
      description: 'Optional heading, supporting copy, and custom body. child is placed in an internal scroll view when scrollable is true.',
    ),
    ClayProp(
      name: 'actions',
      type: 'List<Widget>',
      description: 'Optional action widgets arranged at the bottom and wrapped onto additional rows when needed.',
      defaultValue: 'const []',
    ),
    ClayProp(
      name: 'barrierDismissible',
      type: 'bool',
      description: 'Whether tapping outside dismisses the modal.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'showCloseButton / closeOnEscape',
      type: 'bool',
      description: 'Control the visible close button and PopScope back/Escape dismissal independently.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'maxWidth / radius / padding',
      type: 'double / double / EdgeInsetsGeometry',
      description: 'Set maximum width, corner radius, and inner padding. Dialog height is capped at 85% of the screen.',
      defaultValue: '480 / 28 / EdgeInsets.all(24)',
    ),
    ClayProp(
      name: 'leading / backgroundColor / foregroundColor',
      type: 'Widget? / Color? / Color?',
      description: 'Optional widget beside the title, panel color, and content color. Colors default to theme container and onContainer.',
      defaultValue: 'null / theme.container / theme.onContainer',
    ),
    ClayProp(
      name: 'showDragHandle / scrollable / useSafeArea',
      type: 'bool',
      description: 'Show the top handle, place child in an internal scroll view, and keep the dialog within system safe areas.',
      defaultValue: 'false / true / true',
    ),
    ClayProp(
      name: 'actionsAlignment / contentAlignment',
      type: 'MainAxisAlignment / CrossAxisAlignment',
      description: 'Align the action wrap and the main content column.',
      defaultValue: 'MainAxisAlignment.end / CrossAxisAlignment.start',
    ),
    ClayProp(
      name: 'ClayModal.show<T>',
      type: 'Future<T?>',
      description: 'Returns the value supplied to Navigator.pop<T>, or null if dismissed without a value. Await it to continue after the dialog closes.',
    ),
  ],
);
