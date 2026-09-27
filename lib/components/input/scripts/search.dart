import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';

class ClaySearchSuggestion {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final String? value;

  const ClaySearchSuggestion({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.value,
  });

  String get queryValue => value ?? title;
}

class ClaySearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final List<ClaySearchSuggestion> suggestions;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onQueryChanged;
  final ValueChanged<ClaySearchSuggestion>? onSuggestionSelected;
  final bool showSearchButton;
  final bool showSuggestionsOnFocus;
  final bool clearable;
  final int maxSuggestions;
  final String searchButtonLabel;
  final Widget? searchIcon;
  final Color? backgroundColor;
  final Color? accentColor;
  final Color? textColor;
  final Color? hintColor;
  final double borderRadius;

  const ClaySearchInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText = 'Search...',
    this.suggestions = const [],
    this.onSearch,
    this.onQueryChanged,
    this.onSuggestionSelected,
    this.showSearchButton = true,
    this.showSuggestionsOnFocus = true,
    this.clearable = true,
    this.maxSuggestions = 6,
    this.searchButtonLabel = 'Search',
    this.searchIcon,
    this.backgroundColor,
    this.accentColor,
    this.textColor,
    this.hintColor,
    this.borderRadius = 40,
  }) : assert(maxSuggestions > 0, 'maxSuggestions must be greater than zero.');

  @override
  State<ClaySearchInput> createState() => _ClaySearchInputState();
}

class _ClaySearchInputState extends State<ClaySearchInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _ownsController;
  late bool _ownsFocusNode;

  bool _focused = false;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _attachController(widget.controller);
    _attachFocusNode(widget.focusNode);
  }

  void _attachController(TextEditingController? controller) {
    _ownsController = controller == null;
    _controller = controller ?? TextEditingController();
    _controller.addListener(_handleControllerChanged);
  }

  void _attachFocusNode(FocusNode? focusNode) {
    _ownsFocusNode = focusNode == null;
    _focusNode = focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant ClaySearchInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_handleControllerChanged);
      if (_ownsController) _controller.dispose();
      _attachController(widget.controller);
    }

    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_handleFocusChanged);
      if (_ownsFocusNode) _focusNode.dispose();
      _attachFocusNode(widget.focusNode);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _focusNode.removeListener(_handleFocusChanged);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    if (!mounted) return;
    setState(() {});
  }

  void _handleFocusChanged() {
    if (!mounted) return;
    setState(() {
      _focused = _focusNode.hasFocus;
      _showSuggestions =
          _focusNode.hasFocus &&
          (widget.showSuggestionsOnFocus || _controller.text.isNotEmpty);
    });
  }

  List<ClaySearchSuggestion> get _filteredSuggestions {
    final query = _controller.text.trim().toLowerCase();
    final matches = widget.suggestions
        .where((suggestion) {
          if (query.isEmpty) return widget.showSuggestionsOnFocus;
          return suggestion.title.toLowerCase().contains(query) ||
              (suggestion.subtitle?.toLowerCase().contains(query) ?? false);
        })
        .take(widget.maxSuggestions)
        .toList();

    return matches;
  }

  void _submit() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    _hideSuggestions();
    _focusNode.unfocus();
    widget.onSearch?.call(query);
  }

  void _selectSuggestion(ClaySearchSuggestion suggestion) {
    _controller.value = TextEditingValue(
      text: suggestion.queryValue,
      selection: TextSelection.collapsed(offset: suggestion.queryValue.length),
    );
    widget.onQueryChanged?.call(suggestion.queryValue);
    widget.onSuggestionSelected?.call(suggestion);
    _hideSuggestions();
    _focusNode.unfocus();
  }

  void _clear() {
    _controller.clear();
    widget.onQueryChanged?.call('');
    setState(() {
      _showSuggestions = _focusNode.hasFocus && widget.showSuggestionsOnFocus;
    });
    _focusNode.requestFocus();
  }

  void _hideSuggestions() {
    if (!mounted) return;
    setState(() => _showSuggestions = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final background = widget.backgroundColor ?? theme.container;
    final accent = widget.accentColor ?? theme.primary;
    final foreground = widget.textColor ?? theme.onContainer;
    final hint = widget.hintColor ?? theme.onContainer.withValues(alpha: 0.48);
    final radius = BorderRadius.circular(widget.borderRadius);
    final suggestions = _filteredSuggestions;
    final showPanel = _showSuggestions && suggestions.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                widget.label!,
                style: TextStyle(
                  color: theme.onBackground,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: background,
              borderRadius: radius,
              boxShadow: [
                ...ClayShadows.external(theme: theme, offset: 1, blur: 4),
                if (_focused)
                  BoxShadow(
                    color: accent.withValues(alpha: 0.17),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
              ],
            ),
            child: CustomPaint(
              foregroundPainter: ClayInnerShadowPainter(
                shadowColor: theme.shadow,
                lightColor: theme.light,
                borderRadius: widget.borderRadius,
                shadowSize: _focused ? 2.5 : 2,
                blurRadius: 7,
              ),
              child: ClipRRect(
                borderRadius: radius,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.search_rounded,
                        size: 22,
                        color: _focused ? accent : hint,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() => _showSuggestions = true);
                          widget.onQueryChanged?.call(value);
                        },
                        onSubmitted: (_) => _submit(),
                        style: TextStyle(
                          color: foreground,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        cursorColor: accent,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(color: hint, fontSize: 14),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 17,
                          ),
                        ),
                      ),
                    ),
                    if (widget.clearable && _controller.text.isNotEmpty)
                      IconButton(
                        tooltip: 'Clear search',
                        onPressed: _clear,
                        icon: Icon(Icons.close_rounded, color: hint, size: 19),
                      ),
                    if (widget.showSearchButton)
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomPaint(
                          foregroundPainter: ClayInnerShadowPainter(
                            shadowColor: theme.shadow,
                            lightColor: theme.light,
                            borderRadius: widget.borderRadius - 5,
                            shadowSize: 2.5,
                            blurRadius: 7.0,
                          ),
                          child: Material(
                            color: accent,
                            borderRadius: BorderRadius.circular(
                              (widget.borderRadius - 5)
                                  .clamp(8.0, 30.0)
                                  .toDouble(),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                (widget.borderRadius - 5)
                                    .clamp(8.0, 30.0)
                                    .toDouble(),
                              ),
                              onTap: _submit,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 42,
                                  minWidth: 44,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widget.searchButtonLabel.isEmpty
                                        ? 0
                                        : 14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconTheme(
                                        data: IconThemeData(
                                          color: theme.onPrimary,
                                          size: 19,
                                        ),
                                        child:
                                            widget.searchIcon ??
                                            const Icon(
                                              Icons.arrow_forward_rounded,
                                            ),
                                      ),
                                      if (widget
                                          .searchButtonLabel
                                          .isNotEmpty) ...[
                                        const SizedBox(width: 7),
                                        Text(
                                          widget.searchButtonLabel,
                                          style: TextStyle(
                                            color: theme.onPrimary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ],
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
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: showPanel
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CustomPaint(
                      foregroundPainter: ClayInnerShadowPainter(
                        shadowColor: theme.shadow,
                        lightColor: theme.light,
                        borderRadius: 18,
                        shadowSize: 2.5,
                        blurRadius: 7.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: ClayShadows.external(
                            theme: theme,
                            offset: 1,
                            blur: 7,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (
                                var index = 0;
                                index < suggestions.length;
                                index++
                              ) ...[
                                if (index > 0)
                                  Divider(
                                    height: 1,
                                    indent: 14,
                                    endIndent: 14,
                                    color: theme.onBackground.withValues(
                                      alpha: 0.07,
                                    ),
                                  ),
                                _SuggestionTile(
                                  suggestion: suggestions[index],
                                  foreground: foreground,
                                  secondary: hint,
                                  accent: accent,
                                  onTap: () =>
                                      _selectSuggestion(suggestions[index]),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  final ClaySearchSuggestion suggestion;
  final Color foreground;
  final Color secondary;
  final Color accent;
  final VoidCallback onTap;

  const _SuggestionTile({
    required this.suggestion,
    required this.foreground,
    required this.secondary,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              if (suggestion.leading != null) ...[
                IconTheme(
                  data: IconThemeData(color: secondary, size: 20),
                  child: suggestion.leading!,
                ),
                const SizedBox(width: 12),
              ] else ...[
                Icon(Icons.search_rounded, color: secondary, size: 19),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      suggestion.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (suggestion.subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        suggestion.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: secondary, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              if (suggestion.trailing != null) ...[
                const SizedBox(width: 8),
                IconTheme(
                  data: IconThemeData(color: accent, size: 18),
                  child: suggestion.trailing!,
                ),
              ] else
                Icon(
                  Icons.north_west_rounded,
                  size: 16,
                  color: secondary.withValues(alpha: 0.8),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
