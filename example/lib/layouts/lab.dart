import 'package:clay_ui_kit/components/props_table/class/props_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class LabLayout extends StatefulWidget {
  const LabLayout({super.key});

  @override
  State<LabLayout> createState() => _LabLayoutState();
}

class _LabLayoutState extends State<LabLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          ClayText.display("Testando"),

          ClayText.title("Testando"),

          ClayText.body("Testando"),

          ClayText.label("Testando"),

          SizedBox(height: 8),

          ClayButton.base('Base', onPressed: () {}, isLoading: false),

          SizedBox(height: 8),

          ClayButton.primary('Primary', onPressed: () {}, isLoading: false),

          SizedBox(height: 8),

          ClayButton.secondary(
            'Secondary',
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.small,
          ),

          SizedBox(height: 8),

          ClayButton.third(
            'Third',
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.large,
          ),

          SizedBox(height: 8),

          ClayButton.success('Success', onPressed: () {}),

          SizedBox(height: 8),

          ClayButton.warning('Warning', onPressed: () {}),

          SizedBox(height: 8),

          ClayButton.error('Error', onPressed: () {}),

          SizedBox(height: 8),

          ClayButton.text(
            'Text',
            onPressed: () {},
            isLoading: false,
            iconLeft: Icon(Icons.abc_sharp),
          ),

          SizedBox(height: 8),

          ClayButton.icon(
            Icon(Icons.abc_sharp),
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.large,
          ),

          SizedBox(height: 8),

          ClayButton.primary('Disabled'),

          SizedBox(height: 8),

          ClayButton.gradient(
            "Testando",
            colors: [
              ClayColors.sky,
              ClayColors.sky.s600,
              ClayColors.sky.s700,
              ClayColors.sky.s900,
            ],
            begin: AlignmentGeometry.bottomCenter,
            end: AlignmentGeometry.center,
            foregroundColor: ClayColors.sky.s50,
            onPressed: () {},
            iconLeft: Icon(Icons.import_contacts),
            iconRight: Icon(Icons.import_contacts),
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Username',
            hintText: 'Enter your username',
            prefixIcon: const Icon(Icons.person_rounded),
            onChanged: (value) {},
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Password',
            hintText: 'Enter your password',
            password: true,
            prefixIcon: const Icon(Icons.lock_rounded),
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Email',
            hintText: 'example@email.com',
            errorText: 'Enter a valid email address.',
            prefixIcon: const Icon(Icons.email_rounded),
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Email',
            errorText: 'Invalid email.',
            errorColor: Colors.orange,
          ),

          SizedBox(height: 8),

          ClayInput.textArea(
            label: 'Description',
            hintText: 'Write something...',
            minLines: 4,
            maxLines: 8,
          ),

          SizedBox(height: 8),

          ClayInput.textArea(
            label: 'Bio',
            hintText: 'Tell us about yourself...',
            maxLength: 500,
            minLines: 5,
            maxLines: 8,
          ),

          SizedBox(height: 8),

          ClayContainer(
            padding: const EdgeInsets.all(20),
            child: Column(children: [Text('Qualquer coisa'), Icon(Icons.star)]),
          ),

          SizedBox(height: 8),

          ClayCard(
            children: [
              ClayCard.header(
                title: 'Fight Metrics',
                subtitle: 'UFC 320',

                action: ClayCard.action(
                  menu: [
                    ClayCard.menu(
                      title: 'Editar',
                      subtitle: 'Alterar informações',
                      icon: const Icon(Icons.edit_rounded),
                      onPressed: () {},
                    ),
                    ClayCard.menu(
                      title: 'Compartilhar',
                      icon: const Icon(Icons.share_rounded),
                      onPressed: () {},
                    ),
                    ClayCard.menu(
                      title: 'Excluir',
                      icon: const Icon(Icons.delete_outline_rounded),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              ClayCard.image(
                image: const NetworkImage('https://picsum.photos/800/400'),
                width: double.infinity,
                height: 220,
                margin: EdgeInsetsGeometry.symmetric(horizontal: 8),
              ),

              ClayCard.body(
                children: [
                  ClayCard.title('Alexander Volkanovski'),
                  ClayCard.subtitle('vs. Ilia Topuria'),
                  ClayCard.label('Main Event'),
                ],
              ),

              ClayCard.footer(
                buttons: [
                  ClayCard.button(label: 'Cancelar', onPressed: () {}),
                  ClayCard.button(
                    label: 'Analisar',
                    primary: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8),

          ClayBadge(label: 'Testando badge', onClose: () {}),

          SizedBox(height: 8),

          ClayBadge.circle(
            backgroundColor: ClayColors.mint,
            position: ClayBadgePosition.bottomRight,
            target: ClayAvatar(
              image: NetworkImage('https://picsum.photos/800/400'),
            ),
          ),

          SizedBox(height: 8),

          ClayBadge.circle(
            label: '99+',
            backgroundColor: ClayColors.ruby,
            position: ClayBadgePosition.topRight,
            target: ClayAvatar(name: "Teste"),
          ),

          SizedBox(height: 8),

          ClayAvatar.group(
            overlap: 24,
            children: [
              ClayAvatar(name: 'Carlos Eduardo', randomColor: true),
              ClayAvatar(name: 'João Silva', randomColor: true),
              ClayAvatar(name: 'Maria Souza', randomColor: true),
            ],
          ),

          SizedBox(height: 8),

          ClayMenu(
            items: [
              ClayMenuItem(
                label: 'Copiar',
                icon: const Icon(Icons.copy_rounded),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyC,
                  control: true,
                ),
                onPressed: () {
                  debugPrint('Copiar');
                },
              ),

              ClayMenuItem(
                label: 'Colar',
                icon: const Icon(Icons.paste_rounded),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyV,
                  control: true,
                ),
                onPressed: () {
                  debugPrint('Colar');
                },
              ),

              const ClayMenuItem.divider(),

              ClayMenuItem(
                label: 'Deletar',
                icon: const Icon(Icons.delete_rounded),
                destructive: true,
                onPressed: () {},
              ),
            ],

            child: ClayButton.primary("Segure", onPressed: () {}),
          ),

          SizedBox(height: 8),

          ClayPropsTable(
            title: 'Properties',
            props: [
              ClayProp(
                name: 'label',
                type: 'String?',
                description: 'Text displayed inside the button.',
              ),

              ClayProp(
                name: 'icon',
                type: 'Widget?',
                description: 'Optional icon displayed alongside the label.',
              ),
            ],
          ),

          SizedBox(height: 8),

          ClayShowcase(
            title: 'ClayButton',
            description: 'A beatiful claymorphic button.',
            preview: ClayButton.primary('Continue', onPressed: () {}),
            code: '''
ClayButton.primary('Continue', onPressed: () {})
''',
          ),

          SizedBox(height: 8),

          ClayButton.primary(
            'Modal',
            onPressed: () async {
              await ClayModal.show<bool>(
                context: context,
                title: 'Excluir item?',
                description: 'Esta ação não pode ser desfeita.',
                child: const Text('Deseja realmente continuar?'),
                leading: const Icon(Icons.warning_amber_rounded),
                actions: [
                  ClayButton.success('Continuar', onPressed: () {}),
                  ClayButton.warning('Atenção', onPressed: () {}),
                  ClayButton.error('Excluir', onPressed: () {}),
                ],
              );
            },
          ),

          SizedBox(height: 8),

          ClayTooltip(
            message: 'Copiar código',
            child: ClayButton.icon(
              const Icon(Icons.copy_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
