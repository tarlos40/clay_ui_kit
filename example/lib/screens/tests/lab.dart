import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class LabScreen extends StatefulWidget {
  const LabScreen({super.key});

  @override
  State<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> {
  int _currentPage = 1;
  double _volume = 1;
  bool _accepted = false, _notificationsEnabled = false;
  String? _selectedTheme = 'light';
  DateTime? _selectedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ClayToast.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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

          ClayButton.tertiary(
            'Tertiary',
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
            errorColor: ClayColors.peach,
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

          ClayInput.search(
            label: 'Pesquisar lutadores',
            hintText: 'Digite um nome...',
            suggestions: const [
              ClaySearchSuggestion(
                title: 'Alex Pereira',
                subtitle: 'Peso meio-pesado',
                leading: Icon(Icons.sports_mma_rounded),
              ),
              ClaySearchSuggestion(
                title: 'Jon Jones',
                subtitle: 'Peso-pesado',
                leading: Icon(Icons.sports_mma_rounded),
              ),
            ],
            onQueryChanged: (query) {
              // Atualiza os resultados enquanto digita.
            },
            onSuggestionSelected: (suggestion) {
              // Trata a sugestão selecionada.
            },
            onSearch: (query) {
              // Executa a pesquisa.
            },
          ),

          SizedBox(height: 8),

          ClayContainer(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ClayText.body('Qualquer coisa'),
                Icon(Icons.star, color: theme.onContainer),
              ],
            ),
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
                expandable: true,
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

          ClayBadge(label: 'Testando badge', onClose: () {}, onPressed: () {}),

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
            maxVisible: 3,
            children: [
              ClayAvatar(name: 'Carlos Eduardo', randomColor: true),
              ClayAvatar(name: 'João Silva', randomColor: true),
              ClayAvatar(name: 'Maria Socorro', randomColor: true),
              ClayAvatar(name: 'Mario José', randomColor: true),
              ClayAvatar(name: 'João Alecrim', randomColor: true),
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
                child: const ClayText.body('Deseja realmente continuar?'),
                leading: Icon(
                  Icons.warning_amber_rounded,
                  color: theme.onContainer,
                ),
                actions: [
                  ClayButton.success('Continuar', onPressed: () {}),
                  ClayButton.warning('Atenção', onPressed: () {}),
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

          SizedBox(height: 8),

          ClayButton.primary(
            'Abrir sheet',
            onPressed: () {
              ClaySheet.show(
                context,
                initialSnapPoint: 0.5,
                snapPoints: const [0.25, 0.5, 0.9],
                child: const Center(child: ClayText.body('Conteúdo do painel')),
              );
            },
          ),

          SizedBox(height: 8),

          ClayButton.primary(
            'Toast',
            onPressed: () {
              ClayToast.success(
                'Alterações salvas!',
                title: 'Tudo certo',
                showTimer: true,
              );
            },
          ),

          //TOAST PERSISTENTE
          //           final id = ClayToast.base(
          //   'Esta mensagem ficará na tela '
          //   'até o usuário fechá-la.',
          //   duration: null,
          // );

          // // Fechar quando necessário:
          // ClayToast.dismiss(id);
          SizedBox(height: 8),

          ClayProgress.bar(value: 0.68, showPercentage: true),

          SizedBox(height: 8),

          ClayProgress.circle(value: 0.72, showPercentage: true),

          SizedBox(height: 8),

          ClayProgress.wave(value: 0.55),

          SizedBox(height: 8),

          ClayTable<Map<String, dynamic>>(
            columns: [
              ClayTableColumn<Map<String, dynamic>>(
                id: 'name',
                title: 'Nome',
                sortable: true,
                sortValue: (row) => row['name'],
                cellBuilder: (context, row) => ClayText.label(row['name']),
              ),
              ClayTableColumn<Map<String, dynamic>>(
                id: 'old',
                title: 'Idade',
                sortable: true,
                sortValue: (row) => row['old'],
                cellBuilder: (context, row) => ClayText.label(row['old']),
              ),
            ],
            rows: [
              {'name': 'Ana', 'old': '18'},
              {'name': 'Bruno', 'old': '20'},
            ],
          ),

          SizedBox(height: 8),

          ClayPagination(
            currentPage: _currentPage,
            totalPages: 10,
            visiblePages: 5,
            showFirstLast: true,
            showPreviousNext: true,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),

          SizedBox(height: 8),

          ClayBreadcrumbs(
            showHomeIcon: true,
            items: [
              ClayBreadcrumbItem(label: 'Início', onTap: () {}),
              ClayBreadcrumbItem(label: 'Componentes', onTap: () {}),
              ClayBreadcrumbItem(label: 'Navegação', onTap: () {}),
            ],
          ),

          SizedBox(height: 8),

          ClayAccordion(
            allowMultiple: false,
            items: [
              ClayAccordionItem(
                title: 'Configurações',
                subtitle: 'Preferências da conta',
                content: const ClayText.label('Conteúdo da seção.'),
              ),
            ],
          ),

          SizedBox(height: 8),

          const Column(
            children: [
              ClaySkeleton(width: double.infinity, height: 140),
              SizedBox(height: 12),
              ClaySkeletonListTile(),
            ],
          ),

          SizedBox(height: 8),

          ClayLoading(
            label: 'Carregando dados...',
            icon: Icon(Icons.cloud_download_rounded, color: theme.onContainer),
            style: ClayLoadingStyle.orbit,
          ),

          SizedBox(height: 8),

          ClayButton.primary(
            'Loading',
            onPressed: () async {
              ClayLoading.show(
                context,
                label: 'Salvando alterações...',
                style: ClayLoadingStyle.orbit,
                barrierDismissible: true,
              );
            },
          ),

          SizedBox(height: 8),

          ClayCheckbox(
            value: _accepted,
            onChanged: (value) => setState(() => _accepted = value),
            label: 'Aceito os termos',
            description: 'Li e concordo com as condições.',
          ),

          SizedBox(height: 8),

          ClayRadio<String>(
            value: 'light',
            groupValue: _selectedTheme,
            onChanged: (value) {
              setState(() => _selectedTheme = value);
            },
            label: 'Claro',
          ),

          ClayRadio<String>(
            value: 'dark',
            groupValue: _selectedTheme,
            onChanged: (value) {
              setState(() => _selectedTheme = value);
            },
            label: 'Escuro',
          ),

          SizedBox(height: 8),

          ClaySlider(
            value: _volume,
            onChanged: (value) => setState(() => _volume = value),
            min: 0,
            max: 100,
            divisions: 20,
            label: 'Volume',
            showValue: true,
            showMinMax: true,
          ),

          SizedBox(height: 8),

          ClaySwitch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
            label: 'Notificações',
            description: 'Receba alertas de atualizações.',
          ),

          SizedBox(height: 8),

          ClayFeedback(
            status: ClayFeedbackStatus.info,
            title: 'Nova atualização',
            message: 'Uma nova versão está disponível.',
            compact: true,
          ),

          SizedBox(height: 8),

          ClayUpload(
            multiple: true,
            maxFiles: 10,
            maxFileSize: 10 * 1024 * 1024,
            allowedExtensions: const ['png', 'jpg', 'pdf'],
            reorderable: true,

            onFilesChanged: (files) {
              debugPrint('${files.length} arquivos selecionados');
            },
            onUpload: (file, onProgress) async {
              // Envie o arquivo para sua API.
              onProgress(0.5);

              // Atualize para 1.0 quando o envio terminar.
              onProgress(1.0);
            },
          ),

          SizedBox(height: 8),

          ClayCarousel(
            height: 340,
            borderRadius: 24,
            showArrows: true,
            showDots: true,
            infinite: true,
            autoplay: false,
            autoplayInterval: const Duration(seconds: 5),
            items: [
              ClayCarouselItem(
                image: const NetworkImage(
                  'https://picsum.photos/id/1018/1200/800',
                ),
                tag: 'DESTINO EM DESTAQUE',
                subtitle: 'Descubra novos horizontes',
                title: 'Explore o desconhecido',
                description: 'Lugares extraordinários esperam por você.',
                buttons: [
                  ClayCarouselButton(
                    label: 'Explorar',
                    icon: const Icon(Icons.arrow_forward_rounded),
                    primary: true,
                    onPressed: () {
                      debugPrint('Explorar');
                    },
                  ),
                  ClayCarouselButton(
                    label: 'Saiba mais',
                    onPressed: () {
                      debugPrint('Saiba mais');
                    },
                  ),
                ],
              ),

              ClayCarouselItem(
                image: const NetworkImage(
                  'https://picsum.photos/id/1015/1200/800',
                ),
                tag: 'AVENTURA',
                subtitle: 'Desconecte-se da rotina',
                title: 'Encontre seu próximo destino',
                description: 'Uma nova experiência começa com uma escolha.',
                buttons: [
                  ClayCarouselButton(
                    label: 'Ver destinos',
                    icon: const Icon(Icons.explore_rounded),
                    primary: true,
                    onPressed: () {},
                  ),
                ],
              ),

              ClayCarouselItem(
                image: const NetworkImage(
                  'https://picsum.photos/id/1016/1200/800',
                ),
                title: 'Momentos inesquecíveis',
                description: 'Transforme suas viagens em histórias.',
                gradient: true,
                buttons: [
                  ClayCarouselButton(
                    label: 'Começar',
                    primary: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
            onPageChanged: (index) {
              debugPrint('Slide atual: $index');
            },
          ),

          SizedBox(height: 8),

          ClayDatePick(
            mode: ClayDatePickMode.dateTime,
            initialDate: DateTime.now(),
            use24HourFormat: true,
            firstDate: DateTime(2020),
            lastDate: DateTime(2035),
            dateFormat: 'dd/MM/yyyy',
            onChanged: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          ClayText.body('Data: $_selectedDate'),

          SizedBox(height: 8),
        ],
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   int currentIndex = 0;

//   final List<GlobalKey<NavigatorState>> _navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ClayScaffold(
//       useScrollView: true,
//       useRefreshIndicator: true,
//       hideNavigationBarOnScroll: true,
//       hideAppBarOnScroll: true,
//       hideTabsOnScroll: true,
//       onRefresh: () async {
//         debugPrint("Recarregado");
//       },

//       clayDrawer: ClayDrawer(
//         children: [
//           ClayDrawer.title(
//             'Clay UI Kit',
//             leading: const Icon(Icons.widgets_rounded),
//           ),

//           ClayDrawer.subtitle('Components'),

//           ClayDrawer.action(
//             icon: const Icon(Icons.home_rounded),
//             label: "Overview",
//             selected: true,
//             onPressed: () {},
//           ),

//           ClayDrawer.expansion(
//             icon: const Icon(Icons.widgets_rounded),
//             label: "Components",
//             children: [
//               ClayDrawer.action(
//                 icon: const Icon(Icons.smart_button_rounded),
//                 label: 'Buttons',
//                 compact: true,
//                 onPressed: () {},
//               ),

//               ClayDrawer.action(
//                 icon: const Icon(Icons.navigation_rounded),
//                 label: 'Navigation',
//                 compact: true,
//                 onPressed: () {},
//               ),

//               ClayDrawer.action(
//                 icon: const Icon(Icons.view_sidebar_rounded),
//                 label: 'Drawer',
//                 compact: true,
//                 onPressed: () {},
//               ),
//             ],
//           ),

//           ClayDrawer.divider(),

//           ClayDrawer.subtitle('Preferences'),

//           ClayDrawer.action(
//             icon: const Icon(Icons.settings_rounded),
//             label: 'Settings',
//             onPressed: () {},
//           ),
//         ],
//       ),

//       clayAppBar: ClayAppBar(
//         title: "Clay UI Kit",
//         leading: ClayDrawer.menuButton(context),
//         actions: [
//           ClayAppBar.action(Icon(Icons.wb_sunny_rounded), onPressed: () {}),
//           ClayButton.primary(
//             "Start",
//             iconRight: Icon(Icons.arrow_forward_rounded),
//             onPressed: () {},
//           ),
//         ],
//       ),

//       clayTabs: ClayTabs(
//         index: currentIndex,
//         showContent: false,
//         swipeable: true,
//         style: ClayTabsStyle.pills,
//         tabs: [
//           ClayTabItem(
//             label: 'Home',
//             icon: const Icon(Icons.home_rounded),
//             child: HomeLayout(),
//           ),
//           ClayTabItem(
//             label: 'Documentation',
//             icon: const Icon(Icons.import_contacts_rounded),
//             child: DocumentationLayout(),
//           ),
//           ClayTabItem(
//             label: 'Components',
//             icon: const Icon(Icons.layers_rounded),
//             child: ComponentsLayout(),
//           ),
//           ClayTabItem(
//             label: 'Lab',
//             icon: const Icon(Icons.science_rounded),
//             child: LabLayout(),
//           ),
//         ],
//         onChanged: (index) {
//           setState(() => currentIndex = index);
//         },
//       ),

//       body: IndexedStack(
//         index: currentIndex,
//         children: [
//           ClayBuildNavigator(
//             navigatorKey: _navigatorKeys[0],
//             child: HomeLayout(),
//           ),
//           ClayBuildNavigator(
//             navigatorKey: _navigatorKeys[1],
//             child: DocumentationLayout(),
//           ),
//           ClayBuildNavigator(
//             navigatorKey: _navigatorKeys[2],
//             child: ComponentsLayout(),
//           ),
//           ClayBuildNavigator(
//             navigatorKey: _navigatorKeys[3],
//             child: LabLayout(),
//           ),
//         ],
//       ),

//       clayNavigationBar: ClayNavigationBar(
//         swipeable: true,
//         selectedIndex: currentIndex,
//         onDestinationSelected: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         destinations: const [
//           ClayNavigationBar.destination(
//             icon: Icon(Icons.home_rounded),
//             label: 'Home',
//           ),
//           ClayNavigationBar.destination(
//             icon: Icon(Icons.import_contacts_rounded),
//             label: 'Documentation',
//           ),
//           ClayNavigationBar.destination(
//             icon: Icon(Icons.layers_rounded),
//             label: 'Components',
//           ),
//           ClayNavigationBar.destination(
//             icon: Icon(Icons.science_rounded),
//             label: 'Lab',
//           ),
//         ],
//       ),

//       clayFloatingActionButton: ClayFloatingActionButton(
//         onPressed: () {},
//         icon: const Icon(Icons.add),
//         extend: true,
//         label: "Adicionar",
//         // heroTag: 'add-button',
//         // onPressed: () {
//         //   Navigator.push(context, route)
//         // }
//       ),
//     );
//   }
// }
