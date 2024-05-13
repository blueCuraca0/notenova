import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'question_row.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';


class QuestionBlock extends StatelessWidget {
  final int index;

  const QuestionBlock({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomTextField(
                  baseColor: Theme.of(context).cardColor,
                  hintText: LocaleKeys.question.tr(),
                  onChanged: (value) {
                    context.read<QuizCubit>().updateQuestion(index, value);
                  },
                ),
                midSizedBoxHeight,
                Column(
                  children: List<Widget>.generate(state.newQuiz!.questions[index].options.length, (int optionIndex) {
                    return Column(
                      children: [
                        QuestionRow(optionIndex: optionIndex,
                          type: state.newQuiz!.questions[index] is OneChoiceQuestion ? 'single' : 'multiple',
                          questionIndex: index,
                          deleteOption: (){
                            context.read<QuizCubit>().deleteOption(index, optionIndex);
                          },
                          onChangedText: (value){
                            state.newQuiz!.questions[index].options[optionIndex] = value;
                          },),
                        midSizedBoxHeight,
                      ],
                    );
                  }),
                ),
                TextButton(onPressed: (){
                  if (state.newQuiz!.questions[index].options.length < 5){
                    context.read<QuizCubit>().addOption(index);
                  }
                },
                  child: Text("+ ${LocaleKeys.add_option.tr()}",
                      style: Theme.of(context).textTheme.bodySmall
                  ),),
              ],
            );
          }
      ),
    );
  }
}