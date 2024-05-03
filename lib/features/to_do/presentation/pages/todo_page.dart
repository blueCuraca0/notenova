import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notenova/core/style/c_colors.dart';
import '../../../../core/utils/languages/generated/locale_keys.g.dart';
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
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverAppBar(
                backgroundColor: CColors.accent,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        context.setLocale(const Locale('ua'));
                      },
                      icon: const Icon(Icons.access_alarm)),
                  // Text('To-do', style: TextStyle(fontSize: 25)),
                  const Spacer(),
                  const Icon(Icons.person),
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
                        buttonPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const CreateTaskBottomSheet();
                            },
                          );
                        },
                        text: LocaleKeys.create_task.tr()),
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
