import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

import '../utils/list_components.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _routeFromQuery(String query) {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) return null;

    final lowerQuery = normalizedQuery.toLowerCase();

    for (final item in ListComponents.itemsFull) {
      final title = (item['title'] ?? '').toString().toLowerCase();
      final category = (item['category'] ?? '').toString().toLowerCase();
      final value = (item['value'] ?? '').toString().toLowerCase();
      final route = item['route'];

      if ((title.contains(lowerQuery) ||
              category.contains(lowerQuery) ||
              value.contains(lowerQuery)) &&
          route is String &&
          route.isNotEmpty) {
        return route;
      }
    }

    return null;
  }

  void _goToRoute(String? route) {
    if (route == null || route.isEmpty || !mounted) return;
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayInput.search(
      hintText: 'Search components',
      controller: _controller,
      maxSuggestions: 3,
      suggestions: ListComponents.itemsFull.map((item) {
        return ClaySearchSuggestion(
          title: item['title'],
          subtitle: item['category'],
          leading: HugeIcon(
            icon: item['icon'],
            color: theme.onContainer.withValues(alpha: 0.48),
          ),
        );
      }).toList(),
      onSuggestionSelected: (suggestion) {
        _controller.value = TextEditingValue(
          text: suggestion.queryValue,
          selection: TextSelection.collapsed(
            offset: suggestion.queryValue.length,
          ),
        );
      },
      onSearch: (query) {
        _goToRoute(_routeFromQuery(query));
      },
    );
  }
}
