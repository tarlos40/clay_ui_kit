import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc buttonDocumentation = ComponentDoc(
  title: 'Button',
  subtitle: 'Components',
  description:
      'Botão principal para ações primárias, secundárias e estados auxiliares.',
  legends: [
    DocumentationLegend(label: 'Default', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Primary', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Disabled', color: ClayColors.peach.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Primary button',
      description: 'Ação principal em destaque para o usuário.',
      code: '''
ClayButton.primary(
  'Primary',
  onPressed: () {},
)
''',
      preview: ClayButton.primary('Primary', onPressed: () {}),
    ),
    ClayShowcase(
      title: 'Secondary button',
      description: 'Botão complementar para ações menos prioritárias.',
      code: '''
ClayButton.secondary(
  'Secondary',
  onPressed: () {},
)
''',
      preview: ClayButton.secondary('Secondary', onPressed: () {}),
    ),
  ],
  props: const [
    ClayProp(
      name: 'label',
      type: 'String',
      description: 'Texto exibido dentro do botão.',
      required: true,
    ),
    ClayProp(
      name: 'onPressed',
      type: 'VoidCallback?',
      description: 'Callback executado ao pressionar o botão.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'isLoading',
      type: 'bool',
      description: 'Exibe estado de carregamento.',
      defaultValue: 'false',
    ),
  ],
);
