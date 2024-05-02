import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/to_do/data/models/task_model.dart';

class CalendarCard extends StatelessWidget {
  final Task task;
  const CalendarCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: CColors.white,
              boxShadow: shadowCard,
            ),
            child: Padding(
              padding: smallPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMMM').format(task.finalDate),
                    style: const TextStyle(fontSize: 15),
                  ),
                  smallSizedBoxHeight,
                  Text(
                    task.finalDate.day.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  smallSizedBoxHeight,
                  Text(
                    DateFormat('EEEE').format(task.finalDate),
                    style: const TextStyle(fontSize: 15),
                  ),
                  smallSizedBoxHeight,
                ],
              ),
            )),
      ),
    );
  }
}
