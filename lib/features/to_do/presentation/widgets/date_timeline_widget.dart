import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';

class TimelineDataPicker extends StatefulWidget {
  final List<Task> tasks;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChange;

  const TimelineDataPicker({
    super.key,
    required this.tasks,
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  State<TimelineDataPicker> createState() => _TimelineDataPickerState();
}

class _TimelineDataPickerState extends State<TimelineDataPicker> {
  Map<DateTime, bool> _isDateSelected = {};

  @override
  void initState() {
    super.initState();
    _isDateSelected = {widget.selectedDate: true};
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = context.locale;

    String weekdayFormat = 'EEEE';
    if (locale.languageCode == 'uk') {
      weekdayFormat = 'EEEE';
    } else {
      weekdayFormat = 'EEEE';
    }

    // Group tasks by date
    final Map<DateTime, List<Task>> tasksByDate = widget.tasks.fold(
      {},
      (map, task) {
        final date = DateTime(
            task.finalDate.year, task.finalDate.month, task.finalDate.day);
        map.putIfAbsent(date, () => []).add(task);
        return map;
      },
    );

    // Sort the dates in ascending order
    final sortedDates = tasksByDate.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    return SizedBox(
      height: 160.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final date = sortedDates[index];
          final isSelected = _isDateSelected[date] ?? false;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDateSelected = {date: true};
                });
                widget.onDateChange(date);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                child: Container(
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: isSelected
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        spreadRadius: -2,
                        blurRadius: 7,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: smallPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('MMMM').format(date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        smallSizedBoxHeight,
                        Text(
                          date.day.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        smallSizedBoxHeight,
                        Text(
                          DateFormat(weekdayFormat, locale.languageCode)
                              .format(date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
