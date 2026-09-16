import 'package:flutter/material.dart';

class ClayBuildNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  const ClayBuildNavigator({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  @override
  State<ClayBuildNavigator> createState() => _ClayBuildNavigatorState();
}

class _ClayBuildNavigatorState extends State<ClayBuildNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => widget.child),
    );
  }
}
