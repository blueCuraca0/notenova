import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/profile/presentation/pages/settings_page.dart';
import 'package:notenova/features/summary/presentation/pages/summary_page.dart';
import 'package:notenova/features/to_do/data/services/firebase_service.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/widgets/lists/task_calendar_list.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(TaskFirestoreService()),
      child: const Scaffold(
        backgroundColor: CColors.accent,
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBarWidget(),
            CurrentTimeWidget(),
            SliverToBoxAdapter(
              child: smallSizedBoxHeight,
            ),
            SliverToBoxAdapter(
              child: CalendarTaskList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentTimeWidget extends StatelessWidget {
  const CurrentTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}

class CustomSliverAppBarWidget extends StatefulWidget {
  const CustomSliverAppBarWidget({
    super.key,
  });

  @override
  State<CustomSliverAppBarWidget> createState() =>
      _CustomSliverAppBarWidgetState();
}

class _CustomSliverAppBarWidgetState extends State<CustomSliverAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.1,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      surfaceTintColor: Theme.of(context).primaryColor,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            titlePadding:
                EdgeInsets.only(left: 10, top: constraints.maxHeight - 70),
            title: Padding(
              padding: smallerPadding,
              child: Row(
                children: [
                  Text(LocaleKeys.to_quiz.tr(),
                      style: Theme.of(context).textTheme.bodyLarge),
                  const Spacer(),
                  Icon(
                    Icons.person,
                    color: Theme.of(context).cardColor,
                  ),
                ],
              ),
            ),
            background: ColoredBox(color: Theme.of(context).primaryColor),
          );
        },
      ),
    );
  }
}
