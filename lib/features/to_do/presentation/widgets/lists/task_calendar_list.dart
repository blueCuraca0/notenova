import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_state.dart';
import 'package:notenova/features/to_do/presentation/pages/create_edit_task_sheet.dart';
import 'package:notenova/features/to_do/presentation/widgets/date_timeline_widget.dart';
import 'package:notenova/features/to_do/presentation/widgets/lists/tasks_list.dart';

class CalendarTaskList extends StatefulWidget {
  const CalendarTaskList({
    super.key,
  });

  @override
  State<CalendarTaskList> createState() => _CalendarTaskListState();
}

class _CalendarTaskListState extends State<CalendarTaskList>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  late final AnimationController _controller;
  bool isEdit = false;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    BlocProvider.of<TaskCubit>(context).loadTasks();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        curve: Curves.easeOut,
        parent: _controller,
      )),
      child: Container(
        constraints: BoxConstraints(minHeight: 900),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 300.0),
                  child: Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 10.0,
                        color: Theme.of(context).shadowColor),
                  ),
                );
              } else if (state is TaskLoaded) {
                final tasks = state.tasks;
                deleteTasksBeforeToday(tasks);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.today.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          spacer,
                          CustomButton(
                              buttonPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CreateTaskBottomSheet(
                                        isEdit: false, taskCubit: taskCubit);
                                  },
                                );
                              },
                              text: LocaleKeys.create_task1.tr()),
                        ],
                      ),
                    ),
                    smallSizedBoxHeight,
                    tasks.isNotEmpty
                        ? Column(
                            children: [
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
                              TaskList(
                                  isEdit: isEdit,
                                  tasks: tasks,
                                  selectedDate: _selectedDate,
                                  taskCubit: taskCubit),
                              bigSizedBoxHeight,
                              bigSizedBoxHeight,
                              bigSizedBoxHeight
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No tasks yet',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                  ],
                );
              } else if (state is TaskSuccess) {
                BlocProvider.of<TaskCubit>(context).loadTasks();
                return Container();
              } else if (state is TaskError) {
                return Center(child: Text(state.errorMessage));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

// for deleting task before date now
  void deleteTasksBeforeToday(List<Task> tasks) {
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    final tasksToRemove =
        tasks.where((task) => task.finalDate.isBefore(yesterday)).toList();
    for (Task task in tasksToRemove) {
      BlocProvider.of<TaskCubit>(context).deleteTask(task.id);
    }
  }
}
