import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/pages/todo_detail_page.dart';
import 'package:notenova/features/to_do/presentation/widgets/cards/task_card.dart';
import 'package:notenova/features/to_do/presentation/widgets/date_timepane_widget.dart';

class CalendarTaskList extends StatefulWidget {
  const CalendarTaskList({
    super.key,
  });

  @override
  State<CalendarTaskList> createState() => _CalendarTaskListState();
}

class _CalendarTaskListState extends State<CalendarTaskList> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CColors.accentSoft,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                LocaleKeys.today.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            smallSizedBoxHeight,
            TimelineDataPicker(
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              selectedDate: DateTime.now(),
              tasks: tasks,
            ),
            smallSizedBoxHeight,
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                if (DateFormat('yyyy-MM-dd').format(task.finalDate) ==
                    DateFormat('yyyy-MM-dd').format(_selectedDate)) {
                  return GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TaskDialog(task: task);
                      },
                    ),
                    child: TaskCard(task: task),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}