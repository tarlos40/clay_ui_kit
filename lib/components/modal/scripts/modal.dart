import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';
import '../../buttons/scripts/button.dart';
import '../../buttons/types/sizes.dart';

class ClayModal {
  ClayModal._();

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? description,
    Widget? child,
    List<Widget> actions = const [],
    Widget? leading,
    Color? backgroundColor,
    Color? foregroundColor,
    double maxWidth = 480,
    double radius = 28,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    bool barrierDismissible = true,
    bool showCloseButton = true,
    bool showDragHandle = false,
    bool scrollable = true,
    bool useSafeArea = true,
    bool closeOnEscape = true,
    MainAxisAlignment actionsAlignment = MainAxisAlignment.end,
    CrossAxisAlignment contentAlignment = CrossAxisAlignment.start,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      builder: (dialogContext) {
        return PopScope(
          canPop: closeOnEscape,
          child: _ClayModalContent(
            title: title,
            description: description,
            actions: actions,
            leading: leading,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            maxWidth: maxWidth,
            radius: radius,
            padding: padding,
            showCloseButton: showCloseButton,
            showDragHandle: showDragHandle,
            scrollable: scrollable,
            actionsAlignment: actionsAlignment,
            contentAlignment: contentAlignment,
            child: child,
          ),
        );
      },
    );
  }
}

class _ClayModalContent extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? child;
  final List<Widget> actions;
  final Widget? leading;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final double maxWidth;
  final double radius;

  final EdgeInsetsGeometry padding;

  final bool showCloseButton;
  final bool showDragHandle;
  final bool scrollable;

  final MainAxisAlignment actionsAlignment;
  final CrossAxisAlignment contentAlignment;

  const _ClayModalContent({
    required this.title,
    required this.description,
    required this.child,
    required this.actions,
    required this.leading,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.maxWidth,
    required this.radius,
    required this.padding,
    required this.showCloseButton,
    required this.showDragHandle,
    required this.scrollable,
    required this.actionsAlignment,
    required this.contentAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final background = backgroundColor ?? theme.container;
    final foreground = foregroundColor ?? theme.onContainer;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: contentAlignment,
      children: [
        if (showDragHandle)
          Center(
            child: Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: foreground.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),

        if (title != null || leading != null || showCloseButton)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leading != null) ...[
                IconTheme(
                  data: IconThemeData(color: foreground, size: 24),
                  child: leading!,
                ),
                const SizedBox(width: 12),
              ],

              if (title != null)
                Expanded(
                  child: ClayText.title(
                    title!,
                    color: foreground,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                const Spacer(),

              if (showCloseButton)
                ClayButton.icon(
                  Icon(
                    Icons.close_rounded,
                    color: foreground.withValues(alpha: 0.7),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                  size: ClayButtonSize.small,
                ),
            ],
          ),

        if (description != null) ...[
          SizedBox(height: title != null ? 10 : 4),
          Align(
            alignment: Alignment.centerLeft,
            child: ClayText.body(
              description!,
              color: foreground.withValues(alpha: 0.72),
            ),
          ),
        ],

        if (child != null) ...[
          if (title != null || description != null) const SizedBox(height: 20),
          if (scrollable)
            Flexible(child: SingleChildScrollView(child: child!))
          else
            child!,
        ],

        if (actions.isNotEmpty) ...[
          const SizedBox(height: 24),
          Wrap(
            alignment: _wrapAlignment(actionsAlignment),
            spacing: 10,
            runSpacing: 10,
            children: actions,
          ),
        ],
      ],
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: radius,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: ClayShadows.external(theme: theme, offset: 5, blur: 18),
          ),
          child: content,
        ),
      ),
      ),
    );
  }

  WrapAlignment _wrapAlignment(MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.start:
        return WrapAlignment.start;
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
    }
  }
}
