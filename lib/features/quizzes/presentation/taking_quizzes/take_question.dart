import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/checkbox.dart';


class TakeQuestion extends StatelessWidget{
  final Question question;
  final int indexQuestion;
  final double percentage;

  const TakeQuestion({super.key, required this.question, required this.indexQuestion, required this.percentage});

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
                        Text(question.question,
                            style: Theme.of(context).textTheme.bodyLarge),
                        bigSizedBoxHeight,
                        Column(
                          children: List<Widget>.generate(question.options.length, (int optionIndex) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(question.options[optionIndex],
                                      style: Theme.of(context).textTheme.bodyMedium),
                                  leading: Container(
                                    width: 50,
                                    child: CustomCheckBoxQA(
                                      optionIndex: optionIndex,
                                      questionIndex: indexQuestion,
                                      type: question is OneChoiceQuestion ? 'single' : 'multiple',),
                                  ),
                                  //leading: Icon(Icons.check_box_outline_blank),
                                  ),
                                bigSizedBoxHeight,
                              ],
                            );
                          }),
                        ),
                        Row(
                          children: [
                            spacer,
                            CustomButton(text: LocaleKeys.next.tr(), onPressed: (){},
                            width: MediaQuery.of(context).size.width*0.4,),
                            spacer
                          ],
                        )
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBar extends StatelessWidget{
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