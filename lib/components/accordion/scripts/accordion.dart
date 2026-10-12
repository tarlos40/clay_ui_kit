import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';

class ClayAccordionItem {
  const ClayAccordionItem({
    required this.title,
    required this.content,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.initiallyExpanded = false,
  });

  final String title;
  final String? subtitle;
  final Widget content;
  final Widget? leading;
  final bool enabled;
  final bool initiallyExpanded;
}

class ClayAccordion extends StatefulWidget {
  const ClayAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
    this.initiallyExpandedIndices = const <int>{},
    this.onExpansionChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    this.borderRadius = 16,
    this.spacing = 10,
    this.backgroundColor,
    this.expandedColor,
    this.titleColor,
    this.subtitleColor,
    this.iconColor,
    this.showDividers = false,
  });

  final List<ClayAccordionItem> items;
  final bool allowMultiple;
  final Set<int> initiallyExpandedIndices;
  final ValueChanged<({int index, bool expanded})>? onExpansionChanged;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final double spacing;
  final Color? backgroundColor;
  final Color? expandedColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? iconColor;
  final bool showDividers;

  @override
  State<ClayAccordion> createState() => _ClayAccordionState();
}

class _ClayAccordionState extends State<ClayAccordion> {
  late Set<int> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpandedIndices
        .where((i) => i >= 0 && i < widget.items.length)
        .toSet();
    if (!widget.allowMultiple && _expanded.length > 1) {
      _expanded = {_expanded.first};
    }
    for (var i = 0; i < widget.items.length; i++) {
      if (widget.items[i].initiallyExpanded) {
        if (!widget.allowMultiple) {
          _expanded = {i};
          break;
        }
        _expanded.add(i);
      }
    }
  }

  @override
  void didUpdateWidget(covariant ClayAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    _expanded.removeWhere((i) => i < 0 || i >= widget.items.length);
  }

  void _toggle(int index) {
    if (!widget.items[index].enabled) return;
    final opening = !_expanded.contains(index);
    setState(() {
      if (!widget.allowMultiple) _expanded.clear();
      if (opening) {
        _expanded.add(index);
      } else {
        _expanded.remove(index);
      }
    });
    widget.onExpansionChanged?.call((index: index, expanded: opening));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final base = widget.backgroundColor ?? theme.container;
    final expanded = widget.expandedColor ?? base;
    final title = widget.titleColor ?? theme.onBackground;
    final subtitle = widget.subtitleColor ?? theme.onBackgroundVariant;
    final icon = widget.iconColor ?? theme.onBackgroundVariant;

    return Column(
      children: [
        for (var i = 0; i < widget.items.length; i++) ...[
          if (i > 0 && !widget.showDividers) SizedBox(height: widget.spacing),
          if (i > 0 && widget.showDividers)
            Divider(
              height: widget.spacing * 2,
              color: subtitle.withValues(alpha: .18),
            ),
          _buildItem(i, widget.items[i], base, expanded, title, subtitle, icon),
        ],
      ],
    );
  }

  Widget _buildItem(
    int index,
    ClayAccordionItem item,
    Color base,
    Color expanded,
    Color title,
    Color subtitle,
    Color icon,
  ) {
    final isExpanded = _expanded.contains(index);
    final theme = context.clayTheme;

    return CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: widget.borderRadius,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: isExpanded ? expanded : base,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: title.withValues(alpha: isExpanded ? .10 : .055),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .035),
            offset: const Offset(2, 3),
            blurRadius: 7,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: .28),
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Semantics(
            button: true,
            expanded: isExpanded,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: item.enabled ? () => _toggle(index) : null,
                borderRadius: BorderRadius.circular(widget.borderRadius - 4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      if (item.leading != null) ...[
                        item.leading!,
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: item.enabled
                                    ? title
                                    : title.withValues(alpha: .45),
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                item.subtitle!,
                                style: TextStyle(color: subtitle, fontSize: 12),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: isExpanded ? .5 : 0,
                        duration: const Duration(milliseconds: 220),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: icon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: isExpanded
                ? Padding(
                    padding: widget.contentPadding,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: item.content,
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
      )
    );
  }
}
