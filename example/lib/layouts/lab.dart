import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:clay_ui_kit/theme/scripts/shadows.dart';

class LabLayout extends StatefulWidget {
  const LabLayout({super.key});

  @override
  State<LabLayout> createState() => _LabLayoutState();
}

class _LabLayoutState extends State<LabLayout> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          ClayText.display("Testando"),

          ClayText.title("Testando"),

          ClayText.body("Testando"),

          ClayText.label("Testando"),

          Text(
            '$_counter',
            style: TextStyle(color: theme.onBackgroundVariant, fontSize: 32),
          ),

          SizedBox(height: 8),

          ClayButton.base('Base', onPressed: () {}, isLoading: false),

          SizedBox(height: 8),

          ClayButton.primary('Primary', onPressed: () {}, isLoading: false),

          SizedBox(height: 8),

          ClayButton.secondary(
            'Secondary',
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.small,
          ),

          SizedBox(height: 8),

          ClayButton.third(
            'Third',
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.large,
          ),

          SizedBox(height: 8),

          ClayButton.text(
            'Text',
            onPressed: () {},
            isLoading: false,
            iconLeft: Icon(Icons.abc_sharp),
          ),

          SizedBox(height: 8),

          ClayButton.icon(
            Icon(Icons.abc_sharp),
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.large,
          ),

          SizedBox(height: 8),

          ClayButton.gradient(
            "Testando",
            colors: [
              ClayColors.sky,
              ClayColors.sky.s600,
              ClayColors.sky.s700,
              ClayColors.sky.s900,
            ],
            begin: AlignmentGeometry.bottomCenter,
            end: AlignmentGeometry.center,
            foregroundColor: ClayColors.sky.s50,
            onPressed: () {},
            iconLeft: Icon(Icons.import_contacts),
            iconRight: Icon(Icons.import_contacts),
          ),

          SizedBox(height: 8),

          CustomPaint(
            foregroundPainter: ClayInnerShadowPainter(
              shadowColor: theme.shadow,
              lightColor: theme.light,
              borderRadius: 20,
              shadowSize: 6.0,
              blurRadius: 12.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: theme.container,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.border, width: .5),
              ),
              child: TextField(
                style: TextStyle(color: theme.onContainer),
                decoration: InputDecoration(
                  hintText: "Testando",
                  hintStyle: TextStyle(
                    color: theme.onBackgroundVariant.withAlpha(150),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 8),

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.container,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.border, width: .5),
              boxShadow: ClayShadows.external(theme: theme),
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: theme.onContainer),
              child: Text(
                'testando',
                style: TextStyle(color: theme.onContainer),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
