import 'package:clay_ui_kit/widgets/fab/types/sizes.dart';
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
      clayThemeData: ClayThemeData(seedColor: ClayColors.sky, isDark: false),
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
      clayAppBar: ClayAppBar(
        title: "Clay UI Kit",
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
        tooltip: 'Adicionar',
        // heroTag: 'add-button',
        // onPressed: () {
        //   Navigator.push(context, route)
        // }
      ),
    );
  }
}
