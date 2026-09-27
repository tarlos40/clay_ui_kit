import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';
import '../types/positions.dart';

class ClayTooltip extends StatefulWidget {
  final Widget child;
  final String? message;
  final Widget? content;

  final ClayTooltipPosition position;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final EdgeInsetsGeometry padding;
  final double radius;
  final double maxWidth;
  final double offset;

  final Duration waitDuration;
  final Duration showDuration;

  final bool enabled;
  final bool preferBelow;

  const ClayTooltip({
    super.key,
    required this.child,
    this.message,
    this.content,
    this.position = ClayTooltipPosition.top,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    this.radius = 12,
    this.maxWidth = 260,
    this.offset = 8,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(seconds: 3),
    this.enabled = true,
    this.preferBelow = false,
  }) : assert(
         message != null || content != null,
         'ClayTooltip: provide a message or custom content.',
       );

  @override
  State<ClayTooltip> createState() => _ClayTooltipState();
}

class _ClayTooltipState extends State<ClayTooltip> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  Timer? _showTimer;
  Timer? _hideTimer;

  bool _hovering = false;

  bool get _isDesktop {
    final platform = Theme.of(context).platform;

    return platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS;
  }

  @override
  void didUpdateWidget(covariant ClayTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.enabled ||
        oldWidget.message != widget.message ||
        oldWidget.content != widget.content ||
        oldWidget.position != widget.position) {
      _hideImmediately();
    }
  }

  void _scheduleShow() {
    if (!widget.enabled) return;

    _showTimer?.cancel();
    _hideTimer?.cancel();

    _showTimer = Timer(widget.waitDuration, _show);
  }

  void _show() {
    if (!mounted || !widget.enabled || _overlayEntry != null) return;

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) => _buildOverlay(overlayContext),
    );

    overlay.insert(_overlayEntry!);

    if (!_hovering || !_isDesktop) {
      _hideTimer = Timer(widget.showDuration, _hideImmediately);
    }
  }

  void _scheduleHide() {
    _showTimer?.cancel();

    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 100), _hideImmediately);
  }

  void _hideImmediately() {
    _showTimer?.cancel();
    _hideTimer?.cancel();

    _showTimer = null;
    _hideTimer = null;

    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  void _handlePointerEnter(PointerEvent event) {
    _hovering = true;

    if (_isDesktop) {
      _scheduleShow();
    }
  }

  void _handlePointerExit(PointerEvent event) {
    _hovering = false;

    if (_isDesktop) {
      _scheduleHide();
    }
  }

  void _handleLongPress() {
    _showTimer?.cancel();
    _show();
  }

  Widget _buildOverlay(BuildContext overlayContext) {
    final theme = context.clayTheme;

    final background = widget.backgroundColor ?? theme.container;
    final foreground = widget.foregroundColor ?? theme.onContainer;

    final anchors = _anchors();

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: anchors.$1,
              followerAnchor: anchors.$2,
              offset: _offsetForPosition(),
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: widget.maxWidth),
                  child: CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      borderRadius: widget.radius,
                      shadowSize: 2.5,
                      blurRadius: 7.0,
                    ),
                    child: Container(
                      padding: widget.padding,
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(widget.radius),
                        boxShadow: ClayShadows.external(
                          theme: theme,
                          offset: 3,
                          blur: 9,
                        ),
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: foreground,
                          fontSize: 12,
                          height: 1.35,
                        ),
                        child: IconTheme(
                          data: IconThemeData(color: foreground, size: 16),
                          child:
                              widget.content ??
                              ClayText.label(
                                widget.message!,
                                color: foreground,
                                fontWeight: FontWeight.w500,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  (Alignment, Alignment) _anchors() {
    switch (widget.position) {
      case ClayTooltipPosition.top:
        return (Alignment.topCenter, Alignment.bottomCenter);

      case ClayTooltipPosition.bottom:
        return (Alignment.bottomCenter, Alignment.topCenter);

      case ClayTooltipPosition.left:
        return (Alignment.centerLeft, Alignment.centerRight);

      case ClayTooltipPosition.right:
        return (Alignment.centerRight, Alignment.centerLeft);
    }
  }

  Offset _offsetForPosition() {
    switch (widget.position) {
      case ClayTooltipPosition.top:
        return Offset(0, -widget.offset);

      case ClayTooltipPosition.bottom:
        return Offset(0, widget.offset);

      case ClayTooltipPosition.left:
        return Offset(-widget.offset, 0);

      case ClayTooltipPosition.right:
        return Offset(widget.offset, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: _handlePointerEnter,
        onExit: _handlePointerExit,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onLongPress: widget.enabled ? _handleLongPress : null,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _showTimer?.cancel();
    _hideTimer?.cancel();

    _overlayEntry?.remove();
    _overlayEntry?.dispose();

    super.dispose();
  }
}
