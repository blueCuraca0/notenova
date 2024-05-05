import 'package:flutter/material.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';

class TaskDialog extends StatelessWidget {
  final Task task;

  const TaskDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(task.name),
      content: Text(task.description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
