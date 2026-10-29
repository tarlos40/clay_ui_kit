import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import 'models.dart';

ComponentDoc propsTableDocumentation = ComponentDoc(
  title: 'Props table',
  description: 'Tabela de referência para propriedades de API e documentação.',
  legends: [
    DocumentationLegend(label: 'Required', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Optional', color: ClayColors.sky.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Props table preview',
      description: 'Estrutura de tabela de propriedades para documentação.',
      code: '''
ClayPropsTable(
  title: 'Props',
  props: [
    ClayProp(
      name: 'label',
      type: 'String',
      description: 'Texto principal',
      required: true,
    ),
  ],
)
''',
      preview: SizedBox(
        width: 640,
        child: ClayPropsTable(
          title: 'Props',
          props: const [
            ClayProp(
              name: 'label',
              type: 'String',
              description: 'Texto principal da propriedade.',
              required: true,
            ),
            ClayProp(
              name: 'onPressed',
              type: 'VoidCallback?',
              description: 'Callback ao interagir com o componente.',
              defaultValue: 'null',
            ),
          ],
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'props',
      type: 'List<ClayProp>',
      description: 'Lista de propriedades a serem exibidas na tabela.',
      required: true,
    ),
    ClayProp(
      name: 'title',
      type: 'String?',
      description: 'Título opcional exibido acima da tabela.',
      defaultValue: 'null',
    ),
  ],
);
