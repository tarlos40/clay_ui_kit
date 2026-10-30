import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc tableDocumentation = ComponentDoc(
  title: 'Table',
  subtitle: 'Components',
  description: 'A data table with custom cell builders, sorting, row selection, grouping, and a sticky header.',
  legends: [
    DocumentationLegend(label: 'Sortable', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Selectable', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Grouped Rows', color: ClayColors.violet.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Define Columns and Rows',
      description: 'ClayTable is generic over the row model. Define a cellBuilder for each column and provide sortValue or compare when a column is sortable.',
      code: '''
ClayTable<Map<String, Object>>(
  columns: [
    ClayTableColumn(
      id: 'name',
      title: 'Name',
      sortable: true,
      sortValue: (row) => row['name'],
      cellBuilder: (context, row) => Text(row['name'].toString()),
    ),
    ClayTableColumn(
      id: 'team',
      title: 'Team',
      cellBuilder: (context, row) => Text(row['team'].toString()),
    ),
  ],
  rows: const [
    {'name': 'Ari', 'team': 'Design'},
    {'name': 'Noah', 'team': 'Engineering'},
  ],
  onRowTap: (row) {},
)
''',
      preview: SizedBox(
        height: 240,
        child: ClayTable<Map<String, Object>>(
          columns: [
            ClayTableColumn<Map<String, Object>>(
              id: 'name',
              title: 'Name',
              sortable: true,
              sortValue: (row) => row['name'],
              cellBuilder: (context, row) => Text(row['name'].toString()),
            ),
            ClayTableColumn<Map<String, Object>>(
              id: 'team',
              title: 'Team',
              cellBuilder: (context, row) => Text(row['team'].toString()),
            ),
          ],
          rows: const [
            {'name': 'Ari', 'team': 'Design'},
            {'name': 'Noah', 'team': 'Engineering'},
          ],
          onRowTap: (_) {},
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'columns',
      type: 'List<ClayTableColumn<T>>',
      description: 'Column definitions with IDs, titles, and cell builders.',
      required: true,
    ),
    ClayProp(
      name: 'rows / groups',
      type: 'List<T> / List<ClayTableGroup<T>>',
      description: 'Flat rows or grouped row collections.',
    ),
    ClayProp(
      name: 'selectedRows / onSelectionChanged',
      type: 'Set<T> / ValueChanged<Set<T>>?',
      description: 'Selected rows and selection callback.',
    ),
    ClayProp(
      name: 'sortColumnId / sortAscending / onSortChanged',
      type: 'String? / bool / callback?',
      description: 'Control sorting and receive sort changes.',
    ),
    ClayProp(
      name: 'onRowTap / empty',
      type: 'ValueChanged<T>? / Widget?',
      description: 'Optional row action and empty-state widget.',
    ),
    ClayProp(
      name: 'height / minWidth / rowHeight / stickyHeader',
      type: 'double? / double? / double / bool',
      description: 'Configure viewport sizing and header behavior.',
    ),
  ],
);