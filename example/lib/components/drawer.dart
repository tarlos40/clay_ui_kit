import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../utils/list_components.dart';

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

        ...ListComponents.byCategory('Documentation').map((item) {
          final route = item['route'] as String? ?? '/${item['value']}';
          final isSelected = widget.selected == route;

          return ClayDrawer.action(
            icon: HugeIcon(
              icon: item['icon'],
              color: isSelected ? theme.onPrimary : theme.onBackground,
            ),
            label: item['title'],
            selected: isSelected,
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
          );
        }),

        ClayDrawer.subtitle('Foundations'),

        ClayDrawer.expansion(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedPuzzle,
            color: theme.onBackground,
          ),
          label: "Foundations",
          children: ListComponents.byCategory('Foundations').map((item) {
            final route = item['route'] as String? ?? '/${item['value']}';
            final isSelected = widget.selected == route;

            return ClayDrawer.action(
              icon: HugeIcon(
                icon: item['icon'],
                color: isSelected ? theme.onPrimary : theme.onBackground,
              ),
              label: item['title'],
              selected: isSelected,
              compact: true,
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
            );
          }).toList(),
        ),

        ClayDrawer.subtitle('Components'),

        ClayDrawer.expansion(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedLayer,
            color: theme.onBackground,
          ),
          label: "Components",
          children: ListComponents.byCategory('Components').map((item) {
            final route = item['route'] as String? ?? '/${item['value']}';
            final isSelected = widget.selected == route;

            return ClayDrawer.action(
              icon: HugeIcon(
                icon: item['icon'],
                color: isSelected ? theme.onPrimary : theme.onBackground,
              ),
              label: item['title'],
              selected: isSelected,
              compact: true,
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
