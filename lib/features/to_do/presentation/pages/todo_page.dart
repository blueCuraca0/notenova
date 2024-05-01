import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notenova/core/style/c_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/lists/task_and_calendar_list.dart';
import 'task_bottom_sheet.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CColors.accent,
        body: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverAppBar(
                backgroundColor: CColors.accent,
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
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text('${DateTime.now().day.toString()} ',
                        style: const TextStyle(fontSize: 20)),
                    Text('${DateFormat('MMMM').format(DateTime.now())}, ',
                        style: const TextStyle(fontSize: 20)),
                    Text('${DateTime.now().year.toString()} ',
                        style: const TextStyle(fontSize: 20)),
                    const Spacer(),
                    CustomButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const CreateTaskBottomSheet();
                            },
                          );
                        },
                        text: 'Create task'),
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
