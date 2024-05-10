import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/summary/data/firebase_services.dart';
import 'package:notenova/features/summary/domain/entities/summary_model.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_cubit.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_state.dart';
import 'package:notenova/features/summary/presentation/pages/create_edit_summary_page.dart';
import 'package:notenova/features/summary/presentation/pages/detail_summary_page.dart';
import 'package:notenova/features/summary/presentation/widgets/cards/summary_card.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';

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
  String selectedCategory = LocaleKeys.exams.tr();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SummaryCubit>(context).loadSummary();
  }

  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(context).textTheme.bodyLarge,
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
                        return const EditAndCreateSummaryPage();
                      },
                    );
                  }),
              midSizedBoxHeight,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton(LocaleKeys.exams.tr(), context),
                    _buildCategoryButton(LocaleKeys.lectures.tr(), context),
                    _buildCategoryButton(LocaleKeys.workshops.tr(), context),
                    _buildCategoryButton(LocaleKeys.seminars.tr(), context),
                    _buildCategoryButton(LocaleKeys.practices.tr(), context),
                    _buildCategoryButton(LocaleKeys.lab_works.tr(), context),
                  ],
                ),
              ),
              BlocBuilder<SummaryCubit, SummaryState>(
                builder: (context, state) {
                  if (state is SummaryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SummaryLoaded) {
                    final summaries = state.summaries;
                    List<Summary> filteredSummary = summaries
                        .where(
                            (summary) => summary.category == selectedCategory)
                        .toList();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          filteredSummary.isEmpty ? 1 : filteredSummary.length,
                      itemBuilder: (context, index) {
                        if (filteredSummary.isEmpty) {
                          return Center(
                              child: Text(
                            'No summary yet',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ));
                        } else {
                          final summary = filteredSummary[index];
                          return GestureDetector(
                            onTap: () => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DetailSummaryPage(summary: summary);
                                },
                              ),
                            },
                            child: SummaryCard(summary: summary),
                          );
                        }
                      },
                    );
                  } else if (state is SummaryError) {
                    return Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
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

  Widget _buildCategoryButton(String category, BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
          BlocProvider.of<SummaryCubit>(context).loadSummary();
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 10),
        child: Text(category,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: selectedCategory == category
                      ? FontWeight.bold
                      : FontWeight.normal,
                )),
      ),
    );
  }
}
