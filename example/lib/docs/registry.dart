import 'package:clay_ui_kit/clay_ui_kit.dart';

import 'button_doc.dart';
import 'card_doc.dart';
import 'input_doc.dart';
import 'models.dart';
import 'props_table_doc.dart';

class ComponentDocRegistry {
  static final Map<String, ComponentDoc> docs = {
    'button': buttonDocumentation,
    'input': inputDocumentation,
    'card': cardDocumentation,
    'props-table': propsTableDocumentation,
  };

  static ComponentDoc resolve(String slug) {
    final normalized = slug
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9-]+'), '-');

    return docs[normalized] ?? ComponentDoc(
      title: _humanize(normalized),
      description: 'Esta documentação ainda não foi adicionada, mas a estrutura genérica já está pronta para receber o próximo componente.',
      legends: [
        DocumentationLegend(label: 'Padrão', color: ClayColors.sky.s500),
        DocumentationLegend(label: 'Status', color: ClayColors.forest.s500),
      ],
      showcases: const [],
      props: const [
        ClayProp(
          name: 'TODO',
          type: 'dynamic',
          description: 'Preencha as propriedades do componente aqui.',
          defaultValue: 'null',
        ),
      ],
    );
  }

  static String _humanize(String value) {
    if (value.isEmpty) return 'Component';

    final words = value
        .split('-')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .toList();

    if (words.isEmpty) return 'Component';
    return words.join(' ');
  }
}
