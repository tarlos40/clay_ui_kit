import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../theme/scripts/shadows.dart';
import '../class/props_table.dart';

class ClayPropsTable extends StatelessWidget {
  final List<ClayProp> props;

  final String? title;

  final bool showType;
  final bool showDefault;
  final bool showRequired;

  final EdgeInsetsGeometry padding;

  const ClayPropsTable({
    super.key,
    required this.props,
    this.title,
    this.showType = true,
    this.showDefault = true,
    this.showRequired = true,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: 22,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.container,
            borderRadius: BorderRadius.circular(22),
            boxShadow: ClayShadows.external(theme: theme, offset: 3, blur: 10),
          ),
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                ClayText.title(title!, color: theme.onBackground),
                const SizedBox(height: 16),
              ],

              _buildTable(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),

              for (int i = 0; i < props.length; i++)
                _buildRow(context, props[i], index: i),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = context.clayTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: theme.background),
      child: Row(
        children: [
          _headerCell(context, 'Property', width: 150),

          if (showType) _headerCell(context, 'Type', width: 150),

          if (showDefault) _headerCell(context, 'Default', width: 150),

          if (showRequired) _headerCell(context, 'Required', width: 90),

          _headerCell(context, 'Description', width: 320),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, ClayProp prop, {required int index}) {
    final theme = context.clayTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: index.isEven
            ? theme.container
            : theme.background.withValues(alpha: 0.45),
        border: Border(
          top: BorderSide(color: theme.shadow.withValues(alpha: 0.08)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _propertyName(context, prop.name, width: 150),

          if (showType) _propertyCode(context, prop.type, width: 150),

          if (showDefault)
            _propertyCode(context, prop.defaultValue ?? '—', width: 150),

          if (showRequired) _requiredCell(context, prop.required, width: 90),

          _description(context, prop.description, width: 320),
        ],
      ),
    );
  }

  Widget _headerCell(
    BuildContext context,
    String text, {
    required double width,
  }) {
    final theme = context.clayTheme;

    return SizedBox(
      width: width,
      child: ClayText.label(
        text,
        color: theme.onBackground.withValues(alpha: 0.65),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _propertyName(
    BuildContext context,
    String text, {
    required double width,
  }) {
    final theme = context.clayTheme;

    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          color: theme.primary,
          fontFamily: 'monospace',
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _propertyCode(
    BuildContext context,
    String text, {
    required double width,
  }) {
    final theme = context.clayTheme;

    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: theme.onBackground.withValues(alpha: 0.75),
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _requiredCell(
    BuildContext context,
    bool required, {
    required double width,
  }) {
    final theme = context.clayTheme;

    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: required
                ? theme.primary.withValues(alpha: 0.12)
                : theme.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            required ? 'Yes' : 'No',
            style: TextStyle(
              color: required
                  ? theme.primary
                  : theme.onBackground.withValues(alpha: 0.5),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _description(
    BuildContext context,
    String text, {
    required double width,
  }) {
    final theme = context.clayTheme;

    return SizedBox(
      width: width,
      child: ClayText.label(
        text,
        color: theme.onBackground.withValues(alpha: 0.7),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
