import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';
import '../../../palette/types/colors.dart';

enum ClayMenuTrigger { tap, longPress, secondaryTap, hover }

class ClayMenuItem {
  final String label;
  final Widget? icon;
  final Widget? trailing;
  final ShortcutActivator? shortcut;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool destructive;

  const ClayMenuItem({
    required this.label,
    this.icon,
    this.trailing,
    this.shortcut,
    this.onPressed,
    this.enabled = true,
    this.destructive = false,
  });

  const ClayMenuItem.divider()
    : label = '',
      icon = null,
      trailing = null,
      shortcut = null,
      onPressed = null,
      enabled = true,
      destructive = false;
}

class ClayMenu extends StatefulWidget {
  final Widget child;
  final List<ClayMenuItem> items;

  final Set<ClayMenuTrigger> triggers;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final double width;
  final double radius;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry itemPadding;

  final bool showShortcuts;
  final bool closeOnSelection;
  final bool enableShortcuts;

  final Duration animationDuration;

  const ClayMenu({
    super.key,
    required this.child,
    required this.items,
    this.triggers = const {
      ClayMenuTrigger.tap,
      ClayMenuTrigger.longPress,
      ClayMenuTrigger.secondaryTap,
    },
    this.backgroundColor,
    this.foregroundColor,
    this.width = 220,
    this.radius = 18,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.showShortcuts = true,
    this.closeOnSelection = true,
    this.enableShortcuts = true,
    this.animationDuration = const Duration(milliseconds: 160),
  });

  @override
  State<ClayMenu> createState() => _ClayMenuState();
}

class _ClayMenuState extends State<ClayMenu> {
  final MenuController _controller = MenuController();

  bool _hovering = false;

  bool get _isDesktop {
    return kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  void _open() {
    if (!_controller.isOpen) {
      _controller.open();
    }
  }

  void _close() {
    if (_controller.isOpen) {
      _controller.close();
    }
  }

  void _toggle() {
    if (_controller.isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _handleTap() {
    if (widget.triggers.contains(ClayMenuTrigger.tap)) {
      _toggle();
    }
  }

  void _handleLongPress() {
    if (widget.triggers.contains(ClayMenuTrigger.longPress)) {
      _open();
    }
  }

  void _handleSecondaryTap() {
    if (widget.triggers.contains(ClayMenuTrigger.secondaryTap)) {
      _open();
    }
  }

  void _handleHover(bool value) {
    _hovering = value;

    if (!_isDesktop) return;
    if (!widget.triggers.contains(ClayMenuTrigger.hover)) return;

    if (value) {
      _open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final menu = MenuAnchor(
      controller: _controller,
      consumeOutsideTap: true,
      crossAxisUnconstrained: false,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          widget.backgroundColor ?? context.clayTheme.container,
        ),
        elevation: WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(widget.padding),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
      menuChildren: [
        for (final item in widget.items)
          if (_isDivider(item))
            _buildDivider(context)
          else
            _buildItem(context, item),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        onLongPress: _handleLongPress,
        onSecondaryTap: _handleSecondaryTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _handleHover(true),
          onExit: (_) {
            _handleHover(false);
          },
          child: widget.child,
        ),
      ),
    );

    if (!widget.enableShortcuts) {
      return menu;
    }

    final shortcuts = <ShortcutActivator, VoidCallback>{};

    for (final item in widget.items) {
      if (item.shortcut == null) continue;
      if (!item.enabled) continue;
      if (item.onPressed == null) continue;

      shortcuts[item.shortcut!] = () {
        item.onPressed?.call();

        if (widget.closeOnSelection) {
          _close();
        }
      };
    }

    if (shortcuts.isEmpty) {
      return menu;
    }

    return CallbackShortcuts(bindings: shortcuts, child: menu);
  }

  bool _isDivider(ClayMenuItem item) {
    return item.label.isEmpty &&
        item.icon == null &&
        item.trailing == null &&
        item.shortcut == null &&
        item.onPressed == null;
  }

  Widget _buildDivider(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.shadow.withValues(alpha: 0.10),
      ),
    );
  }

  Widget _buildItem(BuildContext context, ClayMenuItem item) {
    final theme = context.clayTheme;

    final foreground = item.destructive
        ? ClayColors.ruby
        : widget.foregroundColor ?? theme.onContainer;

    final enabled = item.enabled && item.onPressed != null;

    return _ClayMenuItem(
      label: item.label,
      icon: item.icon,
      trailing: item.trailing,
      shortcut: item.shortcut,
      enabled: enabled,
      foregroundColor: foreground,
      itemPadding: widget.itemPadding,
      showShortcut: widget.showShortcuts,
      onPressed: enabled
          ? () {
              item.onPressed?.call();

              if (widget.closeOnSelection) {
                _close();
              }
            }
          : null,
    );
  }
}

class _ClayMenuItem extends StatefulWidget {
  final String label;
  final Widget? icon;
  final Widget? trailing;
  final ShortcutActivator? shortcut;

  final bool enabled;
  final Color foregroundColor;
  final EdgeInsetsGeometry itemPadding;
  final bool showShortcut;

  final VoidCallback? onPressed;

  const _ClayMenuItem({
    required this.label,
    required this.icon,
    required this.trailing,
    required this.shortcut,
    required this.enabled,
    required this.foregroundColor,
    required this.itemPadding,
    required this.showShortcut,
    required this.onPressed,
  });

  @override
  State<_ClayMenuItem> createState() => _ClayMenuItemState();
}

class _ClayMenuItemState extends State<_ClayMenuItem> {
  bool _hovered = false;
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled) return;

    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final color = widget.enabled
        ? widget.foregroundColor
        : widget.foregroundColor.withValues(alpha: 0.35);

    final background = _hovered
        ? theme.primary.withValues(alpha: 0.08)
        : Colors.transparent;

    return MouseRegion(
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
        setState(() {
          _hovered = false;
        });
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: widget.enabled ? (_) => _setPressed(true) : null,
        onTapUp: widget.enabled ? (_) => _setPressed(false) : null,
        onTapCancel: widget.enabled ? () => _setPressed(false) : null,
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: widget.itemPadding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _pressed
                ? ClayShadows.external(theme: theme, offset: 1, blur: 3)
                : const [],
          ),
          child: Row(
            children: [
              if (widget.icon != null) ...[
                IconTheme(
                  data: IconThemeData(color: color, size: 19),
                  child: widget.icon!,
                ),
                const SizedBox(width: 11),
              ],

              Expanded(
                child: ClayText.body(
                  widget.label,
                  color: color,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              if (widget.showShortcut && widget.shortcut != null) ...[
                const SizedBox(width: 16),
                _ClayShortcutLabel(
                  shortcut: widget.shortcut!,
                  color: color.withValues(alpha: 0.55),
                ),
              ],

              if (widget.trailing != null) ...[
                const SizedBox(width: 10),
                widget.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ClayShortcutLabel extends StatelessWidget {
  final ShortcutActivator shortcut;
  final Color color;

  const _ClayShortcutLabel({required this.shortcut, required this.color});

  @override
  Widget build(BuildContext context) {
    String text;

    if (shortcut is SingleActivator) {
      text = _singleActivatorText(shortcut as SingleActivator);
    } else {
      text = shortcut.debugDescribeKeys();
    }

    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
    );
  }

  String _singleActivatorText(SingleActivator activator) {
    final keys = <String>[];

    if (activator.control) {
      keys.add('Ctrl');
    }

    if (activator.meta) {
      keys.add('⌘');
    }

    if (activator.alt) {
      keys.add('Alt');
    }

    if (activator.shift) {
      keys.add('Shift');
    }

    keys.add(_keyName(activator.trigger));

    return keys.join(' + ');
  }

  String _keyName(LogicalKeyboardKey key) {
    final keyLabel = key.keyLabel;

    if (keyLabel.isNotEmpty) {
      return keyLabel.toUpperCase();
    }

    if (key == LogicalKeyboardKey.escape) {
      return 'Esc';
    }

    if (key == LogicalKeyboardKey.enter) {
      return 'Enter';
    }

    if (key == LogicalKeyboardKey.space) {
      return 'Space';
    }

    if (key == LogicalKeyboardKey.delete) {
      return 'Delete';
    }

    if (key == LogicalKeyboardKey.backspace) {
      return 'Backspace';
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      return '↑';
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      return '↓';
    }

    if (key == LogicalKeyboardKey.arrowLeft) {
      return '←';
    }

    if (key == LogicalKeyboardKey.arrowRight) {
      return '→';
    }

    return key.debugName ?? key.toString();
  }
}
