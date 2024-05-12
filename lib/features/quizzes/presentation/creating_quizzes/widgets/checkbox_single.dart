import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';

class CustomCheckBox extends StatelessWidget {
  final int optionIndex;
  final int questionIndex;
  final String type;

  const CustomCheckBox({  required this.optionIndex, required this.questionIndex, required this.type, super.key});

  bool isSelected(BuildContext context){
    return context.read<QuizCubit>().isSelected(questionIndex, optionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<QuizCubit>().selectOption(questionIndex, optionIndex);
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
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isSelected(context) ? Theme.of(context).primaryColorDark : Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).cardColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(type=='single'? 12 : 2),
            ),
          ),
        ],
      ),
    );
  }
}