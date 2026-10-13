import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../appbar/scripts/appbar.dart';
import '../../navigationbar/scripts/navigationbar.dart';
import '../scripts/background.dart';
import '../../fab/scripts/fab.dart';
import '../../drawer/scripts/drawer.dart';
import '../../tabs/scripts/tabs.dart';
import '../../refresh_indicator/scripts/refresh_indicator.dart';

class ClayScaffold extends StatefulWidget {
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final ClayDrawer? clayDrawer;
  final ClayAppBar? clayAppBar;
  final ClayTabs? clayTabs;
  final Widget? body;
  final ClayNavigationBar? clayNavigationBar;
  final ClayFloatingActionButton? clayFloatingActionButton;

  final bool extendBody;
  final bool extendBodyBehindAppBar;

  final double? padding;
  final RefreshCallback? onRefresh;
  final bool useRefreshIndicator, useScrollView;
  final double triggerDistance, indicatorSize;
  final bool hideNavigationBarOnScroll, hideAppBarOnScroll, hideTabsOnScroll;

  const ClayScaffold({
    super.key,
    this.backgroundColor,
    this.backgroundGradient,
    this.clayDrawer,
    this.clayAppBar,
    this.clayTabs,
    this.body,
    this.clayNavigationBar,
    this.clayFloatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.padding,
    this.onRefresh,
    this.useRefreshIndicator = false,
    this.useScrollView = false,
    this.triggerDistance = 80,
    this.indicatorSize = 48,
    this.hideNavigationBarOnScroll = false,
    this.hideAppBarOnScroll = false,
    this.hideTabsOnScroll = false,
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
  double _horizontalDragDistance = 0;
  bool _showNavigationBar = true;
  bool _showAppBar = true;
  bool _showTabs = true;

  void _handleContentSwipe(DragEndDetails details) {
    final tabs = widget.clayTabs;

    if (tabs == null || !tabs.swipeable || tabs.showContent) {
      return;
    }

    final distance = _horizontalDragDistance;
    final velocity = details.primaryVelocity ?? 0;

    _horizontalDragDistance = 0;

    final movedEnough = distance.abs() >= 40;
    final fastEnough = velocity.abs() >= tabs.swipeVelocityThreshold;

    if (!movedEnough && !fastEnough) return;

    final direction = movedEnough
        ? (distance < 0 ? 1 : -1)
        : (velocity < 0 ? 1 : -1);

    final currentIndex = (tabs.index ?? tabs.initialIndex)
        .clamp(0, tabs.tabs.length - 1)
        .toInt();

    var nextIndex = currentIndex + direction;

    while (nextIndex >= 0 &&
        nextIndex < tabs.tabs.length &&
        !tabs.tabs[nextIndex].enabled) {
      nextIndex += direction;
    }

    if (nextIndex < 0 || nextIndex >= tabs.tabs.length) return;

    tabs.onChanged?.call(nextIndex);
  }

  void _handleNavigationSwipe(DragEndDetails details) {
    final navigationBar = widget.clayNavigationBar;

    if (navigationBar == null || !navigationBar.swipeable) {
      _horizontalDragDistance = 0;
      return;
    }

    final distance = _horizontalDragDistance;
    final velocity = details.primaryVelocity ?? 0;

    _horizontalDragDistance = 0;

    final movedEnough = distance.abs() >= 40;
    final fastEnough = velocity.abs() >= navigationBar.swipeVelocityThreshold;

    if (!movedEnough && !fastEnough) return;

    final direction = movedEnough
        ? (distance < 0 ? 1 : -1)
        : (velocity < 0 ? 1 : -1);

    final currentIndex = navigationBar.selectedIndex;
    final nextIndex = currentIndex + direction;

    if (nextIndex < 0 || nextIndex >= navigationBar.destinations.length) {
      return;
    }

    navigationBar.onDestinationSelected(nextIndex);
  }

  void _setNavigationBarVisibility(bool visible) {
    if (_showNavigationBar == visible || !mounted) return;

    setState(() {
      _showNavigationBar = visible;
    });
  }

  void _setAppBarVisibility(bool visible) {
    if (_showAppBar == visible || !mounted) return;

    setState(() {
      _showAppBar = visible;
    });
  }

  void _setTabsVisibility(bool visible) {
    if (_showTabs == visible || !mounted) return;

    setState(() {
      _showTabs = visible;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (!widget.hideNavigationBarOnScroll &&
        !widget.hideAppBarOnScroll &&
        !widget.hideTabsOnScroll) {
      return false;
    }

    if (notification is ScrollUpdateNotification) {
      final metrics = notification.metrics;
      final delta = notification.scrollDelta ?? 0;

      if (metrics.pixels <= metrics.minScrollExtent + 2) {
        if (widget.hideNavigationBarOnScroll) {
          _setNavigationBarVisibility(true);
        }

        if (widget.hideAppBarOnScroll) {
          _setAppBarVisibility(true);
        }

        if (widget.hideTabsOnScroll) {
          _setTabsVisibility(true);
        }
      } else if (delta > 0) {
        if (widget.hideNavigationBarOnScroll) {
          _setNavigationBarVisibility(false);
        }

        if (widget.hideAppBarOnScroll) {
          _setAppBarVisibility(false);
        }

        if (widget.hideTabsOnScroll) {
          _setTabsVisibility(false);
        }
      } else if (delta < 0) {
        if (widget.hideNavigationBarOnScroll) {
          _setNavigationBarVisibility(true);
        }

        if (widget.hideAppBarOnScroll) {
          _setAppBarVisibility(true);
        }

        if (widget.hideTabsOnScroll) {
          _setTabsVisibility(true);
        }
      }
    }

    return false;
  }

  Widget _buildAnimatedNavigationBar() {
    final navigationBar = widget.clayNavigationBar;

    if (navigationBar == null) {
      return const SizedBox.shrink();
    }

    final visible = !widget.hideNavigationBarOnScroll || _showNavigationBar;

    return AnimatedSize(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: visible ? 1 : 0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeInOutCubic,
            offset: visible ? Offset.zero : const Offset(0, 0.35),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              opacity: visible ? 1 : 0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                alignment: Alignment.bottomCenter,
                scale: visible ? 1 : 0.94,
                child: IgnorePointer(ignoring: !visible, child: navigationBar),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAnimatedAppBar() {
    final appBar = widget.clayAppBar;

    if (appBar == null) {
      return const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink(),
      );
    }

    final visible = !widget.hideAppBarOnScroll || _showAppBar;

    return PreferredSize(
      preferredSize: appBar.preferredSize,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
        alignment: Alignment.topCenter,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: visible ? 1 : 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeInOutCubic,
              offset: visible ? Offset.zero : const Offset(0, 0.35),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                opacity: visible ? 1 : 0,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.bottomCenter,
                  scale: visible ? 1 : 0.94,
                  child: IgnorePointer(ignoring: !visible, child: appBar),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTabs() {
    final tabs = widget.clayTabs;

    if (tabs == null) {
      return const SizedBox.shrink();
    }

    final visible = !widget.hideTabsOnScroll || _showTabs;

    return AnimatedSize(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: visible ? 1 : 0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeInOutCubic,
            offset: visible ? Offset.zero : const Offset(0, 0.35),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              opacity: visible ? 1 : 0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                alignment: Alignment.bottomCenter,
                scale: visible ? 1 : 0.94,
                child: IgnorePointer(ignoring: !visible, child: tabs),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          appBar: _buildAnimatedAppBar(),
          body: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: SafeArea(child: _buildBody(context)),
          ),
          bottomNavigationBar: _buildAnimatedNavigationBar(),
          floatingActionButton: widget.clayFloatingActionButton,

          extendBody: widget.extendBody,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    Widget content = widget.body ?? const SizedBox.shrink();

    if (widget.useScrollView) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.only(
          left: widget.padding ?? 12,
          right: widget.padding ?? 12,
        ),
        child: content,
      );
    }

    if (widget.useRefreshIndicator) {
      content = ClayRefreshIndicator(
        onRefresh: widget.onRefresh!,
        triggerDistance: widget.triggerDistance,
        indicatorSize: widget.indicatorSize,
        backgroundColor: context.clayTheme.container,
        color: context.clayTheme.primary,
        enabled: true,
        child: content,
      );
    }

    final tabs = widget.clayTabs;

    if (tabs != null) {
      if (tabs.showContent) {
        return tabs;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAnimatedTabs(),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragStart: tabs.swipeable
                  ? (_) => _horizontalDragDistance = 0
                  : null,
              onHorizontalDragUpdate: tabs.swipeable
                  ? (details) {
                      _horizontalDragDistance += details.delta.dx;
                    }
                  : null,
              onHorizontalDragEnd: tabs.swipeable ? _handleContentSwipe : null,
              child: content,
            ),
          ),
        ],
      );
    }

    final navigationBar = widget.clayNavigationBar;

    if (navigationBar == null || !navigationBar.swipeable) {
      return content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (_) {
        _horizontalDragDistance = 0;
      },
      onHorizontalDragUpdate: (details) {
        _horizontalDragDistance += details.delta.dx;
      },
      onHorizontalDragEnd: _handleNavigationSwipe,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: content,
      ),
    );
  }
}
