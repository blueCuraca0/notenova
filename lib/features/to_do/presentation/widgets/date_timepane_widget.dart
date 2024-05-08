import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notenova/core/style/c_colors.dart';
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
  @override
  Widget build(BuildContext context) {
    List<DateTime> allDates =
        widget.tasks.map((task) => task.finalDate).toSet().toList();
    List<DateTime> dates = allDates
        .where((date) =>
            date.isAfter(DateTime.now().subtract(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.compareTo(b));

    return SizedBox(
      height: 160.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                widget.onDateChange(date);
                widget.onDateChange(date);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                child: Container(
                  width: 110.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: date == widget.selectedDate
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).cardColor,
                    boxShadow: shadowCard,
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
                          DateFormat('EEEE').format(date),
                          style: Theme.of(context).textTheme.bodyMedium,
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
