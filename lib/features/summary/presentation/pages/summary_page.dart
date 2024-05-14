import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/summary/data/services/firebase_services.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_cubit.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_state.dart';
import 'package:notenova/features/summary/presentation/pages/create_edit_summary_sheet.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';
import 'package:notenova/features/summary/presentation/widgets/summary_list.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SummaryCubit(SummaryFirestoreService()),
        child: const SummariesPage(),
      ),
    );
  }
}

class SummariesPage extends StatefulWidget {
  const SummariesPage({super.key});

  @override
  State<SummariesPage> createState() => _SummariesPageState();
}

class _SummariesPageState extends State<SummariesPage> {
  String selectedCategory = 'Exams';
  List<String> categoryIds = [
    'Exams',
    'Lectures',
    'Workshops',
    'Seminars',
    'Practices',
    'Lab_works'
  ];
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SummaryCubit>(context).loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    final SummaryCubit summaryCubit = BlocProvider.of<SummaryCubit>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10),
          child: Row(
            children: [
              CustomArrowBackButton(
                  height: 40,
                  width: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              midSizedBoxWidth,
              midSizedBoxWidth,
              Text(
                LocaleKeys.my_summary.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 27),
              ),
              midSizedBoxHeight,
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: smallPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              midSizedBoxHeight,
              CustomButton(
                  color: Theme.of(context).primaryColorLight,
                  text: LocaleKeys.create_summary.tr(),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return EditAndCreateSummaryPage(
                          isEdit: false,
                          summaryCubit: summaryCubit,
                        );
                      },
                    );
                  }),
              midSizedBoxHeight,
              _selectCategoryButton(),
              BlocBuilder<SummaryCubit, SummaryState>(
                builder: (context, state) {
                  if (state is SummaryLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 300.0),
                      child: Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 10.0,
                            color: Theme.of(context).shadowColor),
                      ),
                    );
                  } else if (state is SummaryLoaded) {
                    final summaries = state.summaries;

                    // filtration for category
                    List<Summary> filteredSummary = summaries
                        .where(
                            (summary) => summary.category == selectedCategory)
                        .toList();
                    return SummaryList(
                        filteredSummary: filteredSummary,
                        summaryCubit: summaryCubit);
                  } else if (state is SummaryError) {
                    return Text(
                      ' ${state.errorMessage}',
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              bigSizedBoxHeight,
              bigSizedBoxHeight,
              midSizedBoxHeight,
              midSizedBoxHeight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectCategoryButton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryIds.map((category) {
          return _buildCategoryButton(category, context);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryButton(String categoryId, BuildContext context) {
    String categoryTranslation = getCategoryTranslation(categoryId);

    return TextButton(
      onPressed: () {
        setState(() {
          selectedCategory = categoryId;
          BlocProvider.of<SummaryCubit>(context).loadSummary();
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 10),
        child: Text(categoryTranslation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: selectedCategory == categoryId
                      ? FontWeight.bold
                      : FontWeight.normal,
                )),
      ),
    );
  }

  String getCategoryTranslation(String categoryId) {
    switch (categoryId) {
      case 'Exams':
        return LocaleKeys.exams.tr();
      case 'Lectures':
        return LocaleKeys.lectures.tr();
      case 'Workshops':
        return LocaleKeys.workshops.tr();
      case 'Seminars':
        return LocaleKeys.seminars.tr();
      case 'Practices':
        return LocaleKeys.practices.tr();
      case 'Lab_works':
        return LocaleKeys.lab_works.tr();
      default:
        return '';
    }
  }
}
