import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../theme/scripts/shadows.dart';

class ClayTableColumn<T> {
  const ClayTableColumn({
    required this.id,
    required this.title,
    required this.cellBuilder,
    this.width,
    this.alignment = Alignment.centerLeft,
    this.sortable = false,
    this.sortValue,
    this.compare,
    this.header,
  });

  final String id;
  final String title;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final double? width;
  final Alignment alignment;
  final bool sortable;
  final Object? Function(T row)? sortValue;
  final int Function(T a, T b)? compare;
  final Widget? header;
}

class ClayTableGroup<T> {
  const ClayTableGroup({
    required this.title,
    required this.rows,
    this.subtitle,
    this.initiallyExpanded = true,
  });

  final String title;
  final String? subtitle;
  final List<T> rows;
  final bool initiallyExpanded;
}

class ClayTable<T> extends StatefulWidget {
  const ClayTable({
    super.key,
    required this.columns,
    this.rows = const [],
    this.groups = const [],
    this.height,
    this.minWidth,
    this.rowHeight = 56,
    this.headerHeight = 52,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.showCheckboxes = true,
    this.selectedRows = const {},
    this.onSelectionChanged,
    this.onRowTap,
    this.empty,
    this.sortColumnId,
    this.sortAscending = true,
    this.onSortChanged,
    this.stickyHeader = true,
    this.groupHeaderBuilder,
    this.borderRadius = 18,
  }) : assert(columns.length > 0, 'ClayTable requires at least one column.');

  final List<ClayTableColumn<T>> columns;
  final List<T> rows;
  final List<ClayTableGroup<T>> groups;
  final double? height;
  final double? minWidth;
  final double rowHeight;
  final double headerHeight;
  final EdgeInsetsGeometry padding;
  final bool showCheckboxes;
  final Set<T> selectedRows;
  final ValueChanged<Set<T>>? onSelectionChanged;
  final ValueChanged<T>? onRowTap;
  final Widget? empty;
  final String? sortColumnId;
  final bool sortAscending;
  final void Function(String columnId, bool ascending)? onSortChanged;
  final bool stickyHeader;
  final Widget Function(
    BuildContext context,
    ClayTableGroup<T> group,
    bool expanded,
  )?
  groupHeaderBuilder;
  final double borderRadius;

  @override
  State<ClayTable<T>> createState() => _ClayTableState<T>();
}

class _ClayTableState<T> extends State<ClayTable<T>> {
  String? _sortColumnId;
  bool _ascending = true;
  late Set<T> _selected;
  final Set<String> _collapsedGroups = {};

  @override
  void initState() {
    super.initState();
    _sortColumnId = widget.sortColumnId;
    _ascending = widget.sortAscending;
    _selected = Set<T>.of(widget.selectedRows);
    for (final group in widget.groups) {
      if (!group.initiallyExpanded) _collapsedGroups.add(group.title);
    }
  }

  @override
  void didUpdateWidget(covariant ClayTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedRows != widget.selectedRows) {
      _selected = Set<T>.of(widget.selectedRows);
    }
    if (oldWidget.sortColumnId != widget.sortColumnId) {
      _sortColumnId = widget.sortColumnId;
      _ascending = widget.sortAscending;
    }
  }

  double get _tableWidth {
    final columnsWidth = widget.columns.fold<double>(
      0,
      (sum, column) => sum + (column.width ?? 160),
    );
    return columnsWidth + (widget.showCheckboxes ? 52 : 0) + 2;
  }

  void _sort(ClayTableColumn<T> column) {
    if (!column.sortable) return;
    final nextAscending = _sortColumnId == column.id ? !_ascending : true;
    setState(() {
      _sortColumnId = column.id;
      _ascending = nextAscending;
    });
    widget.onSortChanged?.call(column.id, nextAscending);
  }

  List<T> _sortedRows(List<T> rows) {
    final columnId = _sortColumnId;
    if (columnId == null) return rows;
    final column = widget.columns.cast<ClayTableColumn<T>?>().firstWhere(
      (item) => item?.id == columnId,
      orElse: () => null,
    );
    if (column == null || !column.sortable) return rows;
    final result = List<T>.of(rows);
    int compareValues(T a, T b) {
      if (column.compare != null) return column.compare!(a, b);
      final av = column.sortValue?.call(a);
      final bv = column.sortValue?.call(b);
      if (av == null && bv == null) return 0;
      if (av == null) return -1;
      if (bv == null) return 1;
      if (av is num && bv is num) return av.compareTo(bv);
      if (av is DateTime && bv is DateTime) return av.compareTo(bv);
      return av.toString().toLowerCase().compareTo(bv.toString().toLowerCase());
    }

    result.sort(
      (a, b) => _ascending ? compareValues(a, b) : compareValues(b, a),
    );
    return result;
  }

  List<T> get _allRows => widget.groups.isEmpty
      ? widget.rows
      : widget.groups.expand((group) => group.rows).toList(growable: false);

  void _setRowSelected(T row, bool selected) {
    final next = Set<T>.of(_selected);
    if (selected) {
      next.add(row);
    } else {
      next.remove(row);
    }
    setState(() => _selected = next);
    widget.onSelectionChanged?.call(Set<T>.unmodifiable(next));
  }

  void _setAllSelected(bool selected) {
    final next = Set<T>.of(_selected);
    if (selected) {
      next.addAll(_allRows);
    } else {
      next.removeAll(_allRows);
    }
    setState(() => _selected = next);
    widget.onSelectionChanged?.call(Set<T>.unmodifiable(next));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final surface = theme.container;
    final border = theme.border;
    final rows = _allRows;
    final allSelected = rows.isNotEmpty && rows.every(_selected.contains);
    final someSelected = rows.any(_selected.contains);
    final header = _buildHeader(context, allSelected, someSelected);
    final body = _buildRows(context);

    return CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: widget.borderRadius,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: border.withValues(alpha: 0.65)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.045),
              offset: const Offset(3, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.42),
              offset: const Offset(-3, -3),
              blurRadius: 10,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final tableWidth = widget.minWidth == null
                ? _tableWidth
                : (_tableWidth < widget.minWidth!
                      ? widget.minWidth!
                      : _tableWidth);
            final effectiveWidth =
                availableWidth.isFinite && availableWidth > tableWidth
                ? availableWidth
                : tableWidth;
            final Widget tableContent;
            if (widget.height != null) {
              tableContent = Column(
                children: [
                  if (widget.stickyHeader) header,
                  Expanded(
                    child: SingleChildScrollView(
                      child: widget.stickyHeader
                          ? body
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [header, body],
                            ),
                    ),
                  ),
                ],
              );
            } else {
              tableContent = Column(
                mainAxisSize: MainAxisSize.min,
                children: [header, body],
              );
            }

            final table = SizedBox(width: effectiveWidth, child: tableContent);
            final horizontal = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: table,
            );
            if (widget.height != null) {
              return SizedBox(height: widget.height, child: horizontal);
            }
            return horizontal;
          },
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool allSelected,
    bool someSelected,
  ) {
    final theme = context.clayTheme;
    return Container(
      height: widget.headerHeight,
      decoration: BoxDecoration(
        color: theme.background.withValues(alpha: 0.68),
        border: Border(
          bottom: BorderSide(color: theme.border.withValues(alpha: 0.7)),
        ),
      ),
      child: Row(
        children: [
          if (widget.showCheckboxes)
            SizedBox(
              width: 52,
              child: Center(
                child: Checkbox(
                  value: allSelected ? true : (someSelected ? null : false),
                  tristate: true,
                  onChanged: (value) => _setAllSelected(value == true),
                  activeColor: theme.primary,
                  checkColor: theme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
          for (final column in widget.columns)
            SizedBox(
              width: column.width ?? 160,
              child: Align(
                alignment: column.alignment,
                child: Padding(
                  padding: widget.padding,
                  child: InkWell(
                    onTap: column.sortable ? () => _sort(column) : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child:
                              column.header ??
                              Text(
                                column.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: theme.onBackground,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.5,
                                ),
                              ),
                        ),
                        if (column.sortable) ...[
                          const SizedBox(width: 5),
                          Icon(
                            _sortColumnId != column.id
                                ? Icons.unfold_more_rounded
                                : (_ascending
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded),
                            size: 15,
                            color: _sortColumnId == column.id
                                ? theme.primary
                                : theme.onBackground.withValues(alpha: 0.5),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRows(BuildContext context) {
    if (widget.groups.isEmpty) {
      final rows = _sortedRows(widget.rows);
      if (rows.isEmpty) return _buildEmpty(context);
      return Column(
        children: [
          for (var i = 0; i < rows.length; i++)
            _buildDataRow(context, rows[i], i),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final group in widget.groups) ...[
          _buildGroupHeader(context, group),
          if (!_collapsedGroups.contains(group.title))
            for (var i = 0; i < _sortedRows(group.rows).length; i++)
              _buildDataRow(context, _sortedRows(group.rows)[i], i),
        ],
        if (widget.groups.every((group) => group.rows.isEmpty))
          _buildEmpty(context),
      ],
    );
  }

  Widget _buildGroupHeader(BuildContext context, ClayTableGroup<T> group) {
    final theme = context.clayTheme;
    final expanded = !_collapsedGroups.contains(group.title);
    if (widget.groupHeaderBuilder != null) {
      return InkWell(
        onTap: () => setState(
          () => expanded
              ? _collapsedGroups.add(group.title)
              : _collapsedGroups.remove(group.title),
        ),
        child: widget.groupHeaderBuilder!(context, group, expanded),
      );
    }
    return InkWell(
      onTap: () => setState(
        () => expanded
            ? _collapsedGroups.add(group.title)
            : _collapsedGroups.remove(group.title),
      ),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: theme.background.withValues(alpha: 0.38),
          border: Border(
            bottom: BorderSide(color: theme.border.withValues(alpha: 0.45)),
          ),
        ),
        child: Row(
          children: [
            AnimatedRotation(
              turns: expanded ? 0.25 : 0,
              duration: const Duration(milliseconds: 180),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 19,
                color: theme.onBackground.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                group.title,
                style: TextStyle(
                  color: theme.onBackground,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
            if (group.subtitle != null) ...[
              Text(
                group.subtitle!,
                style: TextStyle(
                  color: theme.onBackground.withValues(alpha: 0.65),
                  fontSize: 11.5,
                ),
              ),
              const SizedBox(width: 10),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: theme.container,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${group.rows.length}',
                style: TextStyle(
                  color: theme.onBackground,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, T row, int index) {
    final theme = context.clayTheme;
    final selected = _selected.contains(row);
    return Material(
      color: selected
          ? theme.primary.withValues(alpha: 0.09)
          : (index.isOdd
                ? theme.background.withValues(alpha: 0.14)
                : Colors.transparent),
      child: InkWell(
        onTap: widget.onRowTap == null ? null : () => widget.onRowTap!(row),
        child: Container(
          height: widget.rowHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: theme.border.withValues(alpha: 0.35)),
            ),
          ),
          child: Row(
            children: [
              if (widget.showCheckboxes)
                SizedBox(
                  width: 52,
                  child: Center(
                    child: Checkbox(
                      value: selected,
                      onChanged: (value) => _setRowSelected(row, value == true),
                      activeColor: theme.primary,
                      checkColor: theme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
              for (final column in widget.columns)
                SizedBox(
                  width: column.width ?? 160,
                  child: Align(
                    alignment: column.alignment,
                    child: Padding(
                      padding: widget.padding,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: theme.onBackground,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: column.cellBuilder(context, row),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final theme = context.clayTheme;
    return SizedBox(
      height: 100,
      child: Center(
        child:
            widget.empty ??
            Text(
              'Nenhum registro encontrado',
              style: TextStyle(
                color: theme.onBackground.withValues(alpha: 0.65),
              ),
            ),
      ),
    );
  }
}
