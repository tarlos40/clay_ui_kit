import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../components/navbar.dart';
import '../components/drawer.dart';
import '../components/search.dart';
import '../components/show_case.dart';
import '../components/copyright.dart';
import '../components/card_gradient.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: true,

      clayDrawer: DrawerNavbar(selected: 'getting-started'),

      clayAppBar: Navbar(
        title: 'Getting Started',
        subtitle: 'Documentation',
        showDrawer: true,
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            SizedBox(height: 20),
            Search(),

            SizedBox(height: 20),

            ClayText.display('Getting Started'),
            ClayText.display(
              'Start using the Clay UI Kit in your Flutter projects',
              color: theme.onBackground.withValues(alpha: .7),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 28),

            ShowCase(
              title: '1. Installation',
              description:
                  'Install the necessary dependencies in your Flutter project',
              icon: HugeIcons.strokeRoundedBlockchain01,
              showOnlyCode: true,
              code: '''
flutter pub add clay_ui_kit
''',
            ),

            SizedBox(height: 20),

            ShowCase(
              title: '2. Configure application',
              description: 'Copy the ClayApp file to your proect to start using the Clay UI Kit',
              icon: HugeIcons.strokeRoundedCode,
              showOnlyCode: true,
              code: '''
import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return ClayApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: const MyScreen();
    );
  }
}
''',
            ),

            SizedBox(height: 20),

            ShowCase(
              title: '3. Configure style',
              description:
                  'Define the color used in your application and the theme',
              icon: HugeIcons.strokeRoundedPaintBoard,
              showOnlyCode: true,
              code: '''
import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return ClayApp(
      title: 'My App',
      clayThemeData: ClayThemeData(
        seedColor: ClayColors.cobalt,
        isDark: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyScreen();
    );
  }
}
''',
            ),

            SizedBox(height: 20),

            ShowCase(
              title: '4. Obtaining style',
              description: 'Retrieve `clayTheme` and `clayPalette`from the context to access the theme and color palette, respectively',
              icon: HugeIcons.strokeRoundedDrawingMode,
              showOnlyCode: true,
              code: '''
import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final palette = context.clayPalette;

    return ClayScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClayButton.base(
              'Theme',
              onPressed: () {},
              backgroundColor: theme.primary,
              foregroundColor: theme.onPrimary,
            ),
            ClayText.body('Palette', color: palette.s500),
          ],
        ),
      ),
    );
  }
}
''',
            ),

            SizedBox(height: 20),

            ClayCard(
              children: [
                ClayCard.header(title: 'Design Principles'),
                ClayCard.body(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedDrawingMode,
                              color: theme.primary,
                            ),
                            SizedBox(width: 8),
                            ClayCard.title('Claymorphism'),
                          ],
                        ),
                        ClayCard.label(
                          'A soft 3D effect using multiple shadows (inset + outset) to create depth',
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    Column(
                      children: [
                        Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedPaintBoard,
                              color: theme.primary,
                            ),
                            SizedBox(width: 8),
                            ClayCard.title('Pastel Colors'),
                          ],
                        ),
                        ClayCard.label(
                          'A palette based on pastel tones, with variations for differents states',
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    Column(
                      children: [
                        Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedTextFont,
                              color: theme.primary,
                            ),
                            SizedBox(width: 8),
                            ClayCard.title('Typography'),
                          ],
                        ),
                        ClayCard.label(
                          'Serif (Crimson Text) for titles and headings, Sans Serif (inter) for body text and UI elements',
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    Column(
                      children: [
                        Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedMoonEclipse,
                              color: theme.primary,
                            ),
                            SizedBox(width: 8),
                            ClayCard.title('Dark Mode'),
                          ],
                        ),
                        ClayCard.label(
                          'Full support for a dark theme, with optimized colors',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            CardGradient(
              title: 'Next Steps',
              subtitle: 'Explore all avaliable components and their variations',
              label: 'Explore Components',
              onPressed: () {
                Navigator.pushNamed(context, '/catalog');
              },
            ),

            Copyright(),
          ],
        ),
      ),
    );
  }
}
