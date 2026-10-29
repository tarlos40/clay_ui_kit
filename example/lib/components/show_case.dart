import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class ShowCase extends StatefulWidget {
  final String title, description, code;
  final Widget? preview;
  final bool? showOnlyCode;
  final String? copyToastMessage;
  final IconData? icon;

  const ShowCase({
    super.key,
    required this.title,
    required this.description,
    required this.code,
    this.icon,
    this.showOnlyCode,
    this.copyToastMessage,
    this.preview,
  });

  @override
  State<ShowCase> createState() => _ShowCaseState();
}

class _ShowCaseState extends State<ShowCase> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayShowcase(
      title: widget.title,
      description: widget.description,
      code: widget.code,
      showOnlyCode: widget.showOnlyCode ?? false,
      copyToastMessage: widget.copyToastMessage ?? 'Code copied to clipboard',
      preview: widget.preview,
      headerTrailing: widget.icon != null
          ? CustomPaint(
              foregroundPainter: ClayInnerShadowPainter(
                shadowColor: theme.shadow,
                lightColor: theme.light,
                borderRadius: 12,
                shadowSize: 2.5,
                blurRadius: 7.0,
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: ClayShadows.external(
                    theme: theme,
                    offset: 2.5,
                    blur: 7,
                  ),
                ),
                child: HugeIcon(
                  icon: widget.icon!,
                  color: theme.onPrimary,
                  size: 32,
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
