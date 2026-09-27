import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClayText.display("Testando"),

          ClayText.title("Testando"),

          ClayText.body("Testando"),

          ClayText.label("Testando"),
        ],
      ),
    );
  }
}