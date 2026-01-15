import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/ui/glass_container.dart';

class AdvancedDateFilterDialog extends ConsumerStatefulWidget {
  final Set<DateTime> initialSpecificDates;
  final DateTimeRange? initialRange;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;

  const AdvancedDateFilterDialog({
    super.key,
    required this.initialSpecificDates,
    required this.initialRange,
    required this.initialStartTime,
    required this.initialEndTime,
  });

  @override
  ConsumerState<AdvancedDateFilterDialog> createState() =>
      _AdvancedDateFilterDialogState();
}

class _AdvancedDateFilterDialogState
    extends ConsumerState<AdvancedDateFilterDialog> {
  late Set<DateTime> _selectedDates;
  late DateTimeRange? _selectedRange;
  late TimeOfDay? _startTime;
  late TimeOfDay? _endTime;

  DateTime _focusedMonth = DateTime.now();

  // Controllers
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDates = Set.from(widget.initialSpecificDates);
    _selectedRange = widget.initialRange;
    _startTime = widget.initialStartTime;
    _endTime = widget.initialEndTime;

    // Normalize inputs to ignore time components just to be safe
    _selectedDates =
        _selectedDates.map((d) => DateTime(d.year, d.month, d.day)).toSet();

    _updateControllers();
  }

  void _updateControllers() {
    if (_selectedRange != null) {
      _startDateController.text =
          DateFormat('dd/MM/yyyy').format(_selectedRange!.start);
      _endDateController.text =
          DateFormat('dd/MM/yyyy').format(_selectedRange!.end);
    } else {
      _startDateController.clear();
      _endDateController.clear();
    }

    if (_startTime != null) {
      _startTimeController.text = _formatTime(_startTime!);
    } else {
      _startTimeController.clear();
    }

    if (_endTime != null) {
      _endTimeController.text = _formatTime(_endTime!);
    } else {
      _endTimeController.clear();
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  void _onDateTap(DateTime date, bool isCtrlPressed, bool isShiftPressed) {
    setState(() {
      final normalizedDate = DateTime(date.year, date.month, date.day);

      if (isShiftPressed) {
        // SHIFT Logic: Range Selection
        if (_selectedDates.isEmpty) {
          // If no dates selected, treat as single selection
          _selectedDates.add(normalizedDate);
          _selectedRange =
              DateTimeRange(start: normalizedDate, end: normalizedDate);
        } else {
          // Select range from last selected to current
          final start = _selectedDates.last;
          final end = normalizedDate;

          final rangeDates = _getDatesInRange(start, end);
          _selectedDates.addAll(rangeDates);
        }

        // Re-calculate effective range for UI if we want to show it in text fields
        if (_selectedDates.isNotEmpty) {
          final sorted = _selectedDates.toList()..sort();
          _selectedRange = DateTimeRange(start: sorted.first, end: sorted.last);
        }
      } else if (isCtrlPressed) {
        // CTRL Logic: Toggle
        if (_selectedDates.contains(normalizedDate)) {
          _selectedDates.remove(normalizedDate);
        } else {
          _selectedDates.add(normalizedDate);
        }
        // If multiple connected dates, we *could* infer a range, but for specific days selection
        // range might be null or ambiguous. Let's strictly use specificDates if gaps exist.
        _selectedRange = null;
      } else {
        // SINGLE Click: Reset and Select
        _selectedDates.clear();
        _selectedDates.add(normalizedDate);
        _selectedRange =
            DateTimeRange(start: normalizedDate, end: normalizedDate);
      }

      _updateControllers();
    });
  }

  List<DateTime> _getDatesInRange(DateTime start, DateTime end) {
    final days = <DateTime>[];
    DateTime current = start.isBefore(end) ? start : end;
    final DateTime target = start.isBefore(end) ? end : start;

    // Normalize logic
    current = DateTime(current.year, current.month, current.day);
    final targetNorm = DateTime(target.year, target.month, target.day);

    while (
        current.isBefore(targetNorm) || current.isAtSameMomentAs(targetNorm)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    // Using Dialog > GlassContainer structure
    return Dialog(
      backgroundColor: Colors.transparent, // Important for glass effect
      insetPadding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 900,
        height: 600,
        child: GlassContainer(
          opacity: 0.1,
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildCalendarSection(),
              ),
              const VerticalDivider(width: 32, color: Colors.white12),
              Expanded(
                flex: 2,
                child: _buildInputSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    final daysInMonth =
        DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final weekdayOffset = firstDay.weekday % 7;

    return Column(
      children: [
        // Calendar Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () {
                setState(() {
                  _focusedMonth =
                      DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
                });
              },
            ),
            Text(
              DateFormat('MMMM yyyy', 'pt_BR')
                  .format(_focusedMonth)
                  .toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white),
              onPressed: () {
                setState(() {
                  _focusedMonth =
                      DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
                });
              },
            ),
          ],
        ),
        const Gap(16),
        // Weekday Headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB']
              .map((e) => Expanded(
                    child: Center(
                      child: Text(e,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary, // Use Theme Primary
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ))
              .toList(),
        ),
        const Gap(8),
        // Calendar Grid
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: daysInMonth + weekdayOffset,
            itemBuilder: (context, index) {
              if (index < weekdayOffset) {
                return const SizedBox();
              }
              final day = index - weekdayOffset + 1;
              final date =
                  DateTime(_focusedMonth.year, _focusedMonth.month, day);

              // Highlight Logic
              final isSelected = _selectedDates.contains(date);
              final isToday = DateUtils.isSameDay(date, DateTime.now());

              return Focus(
                onKeyEvent: (node, event) => KeyEventResult.ignored,
                child: Builder(builder: (context) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        final isCtrl = HardwareKeyboard
                                .instance.logicalKeysPressed
                                .contains(LogicalKeyboardKey.controlLeft) ||
                            HardwareKeyboard.instance.logicalKeysPressed
                                .contains(LogicalKeyboardKey.controlRight);
                        final isShift = HardwareKeyboard
                                .instance.logicalKeysPressed
                                .contains(LogicalKeyboardKey.shiftLeft) ||
                            HardwareKeyboard.instance.logicalKeysPressed
                                .contains(LogicalKeyboardKey.shiftRight);
                        _onDateTap(date, isCtrl, isShift);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : (isToday ? Colors.white12 : Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? null
                              // If not selected but is today, show optional border or different bg
                              : (isToday
                                  ? Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.5))
                                  : Border.all(color: Colors.white12)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "$day",
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Configuração",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const Gap(24),
        _buildTextField("Data Início", _startDateController, isDate: true),
        const Gap(16),
        _buildTextField("Data Fim", _endDateController, isDate: true),
        const Gap(24),
        Row(
          children: [
            Expanded(
              child: _buildTextField("Hora Início", _startTimeController,
                  isTime: true, onTap: () async {
                final picked = await showTimePicker(
                    context: context,
                    initialTime: _startTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Color(
                                0xFF00E5FF), // Fix color directly or use theme
                            onPrimary: Colors.black,
                            surface: Color(0xFF1E293B),
                            onSurface: Colors.white,
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (picked != null) {
                  setState(() {
                    _startTime = picked;
                    _startTimeController.text = _formatTime(picked);
                  });
                }
              }),
            ),
            const Gap(16),
            Expanded(
              child: _buildTextField("Hora Fim", _endTimeController,
                  isTime: true, onTap: () async {
                final picked = await showTimePicker(
                    context: context,
                    initialTime: _endTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Color(0xFF00E5FF),
                            onPrimary: Colors.black,
                            surface: Color(0xFF1E293B),
                            onSurface: Colors.white,
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (picked != null) {
                  setState(() {
                    _endTime = picked;
                    _endTimeController.text = _formatTime(picked);
                  });
                }
              }),
            ),
          ],
        ),
        const Spacer(),
        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar",
                  style: TextStyle(color: Colors.white70)),
            ),
            const Gap(8),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedDates.clear();
                  _selectedRange = null;
                  _startTime = null;
                  _endTime = null;
                  _startDateController.clear();
                  _endDateController.clear();
                  _startTimeController.clear();
                  _endTimeController.clear();
                });
              },
              child: const Text("Limpar",
                  style: TextStyle(color: Colors.redAccent)),
            ),
            const Gap(8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context, {
                  'dates': _selectedDates,
                  'range': _selectedRange,
                  'start': _startTime,
                  'end': _endTime
                });
              },
              child: const Text("APLICAR"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isDate = false, bool isTime = false, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const Gap(4),
        TextFormField(
          controller: controller,
          onTap: onTap,
          readOnly: onTap != null,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black26, // Transparency for glass effect
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            suffixIcon: onTap != null
                ? const Icon(Icons.access_time, color: Colors.white54, size: 16)
                : null,
          ),
          inputFormatters: [
            if (isDate) _DateTextFormatter(),
            if (isTime) _TimeTextFormatter(),
            LengthLimitingTextInputFormatter(isDate ? 10 : 5),
          ],
        ),
      ],
    );
  }
}

class _DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final buffer = StringBuffer();
    // Simpler logic for formatting date DD/MM/YYYY
    text = text.replaceAll('/', '');
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 1 || i == 3) && i != text.length - 1) {
        buffer.write('/');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class _TimeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(':', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && i != text.length - 1) {
        buffer.write(':');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
