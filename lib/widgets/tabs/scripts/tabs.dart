import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/styles.dart';
import '../../../theme/scripts/shadows.dart';

class ClayTabItem {
  const ClayTabItem({
    required this.label,
    required this.child,
    this.icon,
    this.selectedIcon,
    this.enabled = true,
    this.badge,
  });

  final String label;
  final Widget child;
  final Widget? icon;
  final Widget? selectedIcon;
  final bool enabled;
  final Widget? badge;
}

class ClayTabs extends StatefulWidget {
  const ClayTabs({
    super.key,
    required this.tabs,
    this.index,
    this.initialIndex = 0,
    this.onChanged,
    this.style = ClayTabsStyle.pills,
    this.isScrollable = true,
    this.expand = false,
    this.showContent = true,
    this.contentPadding = EdgeInsets.zero,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
    this.spacing = 6,
    this.borderRadius = 40,
    this.animationDuration = const Duration(milliseconds: 260),
    this.indicatorColor,
    this.backgroundColor,
    this.selectedForegroundColor,
    this.foregroundColor,
  }) : assert(tabs.length > 0, 'ClayTabs requires at least one tab.'),
       assert(initialIndex >= 0),
       assert(index == null || index >= 0);

  final List<ClayTabItem> tabs;
  final int? index;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final ClayTabsStyle style;
  final bool isScrollable;
  final bool expand;
  final bool showContent;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry tabPadding;
  final double spacing;
  final double borderRadius;
  final Duration animationDuration;
  final Color? indicatorColor;
  final Color? backgroundColor;
  final Color? selectedForegroundColor;
  final Color? foregroundColor;

  @override
  State<ClayTabs> createState() => _ClayTabsState();
}

class _ClayTabsState extends State<ClayTabs> {
  late int _selectedIndex;

  int get _index =>
      (widget.index ?? _selectedIndex).clamp(0, widget.tabs.length - 1).toInt();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex
        .clamp(0, widget.tabs.length - 1)
        .toInt();
  }

  @override
  void didUpdateWidget(covariant ClayTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex && widget.index == null) {
      _selectedIndex = widget.initialIndex
          .clamp(0, widget.tabs.length - 1)
          .toInt();
    }
    if (_selectedIndex >= widget.tabs.length) {
      _selectedIndex = widget.tabs.length - 1;
    }
  }

  void _select(int index) {
    if (index < 0 ||
        index >= widget.tabs.length ||
        !widget.tabs[index].enabled) {
      return;
    }
    if (index == _index) return;
    if (widget.index == null) setState(() => _selectedIndex = index);
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final selectedColor = widget.indicatorColor ?? theme.primary;
    final foreground = widget.foregroundColor ?? theme.onBackgroundVariant;
    final selectedForeground =
        widget.selectedForegroundColor ?? theme.onPrimary;
    final background = widget.backgroundColor ?? theme.container;

    final tabs = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        for (var i = 0; i < widget.tabs.length; i++) ...[
          if (i > 0 && widget.spacing > 0) SizedBox(width: widget.spacing),
          if (widget.expand)
            Expanded(
              child: _buildTab(
                context,
                i,
                selectedColor,
                selectedForeground,
                foreground,
                background,
              ),
            )
          else
            _buildTab(
              context,
              i,
              selectedColor,
              selectedForeground,
              foreground,
              background,
            ),
        ],
      ],
    );

    final tabBar = widget.style == ClayTabsStyle.segmented
        ? Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(widget.borderRadius + 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.055),
                  offset: const Offset(2, 3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.45),
                  offset: const Offset(-2, -2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: tabs,
          )
        : tabs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isScrollable && !widget.expand)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Align(alignment: Alignment.centerLeft, child: tabBar),
          )
        else
          tabBar,
        if (widget.showContent) ...[
          SizedBox(height: widget.style == ClayTabsStyle.underline ? 12 : 16),
          Padding(
            padding: widget.contentPadding,
            child: AnimatedSwitcher(
              duration: widget.animationDuration,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.015, 0.025),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey<int>(_index),
                child: widget.tabs[_index].child,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTab(
    BuildContext context,
    int index,
    Color selectedColor,
    Color selectedForeground,
    Color foreground,
    Color background,
  ) {
    final theme = context.clayTheme;
    final tab = widget.tabs[index];
    final selected = index == _index;
    final isUnderline = widget.style == ClayTabsStyle.underline;
    final isSegmented = widget.style == ClayTabsStyle.segmented;
    final activeBackground = isUnderline ? Colors.transparent : selectedColor;

    return Semantics(
      button: true,
      selected: selected,
      enabled: tab.enabled,
      label: tab.label,
      child: Tooltip(
        message: tab.label,
        excludeFromSemantics: true,
        child: InkWell(
          onTap: tab.enabled ? () => _select(index) : null,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: CustomPaint(
            foregroundPainter: ClayInnerShadowPainter(
              shadowColor: selected ? theme.shadow : Colors.transparent,
              lightColor: selected ? theme.light : Colors.transparent,
              borderRadius: selected ? widget.borderRadius : 0,
              shadowSize: selected ? 2.5 : 0,
              blurRadius: selected ? 7.0 : 0,
            ),
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeOutCubic,
              padding: widget.tabPadding,
              decoration: BoxDecoration(
                color: selected ? activeBackground : Colors.transparent,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: selected && !isUnderline
                    ? [
                        BoxShadow(
                          color: selectedColor.withValues(alpha: 0.18),
                          offset: const Offset(0, 3),
                          blurRadius: 7,
                        ),
                        if (isSegmented)
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.16),
                            offset: const Offset(-1, -1),
                            blurRadius: 3,
                          ),
                      ]
                    : null,
                border: isUnderline
                    ? Border(
                        bottom: BorderSide(
                          color: selected ? selectedColor : Colors.transparent,
                          width: selected ? 2.5 : 1,
                        ),
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: widget.expand
                    ? MainAxisSize.min
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selected
                      ? (tab.selectedIcon ?? tab.icon) != null
                      : tab.icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        size: 18,
                        color: selected
                            ? (isUnderline ? selectedColor : selectedForeground)
                            : foreground,
                      ),
                      child: selected
                          ? (tab.selectedIcon ?? tab.icon)!
                          : tab.icon!,
                    ),
                    const SizedBox(width: 7),
                  ],
                  AnimatedDefaultTextStyle(
                    duration: widget.animationDuration,
                    style: TextStyle(
                      color: !tab.enabled
                          ? foreground.withValues(alpha: 0.4)
                          : selected
                          ? (isUnderline ? selectedColor : selectedForeground)
                          : foreground,
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    child: Text(
                      tab.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (tab.badge != null) ...[
                    const SizedBox(width: 7),
                    tab.badge!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
