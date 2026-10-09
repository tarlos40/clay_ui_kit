import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/buttons/scripts/button.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';

class ClayCard extends StatefulWidget {
  final List<Widget> children;

  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  final double? width;
  final double? height;
  final BoxConstraints? constraints;

  final Clip clipBehavior;

  final VoidCallback? onTap;

  final bool hoverable;
  final ValueChanged<bool>? onHover;

  final bool enabled;

  const ClayCard({
    super.key,
    required this.children,
    this.backgroundColor,
    this.backgroundGradient,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
    this.onTap,
    this.hoverable = false,
    this.onHover,
    this.enabled = true,
  }) : assert(
         backgroundColor == null || backgroundGradient == null,
         'Cannot provide both backgroundColor and backgroundGradient. '
         'Please choose one.',
       );

  static Widget header({
    String? title,
    String? subtitle,
    Widget? leading,
    Widget? action,
    Widget? child,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20, 20, 20, 12),
  }) {
    return _ClayCardHeader(
      title: title,
      subtitle: subtitle,
      leading: leading,
      action: action,
      padding: padding,
      child: child,
    );
  }

  static Widget body({
    required List<Widget> children,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
  }) {
    return _ClayCardBody(padding: padding, children: children);
  }

  static Widget footer({
    Widget? leading,
    Widget? child,
    Widget? trailing,
    List<Widget>? buttons,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20, 12, 20, 20),
  }) {
    return _ClayCardFooter(
      leading: leading,
      trailing: trailing,
      buttons: buttons,
      padding: padding,
      child: child,
    );
  }

  static Widget title(
    String text, {
    Color? color,
    FontWeight fontWeight = FontWeight.w700,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Padding(
      padding: padding,
      child: Builder(
        builder: (context) {
          final theme = context.clayTheme;

          return ClayText.title(
            text,
            color: color ?? theme.onContainer,
            fontWeight: fontWeight,
          );
        },
      ),
    );
  }

  static Widget subtitle(
    String text, {
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Padding(
      padding: padding,
      child: Builder(
        builder: (context) {
          final theme = context.clayTheme;

          return ClayText.label(
            text,
            color: color ?? theme.onContainer.withValues(alpha: 0.65),
            fontWeight: fontWeight,
          );
        },
      ),
    );
  }

  static Widget label(
    String text, {
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Padding(
      padding: padding,
      child: Builder(
        builder: (context) {
          final theme = context.clayTheme;

          return ClayText.label(
            text,
            color: color ?? theme.onContainer.withValues(alpha: 0.55),
            fontWeight: fontWeight,
          );
        },
      ),
    );
  }

  static Widget action({
    required List<Widget> menu,
    Widget? icon,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8),
    String? tooltip,
  }) {
    return _ClayCardAction(
      menu: menu,
      icon: icon ?? const Icon(Icons.more_vert_rounded),
      padding: padding,
      tooltip: tooltip ?? 'More options',
    );
  }

  static Widget menu({
    required String title,
    String? subtitle,
    Widget? icon,
    Widget? trailing,
    VoidCallback? onPressed,
    bool enabled = true,
  }) {
    return _ClayCardMenuItem(
      title: title,
      subtitle: subtitle,
      icon: icon,
      trailing: trailing,
      onPressed: onPressed,
      enabled: enabled,
    );
  }

  static Widget button({
    required String label,
    required VoidCallback? onPressed,
    bool primary = false,
    Widget? iconLeft,
    Widget? iconRight,
    String? tooltip,
  }) {
    if (primary) {
      return ClayButton.primary(
        label,
        iconLeft: iconLeft,
        iconRight: iconRight,
        onPressed: onPressed,
      );
    }

    return ClayButton.third(
      label,
      iconLeft: iconLeft,
      iconRight: iconRight,
      onPressed: onPressed,
    );
  }

  static Widget image({
    ImageProvider? image,
    Widget? child,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(18),
    ),
    AlignmentGeometry alignment = Alignment.center,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    Color? color,
    BlendMode? colorBlendMode,
  }) {
    assert(
      image != null || child != null,
      'ClayCard.image requires either image or child.',
    );

    assert(
      image == null || child == null,
      'ClayCard.image cannot receive both image and child.',
    );

    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          width: width,
          height: height,
          child:
              child ??
              Image(
                image: image!,
                fit: fit,
                alignment: alignment,
                color: color,
                colorBlendMode: colorBlendMode,
              ),
        ),
      ),
    );
  }

  @override
  State<ClayCard> createState() => _ClayCardState();
}

class _ClayCardState extends State<ClayCard> {
  bool _hovered = false;
  bool _pressed = false;

  bool get _interactive =>
      widget.enabled && (widget.onTap != null || widget.hoverable);

  void _handleHover(bool value) {
    if (!widget.enabled) return;

    setState(() {
      _hovered = value;
    });

    widget.onHover?.call(value);
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_interactive) return;

    setState(() {
      _pressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    if (!_interactive) return;

    setState(() {
      _pressed = false;
    });
  }

  void _handleTapCancel() {
    if (!_interactive) return;

    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final hoverEnabled = widget.hoverable || widget.onTap != null;

    final scale = _pressed
        ? 0.985
        : _hovered && hoverEnabled
        ? 1.008
        : 1.0;

    final elevationOffset = 1.0;

    final blur = 4.0;

    final shadows =
        widget.boxShadow ??
        ClayShadows.external(theme: theme, offset: elevationOffset, blur: blur);

    final backgroundColor = widget.backgroundColor ?? theme.container;

    Widget card = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: widget.borderRadius,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            width: widget.width,
            height: widget.height,
            constraints: widget.constraints,
            margin: widget.margin,
            padding: widget.padding,
            clipBehavior: widget.clipBehavior,
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: widget.backgroundGradient,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
              border: widget.border,
              boxShadow: shadows,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.children,
            ),
          ),
        ),
      ),
    );

    if (!_interactive && widget.onHover == null) {
      return card;
    }

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.enabled ? widget.onTap : null,
        onTapDown: widget.enabled ? _handleTapDown : null,
        onTapUp: widget.enabled ? _handleTapUp : null,
        onTapCancel: widget.enabled ? _handleTapCancel : null,
        child: card,
      ),
    );
  }
}

class _ClayCardHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  final Widget? leading;
  final Widget? action;
  final Widget? child;

  final EdgeInsetsGeometry padding;

  const _ClayCardHeader({
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.action,
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final content =
        child ??
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              ClayText.title(
                title!,
                color: theme.onContainer,
                fontWeight: FontWeight.w700,
              ),
            if (subtitle != null) ...[
              const SizedBox(height: 3),
              ClayText.label(
                subtitle!,
                color: theme.onContainer.withValues(alpha: 0.65),
                fontWeight: FontWeight.w500,
              ),
            ],
          ],
        );

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 12)],

          Expanded(child: content),

          if (action != null) ...[const SizedBox(width: 12), action!],
        ],
      ),
    );
  }
}

class _ClayCardBody extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const _ClayCardBody({required this.children, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _ClayCardFooter extends StatelessWidget {
  final Widget? leading;
  final Widget? child;
  final Widget? trailing;
  final List<Widget>? buttons;

  final EdgeInsetsGeometry padding;

  const _ClayCardFooter({
    required this.leading,
    required this.child,
    required this.trailing,
    required this.buttons,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final hasButtons = buttons != null && buttons!.isNotEmpty;

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ?leading,

          if (child != null) ...[
            if (leading != null) const SizedBox(width: 12),
            Expanded(child: child!),
          ],

          if (hasButtons) ...[
            if (leading != null || child != null) const Spacer(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.end,
              children: buttons!,
            ),
          ] else if (trailing != null) ...[
            const Spacer(),
          ],

          if (trailing != null) ...[
            if (hasButtons) const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _ClayCardAction extends StatefulWidget {
  final List<Widget> menu;
  final Widget icon;
  final EdgeInsetsGeometry padding;
  final String tooltip;

  const _ClayCardAction({
    required this.menu,
    required this.icon,
    required this.padding,
    required this.tooltip,
  });

  @override
  State<_ClayCardAction> createState() => _ClayCardActionState();
}

class _ClayCardActionState extends State<_ClayCardAction> {
  bool _pressed = false;

  Future<void> _showMenu() async {
    final renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset.zero, ancestor: overlay),
        renderBox.localToGlobal(
          renderBox.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    await showMenu<void>(
      context: context,
      position: position,
      elevation: 0,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      items: [
        PopupMenuItem<void>(
          enabled: false,
          padding: EdgeInsets.zero,
          child: _ClayCardMenu(children: widget.menu),
        ),
      ],
    );
  }

  void _handleTapDown() {
    setState(() {
      _pressed = true;
    });
  }

  void _handleTapUp() {
    setState(() {
      _pressed = false;
    });

    _showMenu();
  }

  void _handleTapCancel() {
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    Widget action = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: CustomPaint(
          foregroundPainter: ClayInnerShadowPainter(
            shadowColor: theme.shadow,
            lightColor: theme.light,
            borderRadius: 14,
            shadowSize: _pressed ? 1.5 : 2,
            blurRadius: _pressed ? 4 : 7,
          ),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: theme.container,
              borderRadius: BorderRadius.circular(14),
              boxShadow: ClayShadows.external(
                theme: theme,
                offset: _pressed ? 1 : 2,
                blur: _pressed ? 3 : 6,
              ),
            ),
            child: IconTheme(
              data: IconThemeData(color: theme.onContainer, size: 20),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );

    return Tooltip(message: widget.tooltip, child: action);
  }
}

class _ClayCardMenu extends StatelessWidget {
  final List<Widget> children;

  const _ClayCardMenu({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(minWidth: 220, maxWidth: 320),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.container,
          borderRadius: BorderRadius.circular(18),
          boxShadow: ClayShadows.external(theme: theme, offset: 6, blur: 16),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}

class _ClayCardMenuItem extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool enabled;

  const _ClayCardMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.trailing,
    required this.onPressed,
    required this.enabled,
  });

  @override
  State<_ClayCardMenuItem> createState() => _ClayCardMenuItemState();
}

class _ClayCardMenuItemState extends State<_ClayCardMenuItem> {
  bool _hovered = false;
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled || widget.onPressed == null) {
      return;
    }

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final foreground = theme.onContainer.withValues(
      alpha: widget.enabled ? 1 : 0.4,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: MouseRegion(
        cursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) {
          if (!widget.enabled) return;

          setState(() {
            _hovered = true;
          });
        },
        onExit: (_) {
          if (!widget.enabled) return;

          setState(() {
            _hovered = false;
          });
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: widget.enabled ? (_) => _setPressed(true) : null,
          onTapUp: widget.enabled
              ? (_) {
                  _setPressed(false);
                  widget.onPressed?.call();

                  if (widget.onPressed != null) {
                    Navigator.of(context).pop();
                  }
                }
              : null,
          onTapCancel: widget.enabled ? () => _setPressed(false) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _hovered || _pressed
                  ? theme.background.withValues(alpha: 0.55)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(13),
              boxShadow: _pressed
                  ? ClayShadows.external(theme: theme, offset: 1, blur: 3)
                  : null,
            ),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  IconTheme(
                    data: IconThemeData(color: foreground, size: 20),
                    child: widget.icon!,
                  ),
                  const SizedBox(width: 12),
                ],

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClayText.label(
                        widget.title,
                        color: foreground,
                        fontWeight: FontWeight.w600,
                      ),

                      if (widget.subtitle != null) ...[
                        const SizedBox(height: 2),
                        ClayText.label(
                          widget.subtitle!,
                          color: foreground.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ],
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
    );
  }
}
