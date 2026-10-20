import 'package:flutter/material.dart';
import "package:clay_ui_kit/clay_ui_kit.dart";
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:seo/seo.dart';

import './routes.dart';

import './services/hive.dart';
import './services/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  usePathUrlStrategy();

  await HiveService.init();

  runApp(const ClayUiKit());
}

class ClayUiKit extends StatefulWidget {
  const ClayUiKit({super.key});

  @override
  State<ClayUiKit> createState() => _ClayUiKitState();
}

class _ClayUiKitState extends State<ClayUiKit> {
  late bool isDark;

  @override
  void initState() {
    super.initState();

    isDarkNotifier.value = HiveService().get('clay_ui_kit', 'isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: ValueListenableBuilder<bool>(
        valueListenable: isDarkNotifier,
        builder: (context, isDark, _) {
          return ClayApp(
            title: 'Clay UI Kit',
            clayThemeData: ClayThemeData(
              seedColor: ClayColors.cobalt,
              isDark: isDark,
            ),
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: Routes.home,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
