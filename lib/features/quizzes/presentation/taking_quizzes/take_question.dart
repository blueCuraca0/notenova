import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/checkbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/check_answers.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';

class TakeQuestion extends StatelessWidget {
  final Question question;
  final int indexQuestion;
  final double percentage;
  final Quiz quiz;

  const TakeQuestion(
      {super.key,
      required this.question,
      required this.indexQuestion,
      required this.percentage,
      required this.quiz});

  Question getNextQuestion(BuildContext context, int index) {
    int quizIndex = getQuizIndex(context, quiz);
    return context.read<QuizCubit>().getNextQuestion(index, quizIndex);
  }

  double getPercentage(BuildContext context, int index) {
    return context.read<QuizCubit>().getPercentage(index);
  }

  bool isLastQuestion(BuildContext context, int index) {
    return context.read<QuizCubit>().isLast(index);
  }

  int getQuizIndex(BuildContext context, Quiz quiz) {
    return context.read<QuizCubit>().indexQuiz(quiz);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBar(percentage: percentage),
            bigSizedBoxHeight,
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: lPadding,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacer,
                  Text(question.question,
                      style: Theme.of(context).textTheme.bodyLarge),
                  bigSizedBoxHeight,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      children: List<Widget>.generate(question.options.length,
                          (int optionIndex) {
                        return Expanded(
                          child: ListTile(
                            title: Text(question.options[optionIndex],
                                style: Theme.of(context).textTheme.bodyMedium),
                            leading: CustomCheckBoxQA(
                              optionIndex: optionIndex,
                              questionIndex: indexQuestion,
                              type: question is OneChoiceQuestion
                                  ? 'single'
                                  : 'multiple',
                            ),

                            //leading: Icon(Icons.check_box_outline_blank),
                          ),
                        );
                      }),
                    ),
                  ),
                  spacer,
                  Row(
                    children: [
                      spacer,
                      CustomButton(
                        text: LocaleKeys.next.tr(),
                        onPressed: () {
                          if (isLastQuestion(context, indexQuestion)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckAnswers(
                                        indexQuiz:
                                            getQuizIndex(context, quiz))));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TakeQuestion(
                                          question: getNextQuestion(
                                              context, indexQuestion + 1),
                                          indexQuestion: indexQuestion + 1,
                                          percentage: getPercentage(
                                              context, indexQuestion + 1),
                                          quiz: quiz,
                                        )));
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      spacer
                    ],
                  ),
                  spacer,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBar extends StatelessWidget {
  final double percentage;

  const CustomBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: Theme.of(context).shadowColor,
              width: 2,
            ),
          ),
        ),
        Positioned(
          top: 2,
          left: 2,
          child: Container(
            height: 16,
            width: MediaQuery.of(context).size.width * 0.8 * percentage,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
