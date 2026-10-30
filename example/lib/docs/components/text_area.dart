import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc textAreaDocumentation = ComponentDoc(
  title: 'Text Area',
  subtitle: 'Components',
  description: 'A multiline text-entry field built with the ClayInput.textArea constructor, with helper, validation, and length options.',
  legends: [
    DocumentationLegend(label: 'Multiline', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Helper Text', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Validation', color: ClayColors.ruby.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Collect Longer Text',
      description: 'Use ClayInput.textArea for multiline input. It defaults to sentence capitalization, newline action, and a taller rounded surface; configure line limits and maxLength as needed.',
      code: '''
ClayInput.textArea(
  label: 'Project description',
  hintText: 'Describe the project...',
  helperText: 'Up to 500 characters',
  minLines: 4,
  maxLines: 8,
  maxLength: 500,
  onChanged: (value) {},
)
''',
      preview: const ClayInput.textArea(
        label: 'Project description',
        hintText: 'Describe the project...',
        helperText: 'Up to 500 characters',
        minLines: 3,
        maxLines: 5,
        maxLength: 500,
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
      description:
          'Field title, placeholder, supporting copy, and validation message.',
    ),
    ClayProp(
      name: 'minLines / maxLines / maxLength',
      type: 'int?',
      description:
          'Configure the visible line range and maximum character count.',
      defaultValue: '3 / 5 / null',
    ),
    ClayProp(
      name: 'keyboardType / textInputAction / textCapitalization',
      type: 'TextInputType? / TextInputAction? / TextCapitalization',
      description:
          'Defaults to multiline, newline, and sentence capitalization.',
    ),
    ClayProp(
      name: 'onChanged / onSubmitted',
      type: 'ValueChanged<String>?',
      description: 'Callbacks for text editing and submission.',
    ),
    ClayProp(
      name: 'enabled / readOnly / clearable',
      type: 'bool',
      description: 'Configure editability and the clear affordance.',
    ),
  ],
);
