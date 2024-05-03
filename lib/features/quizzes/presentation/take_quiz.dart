import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/features/quizzes/presentation/custom_category.dart';

class TakeQuizWindow extends StatelessWidget {
  Quiz quiz;

  TakeQuizWindow({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.accent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: CColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: CColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: lPadding,
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(quiz.image,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  midSizedBoxWidth,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.title,
                          style: TextStyle(
                            fontSize: mediumTextSize,
                            color: CColors.text,
                          ),
                        ),
                       CustomCategory(category: quiz.category),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                quiz.description,
                style: TextStyle(
                  fontSize: smallTextSize,
                  color: CColors.text,
                ),
              ),
              ],
        ),
      ),
      ),
    );
  }
}