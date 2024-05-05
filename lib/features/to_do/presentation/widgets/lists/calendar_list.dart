import 'package:flutter/material.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/widgets/cards/calendar_card.dart';

class CalendarList extends StatelessWidget {
  const CalendarList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
            child: CalendarCard(task: task),
          );
        },
      ),
    );
  }
}
