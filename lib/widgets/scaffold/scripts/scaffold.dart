import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../appbar/scripts/appbar.dart';
import '../../navigationbar/scripts/navigationbar.dart';
import '../scripts/background.dart';
import '../../fab/scripts/fab.dart';
import '../../drawer/scripts/drawer.dart';

class ClayScaffold extends StatefulWidget {
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final ClayDrawer? clayDrawer;
  final ClayAppBar? clayAppBar;
  final Widget? body;
  final ClayNavigationBar? clayNavigationBar;
  final ClayFloatingActionButton? clayFloatingActionButton;

  final bool extendBody;
  final bool extendBodyBehindAppBar;

  final double? padding;
  final RefreshCallback? onRefresh;
  final bool useRefreshIndicator, useScrollView;

  const ClayScaffold({
    super.key,
    this.backgroundColor,
    this.backgroundGradient,
    this.clayDrawer,
    this.clayAppBar,
    this.body,
    this.clayNavigationBar,
    this.clayFloatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.padding,
    this.onRefresh,
    this.useRefreshIndicator = false,
    this.useScrollView = false,
  }) : assert(
         backgroundColor == null || backgroundGradient == null,
         "Cannot provide both backgroundColor and backgroundGradient. Please choose one.",
       ),
       assert(
         !useRefreshIndicator || onRefresh != null,
         "onRefresh must be provided when useRefreshIndicator is true.",
       );

  @override
  State<ClayScaffold> createState() => _ClayScaffoldState();
}

class _ClayScaffoldState extends State<ClayScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ClayBackground(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        child: Scaffold(
          backgroundColor: Colors.transparent,

          drawer: widget.clayDrawer,
          appBar: widget.clayAppBar,
          body: SafeArea(child: _buildBody(context)),
          bottomNavigationBar: widget.clayNavigationBar,
          floatingActionButton: widget.clayFloatingActionButton,

          extendBody: widget.extendBody,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget body = widget.body ?? const SizedBox.shrink();

    final shouldScroll = widget.useScrollView || widget.useRefreshIndicator;

    if (shouldScroll) {
      body = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: widget.padding ?? 12,
          right: widget.padding ?? 12,
          bottom: 8,
        ),
        child: body,
      );
    }

    if (widget.useRefreshIndicator) {
      body = RefreshIndicator(
        onRefresh: widget.onRefresh!,
        backgroundColor: context.clayTheme.container,
        color: context.clayTheme.primary,
        child: body,
      );
    }

    return body;
  }
}
