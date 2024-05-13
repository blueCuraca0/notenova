import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/take_question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/core/widgets/custom_button_2.dart';
import 'package:notenova/features/quizzes/presentation/button_back.dart';
import 'dart:io';

class TakeQuizWindow extends StatelessWidget {
  Quiz quiz;

  TakeQuizWindow({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0,
        leading: ButtonBack(),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          spacer,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spacer,
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: lPadding,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: quiz.image == 'https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg'? Image.network(
                                quiz.image,
                                height: MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width * 0.26,
                                fit: BoxFit.cover,
                              ): Image.file(File(quiz.image!),
                                height: MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width * 0.26,
                                fit: BoxFit.cover,),
                            ),
                          ),
                          bigSizedBoxWidth,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                spacer,
                                Text(
                                  quiz.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                midSizedBoxHeight,
                                FittedBox(
                                  child: CustomButton(
                                    text: quiz.category == null
                                        ? 'Unknown'
                                        : quiz.category!.name,
                                    onPressed: () {},
                                    gradient: LinearGradient(
                                      colors: quiz.category == null
                                          ? CColors.pinkGradientColor
                                          : quiz.category!.gradient,
                                    ),
                                  ),
                                ),
                                spacer,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    midSizedBoxHeight,
                    Expanded(
                      flex: 2,
                      child: ListView(
                        children: [
                          Text(
                            quiz.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomButton2(
                        text: LocaleKeys.take_quiz.tr(),
                        textColor: Theme.of(context).textTheme.bodySmall!.color,
                        onPressed: () {
                          context.read<QuizCubit>().startQuiz(
                              context.read<QuizCubit>().quizIndex(quiz));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TakeQuestion(
                                question: quiz.questions[0],
                                indexQuestion: 0,
                                percentage: 0,
                                quiz: quiz);
                          }));
                        },
                      ),
                    ),
                    bigSizedBoxHeight,
                  ],
                ),
              ),
              spacer,
            ],
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
