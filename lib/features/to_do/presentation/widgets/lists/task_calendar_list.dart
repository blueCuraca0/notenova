import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_state.dart';
import 'package:notenova/features/to_do/presentation/pages/task_bottom_sheet.dart';
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
    return Container(
      constraints: const BoxConstraints(minHeight: 900),
      decoration: const BoxDecoration(
        color: CColors.accentSoft,
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              final tasks = state.tasks;
              print(tasks.length);
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  curve: Curves.easeOut,
                  parent: _controller,
                )),
                child: Column(
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
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CreateTaskBottomSheet(
                                        taskCubit: taskCubit);
                                  },
                                );
                              },
                              text: LocaleKeys.create_task.tr()),
                        ],
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
                    TaskList(
                        tasks: tasks,
                        selectedDate: _selectedDate,
                        taskCubit: taskCubit),
                  ],
                ),
              );
            } else if (state is TaskSuccess) {
              return Container();
            } else if (state is TaskError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
