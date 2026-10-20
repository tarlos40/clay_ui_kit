import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 56),

        ClayText.label(
          'Clay UI Kit © 2026 - Built with Claymorphism and Flutter',
        ),

        SizedBox(height: 28),
      ],
    );
  }
}
