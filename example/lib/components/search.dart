import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return ClayInput.search(
      hintText: 'Search components',
      showSearchButton: false,
    );
  }
}
