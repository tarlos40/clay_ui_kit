import 'package:flutter/material.dart';

import '../../appbar/scripts/appbar.dart';
import '../../navigationbar/scripts/navigationbar.dart';
import '../scripts/background.dart';

class ClayScaffold extends StatefulWidget {
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final ClayAppBar? clayAppBar;
  final Widget? body;
  final ClayNavigationBar? clayNavigationBar;

  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const ClayScaffold({
    super.key,
    this.backgroundColor,
    this.backgroundGradient,
    this.clayAppBar,
    this.body,
    this.clayNavigationBar,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  }) : assert(
         backgroundColor == null || backgroundGradient == null,
         "Cannot provide both backgroundColor and backgroundGradient. Please choose one.",
       );

  @override
  State<ClayScaffold> createState() => _ClayScaffoldState();
}

class _ClayScaffoldState extends State<ClayScaffold> {
  @override
  Widget build(BuildContext context) {
    return ClayBackground(
      color: widget.backgroundColor,
      gradient: widget.backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: widget.clayAppBar,
        body: widget.body,
        bottomNavigationBar: widget.clayNavigationBar,

        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      ),
    );
  }
}
