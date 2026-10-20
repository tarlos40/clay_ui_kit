import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../components/navbar.dart';
import '../components/drawer.dart';
import '../components/search.dart';
import '../components/copyright.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return ClayScaffold(
      useScrollView: true,
      hideAppBarOnScroll: true,

      clayDrawer: DrawerNavbar(selected: 'catalog'),

      clayAppBar: Navbar(
        title: 'Catalog',
        subtitle: 'Documentation',
        showDrawer: true,
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [SizedBox(height: 20), Search(), Copyright()],
        ),
      ),
    );
  }
}
