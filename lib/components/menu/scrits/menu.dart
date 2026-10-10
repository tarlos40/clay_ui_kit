import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';

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
  final Color? borderColor;

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
    this.borderColor,
    this.width = 220,
    this.radius = 18,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.showShortcuts = true,
    this.closeOnSelection = true,
    this.enableShortcuts = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<ClayMenu> createState() => _ClayMenuState();
}

class _ClayMenuState extends State<ClayMenu>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode(debugLabel: 'ClayMenu');
  final GlobalKey _triggerKey = GlobalKey();

  OverlayEntry? _overlayEntry;

  late final AnimationController _animationController;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  bool _closing = false;
  bool _hoveringTrigger = false;
  bool _hoveringMenu = false;
  bool _closeScheduled = false;

  int _focusedIndex = -1;

  bool get _isDesktop =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS;

  bool get _isOpen => _overlayEntry != null;

  List<int> get _actionIndices => [
    for (var i = 0; i < widget.items.length; i++)
      if (!_isDivider(widget.items[i]) &&
          widget.items[i].enabled &&
          widget.items[i].onPressed != null)
        i,
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: const Duration(milliseconds: 140),
    );

    _opacity = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _scale = Tween<double>(begin: 0.94, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _slide = Tween<Offset>(begin: const Offset(0, -0.035), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void didUpdateWidget(covariant ClayMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_isOpen) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  bool _isDivider(ClayMenuItem item) {
    return item.label.isEmpty &&
        item.icon == null &&
        item.trailing == null &&
        item.shortcut == null &&
        item.onPressed == null;
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
    if (!_isDesktop || !widget.triggers.contains(ClayMenuTrigger.hover)) {
      return;
    }

    _hoveringTrigger = value;

    if (value) {
      _open();
    } else {
      _scheduleHoverClose();
    }
  }

  void _scheduleHoverClose() {
    if (_closeScheduled) return;

    _closeScheduled = true;

    Future<void>.delayed(const Duration(milliseconds: 100), () {
      _closeScheduled = false;

      if (!mounted || !_isOpen) return;

      if (!_hoveringTrigger && !_hoveringMenu) {
        _close();
      }
    });
  }

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    if (_isOpen || !mounted || widget.items.isEmpty) return;

    final overlay = Overlay.of(context, rootOverlay: true);

    _closing = false;
    _focusedIndex = -1;

    _overlayEntry = OverlayEntry(builder: (context) => _buildOverlay(context));

    overlay.insert(_overlayEntry!);

    _animationController.forward(from: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_isOpen) return;

      _overlayEntry?.markNeedsBuild();
    });
  }

  Future<void> _close() async {
    if (!_isOpen || _closing) return;

    _closing = true;

    await _animationController.reverse();

    if (!mounted) return;

    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;

    _hoveringMenu = false;
    _focusedIndex = -1;

    _focusNode.unfocus();

    if (mounted) {
      setState(() {});
    }
  }

  void _selectItem(ClayMenuItem item) {
    if (!item.enabled || item.onPressed == null) return;

    item.onPressed!.call();

    if (widget.closeOnSelection) {
      _close();
    }
  }

  void _moveFocus(int direction) {
    final indices = _actionIndices;

    if (indices.isEmpty) return;

    final currentPosition = indices.indexOf(_focusedIndex);

    final nextPosition = currentPosition == -1
        ? (direction > 0 ? 0 : indices.length - 1)
        : (currentPosition + direction) % indices.length;

    final normalizedPosition = (nextPosition + indices.length) % indices.length;

    setState(() {
      _focusedIndex = indices[normalizedPosition];
    });

    _overlayEntry?.markNeedsBuild();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent || !_isOpen) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.escape) {
      _close();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowDown) {
      _moveFocus(1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowUp) {
      _moveFocus(-1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.home) {
      _focusedIndex = -1;
      _moveFocus(1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.end) {
      _focusedIndex = -1;
      _moveFocus(-1);
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
      if (_focusedIndex >= 0 && _focusedIndex < widget.items.length) {
        _selectItem(widget.items[_focusedIndex]);
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  Map<ShortcutActivator, VoidCallback> _shortcutBindings() {
    final bindings = <ShortcutActivator, VoidCallback>{};

    if (!widget.enableShortcuts) return bindings;

    for (final item in widget.items) {
      if (item.shortcut == null || !item.enabled || item.onPressed == null) {
        continue;
      }

      bindings[item.shortcut!] = () {
        _selectItem(item);
      };
    }

    return bindings;
  }

  Widget _buildOverlay(BuildContext overlayContext) {
    final theme = context.clayTheme;

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _close,
              child: const SizedBox.expand(),
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 8),
            child: Material(
              type: MaterialType.transparency,
              child: Focus(
                focusNode: _focusNode,
                autofocus: true,
                onKeyEvent: _handleKeyEvent,
                child: MouseRegion(
                  onEnter: (_) {
                    _hoveringMenu = true;
                  },
                  onExit: (_) {
                    _hoveringMenu = false;
                    _scheduleHoverClose();
                  },
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, _) {
                      return Opacity(
                        opacity: _opacity.value,
                        child: Transform.translate(
                          offset: _slide.value * 100,
                          child: Transform.scale(
                            scale: _scale.value,
                            alignment: Alignment.topLeft,
                            child: _buildPanel(theme),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel(dynamic theme) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.width,
        maxWidth: math.max(widget.width, 240),
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: widget.radius,
          shadowSize: 2.5,
          blurRadius: 7,
        ),
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? theme.container,
            borderRadius: BorderRadius.circular(widget.radius),
            border: widget.borderColor == null
                ? null
                : Border.all(color: widget.borderColor!, width: 1),
            boxShadow: ClayShadows.external(theme: theme, offset: 5, blur: 16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < widget.items.length; i++)
                  if (_isDivider(widget.items[i]))
                    _buildDivider(theme)
                  else
                    _buildItem(widget.items[i], i, theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(dynamic theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.shadow.withValues(alpha: 0.12),
      ),
    );
  }

  Widget _buildItem(ClayMenuItem item, int index, dynamic theme) {
    final enabled = item.enabled && item.onPressed != null;

    final foreground = item.destructive
        ? theme.error
        : widget.foregroundColor ?? theme.onContainer;

    return _ClayMenuEntry(
      key: ValueKey('clay-menu-$index'),
      label: item.label,
      icon: item.icon,
      trailing: item.trailing,
      shortcut: item.shortcut,
      enabled: enabled,
      selected: _focusedIndex == index,
      foregroundColor: foreground,
      itemPadding: widget.itemPadding,
      showShortcut: widget.showShortcuts,
      animationDuration: widget.animationDuration,
      onHover: (hovered) {
        if (hovered && enabled) {
          setState(() {
            _focusedIndex = index;
          });
          _overlayEntry?.markNeedsBuild();
        }
      },
      onPressed: enabled ? () => _selectItem(item) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final shortcuts = _shortcutBindings();

    return CallbackShortcuts(
      bindings: shortcuts,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Focus(
          canRequestFocus: false,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => _handleHover(true),
            onExit: (_) {
              _hoveringTrigger = false;
              _scheduleHoverClose();
            },
            child: GestureDetector(
              key: _triggerKey,
              behavior: HitTestBehavior.opaque,
              onTap: widget.triggers.contains(ClayMenuTrigger.tap)
                  ? _handleTap
                  : null,
              onLongPress: widget.triggers.contains(ClayMenuTrigger.longPress)
                  ? _handleLongPress
                  : null,
              onSecondaryTap:
                  widget.triggers.contains(ClayMenuTrigger.secondaryTap)
                  ? _handleSecondaryTap
                  : null,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class _ClayMenuEntry extends StatefulWidget {
  final String label;
  final Widget? icon;
  final Widget? trailing;
  final ShortcutActivator? shortcut;

  final bool enabled;
  final bool selected;

  final Color foregroundColor;
  final EdgeInsetsGeometry itemPadding;
  final bool showShortcut;

  final Duration animationDuration;

  final ValueChanged<bool>? onHover;
  final VoidCallback? onPressed;

  const _ClayMenuEntry({
    super.key,
    required this.label,
    required this.icon,
    required this.trailing,
    required this.shortcut,
    required this.enabled,
    required this.selected,
    required this.foregroundColor,
    required this.itemPadding,
    required this.showShortcut,
    required this.animationDuration,
    this.onHover,
    this.onPressed,
  });

  @override
  State<_ClayMenuEntry> createState() => _ClayMenuEntryState();
}

class _ClayMenuEntryState extends State<_ClayMenuEntry> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  void didUpdateWidget(covariant _ClayMenuEntry oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.enabled) {
      _hovered = false;
      _pressed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final active = _hovered || widget.selected;
    final color = widget.enabled
        ? widget.foregroundColor
        : widget.foregroundColor.withValues(alpha: 0.35);

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

          widget.onHover?.call(true);
        },
        onExit: (_) {
          setState(() {
            _hovered = false;
          });

          widget.onHover?.call(false);
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: widget.enabled
              ? (_) => setState(() => _pressed = true)
              : null,
          onTapUp: widget.enabled
              ? (_) => setState(() => _pressed = false)
              : null,
          onTapCancel: widget.enabled
              ? () => setState(() => _pressed = false)
              : null,
          onTap: widget.onPressed,
          child: AnimatedScale(
            scale: _pressed ? 0.985 : 1,
            duration: const Duration(milliseconds: 110),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeOutCubic,
              padding: widget.itemPadding,
              decoration: BoxDecoration(
                color: active
                    ? theme.primary.withValues(alpha: 0.09)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: _pressed
                    ? ClayShadows.external(theme: theme, offset: 1, blur: 3)
                    : null,
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
                    const SizedBox(width: 12),
                    _ClayShortcutLabel(
                      shortcut: widget.shortcut!,
                      color: color.withValues(alpha: 0.58),
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
    final text = shortcut is SingleActivator
        ? _singleActivatorText(shortcut as SingleActivator)
        : shortcut.debugDescribeKeys();

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

    if (activator.control) keys.add('Ctrl');
    if (activator.meta) keys.add('⌘');
    if (activator.alt) keys.add('Alt');
    if (activator.shift) keys.add('Shift');

    keys.add(_keyName(activator.trigger));

    return keys.join(' + ');
  }

  String _keyName(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.escape) return 'Esc';
    if (key == LogicalKeyboardKey.enter) return 'Enter';
    if (key == LogicalKeyboardKey.space) return 'Space';
    if (key == LogicalKeyboardKey.delete) return 'Delete';
    if (key == LogicalKeyboardKey.backspace) return 'Backspace';
    if (key == LogicalKeyboardKey.arrowUp) return '↑';
    if (key == LogicalKeyboardKey.arrowDown) return '↓';
    if (key == LogicalKeyboardKey.arrowLeft) return '←';
    if (key == LogicalKeyboardKey.arrowRight) return '→';

    final label = key.keyLabel;

    if (label.isNotEmpty) {
      return label.toUpperCase();
    }

    return key.debugName ?? key.toString();
  }
}
