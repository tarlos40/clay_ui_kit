import 'package:flutter/material.dart';

import '../../theme/scripts/theme.dart';
import '../../theme/scripts/data.dart';

class ClayApp extends StatelessWidget {
  final String? title;
  final ClayThemeData clayThemeData;
  final Widget? home;
  final bool? debugShowCheckedModeBanner;

  const ClayApp({
    super.key,
    this.title = 'Clay App',
    required this.clayThemeData,
    this.home,
    this.debugShowCheckedModeBanner = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClayTheme(
      theme: clayThemeData,
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner ?? true,

        home: home,
      ),
    );
  }
}
