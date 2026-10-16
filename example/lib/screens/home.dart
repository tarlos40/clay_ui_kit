import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../services/hive.dart';
import '../services/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: true,
      clayAppBar: ClayAppBar(
        title: 'Clay UI Kit',
        actions: [
          ClayAppBar.action(
            Icon(
              theme.isDark ? Icons.dark_mode_rounded : Icons.wb_sunny_rounded,
            ),
            onPressed: () {
              final newTheme = !isDarkNotifier.value;

              isDarkNotifier.value = newTheme;

              HiveService().put('clay_ui_kit', 'isDark', newTheme);
            },
          ),
          ClayButton.primary(
            'Start',
            iconRight: Icon(Icons.arrow_forward_rounded),
            onPressed: () {},
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),

            SizedBox(
              width: 292,
              child: ClayContainer(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.token, color: theme.primary, size: 28),
                    SizedBox(width: 8),
                    ClayText.body('Claymorphism Design System'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            ClayText.display('Beautiful Components'),
            ClayText.display('with Depth 3D', color: theme.primary),

            SizedBox(height: 28),

            ClayText.body(
              'A complete collection of Flutter components in a claymorphism style, characterized by an elegant aesthetic and smooth animations.',
              textAlign: TextAlign.center,
              color: theme.onBackground.withValues(alpha: .80),
            ),

            SizedBox(height: 28),

            ClayButton.primary(
              'Read documentation',
              iconRight: Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
            SizedBox(height: 8),
            ClayButton.base('View components', onPressed: () {}),

            SizedBox(height: 56),

            ClayCard(
              children: [
                ClayCard.header(
                  leading: Icon(
                    Icons.palette_rounded,
                    color: theme.primary,
                    size: 32,
                  ),
                ),

                ClayCard.body(
                  padding: EdgeInsetsGeometry.only(
                    bottom: 20,
                    top: 12,
                    left: 20,
                    right: 20,
                  ),
                  children: [
                    ClayCard.title('Claymorphism Design'),
                    ClayCard.subtitle(
                      'Beautiful 3D-like components with soft shadows and depth effects',
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            ClayCard(
              children: [
                ClayCard.header(
                  leading: Icon(
                    Icons.code_rounded,
                    color: theme.primary,
                    size: 32,
                  ),
                ),

                ClayCard.body(
                  padding: EdgeInsetsGeometry.only(
                    bottom: 20,
                    top: 12,
                    left: 20,
                    right: 20,
                  ),
                  children: [
                    ClayCard.title('Copy-Paste Ready'),
                    ClayCard.subtitle(
                      'Clean, well-documented code snippets you can use immediately',
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            ClayCard(
              children: [
                ClayCard.header(
                  leading: Icon(
                    Icons.bolt_rounded,
                    color: theme.primary,
                    size: 32,
                  ),
                ),

                ClayCard.body(
                  padding: EdgeInsetsGeometry.only(
                    bottom: 20,
                    top: 12,
                    left: 20,
                    right: 20,
                  ),
                  children: [
                    ClayCard.title('Fully Interactive'),
                    ClayCard.subtitle(
                      'Live playground to test and customize each component',
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            ClayCard(
              children: [
                ClayCard.header(
                  leading: Icon(
                    Icons.brightness_6_rounded,
                    color: theme.primary,
                    size: 32,
                  ),
                ),

                ClayCard.body(
                  padding: EdgeInsetsGeometry.only(
                    bottom: 20,
                    top: 12,
                    left: 20,
                    right: 20,
                  ),
                  children: [
                    ClayCard.title('Dark Mode Support'),
                    ClayCard.subtitle(
                      'Seamless theme switching with optimized colors for both modes',
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 56),

            ClayText.display('Available Components'),
            ClayText.body(
              'Buttons, inputs, cards, modals, and much more...',
              textAlign: TextAlign.center,
              color: theme.onBackground.withValues(alpha: .80),
            ),

            SizedBox(height: 28),

            ClayCard(
              children: [
                ClayCard.body(
                  children: [
                    ClayButton.base('Base Button', onPressed: () {}),
                    SizedBox(height: 8),
                    ClayButton.primary('Primary Button', onPressed: () {}),
                    SizedBox(height: 8),
                    ClayButton.secondary('Secondary Button', onPressed: () {}),
                    SizedBox(height: 8),
                    ClayButton.tertiary('Tertiary Button', onPressed: () {}),
                  ],
                ),
              ],
            ),

            SizedBox(height: 56),

            ClayCard(
              backgroundGradient: LinearGradient(
                colors: [theme.primary, theme.secondary, theme.tertiary],
                begin: AlignmentGeometry.topStart,
                end: AlignmentGeometry.bottomEnd,
              ),
              children: [
                ClayCard.header(
                  child: ClayText.display('Ready to get started?'),
                ),
                ClayCard.body(
                  children: [
                    ClayCard.subtitle(
                      'Explore our complete documentation and begin building amazing interfaces.',
                    ),
                  ],
                ),
                ClayCard.footer(
                  child: ClayButton.base(
                    'Get Started Now',
                    onPressed: () {},
                    iconRight: Icon(Icons.arrow_forward_rounded),
                  ),
                ),
              ],
            ),

            SizedBox(height: 56),

            ClayText.label(
              'Clay UI Kit © 2026 - Built with Claymorphism and Flutter',
            ),

            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
