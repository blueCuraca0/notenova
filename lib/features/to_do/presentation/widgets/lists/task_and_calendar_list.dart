import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/to_do/data/models/task_model.dart';
import 'package:notenova/features/to_do/presentation/widgets/cards/calendar_card.dart';
import 'package:notenova/features/to_do/presentation/widgets/cards/task_card.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

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
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 5.0, 10, 0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: CColors.text),
              ),
            ),
          ),
          SizedBox(
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
          ),
          midSizedBoxHeight,
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return GestureDetector(
                onTap: () => print('Task $index tapped'),
                child: TaskCard(task: task),
              );
            },
          ),
        ],
      ),
    );
  }
}
