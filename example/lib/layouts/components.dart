import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class ComponentsLayout extends StatefulWidget {
  const ComponentsLayout({super.key});

  @override
  State<ComponentsLayout> createState() => _ComponentsLayoutState();
}

class _ComponentsLayoutState extends State<ComponentsLayout> {
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
