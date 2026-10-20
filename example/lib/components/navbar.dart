import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../services/hive.dart';
import '../services/theme.dart';

class Navbar extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool? showStartButton, showBackButton, showDrawer;

  const Navbar({
    super.key,
    required this.title,
    this.subtitle,
    this.showStartButton,
    this.showBackButton,
    this.showDrawer,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayAppBar(
      title: widget.title,
      subtitle: widget.subtitle,
      actions: [
        ClayAppBar.action(
          HugeIcon(
            icon: theme.isDark
                ? HugeIcons.strokeRoundedMoon
                : HugeIcons.strokeRoundedSun01,
            color: theme.primary,
          ),
          onPressed: () {
            final newTheme = !isDarkNotifier.value;

            isDarkNotifier.value = newTheme;

            HiveService().put('clay_ui_kit', 'isDark', newTheme);
          },
        ),

        widget.showStartButton == true
            ? ClayButton.primary(
                'Start',
                iconRight: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight02,
                  color: theme.onPrimary,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/getting-started');
                },
              )
            : SizedBox.shrink(),
      ],

      leading: widget.showBackButton == true
          ? ClayAppBar.leading(
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft02,
                color: theme.primary,
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            )
          : widget.showDrawer == true
          ? ClayDrawer.menuButton(
              context,
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedMenu02,
                color: theme.primary,
              ),
            )
          : null,
    );
  }
}
