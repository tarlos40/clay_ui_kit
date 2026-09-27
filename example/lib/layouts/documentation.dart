import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class DocumentationLayout extends StatefulWidget {
  const DocumentationLayout({super.key});

  @override
  State<DocumentationLayout> createState() => _DocumentationLayoutState();
}

class _DocumentationLayoutState extends State<DocumentationLayout> {
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
