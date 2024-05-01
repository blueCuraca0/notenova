import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../data/models/task_model.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              Text('To-do', style: TextStyle(fontSize: 25)),
              Spacer(),
              Icon(Icons.person),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text('1 May, 2025', style: TextStyle(fontSize: 20)),
                const Spacer(),
                CustomButton(onPressed: () => {}, text: 'Create task'),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: TaskListWidget(),
        ),
      ],
    ));
  }
}

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        children: [
          const Text('Today'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return CalendarCard(task: task);
                },
              ),
            ),
          ),
          ListView.builder(
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

class CalendarCard extends StatelessWidget {
  final Task task;
  const CalendarCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(task.finalDate.month.toString()),
          Text(task.finalDate.year.toString()),
          Text(task.finalDate.day.toString()),
        ],
      ),
    ));
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    task.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
