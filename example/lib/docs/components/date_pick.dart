import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc datePickDocumentation = ComponentDoc(
  title: 'Date Pick',
  subtitle: 'Components',
  description: 'A themed date and time field that opens a calendar or time picker and reports confirmed selections through callbacks.',
  legends: [
    DocumentationLegend(label: 'Date', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Date Range', color: ClayColors.sky.s500),
    DocumentationLegend(
      label: 'Time / Date-Time',
      color: ClayColors.violet.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Choose a Date or Range',
      description: 'Select a mode with ClayDatePickMode. Use onChanged for a single date/time value and onRangeChanged for date ranges.',
      code: '''
ClayDatePick(
  mode: ClayDatePickMode.dateRange,
  label: 'Travel dates',
  helperText: 'Choose arrival and departure dates.',
  firstDate: DateTime(2025),
  lastDate: DateTime(2030),
  onRangeChanged: (range) => setState(() => selectedRange = range),
)
''',
      preview: Column(
        children: [
          ClayDatePick(
            label: 'Start date',
            initialDate: DateTime(2026, 10, 30),
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          ClayDatePick(
            mode: ClayDatePickMode.time,
            label: 'Reminder time',
            onChanged: (_) {},
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'mode',
      type: 'ClayDatePickMode',
      description: 'date, dateRange, time, or dateTime.',
      defaultValue: 'date',
    ),
    ClayProp(
      name: 'initialDate / initialRange',
      type: 'DateTime? / DateTimeRange?',
      description: 'Initial selected value for the corresponding mode.',
    ),
    ClayProp(
      name: 'firstDate / lastDate',
      type: 'DateTime?',
      description: 'Inclusive date bounds.',
      defaultValue: '1900 / 2100',
    ),
    ClayProp(
      name: 'dateFormat / use24HourFormat / locale',
      type: 'String / bool / String?',
      description: 'Configure date display, time display, and picker locale.',
      defaultValue: 'dd/MM/yyyy / true / null',
    ),
    ClayProp(
      name: 'onChanged / onRangeChanged',
      type: 'ValueChanged<DateTime?>? / ValueChanged<DateTimeRange?>?',
      description: 'Mode-specific selection callbacks.',
    ),
    ClayProp(
      name: 'onConfirmed / onCancelled',
      type: 'ValueChanged<DateTime?>? / VoidCallback?',
      description: 'Optional confirmation and cancellation callbacks.',
    ),
    ClayProp(
      name: 'enabled / showActions / showClearButton',
      type: 'bool',
      description: 'Control interaction and picker action/clear controls.',
      defaultValue: 'true',
    ),
  ],
);