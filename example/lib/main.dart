import 'package:flutter/material.dart';
import "package:clay_ui_kit/clay_ui_kit.dart";
import 'package:clay_ui_kit/theme/scripts/shadows.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
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
            child: Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  ClayText.display("Testando"),

                  ClayText.title("Testando"),

                  ClayText.body("Testando"),

                  ClayText.label("Testando"),

                  Text(
                    '$_counter',
                    style: TextStyle(
                      color: theme.onBackgroundVariant,
                      fontSize: 32,
                    ),
                  ),

                  SizedBox(height: 8),

                  ClayButton.base('Base', onPressed: () {}, isLoading: false),

                  SizedBox(height: 8),

                  ClayButton.primary(
                    'Primary',
                    onPressed: () {},
                    isLoading: false,
                  ),

                  SizedBox(height: 8),

                  ClayButton.secondary(
                    'Secondary',
                    onPressed: () {},
                    isLoading: false,
                    size: ClayButtonSizes.small,
                  ),

                  SizedBox(height: 8),

                  ClayButton.third(
                    'Third',
                    onPressed: () {},
                    isLoading: false,
                    size: ClayButtonSizes.large,
                  ),

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
                    size: ClayButtonSizes.large,
                  ),

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

                  CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      borderRadius: 20,
                      shadowSize: 6.0,
                      blurRadius: 12.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.container,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme.border, width: .5),
                      ),
                      child: TextField(
                        style: TextStyle(color: theme.onContainer),
                        decoration: InputDecoration(
                          hintText: "Testando",
                          hintStyle: TextStyle(
                            color: theme.onBackgroundVariant.withAlpha(150),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.container,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: theme.border, width: .5),
                      boxShadow: ClayShadows.external(theme: theme),
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(color: theme.onContainer),
                      child: Text(
                        'testando',
                        style: TextStyle(color: theme.onContainer),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
        ],
      ),
    );

    // return Scaffold(

    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     backgroundColor: theme.primary,
    //     child: Icon(Icons.add, color: theme.onPrimary),
    //   ),
    // );
  }
}
