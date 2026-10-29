import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../components/navbar.dart';
import '../components/drawer.dart';
import '../components/copyright.dart';
import '../components/empty_catalog.dart';
import '../components/catalog_card.dart';
import '../components/catalog_count.dart';
import '../components/category_filter.dart';

import '../utils/list_components.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final allItems = [
      ...ListComponents.itemsComponents,
      ...ListComponents.itemsFoundations,
    ];
    final filteredItems = allItems.where((item) {
      final category = item['category'] as String;
      final matchesCategory =
          _selectedCategory == 'All' || category == _selectedCategory;
      final searchableText =
          '${item['title']} ${item['description']} ${item['value']}'
              .toLowerCase();
      return matchesCategory && searchableText.contains(_query.toLowerCase());
    }).toList();

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
        child: LayoutBuilder(
          builder: ((context, constraints) {
            final columns = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 580
                ? 2
                : 1;
            const gap = 16.0;
            final cardWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;

            return Column(
              children: [
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: .start,
                  children: [
                    ClayBreadcrumbs(
                      items: [
                        ClayBreadcrumbItem(
                          label: 'Home',
                          onTap: () => Navigator.pushNamed(context, '/'),
                        ),
                        ClayBreadcrumbItem(
                          label: 'Catalog',
                          onTap: () => Navigator.pushNamed(context, '/catalog'),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClayText.display('The component library'),

                          const SizedBox(height: 8),

                          ClayText.body(
                            'Explore building blocks for your next Flutter interface, from everyday controls to the foundations behind their look and feel.',
                            color: theme.onBackground.withValues(alpha: .72),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    CatalogCount(
                      count: allItems.length,
                      label: 'REFERENCE ITEMS',
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                ClayInput.search(
                  controller: _searchController,
                  hintText: 'Search components and foundations',
                  showSearchButton: false,
                  onQueryChanged: (value) =>
                      setState(() => _query = value.trim()),
                ),

                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: .start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        CategoryFilter(
                          label: 'All',
                          count: allItems.length,
                          selected: _selectedCategory == 'All',
                          onTap: () =>
                              setState(() => _selectedCategory = 'All'),
                        ),
                        CategoryFilter(
                          label: 'Components',
                          count: ListComponents.itemsComponents.length,
                          selected: _selectedCategory == 'Components',
                          onTap: () =>
                              setState(() => _selectedCategory = 'Components'),
                        ),
                        CategoryFilter(
                          label: 'Foundations',
                          count: ListComponents.itemsFoundations.length,
                          selected: _selectedCategory == 'Foundations',
                          onTap: () =>
                              setState(() => _selectedCategory = 'Foundations'),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ClayText.title(
                        _selectedCategory == 'All'
                            ? 'Browse everything'
                            : _selectedCategory,
                      ),
                    ),
                    ClayText.label(
                      '${filteredItems.length} ${filteredItems.length == 1 ? 'item' : 'items'}',
                      color: theme.onBackground.withValues(alpha: .62),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if (filteredItems.isEmpty)
                  EmptyCatalog(
                    query: _query,
                    onClear: () {
                      _searchController.clear();
                      setState(() {
                        _query = '';
                        _selectedCategory = 'All';
                      });
                    },
                  )
                else
                  Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: filteredItems.map((item) {
                      return SizedBox(
                        width: cardWidth,
                        child: CatalogCard(item: item),
                      );
                    }).toList(),
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
