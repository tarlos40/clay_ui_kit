import 'package:flutter/material.dart';

import '../../../components/texts/scripts/text.dart';
import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';
import '../../../components/buttons/scripts/button.dart';
import '../../../components/buttons/types/sizes.dart';

class ClayAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title, subtitle;
  final Color? backgroundColor, iconColor;
  final List<Widget>? actions;
  final VoidCallback? onPressed;
  final Widget? icon, leading;
  final bool? isLoading, transparent;
  final ClayButtonSizes? size;
  final double? elevation;

  const ClayAppBar({
    super.key,
    this.title = "",
    this.subtitle,
    this.backgroundColor,
    this.leading,
    this.actions,
    this.elevation,
    this.transparent = false,
  }) : onPressed = null,
       icon = null,
       iconColor = null,
       isLoading = null,
       size = null;

  const ClayAppBar.leading(
    this.icon, {
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.isLoading,
    this.size,
  }) : title = null,
       subtitle = null,
       leading = null,
       actions = null,
       elevation = null,
       transparent = null;

  const ClayAppBar.action(
    this.icon, {
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.isLoading,
    this.size,
  }) : title = null,
       subtitle = null,
       leading = null,
       actions = null,
       elevation = null,
       transparent = null;

  @override
  State<ClayAppBar> createState() => _ClayAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ClayAppBarState extends State<ClayAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    if (widget.icon != null) {
      return ClayButton.icon(
        widget.icon,
        onPressed: widget.onPressed,
        backgroundColor: widget.backgroundColor,
        iconColor: widget.iconColor,
        isLoading: widget.isLoading,
        size: widget.size,
      );
    }

    return AppBar(
      backgroundColor: widget.transparent == true
          ? Colors.transparent
          : widget.backgroundColor ?? theme.background,

      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 12,
        children: [
          widget.leading ??
              CustomPaint(
                foregroundPainter: ClayInnerShadowPainter(
                  shadowColor: theme.shadow,
                  lightColor: theme.light,
                  shadowSize: 2,
                  borderRadius: 100,
                ),

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: theme.container,
                    boxShadow: ClayShadows.external(
                      theme: theme,
                      offset: 2,
                      blur: 4,
                    ),
                  ),
                  height: 42,
                  width: 42,
                  padding: EdgeInsets.all(8),

                  child: CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      shadowSize: 2,
                      borderRadius: 100,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: theme.primary,
                      ),
                      height: 12,
                      width: 12,
                    ),
                  ),
                ),
              ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.subtitle != null
                ? [
                    ClayText.label(
                      widget.subtitle!,
                      color: theme.onBackground.withAlpha(160),
                    ),
                    ClayText.title(widget.title!),
                  ]
                : [ClayText.display(widget.title!)],
          ),
        ],
      ),

      actions: widget.actions == null
          ? null
          : [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.actions!
                      .take(3)
                      .map(
                        (action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: action,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],

      elevation: widget.transparent == true ? 0 : widget.elevation,
    );
  }
}
