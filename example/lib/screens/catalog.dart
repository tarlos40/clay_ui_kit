import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../components/navbar.dart';
import '../components/drawer.dart';
import '../components/search.dart';
import '../components/copyright.dart';

import '../utils/list_components.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: true,

      clayDrawer: DrawerNavbar(selected: '/catalog'),

      clayAppBar: Navbar(
        title: 'Catalog',
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

            ClayBreadcrumbs(
              items: [
                ClayBreadcrumbItem(
                  label: 'Home',
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ClayBreadcrumbItem(
                  label: 'Getting Started',
                  onTap: () {
                    Navigator.pushNamed(context, '/getting-started');
                  },
                ),
                ClayBreadcrumbItem(
                  label: 'Catalog',
                  onTap: () {
                    Navigator.pushNamed(context, '/catalog');
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            Column(
              children: [
                Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedLayer,
                      color: theme.primary,
                      size: 32,
                    ),
                    SizedBox(width: 8),
                    ClayText.display('Components', color: theme.primary),
                  ],
                ),

                SizedBox(height: 8),

                ...ListComponents.byCategory('Components').map((item) {
                  final route = item['route'] as String? ?? '/${item['value']}';

                  return ClayCard(
                    margin: EdgeInsets.only(bottom: 20),
                    onTap: () {
                      Navigator.pushNamed(context, route);
                    },
                    children: [
                      ClayCard.header(
                        title: item['title'],
                        subtitle: item['description'],
                      ),

                      ClayCard.body(
                        children: [
                          HugeIcon(
                            icon: item['icon'],
                            color: theme.onContainer,
                            size: 80,
                          ),
                        ],
                      ),

                      ClayCard.footer(
                        buttons: [
                          ClayCard.button(
                            label: "Go to ${item['title']}",
                            onPressed: () {
                              Navigator.pushNamed(context, route);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),

            SizedBox(height: 20),

            Column(
              children: [
                Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedPuzzle,
                      color: theme.primary,
                      size: 32,
                    ),
                    SizedBox(width: 8),
                    ClayText.display('Foundations', color: theme.primary),
                  ],
                ),

                SizedBox(height: 8),

                ...ListComponents.byCategory('Foundations').map((item) {
                  final route = item['route'] as String? ?? '/${item['value']}';

                  return ClayCard(
                    margin: EdgeInsets.only(bottom: 20),
                    onTap: () {
                      Navigator.pushNamed(context, route);
                    },
                    children: [
                      ClayCard.header(
                        title: item['title'],
                        subtitle: item['description'],
                      ),

                      ClayCard.body(
                        children: [
                          HugeIcon(
                            icon: item['icon'],
                            color: theme.onContainer,
                            size: 80,
                          ),
                        ],
                      ),

                      ClayCard.footer(
                        buttons: [
                          ClayCard.button(
                            label: "Go to ${item['title']}",
                            onPressed: () {
                              Navigator.pushNamed(context, route);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),

            Copyright(),
          ],
        ),
      ),
    );
  }
}
