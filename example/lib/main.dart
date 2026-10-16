import 'package:flutter/material.dart';
import "package:clay_ui_kit/clay_ui_kit.dart";

import './routes.dart';

import './services/hive.dart';
import './services/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  await HiveService.init();

  runApp(const ClayUiKit());
}

class ClayUiKit extends StatefulWidget {
  const ClayUiKit({super.key});

  @override
  State<ClayUiKit> createState() => _ClayUiKitState();
}

class _ClayUiKitState extends State<ClayUiKit> {
  late bool isDark;

  @override
  void initState() {
    super.initState();

    isDarkNotifier.value = HiveService().get('clay_ui_kit', 'isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkNotifier,
      builder: (context, isDark, _) {
        return ClayApp(
          title: 'Clay UI Kit',
          clayThemeData: ClayThemeData(
            seedColor: ClayColors.cobalt,
            isDark: isDark,
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: Routes.home,
          onGenerateRoute: Routes.generateRoute,
        );
      },
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
