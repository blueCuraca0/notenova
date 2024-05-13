import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/quizzes/presentation/main_page/quiz_card.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/create_quiz_layout.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_sort_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_sort_states.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
//import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/features/quizzes/presentation/button_back.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/core/widgets/custom_button_2.dart';

import '../../domain/entities/quiz.dart';

//TODO: create sorting by category


class QuizPage extends StatelessWidget {
  final expandedHeight = 200.0;
  Category all = Category(name: 'All', gradient: CColors.greenGradientColor, darkGradient: CColors.darkGreenGradientColor, id: '0');
  Category? currentCategory;

  QuizPage({super.key});

  int length = 0;

  void createNewQuiz(BuildContext context) {
    context.read<QuizCubit>().createQuiz();
  }

  @override
  Widget build(BuildContext context) {
    length = context.read<QuizCubit>().quizzes.length;
    context.read<QuizCubit>().loadQuizzes(Quiz.empty());
    context.read<QuizSortCubit>().sortByCategory(all, context.read<QuizCubit>().quizzes);
    context.read<QuizCubit>().sortedQuizzes();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                leadingWidth: 80,
                leading: const ButtonBack(),
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                floating: true,
                pinned: true,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                          left: 20, top: constraints.maxHeight - 80),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.quizzes.tr(),
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(LocaleKeys.check_your_knowledge.tr(),
                              style: Theme.of(context).textTheme.bodyMedium),
                          midSizedBoxHeight,
                        ],
                      ),
                      background:
                          ColoredBox(color: Theme.of(context).primaryColor),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<QuizSortCubit, QuizSortState>(
                  builder: (context, stateSort) {
                    return Container(
                      height: stateSort.quizzesSort.length >1  ? null : MediaQuery.of(context).size.height * 0.8,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            bigSizedBoxHeight,
                            Row(
                                  children: [
                                    CustomButton(
                                        text: all.name,
                                        onPressed: () {
                                          context.read<QuizSortCubit>().sortByCategory(all, context.read<QuizCubit>().quizzes);
                                        },
                                        gradient: LinearGradient(
                                          colors: all == stateSort.category ? all.darkGradient!: all.gradient,
                                        )),
                                    midSizedBoxWidth,
                                    BlocBuilder<QuizCubit, QuizState>(
                                        builder: (context, state) {
                                      return SizedBox(
                                        height: 60,
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: ListView.builder(
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Row(
                                              children: [
                                                CustomButton(
                                                  text: state.categories[index].name,
                                                  onPressed: () {
                                                    context.read<QuizSortCubit>().sortByCategory(state.categories[index], state.quizzes);
                                                    context.read<QuizCubit>().sortedQuizzes();
                                                  },
                                                  gradient: LinearGradient(
                                                    colors: state.categories[index] == stateSort.category ? state.categories[index].darkGradient!: state.categories[index].gradient,),),
                                                midSizedBoxWidth,
                                              ],
                                            );
                                          },
                                          itemCount: state.categories.length,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                            bigSizedBoxHeight,
                            BlocBuilder<QuizCubit,QuizState>(
                              builder: (context, state) {
                                if (state is QuizAdded  || state is QuizDeleted){
                                context.read<QuizCubit>().loadQuizzes(Quiz.empty());
                                }
                                if (state is QuizzesLoading){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 0.8,
                                    child: Center(
                                      child: CircularProgressIndicator(color: Theme.of(context).primaryColorDark),
                                    ),
                                  );}
                                else {
                                return Column(
                                  children: [
                                    BlocBuilder<QuizSortCubit, QuizSortState>(
                                      builder: (context, stateSort) {
                                        if (state is QuizAdded || state is QuizDeleted || state is QuizzesLoaded){
                                          context.read<QuizSortCubit>().sortByCategory(stateSort.category, state.quizzes);
                                          context.read<QuizCubit>().sortedQuizzes();
                                        }
                                        return Column(
                                          children:  List<Widget>.generate(stateSort.quizzesSort.length,
                                            (int index) {
                                              return QuizCard(
                                                    quiz: stateSort.quizzesSort[index],
                                                  );
                                                },
                                              ),
                                        );
                                      }
                                    ),
                                    const SizedBox(
                                      height: 100,),
                                  ],
                                );
                                }

                              }
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
          Positioned(
            left: largePadding.left,
            bottom: 100,
            child: CustomButton2(
              textColor: Theme.of(context).textTheme.bodySmall!.color,
              color: Theme.of(context).primaryColorDark,
              height: 70,
              width: MediaQuery.of(context).size.width -
                  largePadding.left -
                  largePadding.right,
              text: LocaleKeys.create_new_quiz.tr(),
              onPressed: () async {
                createNewQuiz(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizLayout(),
                  ),
                );
                length = context.read<QuizCubit>().quizzes.length;
              },
            ),
          ),
        ],
      ),
    );
  }
}
