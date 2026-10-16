import 'package:flutter/material.dart';

import '../../theme/scripts/theme.dart';
import '../../theme/scripts/data.dart';

class ClayApp extends StatelessWidget {
  final String? title;
  final ClayThemeData clayThemeData;
  final Widget? home;
  final bool? debugShowCheckedModeBanner;
  final Iterable<LocalizationsDelegate>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;

  const ClayApp({
    super.key,
    this.title = 'Clay App',
    required this.clayThemeData,
    this.home,
    this.debugShowCheckedModeBanner = true,
    this.localizationsDelegates,
    this.supportedLocales = const [Locale('en', 'EN')],
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ClayTheme(
      theme: clayThemeData,
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner ?? true,

        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        navigatorKey: navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,

        home: home,
      ),
    );
  }
}
