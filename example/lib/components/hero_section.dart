import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import './component_preview.dart';

class HeroSection extends StatelessWidget {
  final ClayThemeData theme;

  const HeroSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: .center,
          children: [
             ClayContainer(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedCodesandbox,
                color: theme.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              ClayText.label('CLAYMORPHISM DESIGN SYSTEM'),
            ],
          ),
        ),
          ],
        ),
        const SizedBox(height: 24),
        ClayText.display('Beautiful Components'),
        ClayText.display('with Depth 3D', color: theme.primary),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ClayText.body(
            'A complete collection of Flutter components in a claymorphism style, characterized by an elegant aesthetic and smooth animations.',
            color: theme.onBackground.withValues(alpha: .72),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ClayButton.primary(
              'Read documentation',
              iconRight: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight02,
                color: theme.onPrimary,
              ),
              onPressed: () => Navigator.pushNamed(context, '/getting-started'),
            ),
            ClayButton.base(
              'Explore components',
              onPressed: () => Navigator.pushNamed(context, '/catalog'),
            ),
          ],
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              copy,
              const SizedBox(height: 32),
              ComponentPreview(theme: theme),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: copy),
            const SizedBox(width: 32),
            Expanded(flex: 5, child: ComponentPreview(theme: theme)),
          ],
        );
      },
    );
  }
}
