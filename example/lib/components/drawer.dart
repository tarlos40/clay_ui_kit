import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class DrawerNavbar extends StatefulWidget {
  final String? selected;

  const DrawerNavbar({super.key, this.selected});

  @override
  State<DrawerNavbar> createState() => _DrawerNavbarState();
}

class _DrawerNavbarState extends State<DrawerNavbar> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayDrawer(
      children: [
        ClayDrawer.title(
          'Clay UI Kit',
          leading: HugeIcon(
            icon: HugeIcons.strokeRoundedDashboardSquare02,
            color: theme.onBackground,
          ),
        ),

        ClayDrawer.subtitle('Documentation'),

        ClayDrawer.action(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedHome03,
            color: widget.selected == 'home'
                ? theme.onPrimary
                : theme.onBackground,
          ),
          label: "Home",
          selected: widget.selected == 'home' ? true : false,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),

        ClayDrawer.action(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedBookOpen02,
            color: widget.selected == 'getting-started'
                ? theme.onPrimary
                : theme.onBackground,
          ),
          label: "Getting Started",
          selected: widget.selected == 'getting-started' ? true : false,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/getting-started');
          },
        ),

        ClayDrawer.action(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedCatalogue,
            color: widget.selected == 'catalog'
                ? theme.onPrimary
                : theme.onBackground,
          ),
          label: "Catalog",
          selected: widget.selected == 'catalog' ? true : false,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/catalog');
          },
        ),

        ClayDrawer.subtitle('Foundations'),

        ClayDrawer.expansion(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedPuzzle,
            color: theme.onBackground,
          ),
          label: "Foundations",
          children: [
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedPaintBucket,
                color: theme.onBackground,
              ),
              label: 'Colors',
              compact: true,
              selected: widget.selected == 'foundations-colors' ? true : false,
              onPressed: () {},
            ),
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSolidLine02,
                color: theme.onBackground,
              ),
              label: 'Containers',
              compact: true,
              selected: widget.selected == 'foundations-containers'
                  ? true
                  : false,
              onPressed: () {},
            ),
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedMaterialAndTexture,
                color: theme.onBackground,
              ),
              label: 'Scaffold',
              compact: true,
              selected: widget.selected == 'foundations-scaffold'
                  ? true
                  : false,
              onPressed: () {},
            ),
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedLayerMask01,
                color: theme.onBackground,
              ),
              label: 'Shadows',
              compact: true,
              selected: widget.selected == 'foundations-shadows' ? true : false,
              onPressed: () {},
            ),
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedPaintBoard,
                color: theme.onBackground,
              ),
              label: 'Palette',
              compact: true,
              selected: widget.selected == 'foundations-palette' ? true : false,
              onPressed: () {},
            ),
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedTextFont,
                color: theme.onBackground,
              ),
              label: 'Typography',
              compact: true,
              selected: widget.selected == 'foundations-typography'
                  ? true
                  : false,
              onPressed: () {},
            ),
          ],
        ),

        ClayDrawer.subtitle('Components'),

        ClayDrawer.expansion(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedLayer,
            color: theme.onBackground,
          ),
          label: "Components",
          children: [
            ClayDrawer.action(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedTouchpad04,
                color: theme.onBackground,
              ),
              label: 'Buttons',
              compact: true,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
