import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc radioDocumentation = ComponentDoc(
  title: 'Radio',
  subtitle: 'Components',
  description: 'A controlled single-choice option. Keep one selected value in parent state and pass the same groupValue to every radio in the group.',
  legends: [
    DocumentationLegend(label: 'Selected', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Unselected', color: ClayColors.cloud.s500),
    DocumentationLegend(label: 'Disabled', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Create a Radio Group',
      description: 'Each radio shares groupValue and has a distinct value. Update the parent value from onChanged; choosing the selected option reports that same value, so the parent remains the source of truth.',
      code: '''
ClayRadio<String>(
  value: 'monthly',
  groupValue: billingCycle,
  label: 'Monthly billing',
  onChanged: (value) => setState(() => billingCycle = value),
)
''',
      preview: _RadioGroupPreview(),
    ),
    ClayShowcase(
      title: 'Generated Colors and Control States',
      description: 'randomColor generates a palette-based active fill and check color. Provide randomSeed to make the generated colors repeatable for the same theme; explicit activeColor, backgroundColor, and foregroundColor take precedence for their corresponding colors.',
      code: '''
ClayRadio<String>(
  value: 'ocean',
  groupValue: selectedTheme,
  label: 'Ocean',
  description: 'Generated colors use this seed consistently.',
  randomColor: true,
  randomSeed: 42,
  size: 26,
  padding: EdgeInsets.symmetric(vertical: 10),
  onChanged: (value) => setState(() => selectedTheme = value),
)

// enabled: false or onChanged: null prevents selection.
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClayRadio<String>(
            value: 'ocean',
            groupValue: 'ocean',
            label: 'Ocean',
            description: 'Repeatable generated colors',
            randomColor: true,
            randomSeed: 42,
            size: 26,
            onChanged: null,
          ),
          ClayRadio<String>(
            value: 'forest',
            groupValue: 'ocean',
            label: 'Forest',
            activeColor: ClayColors.forest.s600,
            backgroundColor: ClayColors.cloud.s50,
            foregroundColor: Colors.white,
            onChanged: (_) {},
          ),
          const ClayRadio<String>(
            value: 'disabled',
            groupValue: 'ocean',
            label: 'Unavailable option',
            enabled: false,
            onChanged: null,
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'value / groupValue',
      type: 'T / T?',
      description: 'Option value and current selected value. A radio is selected when value == groupValue; each option in a group must use the same T type.',
      required: true,
    ),
    ClayProp(
      name: 'onChanged',
      type: 'ValueChanged<T?>?',
      description: 'Called with this radio’s value when tapped. The parent must store it and rebuild the group to update selection; null disables interaction.',
    ),
    ClayProp(
      name: 'label / description',
      type: 'String?',
      description: 'Optional visible label and supporting text; also exposed through semantic label and hint.',
    ),
    ClayProp(
      name: 'enabled',
      type: 'bool',
      description: 'Whether the control responds to taps.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'activeColor / backgroundColor / foregroundColor',
      type: 'Color?',
      description: 'activeColor sets the selected fill; backgroundColor sets the unselected surface and is the fallback active fill; foregroundColor sets the selected center indicator.',
    ),
    ClayProp(
      name: 'randomColor / randomSeed / size',
      type: 'bool / int? / double',
      description: 'Enable palette-generated active and foreground colors; randomSeed makes the selection repeatable for the current theme. Explicit color props override generated colors.',
      defaultValue: 'false / null / 22',
    ),
    ClayProp(
      name: 'enabled / padding',
      type: 'bool / EdgeInsetsGeometry',
      description: 'enabled false dims the option and disables tapping; padding controls the outer vertical/horizontal inset.',
      defaultValue: 'true / EdgeInsets.symmetric(vertical: 6)',
    ),
  ],
);

class _RadioGroupPreview extends StatefulWidget {
  const _RadioGroupPreview();

  @override
  State<_RadioGroupPreview> createState() => _RadioGroupPreviewState();
}

class _RadioGroupPreviewState extends State<_RadioGroupPreview> {
  String _billingCycle = 'monthly';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClayRadio<String>(
          value: 'monthly',
          groupValue: _billingCycle,
          label: 'Monthly billing',
          onChanged: (value) => setState(() => _billingCycle = value!),
        ),
        ClayRadio<String>(
          value: 'annual',
          groupValue: _billingCycle,
          label: 'Annual billing',
          description: 'Save 15%',
          onChanged: (value) => setState(() => _billingCycle = value!),
        ),
        const ClayRadio<String>(
          value: 'legacy',
          groupValue: 'monthly',
          label: 'Legacy option',
          enabled: false,
          onChanged: null,
        ),
      ],
    );
  }
}
