import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/take_quiz.dart';
import 'custom_category.dart';


class QuizCard extends StatelessWidget {
  Quiz quiz;

  QuizCard(
      {super.key,
        required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Column(
        children: [
          midSizedBoxHeight,
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return TakeQuizWindow(quiz: quiz);
              }));
            },
            child: Container(
              padding: smallPadding,
              decoration: BoxDecoration(
                color: CColors.white,
                boxShadow: const [
                  BoxShadow(
                    color: CColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  midSizedBoxWidth,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      quiz.image,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  midSizedBoxWidth,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.title,
                        style: const TextStyle(
                          fontSize: mediumTextSize,
                          color: Color(0xff334669),
                        ),
                      ),
                      CustomCategory(
                        category: quiz.category,
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


