import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../components/navbar.dart';
import '../components/copyright.dart';
import '../components/card_gradient.dart';

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

      clayAppBar: Navbar(title: 'Clay UI Kit', showStartButton: true),

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
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCodesandbox,
                      color: theme.primary,
                    ),
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
              color: theme.onBackground.withValues(alpha: .7),
            ),

            SizedBox(height: 28),

            ClayButton.primary(
              'Read documentation',
              iconRight: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight02,
                color: theme.onPrimary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/getting-started');
              },
            ),
            SizedBox(height: 8),
            ClayButton.base(
              'View components',
              onPressed: () {
                Navigator.pushNamed(context, '/catalog');
              },
            ),

            SizedBox(height: 56),

            ClayCard(
              children: [
                ClayCard.header(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedPaintBoard,
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
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedCode,
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
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedEnergy,
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
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedMoonEclipse,
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
              color: theme.onBackground.withValues(alpha: .7),
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

            CardGradient(
              title: 'Ready to get started?',
              subtitle: 'Explore our complete documentation and begin building amazing interfaces.',
              label: 'Get Started Now',
              onPressed: () {
                Navigator.pushNamed(context, '/getting-started');
              },
            ),

            Copyright(),
          ],
        ),
      ),
    );
  }
}
