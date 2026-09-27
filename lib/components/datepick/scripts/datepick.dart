import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/pick_mode.dart';
import '../../text/scripts/text.dart';
import '../../button/scripts/button.dart';
import '../../../theme/scripts/shadows.dart';

class ClayDatePick extends StatefulWidget {
  const ClayDatePick({
    super.key,
    this.mode = ClayDatePickMode.date,
    this.initialDate,
    this.initialRange,
    this.firstDate,
    this.lastDate,
    this.dateFormat = 'dd/MM/yyyy',
    this.use24HourFormat = true,
    this.locale,
    this.enabled = true,
    this.showActions = true,
    this.showClearButton = true,
    this.label,
    this.helperText,
    this.errorText,
    this.backgroundColor,
    this.accentColor,
    this.accentForegroundColor,
    this.borderRadius = 18,
    this.padding = const EdgeInsets.all(14),
    this.onChanged,
    this.onRangeChanged,
    this.onConfirmed,
    this.onCancelled,
  });

  final ClayDatePickMode mode;
  final DateTime? initialDate;
  final DateTimeRange? initialRange;
  final DateTime? firstDate;
  final DateTime? lastDate;

  final String dateFormat;
  final bool use24HourFormat;
  final String? locale;

  final bool enabled;
  final bool showActions;
  final bool showClearButton;

  final String? label;
  final String? helperText;
  final String? errorText;

  final Color? backgroundColor;
  final Color? accentColor, accentForegroundColor;

  final double borderRadius;
  final EdgeInsetsGeometry padding;

  final ValueChanged<DateTime?>? onChanged;
  final ValueChanged<DateTimeRange?>? onRangeChanged;
  final ValueChanged<DateTime?>? onConfirmed;
  final VoidCallback? onCancelled;

  @override
  State<ClayDatePick> createState() => _ClayDatePickState();
}

class _ClayDatePickState extends State<ClayDatePick> {
  DateTime? _selected;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  TimeOfDay? _time;

  DateTime get _first => widget.firstDate ?? DateTime(1900);
  DateTime get _last => widget.lastDate ?? DateTime(2100);

  bool get _isRange => widget.mode == ClayDatePickMode.dateRange;
  bool get _isTime => widget.mode == ClayDatePickMode.time;
  bool get _isDateTime => widget.mode == ClayDatePickMode.dateTime;

  bool get _hasValue {
    if (_isRange) return _rangeStart != null;
    if (_isTime) return _time != null;
    return _selected != null;
  }

  @override
  void initState() {
    super.initState();
    _syncFromWidget();
  }

  void _syncFromWidget() {
    _selected = widget.initialDate;
    _rangeStart = widget.initialRange?.start;
    _rangeEnd = widget.initialRange?.end;

    final initial = widget.initialDate;
    _time = initial == null
        ? (_isTime ? TimeOfDay.now() : null)
        : TimeOfDay.fromDateTime(initial);
  }

  @override
  void didUpdateWidget(covariant ClayDatePick oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialDate != widget.initialDate ||
        oldWidget.initialRange != widget.initialRange ||
        oldWidget.mode != widget.mode) {
      _syncFromWidget();
    }
  }

  DateTime _dateWithTime(DateTime date, TimeOfDay? time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time?.hour ?? 0,
      time?.minute ?? 0,
    );
  }

  String _format(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return widget.dateFormat
        .replaceAll('yyyy', year)
        .replaceAll('dd', day)
        .replaceAll('MM', month);
  }

  String _formatTime(TimeOfDay time) {
    if (!widget.use24HourFormat) {
      return time.format(context);
    }

    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  String _displayValue() {
    if (_isRange) {
      if (_rangeStart == null) return 'Select period';

      if (_rangeEnd == null) {
        return '${_format(_rangeStart!)} – End date';
      }

      return '${_format(_rangeStart!)} – ${_format(_rangeEnd!)}';
    }

    if (_isTime) {
      return _time == null ? 'Select time' : _formatTime(_time!);
    }

    if (_selected == null) return 'Select date';

    final date = _format(_selected!);

    if (!_isDateTime) return date;

    return '$date · ${_formatTime(_time ?? TimeOfDay.now())}';
  }

  Future<void> _openPicker() async {
    if (!widget.enabled) return;

    final result = await showDialog<_DatePickResult>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return _ClayDateDialog(
          mode: widget.mode,
          initialDate: _selected,
          initialRange: _rangeStart != null && _rangeEnd != null
              ? DateTimeRange(start: _rangeStart!, end: _rangeEnd!)
              : null,
          initialRangeStart: _rangeStart,
          initialTime: _time,
          firstDate: _first,
          lastDate: _last,
          dateFormat: widget.dateFormat,
          use24HourFormat: widget.use24HourFormat,
          locale: widget.locale,
          title: widget.label ?? 'Select date',
          backgroundColor: widget.backgroundColor,
          accentColor: widget.accentColor,
          accentForegroundColor: widget.accentForegroundColor,
          borderRadius: widget.borderRadius,
          showActions: widget.showActions,
        );
      },
    );

    if (!mounted) return;

    if (result == null) {
      widget.onCancelled?.call();
      return;
    }

    setState(() {
      _selected = result.date;
      _rangeStart = result.range?.start;
      _rangeEnd = result.range?.end;
      _time = result.time;
    });

    if (_isRange) {
      widget.onRangeChanged?.call(result.range);
    } else {
      widget.onChanged?.call(
        _isTime
            ? _dateWithTime(DateTime.now(), result.time)
            : _isDateTime
            ? _dateWithTime(result.date ?? DateTime.now(), result.time)
            : result.date,
      );
    }

    widget.onConfirmed?.call(
      _isRange
          ? result.range?.start
          : _isTime
          ? _dateWithTime(DateTime.now(), result.time)
          : _isDateTime
          ? _dateWithTime(result.date ?? DateTime.now(), result.time)
          : result.date,
    );
  }

  void _clear() {
    if (!widget.enabled) return;

    setState(() {
      _selected = null;
      _rangeStart = null;
      _rangeEnd = null;
      _time = _isTime ? TimeOfDay.now() : null;
    });

    if (_isRange) {
      widget.onRangeChanged?.call(null);
    } else {
      widget.onChanged?.call(null);
    }

    widget.onConfirmed?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final accent = widget.accentColor ?? theme.primary;
    final accentForeground = widget.accentForegroundColor ?? theme.onPrimary;
    final background = widget.backgroundColor ?? theme.container;
    final foreground = theme.onBackground;
    final hasError = widget.errorText != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: widget.enabled ? 1 : 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: ClayText.label(
                  widget.label!,
                  color: foreground,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.enabled ? _openPicker : null,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: CustomPaint(
                  foregroundPainter: ClayInnerShadowPainter(
                    shadowColor: theme.shadow,
                    lightColor: theme.light,
                    borderRadius: widget.borderRadius,
                    shadowSize: 2.5,
                    blurRadius: 7.0,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    padding: widget.padding,
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      border: Border.all(
                        color: hasError
                            ? theme.error
                            : theme.border.withValues(alpha: 0.75),
                      ),
                      boxShadow: ClayShadows.external(
                        theme: theme,
                        offset: 1,
                        blur: 4,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomPaint(
                          foregroundPainter: ClayInnerShadowPainter(
                            shadowColor: theme.shadow,
                            lightColor: theme.light,
                            borderRadius: 15,
                            shadowSize: 2.5,
                            blurRadius: 7.0,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: ClayShadows.external(
                                theme: theme,
                                offset: 1,
                                blur: 4,
                              ),
                            ),
                            child: Icon(
                              _isTime
                                  ? Icons.schedule_rounded
                                  : _isRange
                                  ? Icons.date_range_rounded
                                  : Icons.calendar_month_rounded,
                              color: accentForeground,
                              size: 22,
                            ),
                          ),
                        ),

                        const SizedBox(width: 13),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClayText.label(
                                _isTime
                                    ? 'Time'
                                    : _isRange
                                    ? 'Period'
                                    : _isDateTime
                                    ? 'Date and time'
                                    : 'Date',
                                color: theme.onBackgroundVariant,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 4),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                child: ClayText.label(
                                  _displayValue(),
                                  key: ValueKey(_displayValue()),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  color: _hasValue
                                      ? foreground
                                      : theme.onBackgroundVariant,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (widget.showClearButton && _hasValue) ...[
                          IconButton(
                            tooltip: 'Clear selection',
                            visualDensity: VisualDensity.compact,
                            onPressed: widget.enabled ? _clear : null,
                            icon: Icon(
                              Icons.close_rounded,
                              color: theme.onBackgroundVariant,
                              size: 19,
                            ),
                          ),
                        ],

                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: theme.onBackgroundVariant,
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (widget.helperText != null || widget.errorText != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 7),
                child: ClayText.label(
                  widget.errorText ?? widget.helperText!,
                  color: hasError ? theme.error : theme.onBackgroundVariant,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DatePickResult {
  const _DatePickResult({this.date, this.range, this.time});

  final DateTime? date;
  final DateTimeRange? range;
  final TimeOfDay? time;
}

class _ClayDateDialog extends StatefulWidget {
  const _ClayDateDialog({
    required this.mode,
    required this.initialDate,
    required this.initialRange,
    required this.initialRangeStart,
    required this.initialTime,
    required this.firstDate,
    required this.lastDate,
    required this.dateFormat,
    required this.use24HourFormat,
    required this.locale,
    required this.title,
    required this.backgroundColor,
    required this.accentColor,
    required this.accentForegroundColor,
    required this.borderRadius,
    required this.showActions,
  });

  final ClayDatePickMode mode;
  final DateTime? initialDate;
  final DateTimeRange? initialRange;
  final DateTime? initialRangeStart;
  final TimeOfDay? initialTime;

  final DateTime firstDate;
  final DateTime lastDate;

  final String dateFormat;
  final bool use24HourFormat;
  final String? locale;

  final String title;
  final Color? backgroundColor;
  final Color? accentColor, accentForegroundColor;
  final double borderRadius;
  final bool showActions;

  @override
  State<_ClayDateDialog> createState() => _ClayDateDialogState();
}

class _ClayDateDialogState extends State<_ClayDateDialog> {
  late DateTime _focused;
  DateTime? _date;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late TimeOfDay _time;

  bool get _isRange => widget.mode == ClayDatePickMode.dateRange;
  bool get _isTime => widget.mode == ClayDatePickMode.time;
  bool get _isDateTime => widget.mode == ClayDatePickMode.dateTime;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _date = widget.initialDate;
    _focused = widget.initialDate ?? now;
    _rangeStart = widget.initialRange?.start ?? widget.initialRangeStart;
    _rangeEnd = widget.initialRange?.end;
    _time = widget.initialTime ?? TimeOfDay.now();
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  DateTime _clampDate(DateTime date) {
    final day = _dateOnly(date);
    final first = _dateOnly(widget.firstDate);
    final last = _dateOnly(widget.lastDate);

    if (day.isBefore(first)) return first;
    if (day.isAfter(last)) return last;
    return day;
  }

  String _format(DateTime date) {
    return widget.dateFormat
        .replaceAll('yyyy', date.year.toString())
        .replaceAll('dd', date.day.toString().padLeft(2, '0'))
        .replaceAll('MM', date.month.toString().padLeft(2, '0'));
  }

  String _formatTime() {
    if (!widget.use24HourFormat) return _time.format(context);

    return '${_time.hour.toString().padLeft(2, '0')}:'
        '${_time.minute.toString().padLeft(2, '0')}';
  }

  String get _summary {
    if (_isTime) return _formatTime();

    if (_isRange) {
      if (_rangeStart == null) return 'Choose the start date';
      if (_rangeEnd == null) {
        return '${_format(_rangeStart!)}  →  Choose the end';
      }

      return '${_format(_rangeStart!)}  →  ${_format(_rangeEnd!)}';
    }

    final date = _date ?? _focused;
    final formatted = _format(date);

    return _isDateTime ? '$formatted · ${_formatTime()}' : formatted;
  }

  void _selectDate(DateTime date) {
    setState(() {
      _date = date;
      _focused = date;

      if (_isRange) {
        if (_rangeStart == null ||
            _rangeEnd != null ||
            date.isBefore(_rangeStart!)) {
          _rangeStart = date;
          _rangeEnd = null;
        } else {
          _rangeEnd = date;
        }
      }
    });
  }

  Future<void> _selectTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        final theme = context.clayTheme;
        final accent = widget.accentColor ?? theme.primary;
        final accentForeground =
            widget.accentForegroundColor ?? theme.onPrimary;
        final background = widget.backgroundColor ?? theme.container;
        final foreground = theme.onBackground;

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: accent,
              onPrimary: accentForeground,
              surface: background,
              onSurface: foreground,
              surfaceContainerHigh: background,
              surfaceContainerHighest: theme.third,
              primaryContainer: theme.secondary,
              onPrimaryContainer: theme.onSecondary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null && mounted) {
      setState(() => _time = result);
    }
  }

  void _confirm() {
    if (_isRange) {
      if (_rangeStart == null || _rangeEnd == null) return;

      Navigator.of(context).pop(
        _DatePickResult(
          range: DateTimeRange(start: _rangeStart!, end: _rangeEnd!),
        ),
      );
      return;
    }

    Navigator.of(context).pop(
      _DatePickResult(date: _isTime ? null : (_date ?? _focused), time: _time),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final accent = widget.accentColor ?? theme.primary;
    final accentForeground = widget.accentForegroundColor ?? theme.onPrimary;
    final background = widget.backgroundColor ?? theme.container;
    final foreground = theme.onBackground;

    final dateForCalendar = _clampDate(_date ?? _focused);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: widget.borderRadius + 6,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 410),
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(widget.borderRadius + 6),
              border: Border.all(color: theme.border.withValues(alpha: 0.5)),
              boxShadow: ClayShadows.external(
                theme: theme,
                offset: 2.5,
                blur: 7,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius + 6),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CustomPaint(
                          foregroundPainter: ClayInnerShadowPainter(
                            shadowColor: theme.shadow,
                            lightColor: theme.light,
                            borderRadius: 15,
                            shadowSize: 2.5,
                            blurRadius: 7.0,
                          ),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: ClayShadows.external(
                                theme: theme,
                                offset: 1,
                                blur: 4,
                              ),
                            ),
                            child: Icon(
                              _isTime
                                  ? Icons.schedule_rounded
                                  : _isRange
                                  ? Icons.date_range_rounded
                                  : Icons.calendar_month_rounded,
                              color: accentForeground,
                              size: 22,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClayText.label(
                                widget.title,
                                color: foreground,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                              const SizedBox(height: 3),
                              ClayText.label(
                                _isRange
                                    ? 'Select the start and end'
                                    : _isTime
                                    ? 'Choose your preferred time'
                                    : _isDateTime
                                    ? 'Choose the date and time'
                                    : 'Choose a date on the calendar',
                                color: theme.onBackgroundVariant,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),

                        ClayButton.icon(
                          Icon(Icons.close_rounded),
                          iconColor: theme.onError,
                          backgroundColor: theme.error,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    CustomPaint(
                      foregroundPainter: ClayInnerShadowPainter(
                        shadowColor: theme.shadow,
                        lightColor: theme.light,
                        borderRadius: 18,
                        shadowSize: 2.5,
                        blurRadius: 7.0,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: ClayShadows.external(
                            theme: theme,
                            offset: 1,
                            blur: 4,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_available_rounded,
                              color: accentForeground,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClayText.label(
                                    'Your selection',
                                    color: accentForeground.withValues(
                                      alpha: 0.9,
                                    ),
                                    fontSize: 11,
                                  ),
                                  const SizedBox(height: 5),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 180),
                                    child: ClayText.label(
                                      _summary,
                                      key: ValueKey(_summary),
                                      color: accentForeground,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (!_isTime) ...[
                      const SizedBox(height: 12),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: accent,
                            onPrimary: accentForeground,
                            surface: background,
                            onSurface: foreground,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: accent,
                            ),
                          ),
                        ),
                        child: CalendarDatePicker(
                          key: ValueKey(
                            '${dateForCalendar.year}-${dateForCalendar.month}',
                          ),
                          initialDate: dateForCalendar,
                          firstDate: widget.firstDate,
                          lastDate: widget.lastDate,
                          currentDate: DateTime.now(),
                          onDisplayedMonthChanged: (date) {
                            setState(() => _focused = date);
                          },
                          onDateChanged: _selectDate,
                        ),
                      ),
                    ],

                    if (_isTime || _isDateTime) ...[
                      const SizedBox(height: 8),
                      Material(
                        color: accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: _selectTime,
                          child: CustomPaint(
                            foregroundPainter: ClayInnerShadowPainter(
                              shadowColor: theme.shadow,
                              lightColor: theme.light,
                              borderRadius: 18,
                              shadowSize: 2.5,
                              blurRadius: 7.0,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: theme.third,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: ClayShadows.external(
                                  theme: theme,
                                  offset: 1,
                                  blur: 4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: theme.onThird,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ClayText.label(
                                        'Time',
                                        color: theme.onThird,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ClayText.label(
                                      _formatTime(),
                                      color: theme.onThird,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.edit_rounded,
                                      color: theme.onThird,
                                      size: 17,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],

                    if (_isRange &&
                        _rangeStart != null &&
                        _rangeEnd == null) ...[
                      const SizedBox(height: 10),
                      ClayText.label(
                        'Now select the end date.',
                        textAlign: TextAlign.center,
                        color: theme.onBackgroundVariant,
                        fontSize: 12,
                      ),
                    ],

                    if (widget.showActions) ...[
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ClayButton.third(
                              'Cancel',
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ClayButton.primary(
                              'Confirm',
                              onPressed:
                                  _isRange &&
                                      (_rangeStart == null || _rangeEnd == null)
                                  ? null
                                  : _confirm,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ClayButton.primary(
                          "Conclude",
                          onPressed:
                              _isRange &&
                                  (_rangeStart == null || _rangeEnd == null)
                              ? null
                              : _confirm,
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
    );
  }
}
