import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import 'models.dart';

ComponentDoc cardDocumentation = ComponentDoc(
  title: 'Card',
  description: 'Container para informações agrupadas e conteúdo de destaque.',
  legends: [
    DocumentationLegend(label: 'Content', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Action', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Media', color: ClayColors.cobalt.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Content card',
      description: 'Estrutura básica para agrupamento visual de conteúdo.',
      code: '''
ClayCard(
  children: [
    ClayCard.header(title: 'Fight Metrics', subtitle: 'UFC 320'),
    ClayCard.body(
      children: [
        ClayCard.title('Alexander Volkanovski'),
        ClayCard.subtitle('vs. Ilia Topuria'),
      ],
    ),
  ],
)
''',
      preview: SizedBox(
        width: 320,
        child: ClayCard(
          children: [
            ClayCard.header(
              title: 'Fight Metrics',
              subtitle: 'UFC 320',
            ),
            ClayCard.body(
              children: [
                ClayCard.title('Alexander Volkanovski'),
                ClayCard.subtitle('vs. Ilia Topuria'),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'children',
      type: 'List<Widget>',
      description: 'Conteúdo interno do card.',
      required: true,
    ),
    ClayProp(
      name: 'margin',
      type: 'EdgeInsetsGeometry?',
      description: 'Espaçamento externo do card.',
      defaultValue: 'null',
    ),
  ],
);
