import 'package:flutter/material.dart';

import './screens/error/not_found.dart';
import './screens/tests/lab.dart';
import './screens/home.dart';
import './screens/getting_started.dart';
import './screens/catalog.dart';

class Routes {
  static const home = '/';
  static const gettingStarted = '/getting-started';
  static const catalog = '/catalog';

  static const labTests = '/tests/lab';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case gettingStarted:
        return MaterialPageRoute(builder: (_) => const GettingStartedScreen());
      case catalog:
        return MaterialPageRoute(builder: (_) => const CatalogScreen());

      case labTests:
        return MaterialPageRoute(builder: (_) => const LabScreen());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
