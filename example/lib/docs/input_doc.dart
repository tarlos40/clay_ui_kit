import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import 'models.dart';

ComponentDoc inputDocumentation = ComponentDoc(
  title: 'Input',
  description: 'Campo de entrada para texto, senhas e formulários.',
  legends: [
    DocumentationLegend(label: 'Filled', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Error', color: ClayColors.ruby.s500),
    DocumentationLegend(label: 'Password', color: ClayColors.tangerine.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Email input',
      description: 'Campo de texto com rótulo e ajuda contextual.',
      code: '''
ClayInput(
  label: 'Email',
  hintText: 'example@email.com',
  prefixIcon: const Icon(Icons.email_rounded),
)
''',
      preview: SizedBox(
        width: 280,
        child: ClayInput(
          label: 'Email',
          hintText: 'example@email.com',
          prefixIcon: const Icon(Icons.email_rounded),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Password input',
      description: 'Campo com mascaramento de senha.',
      code: '''
ClayInput(
  label: 'Password',
  hintText: 'Enter your password',
  password: true,
)
''',
      preview: SizedBox(
        width: 280,
        child: ClayInput(
          label: 'Password',
          hintText: 'Enter your password',
          password: true,
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'label',
      type: 'String?',
      description: 'Texto do rótulo do campo.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'hintText',
      type: 'String?',
      description: 'Texto de apoio dentro do campo.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'password',
      type: 'bool',
      description: 'Oculta o valor digitado.',
      defaultValue: 'false',
    ),
  ],
);
