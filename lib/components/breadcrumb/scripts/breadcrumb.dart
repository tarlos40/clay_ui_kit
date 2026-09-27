import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';

class ClayBreadcrumbItem {
  const ClayBreadcrumbItem({
    required this.label,
    this.onTap,
    this.icon,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final bool enabled;
}

class ClayBreadcrumbs extends StatelessWidget {
  const ClayBreadcrumbs({
    super.key,
    required this.items,
    this.separator,
    this.maxItems = 5,
    this.spacing = 8,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.borderRadius = 10,
    this.backgroundColor,
    this.foregroundColor,
    this.currentColor,
    this.showHomeIcon = false,
    this.overflowLabel = '…',
  }) : assert(maxItems >= 2);

  final List<ClayBreadcrumbItem> items;
  final Widget? separator;
  final int maxItems;
  final double spacing;
  final EdgeInsetsGeometry itemPadding;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? currentColor;
  final bool showHomeIcon;
  final String overflowLabel;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final theme = context.clayTheme;
    final foreground = foregroundColor ?? theme.onBackgroundVariant;
    final current = currentColor ?? theme.onBackground;
    final background = backgroundColor ?? theme.container;
    final visible = _visibleItems(items);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < visible.length; i++) ...[
            if (i > 0) ...[
              SizedBox(width: spacing / 2),
              separator ??
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: foreground.withValues(alpha: .65),
                  ),
              SizedBox(width: spacing / 2),
            ],
            if (visible[i] == null)
              Padding(
                padding: itemPadding,
                child: Text(
                  overflowLabel,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              _buildItem(
                visible[i]!,
                isCurrent: _isLastVisibleRealItem(visible, i),
                first: visible[i] == items.first,
                foreground: foreground,
                current: current,
                background: background,
              ),
          ],
        ],
      ),
    );
  }

  List<ClayBreadcrumbItem?> _visibleItems(List<ClayBreadcrumbItem> source) {
    if (source.length <= maxItems) return source;
    final tailCount = maxItems - 2;
    return [source.first, null, ...source.skip(source.length - tailCount)];
  }

  bool _isLastVisibleRealItem(List<ClayBreadcrumbItem?> visible, int index) {
    for (var i = index + 1; i < visible.length; i++) {
      if (visible[i] != null) return false;
    }
    return visible[index] != null;
  }

  Widget _buildItem(
    ClayBreadcrumbItem item, {
    required bool isCurrent,
    required bool first,
    required Color foreground,
    required Color current,
    required Color background,
  }) {
    final color = isCurrent ? current : foreground;
    Widget content = Padding(
      padding: itemPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            item.icon!,
            const SizedBox(width: 6),
          ] else if (showHomeIcon && first) ...[
            Icon(Icons.home_rounded, size: 16, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            item.label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
    if (isCurrent) return content;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.enabled ? item.onTap : null,
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: item.onTap != null
                ? background.withValues(alpha: .55)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: content,
        ),
      ),
    );
  }
}
