import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc sliderDocumentation = ComponentDoc(
  title: 'Slider',
  subtitle: 'Components',
  description: 'A continuous or stepped value selector with optional range labels, value display, and interaction callbacks.',
  legends: [
    DocumentationLegend(label: 'Continuous', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Discrete Steps', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Disabled', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Configure a Value Range',
      description: 'value must stay within min and max. Set divisions for discrete steps and onChanged to make the slider interactive.',
      code: '''
ClaySlider(
  value: volume,
  min: 0,
  max: 100,
  divisions: 10,
  label: 'Volume',
  showValue: true,
  showMinMax: true,
  onChanged: (value) => setState(() => volume = value),
)
''',
      preview: ClaySlider(
        value: 64,
        min: 0,
        max: 100,
        divisions: 10,
        label: 'Volume',
        description: 'Adjust playback level',
        showValue: true,
        showMinMax: true,
        onChanged: (_) {},
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'value / onChanged',
      type: 'double / ValueChanged<double>?',
      description: 'Current value and required change callback.',
      required: true,
    ),
    ClayProp(
      name: 'min / max / divisions',
      type: 'double / double / int?',
      description: 'Value range and optional number of discrete intervals.',
      defaultValue: '0 / 100 / null',
    ),
    ClayProp(
      name: 'label / description',
      type: 'String?',
      description: 'Optional title and supporting text.',
    ),
    ClayProp(
      name: 'showValue / showMinMax / enabled',
      type: 'bool',
      description: 'Toggle current value, range endpoints, and interaction.',
      defaultValue: 'false / false / true',
    ),
    ClayProp(
      name: 'onChangeStart / onChangeEnd',
      type: 'ValueChanged<double>?',
      description: 'Callbacks when a drag begins and ends.',
    ),
    ClayProp(
      name: 'activeColor / thumbColor / foregroundColor',
      type: 'Color?',
      description: 'Customize track, thumb, and thumb detail colors.',
    ),
  ],
);
