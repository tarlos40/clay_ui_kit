import 'package:flutter/material.dart';

import './screens/home.dart';

class Routes {
  static const home = '/';
  static const tests = '/tests';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
