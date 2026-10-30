import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/scripts/context.dart';
import '../../text/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';
import '../../toast/scripts/toast.dart';
import '../../toast/types/positions.dart';
import '../../../palette/types/colors.dart';

class ClayShowcase extends StatefulWidget {
  final String title;
  final String? description;

  final Widget? preview;
  final String code;
  final String? fileName;
  final String? codeLanguage;

  final bool initiallyShowCode;
  final bool showCode;
  final bool showCopyButton;
  final bool showOnlyCode;
  final String? copyToastMessage;

  final Widget? headerTrailing;

  final EdgeInsetsGeometry padding;

  const ClayShowcase({
    super.key,
    required this.title,
    required this.code,
    this.fileName,
    this.codeLanguage,
    this.preview,
    this.description,
    this.initiallyShowCode = false,
    this.showCode = true,
    this.showOnlyCode = false,
    this.showCopyButton = true,
    this.copyToastMessage = 'Code copied to clipboard',
    this.headerTrailing,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  State<ClayShowcase> createState() => _ClayShowcaseState();
}

class _ClayShowcaseState extends State<ClayShowcase> {
  late bool _showCode;
  late bool _showOnlyCode;

  @override
  void initState() {
    super.initState();
    _showOnlyCode = widget.showOnlyCode;
    _showCode = widget.showOnlyCode || widget.initiallyShowCode;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ClayToast.init(context);
    });
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
            boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 4),
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

              if (widget.showCode && !_showCode && !_showOnlyCode)
                _buildPreview(context),

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

          if (widget.showCode && !widget.showOnlyCode)
            _ClayShowcaseButton(
              icon: _showCode
                  ? Icon(Icons.code_off_rounded)
                  : Icon(Icons.code_rounded),
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
            boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 4),
          ),
          child: Center(child: widget.preview),
        ),
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    final theme = context.clayTheme;
    final palette = context.clayPalette;

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
            color: theme.isDark ? palette.s100 : palette.s950,
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
    final safeTitle = widget.title.isEmpty ? 'component' : widget.title;
    final fileNameValue =
        widget.fileName ??
        '${safeTitle.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}.dart';
    final safeFileName = fileNameValue.trim();
    final languageValue = widget.codeLanguage ?? 'dart';
    final safeLanguage = languageValue.trim().isEmpty
        ? 'dart'
        : languageValue.trim().toLowerCase();

    final palette = context.clayPalette;
    final theme = context.clayTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
      decoration: BoxDecoration(
        color: theme.isDark ? palette.s100 : palette.s950,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(
            color: theme.isDark
                ? palette.s950.withValues(alpha: .2)
                : palette.s50.withValues(alpha: .2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: theme.isDark ? palette.s300 : palette.s800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.code_rounded,
                    size: 14,
                    color: theme.isDark ? palette.s950 : palette.s50,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      safeFileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.jetBrainsMono(
                        color: theme.isDark ? palette.s950 : palette.s50,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.isDark ? palette.s200 : palette.s900,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              safeLanguage,
              style: GoogleFonts.jetBrainsMono(
                color: theme.isDark ? palette.s500 : palette.s600,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const Spacer(),

          if (widget.showCopyButton)
            GestureDetector(
              onTap: _copyCode,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.isDark ? palette.s200 : palette.s900,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.isDark ? palette.s300 : palette.s800,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.copy_rounded,
                      size: 14,
                      color: theme.isDark ? palette.s950 : palette.s50,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Copy',
                      style: GoogleFonts.jetBrainsMono(
                        color: theme.isDark ? palette.s950 : palette.s50,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCodeContent(BuildContext context) {
    final lines = widget.code.trim().split('\n');
    final theme = context.clayTheme;
    final palette = context.clayPalette;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.isDark ? palette.s100 : palette.s950,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(12, 8, 16, 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(lines.length, (index) {
                  return Text(
                    '${index + 1}',
                    style: GoogleFonts.jetBrainsMono(
                      color: theme.isDark
                          ? palette.s950.withValues(alpha: .7)
                          : palette.s50.withValues(alpha: .7),
                      fontSize: 11,
                      height: 1.75,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: MediaQuery.sizeOf(context).width > 760
                  ? MediaQuery.sizeOf(context).width
                  : 760,
              child: SelectableText.rich(
                _DartCodeSyntaxHighlight(context, widget.code.trim()),
                style: GoogleFonts.jetBrainsMono(
                  color: theme.isDark ? palette.s950 : palette.s50,
                  fontSize: 12.5,
                  height: 1.7,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.code));

    if (!mounted) return;

    ClayToast.init(context);

    final message = (widget.copyToastMessage ?? '').trim();
    ClayToast.success(
      message.isEmpty ? 'Code copied to clipboard' : message,
      position: ClayToastPosition.topCenter,
      duration: const Duration(seconds: 2),
    );
  }
}

class _DartCodeSyntaxHighlight extends TextSpan {
  _DartCodeSyntaxHighlight(BuildContext context, String source)
    : super(
        children: _buildSpans(context, source),
        style: TextStyle(
          color: context.clayTheme.isDark
              ? context.clayPalette.s950
              : context.clayPalette.s50,
          fontFamily: 'monospace',
        ),
      );

  static List<TextSpan> _buildSpans(BuildContext context, String source) {
    final spans = <TextSpan>[];
    final pattern = RegExp(
      r'''(///.*|//.*|/\*.*?\*/|"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|\b(?:abstract|as|assert|await|break|case|catch|class|const|continue|covariant|default|deferred|do|else|enum|extends|false|final|finally|for|if|implements|import|in|interface|is|late|library|mixin|new|null|on|operator|part|rethrow|return|set|show|static|super|switch|sync|this|throw|true|try|typedef|var|void|while|with|yield)\b|\b(?:bool|double|dynamic|int|String|List|Map|Set|Widget|BuildContext|VoidCallback|Color|IconData|EdgeInsetsGeometry)\b|\b\d+(?:\.\d+)?\b|[{}()[\].,;:+\-*/%<>=!&|?]+|\s+)''',
      multiLine: true,
      dotAll: true,
    );

    final matches = pattern.allMatches(source);
    var cursor = 0;

    for (final match in matches) {
      if (match.start > cursor) {
        spans.add(_baseSpan(context, source.substring(cursor, match.start)));
      }

      final token = match.group(0)!;
      spans.add(_spanForToken(context, token));
      cursor = match.end;
    }

    if (cursor < source.length) {
      spans.add(_baseSpan(context, source.substring(cursor)));
    }

    return spans;
  }

  static TextSpan _baseSpan(BuildContext context, String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: context.clayTheme.isDark
            ? context.clayPalette.s950
            : context.clayPalette.s50,
        fontWeight: .w600,
      ),
    );
  }

  static TextSpan _spanForToken(BuildContext context, String token) {
    if (token.trim().isEmpty) {
      return _baseSpan(context, token);
    }

    final trimmed = token.trim();

    if (trimmed.startsWith('//') || trimmed.startsWith('///')) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? context.clayPalette.s950
              : context.clayPalette.s50,
        ),
      );
    }

    if (trimmed.startsWith('/*') || trimmed.endsWith('*/')) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? context.clayPalette.s950
              : context.clayPalette.s50,
        ),
      );
    }

    if ((token.startsWith('"') && token.endsWith('"')) ||
        (token.startsWith("'") && token.endsWith("'"))) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? ClayColors.amber.s800
              : ClayColors.amber.s400,
        ),
      );
    }

    if (RegExp(r'^\d+(?:\.\d+)?$').hasMatch(trimmed)) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? context.clayPalette.s950
              : context.clayPalette.s50,
        ),
      );
    }

    if (RegExp(
      r'^(?:abstract|as|assert|await|break|case|catch|class|const|continue|covariant|default|deferred|do|else|enum|extends|false|final|finally|for|if|implements|import|in|interface|is|late|library|mixin|new|null|on|operator|part|rethrow|return|set|show|static|super|switch|sync|this|throw|true|try|typedef|var|void|while|with|yield)$',
    ).hasMatch(trimmed)) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? ClayColors.ruby.s600
              : ClayColors.ruby.s800,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    if (RegExp(
      r'^(?:bool|double|dynamic|int|String|List|Map|Set|Widget|BuildContext|VoidCallback|Color|IconData|EdgeInsetsGeometry)$',
    ).hasMatch(trimmed)) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? ClayColors.cobalt.s600
              : ClayColors.cobalt.s800,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    if (RegExp(r'^[A-Z][A-Za-z0-9_]*$').hasMatch(trimmed)) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? ClayColors.forest.s400
              : ClayColors.forest.s800,
        ),
      );
    }

    if (RegExp(r'^[{}()[\].,;:+\-*/%<>=!&|?]+$').hasMatch(trimmed)) {
      return TextSpan(
        text: token,
        style: TextStyle(
          color: context.clayTheme.isDark
              ? ClayColors.rose.s600
              : ClayColors.rose.s800,
        ),
      );
    }

    return TextSpan(
      text: token,
      style: TextStyle(
        color: context.clayTheme.isDark
            ? context.clayPalette.s950
            : context.clayPalette.s50,
      ),
    );
  }
}

class _ClayShowcaseButton extends StatefulWidget {
  final Widget icon;
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
                  IconTheme(
                    data: IconThemeData(size: 15, color: theme.onContainer),
                    child: widget.icon,
                  ),
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
