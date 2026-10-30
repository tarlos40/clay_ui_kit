import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc inputDocumentation = ComponentDoc(
  title: 'Input',
  subtitle: 'Components',
  description: 'A styled text field with validation feedback, password visibility, clear controls, read-only and disabled states, and multiline support.',
  legends: [
    DocumentationLegend(label: 'Text', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Password', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Error / Disabled', color: ClayColors.ruby.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Text and Password Fields',
      description: 'Use a controller for external editing state or callbacks for changes and submission. password adds a visibility toggle; clearable adds a clear button once text is entered.',
      code: '''
ClayInput(
  label: 'Email address',
  hintText: 'name@example.com',
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {},
)

ClayInput(
  label: 'Password',
  password: true,
  onSubmitted: (value) {},
)
''',
      preview: Column(
        children: [
          ClayInput(
            label: 'Email address',
            hintText: 'name@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          const ClayInput(
            label: 'Password',
            password: true,
            hintText: 'Enter password',
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Validation and Helper Messages',
      description: 'Pass validation feedback through errorText. A non-empty error message highlights the field and hides helperText; clear errorText to restore the helper message.',
      code: '''
ClayInput(
  label: 'Email address',
  hintText: 'name@example.com',
  errorText: 'Enter a valid email address.',
  keyboardType: TextInputType.emailAddress,
)

ClayInput(
  label: 'Username',
  hintText: 'Choose a username',
  helperText: 'Use 3 to 20 characters.',
)
''',
      preview: Column(
        children: [
          ClayInput(
            label: 'Email address',
            hintText: 'name@example.com',
            errorText: 'Enter a valid email address.',
            helperText: 'We will never share your email.',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          const ClayInput(
            label: 'Username',
            hintText: 'Choose a username',
            helperText: 'Use 3 to 20 characters.',
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Input States and Custom Icons',
      description: 'Use readOnly to allow focus and selection without editing, or enabled: false to disable interaction. Prefix and suffix widgets can add context or custom controls.',
      code: '''
ClayInput(
  label: 'Password',
  password: true,
  clearable: false,
  prefixIcon: Icon(Icons.lock_outline),
  helperText: 'Use at least 8 characters.',
)

ClayInput(
  label: 'Account ID',
  controller: accountIdController,
  readOnly: true,
  suffixIcon: Icon(Icons.copy_outlined),
  onTap: _copyAccountId,
)

ClayInput(label: 'Unavailable', enabled: false)
''',
      preview: Column(
        children: [
          ClayInput(
            label: 'Password',
            password: true,
            clearable: false,
            prefixIcon: const Icon(Icons.lock_outline),
            helperText: 'Use at least 8 characters.',
          ),
          const SizedBox(height: 14),
          ClayInput(
            label: 'Account ID',
            readOnly: true,
            suffixIcon: const Icon(Icons.copy_outlined),
            onTap: () {},
          ),
          const SizedBox(height: 14),
          const ClayInput(label: 'Unavailable', enabled: false),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Multiline Input',
      description: 'Use ClayInput.textArea for a multiline field. It defaults to 3-5 lines, sentence capitalization, and a newline action; maxLength limits input without showing the platform counter.',
      code: '''
ClayInput.textArea(
  label: 'Description',
  hintText: 'Add more detail...',
  helperText: 'Up to 300 characters.',
  minLines: 3,
  maxLines: 5,
  maxLength: 300,
  textInputAction: TextInputAction.newline,
  onChanged: (value) {},
)
''',
      preview: const ClayInput.textArea(
        label: 'Description',
        hintText: 'Add more detail...',
        helperText: 'Up to 300 characters.',
        minLines: 3,
        maxLines: 5,
        maxLength: 300,
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'controller / focusNode',
      type: 'TextEditingController? / FocusNode?',
      description: 'Optional externally managed editing and focus state.',
    ),
    ClayProp(
      name: 'label / hintText / helperText / errorText',
      type: 'String?',
      description: 'Field label and placeholder; helper copy is hidden while a non-empty errorText is shown. Validation is supplied by the app.',
    ),
    ClayProp(
      name: 'prefixIcon / suffixIcon',
      type: 'Widget?',
      description: 'Optional widgets shown before and after the text. Password visibility and clear controls are added alongside suffixIcon when applicable.',
    ),
    ClayProp(
      name: 'enabled / readOnly',
      type: 'bool',
      description: 'enabled: false disables interaction; readOnly prevents text edits while retaining normal focus behavior.',
      defaultValue: 'true / false',
    ),
    ClayProp(
      name: 'password / obscureText / clearable',
      type: 'bool',
      description: 'password starts obscured and adds a visibility toggle; obscureText starts obscured without that toggle; clearable shows a clear button for non-empty text.',
      defaultValue: 'false / false / true',
    ),
    ClayProp(
      name: 'backgroundColor / textColor / hintColor / labelColor / errorColor',
      type: 'Color?',
      description: 'Customize field surface, entered text, hint, label, and validation feedback colors.',
    ),
    ClayProp(
      name: 'maxLength / maxLines / minLines',
      type: 'int?',
      description: 'Configure character limit and line count. The input hides the native counter; password fields must remain single-line.',
      defaultValue: 'null / 1 / null',
    ),
    ClayProp(
      name: 'keyboardType / textInputAction / textCapitalization',
      type: 'TextInputType? / TextInputAction? / TextCapitalization',
      description: 'Configure the keyboard and text entry behavior.',
    ),
    ClayProp(
      name: 'onChanged / onSubmitted / onTap',
      type: 'ValueChanged<String>? / ValueChanged<String>? / VoidCallback?',
      description: 'Callbacks for editing, submission, and tapping.',
    ),
    ClayProp(
      name: 'padding / borderRadius',
      type: 'EdgeInsetsGeometry? / double',
      description: 'Text inset and corner radius of the field.',
      defaultValue: 'null / 40',
    ),
    ClayProp(
      name: 'ClayInput.textArea',
      type: 'named constructor',
      description: 'Multiline constructor; defaults to maxLines 5, minLines 3, multiline keyboard, newline action, sentence capitalization, and radius 18.',
    ),
  ],
);
