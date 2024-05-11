import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/pages/create_edit_task_sheet.dart';
import 'package:notenova/features/to_do/presentation/pages/todo_detail_page.dart';
import 'package:notenova/features/to_do/presentation/widgets/cards/task_card.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required DateTime selectedDate,
    required this.taskCubit,
    required this.isEdit,
  }) : _selectedDate = selectedDate;

  final bool isEdit;
  final List<Task> tasks;
  final DateTime _selectedDate;
  final TaskCubit taskCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        print(task.finalDate);
        print(task.description);
        if (DateFormat('yyyy-MM-dd').format(task.finalDate) ==
            DateFormat('yyyy-MM-dd').format(_selectedDate)) {
          return GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return TaskDialog(task: task);
              },
            ),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                taskCubit.deleteTask(task.id);
              },
              background: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColorDark,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).cardColor,
                ),
              ),
              direction: DismissDirection.endToStart,
              child: GestureDetector(
                onLongPress: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return CreateTaskBottomSheet(
                        task: task, isEdit: true, taskCubit: taskCubit);
                  },
                ),
                child: TaskCard(
                  task: task,
                  onCheckboxChanged: (value) {
                    final updatedTask = task.copyWith(isCompleted: value);
                    taskCubit.updateTaskCheckBox(updatedTask);
                  },
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
