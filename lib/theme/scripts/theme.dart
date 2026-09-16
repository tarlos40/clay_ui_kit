import 'package:flutter/material.dart';

import './data.dart';

class ClayTheme extends InheritedWidget {
  final ClayThemeData theme;

  const ClayTheme({super.key, required this.theme, required super.child});

  static ClayThemeData of(BuildContext context) {
    final ClayTheme? result = context
        .dependOnInheritedWidgetOfExactType<ClayTheme>();
    assert(result != null, 'No ClayTheme found in the BuildContext.');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(ClayTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}
