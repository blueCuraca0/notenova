import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button_2.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/take_quiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'dart:io';
import 'package:notenova/features/quizzes/domain/entities/category.dart';

class QuizCard extends StatelessWidget {
  Quiz quiz;

  QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Column(
        children: [
          midSizedBoxHeight,
          GestureDetector(
            onLongPress: (){
            context.read<QuizCubit>().deleteQuiz(quiz);
            },
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TakeQuizWindow(quiz: quiz);
              }));
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: const Offset(10, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  midSizedBoxWidth,
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      quiz.image,
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width * 0.26,
                      fit: BoxFit.cover,
                    ),
                  ),
                  bigSizedBoxWidth,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          smallSizedBoxWidth,
                           FittedBox(
                             fit: BoxFit.scaleDown,
                             child: Text(
                                quiz.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                           ),
                          
                        ],
                      ),
                      midSizedBoxHeight,
                      CustomButton2(
                        textColor: CColors.white,
                        text: quiz.category == null
                            ? "Unknown"
                            : quiz.category!.name,
                        onPressed: () {},
                        gradient: LinearGradient(
                          colors: quiz.category == null
                              ? CColors.pinkGradientColor
                              : quiz.category!.gradient,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
