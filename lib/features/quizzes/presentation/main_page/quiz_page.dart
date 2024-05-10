import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/main_page/quiz_card.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/create_quiz_layout.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';

/*final List<Quiz> _quizList = [
  Quiz(
      title: 'Pomodoro technique',
      category: 'Productivity',
      description:
          'The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. The technique uses a timer to break down work into intervals, traditionally 25 minutes in length, separated by short breaks.',
      image:
          'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
          'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
          'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
      'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
      'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
      'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
      'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
      'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
      'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
];*/

class QuizPage extends StatelessWidget {
  final expandedHeight = 200.0;
  int length =0;

  QuizPage({super.key});

  void createNewQuiz(BuildContext context) {
    context.read<QuizCubit>().createQuiz();
  }

  @override
  Widget build(BuildContext context) {
    length = context.read<QuizCubit>().quizzes.length;
    return Scaffold(
        body: Stack(
          children:[
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  floating: true,
                  pinned: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(
                            left: 20, top: constraints.maxHeight - 70),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.quizzes.tr(),
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(LocaleKeys.check_your_knowledge.tr(),
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        background: ColoredBox(color: Theme.of(context).primaryColor),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          CustomSearchBar(baseColor: Theme.of(context).cardColor,),
                          bigSizedBoxHeight,//TODO: Hardcoded string
                          Row(
                                  children: [
                                    CustomButton(text: 'All', onPressed: (){}, gradient: LinearGradient(colors: CColors.greenGradientColor,)),
                                    midSizedBoxWidth,
                                    BlocBuilder<QuizCubit, QuizState>(
                                          builder: (context, state) {
                                            return SizedBox(
                                              height: 60,
                                              width: MediaQuery.of(context).size.width*0.7,
                                              child: ListView.builder(itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Row(
                                                  children: [
                                                    CustomButton(
                                                      text: state.categories[index].name,
                                                      onPressed: () {},
                                                      gradient: LinearGradient(
                                                        colors: state.categories[index].gradient,
                                                      ),
                                                    ),
                                                    midSizedBoxWidth,
                                                  ],
                                                );
                                                },
                                                itemCount: state.categories.length,
                                                scrollDirection: Axis.horizontal,
                                              ),
                                            );
                                          }
                                        ),
                                  ],
                                ),
                            ],
                          ),
                      ),
                    ),
                  ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return BlocBuilder<QuizCubit, QuizState>(
                        builder: (context, state) {
                          return QuizCard(
                            quiz: state.quizzes[index],
                          );
                        },
                      );
                    },
                    childCount: length,
                  ),
                ),
              ],
            ),
            Positioned( //TODO: fix the button floating up
              left: largePadding.left,
              bottom: 100,
              child: CustomButton(
                color: CColors.darkGreen,
                height: 70,
                width: MediaQuery.of(context).size.width- largePadding.left - largePadding.right,
                text: LocaleKeys.create_new_quiz.tr(),
                onPressed: () {
                  createNewQuiz(context);
                  Navigator.push(
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

