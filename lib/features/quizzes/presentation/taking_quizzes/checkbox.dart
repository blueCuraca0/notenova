import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';

class CustomCheckBoxQA extends StatelessWidget {
  final int optionIndex;
  final int questionIndex;
  final String type;

  const CustomCheckBoxQA({  required this.optionIndex, required this.questionIndex, required this.type, super.key});

  bool isSelected(BuildContext context){
    return context.read<QuizCubit>().ifSelected(questionIndex, optionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<QuizCubit>().selectQuestionOption(questionIndex, optionIndex, type);
      },
      child: Stack(
        alignment: Alignment.center,
        children:[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(type=='single'? 15 : 3),
              border: Border.all(
                color: Theme.of(context).primaryColorDark,
                width: 2,
              ),
            ),
          ),
          BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: state.answers[questionIndex]![optionIndex] ? Theme.of(context).primaryColorDark : Theme.of(context).cardColor,
                  border: Border.all(
                    color: Theme.of(context).cardColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(type=='single'? 12 : 2),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}