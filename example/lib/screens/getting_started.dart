import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../components/navbar.dart';
import '../components/drawer.dart';
import '../components/search.dart';
import '../components/show_case.dart';
import '../components/copyright.dart';
import '../components/card_gradient.dart';
import '../components/guide_step.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: true,

      clayDrawer: DrawerNavbar(selected: '/getting-started'),

      clayAppBar: Navbar(
        title: 'Getting Started',
        subtitle: 'Documentation',
        showDrawer: true,
      ),

      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final gap = 12.0;
            final columns = constraints.maxWidth >= 760
                ? 4
                : constraints.maxWidth >= 500
                ? 2
                : 1;
            final itemWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;

            return Column(
              children: [
                const SizedBox(height: 16),

                Search(),

                const SizedBox(height: 20),

                Align(
                  alignment: .centerStart,
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      ClayBreadcrumbs(
                        items: [
                          ClayBreadcrumbItem(
                            label: 'Home',
                            onTap: () => Navigator.pushNamed(context, '/'),
                          ),
                          ClayBreadcrumbItem(
                            label: 'Getting Started',
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/getting-started',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      ClayText.display('Start building with Clay'),

                      const SizedBox(height: 8),

                      ClayText.body(
                        'Add the package, configure your theme, and use your first components in a few clear steps.',
                        color: theme.onBackground.withValues(alpha: .72),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    SizedBox(
                      width: itemWidth,
                      child: GuideStep(
                        number: '01',
                        title: 'Install',
                        icon: HugeIcons.strokeRoundedBlockchain01,
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: GuideStep(
                        number: '02',
                        title: 'Configure',
                        icon: HugeIcons.strokeRoundedCode,
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: GuideStep(
                        number: '03',
                        title: 'Choose a theme',
                        icon: HugeIcons.strokeRoundedPaintBoard,
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: GuideStep(
                        number: '04',
                        title: 'Build a screen',
                        icon: HugeIcons.strokeRoundedTouchpad04,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                ClayCard(
                  children: [
                    ClayCard.header(
                      leading: HugeIcon(
                        icon: HugeIcons.strokeRoundedInformationCircle,
                        color: theme.primary,
                      ),
                      child: ClayText.title('Before you begin'),
                    ),
                    ClayCard.body(
                      children: [
                        ClayText.body(
                          'You will need a Flutter project. Run the install command from its root folder, then restart the app after adding the dependency.',
                          color: theme.onContainer.withValues(alpha: .76),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                ShowCase(
                  title: '1. Installation',
                  description: 'Install the necessary dependencies in your Flutter project',
                  icon: HugeIcons.strokeRoundedBlockchain01,
                  showOnlyCode: true,
                  code: '''
flutter pub add clay_ui_kit
''',
                ),

                const SizedBox(height: 16),

                ShowCase(
                  title: '2. Configure your app',
                  description: 'Wrap your app in ClayApp and provide a theme configuration.',
                  icon: HugeIcons.strokeRoundedCode,
                  showOnlyCode: true,
                  code: '''
import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClayApp(
      title: 'My App',
      clayThemeData: ClayThemeData(seedColor: ClayColors.cobalt),
      debugShowCheckedModeBanner: false,
      home: const MyScreen(),
    );
  }
}
''',
                ),

                const SizedBox(height: 16),

                ShowCase(
                  title: '3. Choose your theme',
                  description: 'Pick a seed palette and choose whether the app starts in light or dark mode.',
                  icon: HugeIcons.strokeRoundedPaintBoard,
                  showOnlyCode: true,
                  code: '''
import 'package:clay_ui_kit/clay_ui_kit.dart';

ClayThemeData(
  seedColor: ClayColors.cobalt,
  isDark: false,
)
''',
                ),

                const SizedBox(height: 16),

                ShowCase(
                  title: '4. Use theme values in a screen',
                  description: 'Read the active theme and palette from BuildContext to keep components consistent.',
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
            ClayButton.primary(
              'Primary action',
              onPressed: () {},
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

                const SizedBox(height: 24),

                ClayCard(
                  children: [
                    ClayCard.header(title: 'Design Principles'),
                    ClayCard.body(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Layered light and shadow create soft surfaces with a clear sense of depth.',
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Semantic colors help distinguish primary actions, supporting content, and status.',
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Display, title, and body styles establish hierarchy across the interface.',
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Theme tokens adapt surfaces and text for both light and dark modes.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                CardGradient(
                  title: 'Your next step',
                  subtitle: 'Browse the catalog to find a component and see its examples in context.',
                  label: 'Explore components',
                  onPressed: () {
                    Navigator.pushNamed(context, '/catalog');
                  },
                ),

                const Copyright(),
              ],
            );
          },
        ),
      ),
    );
  }
}
