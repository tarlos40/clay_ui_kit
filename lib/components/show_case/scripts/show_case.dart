import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';

class ClayShowcase extends StatefulWidget {
  final String title;
  final String? description;

  final Widget preview;
  final String code;

  final bool initiallyShowCode;
  final bool showCode;
  final bool showCopyButton;

  final Widget? headerTrailing;

  final EdgeInsetsGeometry padding;

  const ClayShowcase({
    super.key,
    required this.title,
    required this.preview,
    required this.code,
    this.description,
    this.initiallyShowCode = false,
    this.showCode = true,
    this.showCopyButton = true,
    this.headerTrailing,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  State<ClayShowcase> createState() => _ClayShowcaseState();
}

class _ClayShowcaseState extends State<ClayShowcase> {
  late bool _showCode;

  @override
  void initState() {
    super.initState();
    _showCode = widget.initiallyShowCode;
  }

  void _toggleCode() {
    setState(() {
      _showCode = !_showCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: 24,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.container,
            borderRadius: BorderRadius.circular(24),
            boxShadow: ClayShadows.external(theme: theme, offset: 3, blur: 10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),

              if (widget.description != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: ClayText.body(
                    widget.description!,
                    color: theme.onBackground.withValues(alpha: 0.7),
                  ),
                ),

              if (widget.showCode && !_showCode) _buildPreview(context),

              if (widget.showCode && _showCode) _buildCode(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClayText.title(
              widget.title,
              color: theme.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (widget.headerTrailing != null) widget.headerTrailing!,

          if (widget.showCode)
            _ClayShowcaseButton(
              icon: _showCode ? Icons.code_off_rounded : Icons.code_rounded,
              label: _showCode ? 'Hide code' : 'View code',
              onPressed: _toggleCode,
            ),
        ],
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: 18,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Container(
          width: double.infinity,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(18),
            boxShadow: ClayShadows.external(theme: theme, offset: 2, blur: 5),
          ),
          child: Center(child: widget.preview),
        ),
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: 18,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(18),
            boxShadow: ClayShadows.external(theme: theme, offset: 2, blur: 5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildCodeHeader(context), _buildCodeContent(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeHeader(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      child: Row(
        children: [
          Icon(
            Icons.code_rounded,
            size: 18,
            color: theme.onBackground.withValues(alpha: 0.6),
          ),

          const SizedBox(width: 8),

          ClayText.label(
            'Code',
            color: theme.onBackground.withValues(alpha: 0.65),
            fontWeight: FontWeight.w600,
          ),

          const Spacer(),

          if (widget.showCopyButton)
            _ClayShowcaseButton(
              icon: Icons.copy_rounded,
              label: 'Copy',
              onPressed: _copyCode,
            ),
        ],
      ),
    );
  }

  Widget _buildCodeContent(BuildContext context) {
    final theme = context.clayTheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
      child: SelectableText(
        widget.code.trim(),
        style: TextStyle(
          color: theme.onBackground,
          fontFamily: 'monospace',
          fontSize: 13,
          height: 1.6,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
  }
}

class _ClayShowcaseButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ClayShowcaseButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_ClayShowcaseButton> createState() => _ClayShowcaseButtonState();
}

class _ClayShowcaseButtonState extends State<_ClayShowcaseButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _pressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _pressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _pressed = false;
          });
        },
        onTap: widget.onPressed,
        child: CustomPaint(
          foregroundPainter: ClayInnerShadowPainter(
            shadowColor: theme.shadow,
            lightColor: theme.light,
            borderRadius: 10,
            shadowSize: 2.5,
            blurRadius: 7.0,
          ),
          child: AnimatedScale(
            scale: _pressed ? 0.95 : 1,
            duration: const Duration(milliseconds: 100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: theme.container,
                borderRadius: BorderRadius.circular(10),
                boxShadow: ClayShadows.external(
                  theme: theme,
                  offset: _pressed ? 1 : 2,
                  blur: _pressed ? 3 : 5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 15, color: theme.onContainer),
                  const SizedBox(width: 6),
                  ClayText.label(
                    widget.label,
                    color: theme.onContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
