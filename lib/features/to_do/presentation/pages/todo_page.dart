import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/to_do/data/services/firebase_service.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/widgets/lists/task_calendar_list.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(TaskFirestoreService()),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          slivers: [
            CustomAppBarWidget(),
            SliverToBoxAdapter(child: CurrentTimeWidget()),
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
    Locale locale = context.locale;
    String monthFormat = 'MMMM';
    if (locale.languageCode == 'uk') {
      monthFormat = 'MMMM';
    } else {
      monthFormat = 'MMMM';
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
      child: Row(
        children: [
          Text('${DateTime.now().day.toString()} ',
              style: Theme.of(context).textTheme.bodyMedium),
          Text(
              '${DateFormat(monthFormat, locale.languageCode).format(DateTime.now())}, ',
              style: Theme.of(context).textTheme.bodyMedium),
          Text('${DateTime.now().year.toString()} ',
              style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
        ],
      ),
    );
  }
}

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({
    super.key,
  });

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.15,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      surfaceTintColor: Theme.of(context).primaryColor,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                left: 10, top: constraints.maxHeight - 70, right: 15),
            title: Padding(
              padding: smallerPadding,
              child: Row(
                children: [
                  smallSizedBoxWidth,
                  Text(LocaleKeys.to_do1.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 20)),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  smallSizedBoxWidth,
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
