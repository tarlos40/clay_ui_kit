import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';
import '../../../palette/types/colors.dart';

class ClayInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? errorColor;

  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool password;
  final bool clearable;

  final int? maxLength;
  final int? maxLines;
  final int? minLines;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? padding;

  final double borderRadius;

  const ClayInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.errorColor,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.password = false,
    this.clearable = true,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.padding,
    this.borderRadius = 40,
  }) : assert(
         !password || maxLines == 1,
         'ClayInput: password inputs cannot have multiple lines.',
       );

  const ClayInput.textArea({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.errorColor,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.password = false,
    this.clearable = true,
    this.maxLength,
    this.maxLines = 5,
    this.minLines = 3,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.textCapitalization = TextCapitalization.sentences,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.padding,
    this.borderRadius = 18,
  });

  @override
  State<ClayInput> createState() => _ClayInputState();
}

class _ClayInputState extends State<ClayInput>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  late final bool _ownsController;
  late final bool _ownsFocusNode;

  bool _obscured = false;
  bool _focused = false;

  @override
  void initState() {
    super.initState();

    _ownsController = widget.controller == null;
    _ownsFocusNode = widget.focusNode == null;

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _obscured = widget.password || widget.obscureText;

    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);

    if (_ownsController) {
      _controller.dispose();
    }

    if (_ownsFocusNode) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  void _handleFocusChange() {
    if (!mounted) return;

    setState(() {
      _focused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    if (!mounted) return;

    setState(() {});
  }

  void _togglePassword() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  void _clear() {
    _controller.clear();

    widget.onChanged?.call('');

    _focusNode.requestFocus();
  }

  bool get _hasError {
    return widget.errorText != null && widget.errorText!.trim().isNotEmpty;
  }

  bool get _isMultiline {
    return widget.maxLines == null || widget.maxLines! > 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final errorColor = widget.errorColor ?? ClayColors.ruby;

    final background = widget.backgroundColor ?? theme.container;

    final textColor = widget.textColor ?? theme.onContainer;

    final hintColor =
        widget.hintColor ?? theme.onContainer.withValues(alpha: 0.45);

    final labelColor = widget.labelColor ?? theme.onContainer;

    final activeColor = _hasError ? errorColor : theme.primary;

    final borderRadius = BorderRadius.circular(widget.borderRadius);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            ClayText.label(
              widget.label!,
              color: labelColor.withValues(alpha: widget.enabled ? 1 : 0.45),
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 8),
          ],

          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: background,
              borderRadius: borderRadius,
              boxShadow: _buildOuterShadow(theme, activeColor),
            ),
            child: CustomPaint(
              foregroundPainter: ClayInnerShadowPainter(
                shadowColor: theme.shadow,
                lightColor: theme.light,
                borderRadius: widget.borderRadius,
                shadowSize: _focused || _hasError ? 2.5 : 2,
                blurRadius: _focused || _hasError ? 7 : 8,
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: _buildTextField(
                  context,
                  theme: theme,
                  textColor: textColor,
                  hintColor: hintColor,
                  activeColor: activeColor,
                ),
              ),
            ),
          ),

          if (widget.helperText != null && !_hasError) ...[
            const SizedBox(height: 7),
            ClayText.label(
              widget.helperText!,
              color: theme.onBackground.withValues(alpha: 0.55),
            ),
          ],

          if (_hasError) ...[
            const SizedBox(height: 7),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Row(
                key: ValueKey(widget.errorText),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 16,
                    color: errorColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: ClayText.label(widget.errorText!, color: errorColor),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<BoxShadow> _buildOuterShadow(dynamic theme, Color activeColor) {
    if (_hasError) {
      return [
        ...ClayShadows.external(theme: theme, offset: 1, blur: 4),
        BoxShadow(
          color: activeColor.withValues(alpha: 0.16),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ];
    }

    if (_focused) {
      return [
        ...ClayShadows.external(theme: theme, offset: 1, blur: 4),
        BoxShadow(
          color: activeColor.withValues(alpha: 0.16),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ];
    }

    return ClayShadows.external(theme: theme, offset: 2, blur: 6);
  }

  Widget _buildTextField(
    BuildContext context, {
    required dynamic theme,
    required Color textColor,
    required Color hintColor,
    required Color activeColor,
  }) {
    final effectiveSuffix = _buildSuffix(context, theme, activeColor);

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscured,
      maxLength: widget.maxLength,
      maxLines: _obscured ? 1 : widget.maxLines,
      minLines: widget.minLines,
      keyboardType:
          widget.keyboardType ??
          (_isMultiline ? TextInputType.multiline : TextInputType.text),
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      style: TextStyle(
        color: textColor.withValues(alpha: widget.enabled ? 1 : 0.45),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: activeColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 14, right: 4),
                child: IconTheme(
                  data: IconThemeData(
                    color: _focused
                        ? activeColor
                        : theme.onBackground.withValues(alpha: 0.55),
                    size: 21,
                  ),
                  child: widget.prefixIcon!,
                ),
              ),
        suffixIcon: effectiveSuffix,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding:
            widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 16,
              vertical: _isMultiline ? 16 : 15,
            ),
        counterText: '',
      ),
    );
  }

  Widget? _buildSuffix(BuildContext context, dynamic theme, Color activeColor) {
    final List<Widget> actions = [];

    if (widget.password) {
      actions.add(
        _ClayInputIconButton(
          icon: _obscured
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          tooltip: _obscured ? 'Show password' : 'Hide password',
          onPressed: _togglePassword,
          color: theme.onBackground,
        ),
      );
    }

    if (widget.clearable && _controller.text.isNotEmpty) {
      actions.add(
        _ClayInputIconButton(
          icon: Icons.close_rounded,
          tooltip: 'Clear',
          onPressed: _clear,
          color: theme.onBackground,
        ),
      );
    }

    if (widget.suffixIcon != null) {
      actions.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconTheme(
            data: IconThemeData(
              color: theme.onBackground.withValues(alpha: 0.55),
              size: 21,
            ),
            child: widget.suffixIcon!,
          ),
        ),
      );
    }

    if (actions.isEmpty) {
      return null;
    }

    return Row(mainAxisSize: MainAxisSize.min, children: actions);
  }
}

class _ClayInputIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color color;

  const _ClayInputIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        splashRadius: 20,
        icon: Icon(icon, size: 19, color: color.withValues(alpha: 0.65)),
      ),
    );
  }
}
