import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/checkbox_ans.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';


class CheckBlock extends StatelessWidget {
  final int indexQuestion;
  final int indexQuiz;

  const CheckBlock({super.key, required this.indexQuestion, required this.indexQuiz  });

  Quiz getQuiz(BuildContext context, int index){
    return context.read<QuizCubit>().currentQuiz(index);
  }

  Color borderColor(BuildContext context){
    for (int i = 0; i < getQuiz(context, indexQuiz).questions[indexQuestion].options.length; i++){
      if (context.read<QuizCubit>().checkBoxType(indexQuiz, i, indexQuestion) == 'red'){
        return Color(0xffE8897D); //TODO: hardcoded color
      }
    }
    return Theme.of(context).cardColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: lPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor(context),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text(state.quizzes[indexQuiz].questions[indexQuestion].question,
                   style: Theme.of(context).textTheme.bodyMedium),
                midSizedBoxHeight,
                Column(
                  children: List<Widget>.generate(state.quizzes[indexQuiz].questions[indexQuestion].options.length, (int optionIndex) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(state.quizzes[indexQuiz].questions[indexQuestion].options[optionIndex],
                              style: Theme.of(context).textTheme.bodySmall),
                          leading: CustomCheckBoxAns(optionIndex: optionIndex, questionIndex: indexQuestion, quizIndex: indexQuiz, type: state.quizzes[indexQuiz].questions[indexQuestion] is OneChoiceQuestion ? 'single' : 'multiple'),
                        ),
                        midSizedBoxHeight,
                      ],
                    );
                  }),
                ),
              ],
            );
          }
      ),
    );
  }
}