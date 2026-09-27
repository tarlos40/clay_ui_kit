import 'package:flutter/material.dart';
import "package:clay_ui_kit/clay_ui_kit.dart";

import 'layouts/home.dart';
import 'layouts/documentation.dart';
import 'layouts/components.dart';
import 'layouts/lab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ClayApp(
      clayThemeData: ClayThemeData(seedColor: ClayColors.cobalt, isDark: false),
      home: const MyHomePage(title: "Clay App"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayScaffold(
      useScrollView: true,

      clayDrawer: ClayDrawer(
        children: [
          ClayDrawer.title(
            'Clay UI Kit',
            leading: const Icon(Icons.widgets_rounded),
          ),

          ClayDrawer.subtitle('Components'),

          ClayDrawer.action(
            icon: const Icon(Icons.home_rounded),
            label: "Overview",
            selected: true,
            onPressed: () {},
          ),

          ClayDrawer.expansion(
            icon: const Icon(Icons.widgets_rounded),
            label: "Components",
            children: [
              ClayDrawer.action(
                icon: const Icon(Icons.smart_button_rounded),
                label: 'Buttons',
                compact: true,
                onPressed: () {},
              ),

              ClayDrawer.action(
                icon: const Icon(Icons.navigation_rounded),
                label: 'Navigation',
                compact: true,
                onPressed: () {},
              ),

              ClayDrawer.action(
                icon: const Icon(Icons.view_sidebar_rounded),
                label: 'Drawer',
                compact: true,
                onPressed: () {},
              ),
            ],
          ),

          ClayDrawer.divider(),

          ClayDrawer.subtitle('Preferences'),

          ClayDrawer.action(
            icon: const Icon(Icons.settings_rounded),
            label: 'Settings',
            onPressed: () {},
          ),
        ],
      ),

      clayAppBar: ClayAppBar(
        title: "Clay UI Kit",
        leading: ClayDrawer.menuButton(context),
        actions: [
          ClayAppBar.action(Icon(Icons.wb_sunny_rounded), onPressed: () {}),
          ClayButton.primary(
            "Start",
            iconRight: Icon(Icons.arrow_forward_rounded),
            onPressed: () {},
          ),
        ],
      ),

      body: IndexedStack(
        index: currentIndex,
        children: [
          ClayBuildNavigator(
            navigatorKey: _navigatorKeys[0],
            child: HomeLayout(),
          ),
          ClayBuildNavigator(
            navigatorKey: _navigatorKeys[1],
            child: DocumentationLayout(),
          ),
          ClayBuildNavigator(
            navigatorKey: _navigatorKeys[2],
            child: ComponentsLayout(),
          ),
          ClayBuildNavigator(
            navigatorKey: _navigatorKeys[3],
            child: LabLayout(),
          ),
        ],
      ),

      clayNavigationBar: ClayNavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          ClayNavigationBar.destination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.import_contacts_rounded),
            label: 'Documentation',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.layers_rounded),
            label: 'Components',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.science_rounded),
            label: 'Lab',
          ),
        ],
      ),

      clayFloatingActionButton: ClayFloatingActionButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
        extend: true,
        label: "Adicionar",
        // heroTag: 'add-button',
        // onPressed: () {
        //   Navigator.push(context, route)
        // }
      ),
    );
  }
}
