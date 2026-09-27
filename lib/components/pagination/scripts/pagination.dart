import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';

class ClayPagination extends StatelessWidget {
  const ClayPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.visiblePages = 5,
    this.showFirstLast = true,
    this.showPreviousNext = true,
    this.showPageInfo = false,
    this.compact = false,
    this.buttonSize = 38,
    this.spacing = 6,
    this.borderRadius = 12,
    this.activeColor,
    this.activeForegroundColor,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
  }) : assert(currentPage >= 1),
       assert(totalPages >= 0),
       assert(visiblePages >= 1);

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int visiblePages;
  final bool showFirstLast;
  final bool showPreviousNext;
  final bool showPageInfo;
  final bool compact;
  final double buttonSize;
  final double spacing;
  final double borderRadius;
  final Color? activeColor;
  final Color? activeForegroundColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;

  int get _page =>
      totalPages == 0 ? 0 : currentPage.clamp(1, totalPages).toInt();

  List<int> get _pages {
    if (totalPages <= 0) return const [];
    final count = visiblePages < totalPages ? visiblePages : totalPages;
    var start = _page - count ~/ 2;
    start = start.clamp(1, totalPages - count + 1).toInt();
    return List<int>.generate(count, (index) => start + index);
  }

  void _go(int page) {
    if (totalPages <= 0) return;
    final target = page.clamp(1, totalPages).toInt();
    if (target != _page) onPageChanged(target);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final active = activeColor ?? theme.primary;
    final activeForeground = activeForegroundColor ?? theme.onPrimary;
    final background = backgroundColor ?? theme.container;
    final foreground = foregroundColor ?? theme.onBackground;
    final disabled =
        disabledColor ?? theme.onBackgroundVariant.withValues(alpha: 0.38);

    if (totalPages <= 0) return const SizedBox.shrink();

    final controls = <Widget>[];
    if (showFirstLast && !compact) {
      controls.add(
        _iconButton(
          context,
          Icons.keyboard_double_arrow_left_rounded,
          _page > 1,
          () => _go(1),
          background,
          foreground,
          disabled,
        ),
      );
    }
    if (showPreviousNext) {
      controls.add(
        _iconButton(
          context,
          Icons.chevron_left_rounded,
          _page > 1,
          () => _go(_page - 1),
          background,
          foreground,
          disabled,
        ),
      );
    }

    final pages = _pages;
    for (final page in pages) {
      controls.add(
        _pageButton(
          context,
          page,
          page == _page,
          active,
          activeForeground,
          background,
          foreground,
        ),
      );
    }

    if (showPreviousNext) {
      controls.add(
        _iconButton(
          context,
          Icons.chevron_right_rounded,
          _page < totalPages,
          () => _go(_page + 1),
          background,
          foreground,
          disabled,
        ),
      );
    }
    if (showFirstLast && !compact) {
      controls.add(
        _iconButton(
          context,
          Icons.keyboard_double_arrow_right_rounded,
          _page < totalPages,
          () => _go(totalPages),
          background,
          foreground,
          disabled,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow =
            compact ||
            (constraints.maxWidth.isFinite && constraints.maxWidth < 360);
        final visibleControls = isNarrow
            ? <Widget>[
                _iconButton(
                  context,
                  Icons.chevron_left_rounded,
                  _page > 1,
                  () => _go(_page - 1),
                  background,
                  foreground,
                  disabled,
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 64),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '$_page / $totalPages',
                    style: TextStyle(
                      color: foreground,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                _iconButton(
                  context,
                  Icons.chevron_right_rounded,
                  _page < totalPages,
                  () => _go(_page + 1),
                  background,
                  foreground,
                  disabled,
                ),
              ]
            : controls;

        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: spacing,
          runSpacing: spacing,
          children: [
            ...visibleControls,
            if (showPageInfo && !isNarrow)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Página $_page de $totalPages',
                  style: TextStyle(color: foreground, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _pageButton(
    BuildContext context,
    int page,
    bool selected,
    Color active,
    Color activeForeground,
    Color background,
    Color foreground,
  ) {
    final theme = context.clayTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: 'Página $page',
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: borderRadius,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: selected ? null : () => _go(page),
            borderRadius: BorderRadius.circular(borderRadius),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: buttonSize,
              height: buttonSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? active : background,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: selected
                      ? active
                      : foreground.withValues(alpha: 0.055),
                ),
                boxShadow: selected
                    ? ClayShadows.external(theme: theme, offset: 2.5, blur: 7)
                    : ClayShadows.external(theme: theme, offset: 2.5, blur: 7),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  color: selected ? activeForeground : foreground,
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
                child: Text('$page'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
    BuildContext context,
    IconData icon,
    bool enabled,
    VoidCallback onPressed,
    Color background,
    Color foreground,
    Color disabled,
  ) {
    final theme = context.clayTheme;

    return Semantics(
      button: true,
      enabled: enabled,
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: borderRadius,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              width: buttonSize,
              height: buttonSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: foreground.withValues(alpha: 0.055)),
                boxShadow: ClayShadows.external(
                  theme: theme,
                  offset: 2.5,
                  blur: 7,
                ),
              ),
              child: Icon(
                icon,
                size: 21,
                color: enabled ? foreground : disabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
