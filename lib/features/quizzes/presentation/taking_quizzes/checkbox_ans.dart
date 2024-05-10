import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';

class CustomCheckBoxAns extends StatelessWidget {
  final int optionIndex;
  final int questionIndex;
  final int quizIndex;
  final String type;

  const CustomCheckBoxAns({  required this.optionIndex, required this.questionIndex, required this.type,  required this.quizIndex, super.key});

  Color checkBoxColor(BuildContext context){
    String type = context.read<QuizCubit>().checkBoxType(quizIndex, optionIndex, questionIndex);
    if (type == 'green'){
      print('single');//TODO: print
      return Theme.of(context).primaryColorDark;
    }
    else if (type == 'red'){
      print('multiple');//TODO: print
      return Color(0xffE8897D); //TODO: hardcoded color
    }
    else{
      return Theme.of(context).cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    color: checkBoxColor(context),
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
    );
  }
}