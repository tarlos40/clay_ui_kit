import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../components/navbar.dart';
import '../components/copyright.dart';
import '../components/card_gradient.dart';
import '../components/feature_card.dart';
import '../components/hero_section.dart';
import '../components/metric.dart';
import '../components/destination_card.dart';

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
        child: LayoutBuilder(
          builder: ((context, constraints) {
            final columns = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 580
                ? 2
                : 1;
            const gap = 16.0;
            final tileWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;

            return Column(
              children: [
                HeroSection(theme: theme),

                const SizedBox(height: 36),

                Align(
                  alignment: .centerStart,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      Metric(value: '40+', label: 'components'),
                      Metric(value: '2', label: 'theme modes'),
                      Metric(value: '100%', label: 'Flutter'),
                    ],
                  ),
                ),

                const SizedBox(height: 56),

                ClayText.display('Find your starting point'),

                const SizedBox(height: 8),

                ClayText.body(
                  'Go straight to the part of the kit you need.',
                  color: theme.onBackground.withValues(alpha: .72),
                ),

                const SizedBox(height: 20),

                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    SizedBox(
                      width: tileWidth,
                      child: DestinationCard(
                        icon: HugeIcons.strokeRoundedBookOpen02,
                        title: 'Get started',
                        description:
                            'Set up the package and build your first screen.',
                        action: 'Read the guide',
                        onPressed: () =>
                            Navigator.pushNamed(context, '/getting-started'),
                      ),
                    ),
                    SizedBox(
                      width: tileWidth,
                      child: DestinationCard(
                        icon: HugeIcons.strokeRoundedCatalogue,
                        title: 'Browse components',
                        description:
                            'Explore examples, states, and component APIs.',
                        action: 'Open catalog',
                        onPressed: () =>
                            Navigator.pushNamed(context, '/catalog'),
                      ),
                    ),
                    SizedBox(
                      width: tileWidth,
                      child: DestinationCard(
                        icon: HugeIcons.strokeRoundedPaintBoard,
                        title: 'Explore foundations',
                        description:
                            'See the palette, typography, and depth system.',
                        action: 'View palette',
                        onPressed: () =>
                            Navigator.pushNamed(context, '/foundation/palette'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 56),

                ClayText.display('Small details, considered'),

                const SizedBox(height: 20),

                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    SizedBox(
                      width: tileWidth,
                      child: FeatureCard(
                        icon: HugeIcons.strokeRoundedLayers01,
                        title: 'A tactile visual language',
                        description: 'Soft surfaces and layered shadows give familiar controls a distinct feel.',
                      ),
                    ),
                    SizedBox(
                      width: tileWidth,
                      child: FeatureCard(
                        icon: HugeIcons.strokeRoundedCode,
                        title: 'Made to fit your product',
                        description: 'Composable APIs make it simple to adapt each piece to your interface.',
                      ),
                    ),
                    SizedBox(
                      width: tileWidth,
                      child: FeatureCard(
                        icon: HugeIcons.strokeRoundedMoonEclipse,
                        title: 'Comfortable in both modes',
                        description: 'Switch between light and dark themes while keeping clear visual hierarchy.',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 56),

                ClayText.display('Button styles'),

                const SizedBox(height: 8),

                ClayText.body(
                  'One action, four ways to express it.',
                  color: theme.onBackground.withValues(alpha: .72),
                ),

                const SizedBox(height: 18),

                ClayCard(
                  children: [
                    ClayCard.body(
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ClayButton.base('Base', onPressed: () {}),
                            ClayButton.primary('Primary', onPressed: () {}),
                            ClayButton.secondary('Secondary', onPressed: () {}),
                            ClayButton.tertiary('Tertiary', onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 52),

                CardGradient(
                  title: 'Ready to make something?',
                  subtitle: 'Start with the guide, then bring your own ideas to the component catalog.',
                  label: 'Get started',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/getting-started'),
                ),

                const Copyright(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
