import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/buttons/scripts/button.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';

class ClayDrawer extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;

  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final double width;
  final EdgeInsetsGeometry padding;

  const ClayDrawer({
    super.key,
    this.child,
    this.children,
    this.backgroundColor,
    this.backgroundGradient,
    this.width = 320,
    this.padding = const EdgeInsets.all(16),
  }) : assert(
         backgroundColor == null || backgroundGradient == null,
         'Cannot provide both backgroundColor and backgroundGradient. '
         'Please choose one.',
       ),
       assert(
         child == null || children == null,
         'Cannot provide both child and children. '
         'Please choose one.',
       );

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Drawer(
      width: width,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.background,
          gradient: backgroundGradient,
        ),
        child: SafeArea(
          child:
              child ??
              ListView(padding: padding, children: children ?? const []),
        ),
      ),
    );
  }

  static Widget menuButton(
    BuildContext context, {
    Widget? icon,
    VoidCallback? onPressed,
    String? tooltip,
  }) {
    return Builder(
      builder: (context) {
        return ClayButton.icon(
          icon ?? const Icon(Icons.menu_rounded),
          onPressed:
              onPressed ??
              () {
                Scaffold.of(context).openDrawer();
              },
        );
      },
    );
  }

  static Widget title(
    String text, {
    Widget? leading,
    Widget? trailing,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(12, 12, 12, 16),
  }) {
    return _ClayDrawerTitle(
      text: text,
      leading: leading,
      trailing: trailing,
      padding: padding,
    );
  }

  static Widget subtitle(
    String text, {
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(12, 16, 12, 8),
  }) {
    return _ClayDrawerSubtitle(text: text, padding: padding);
  }

  static Widget action({
    required Widget icon,
    required String label,
    VoidCallback? onPressed,
    bool selected = false,
    Widget? trailing,
    bool compact = false,
  }) {
    return _ClayDrawerAction(
      icon: icon,
      label: label,
      onPressed: onPressed,
      selected: selected,
      trailing: trailing,
      compact: compact,
    );
  }

  static Widget divider({
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 12),
  }) {
    return _ClayDrawerDivider(padding: padding);
  }

  static Widget spacer([double height = 8]) {
    return SizedBox(height: height);
  }

  static Widget expansion({
    required Widget icon,
    required String label,
    required List<Widget> children,
    bool initiallyExpanded = false,
  }) {
    return _ClayDrawerExpansion(
      icon: icon,
      label: label,
      initiallyExpanded: initiallyExpanded,
      children: children,
    );
  }
}

class _ClayDrawerTitle extends StatelessWidget {
  final String text;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const _ClayDrawerTitle({
    required this.text,
    required this.leading,
    required this.trailing,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: theme.onBackground, size: 26),
              child: leading!,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(child: ClayText.title(text, color: theme.onBackground)),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}

class _ClayDrawerSubtitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const _ClayDrawerSubtitle({required this.text, required this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: padding,
      child: ClayText.label(
        text.toUpperCase(),
        color: theme.onBackground.withValues(alpha: 0.55),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ClayDrawerAction extends StatefulWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onPressed;
  final bool selected;
  final Widget? trailing;
  final bool compact;

  const _ClayDrawerAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.selected,
    required this.trailing,
    required this.compact,
  });

  @override
  State<_ClayDrawerAction> createState() => _ClayDrawerActionState();
}

class _ClayDrawerActionState extends State<_ClayDrawerAction> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onPressed == null) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final selected = widget.selected;
    final enabled = widget.onPressed != null;

    final backgroundColor = selected
        ? theme.primary
        : theme.container.withValues(alpha: _pressed ? 0.55 : 0);

    final foregroundColor = selected ? theme.onPrimary : theme.onContainer;

    final iconColor = selected ? theme.onPrimary : theme.onContainer;

    final height = widget.compact ? 42.0 : 52.0;
    final horizontalPadding = widget.compact ? 10.0 : 14.0;
    final iconSize = widget.compact ? 19.0 : 22.0;
    final iconSpacing = widget.compact ? 10.0 : 14.0;
    final radius = widget.compact ? 14.0 : 18.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? (_) => _setPressed(true) : null,
        onTapUp: enabled ? (_) => _setPressed(false) : null,
        onTapCancel: enabled ? () => _setPressed(false) : null,
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _pressed ? 0.975 : 1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic,
          child: CustomPaint(
            foregroundPainter: selected
                ? ClayInnerShadowPainter(
                    shadowColor: theme.shadow,
                    lightColor: theme.light,
                    borderRadius: 18,
                    shadowSize: _pressed ? 1.5 : 2,
                    blurRadius: _pressed ? 5 : 8,
                  )
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              height: height,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: selected
                    ? ClayShadows.external(
                        theme: theme,
                        offset: _pressed ? 1 : 3,
                        blur: _pressed ? 3 : 8,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: iconColor.withValues(alpha: enabled ? 1 : 0.4),
                      size: iconSize,
                    ),
                    child: widget.icon,
                  ),

                  SizedBox(width: iconSpacing),

                  Expanded(
                    child: ClayText.label(
                      widget.label,
                      color: foregroundColor.withValues(
                        alpha: enabled ? 1 : 0.4,
                      ),
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    const SizedBox(width: 8),
                    widget.trailing!,
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

class _ClayDrawerDivider extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const _ClayDrawerDivider({required this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: padding,
      child: SizedBox(
        height: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.shadow.withValues(alpha: 0.12),
            boxShadow: [
              BoxShadow(
                color: theme.light.withValues(alpha: 0.45),
                offset: const Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClayDrawerExpansion extends StatefulWidget {
  final Widget icon;
  final String label;
  final List<Widget> children;
  final bool initiallyExpanded;

  const _ClayDrawerExpansion({
    required this.icon,
    required this.label,
    required this.children,
    required this.initiallyExpanded,
  });

  @override
  State<_ClayDrawerExpansion> createState() => _ClayDrawerExpansionState();
}

class _ClayDrawerExpansionState extends State<_ClayDrawerExpansion>
    with SingleTickerProviderStateMixin {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: _expanded
                  ? theme.container.withValues(alpha: 0.45)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                IconTheme(
                  data: IconThemeData(color: theme.onContainer, size: 22),
                  child: widget.icon,
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: ClayText.label(
                    widget.label,
                    color: theme.onContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.onContainer.withValues(alpha: 0.7),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
                  child: Column(children: widget.children),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
