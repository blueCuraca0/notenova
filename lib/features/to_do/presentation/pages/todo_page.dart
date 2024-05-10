import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/to_do/data/services/firebase_service.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/widgets/lists/task_calendar_list.dart';

import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../main.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => TaskCubit(TaskFirestoreService()),
      child: Scaffold(
        backgroundColor: CColors.accent,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.1,
                  floating: true,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  surfaceTintColor: Theme.of(context).primaryColor,
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(
                            left: 10, top: constraints.maxHeight - 70),
                        title: Padding(
                          padding: smallerPadding,
                          child: Row(
                            children: [
                              Text('To-do',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const Spacer(),
                              Icon(
                                Icons.person,
                                color: Theme.of(context).cardColor,
                              ),
                            ],
                          ),
                        ),
                        background:
                            ColoredBox(color: Theme.of(context).primaryColor),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text('${DateTime.now().day.toString()} ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('${DateFormat('MMMM').format(DateTime.now())}, ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('${DateTime.now().year.toString()} ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CalendarTaskList(),
                ),
              ],
            ),
            SizedBox(
              height: height,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavBar(MyApp.navigatorKey)
              ),
            )
          ],
        ),
      ),
    );
  }
}
