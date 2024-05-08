import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';

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
                      child: Image.network(
                        quiz.image,
                      ),
                    ),
                    midSizedBoxWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          midSizedBoxHeight,
                          FittedBox(
                            child: CustomButton(
                              text: quiz.category,
                              onPressed: () {},
                              gradient: LinearGradient(
                                colors: CColors.pinkGradientColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  quiz.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  text: LocaleKeys.take_quiz.tr(),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MyCustomTextField(
                        gradientColor: Color(0xffCCD9E4),
                        baseColor: Colors.white,
                        width: 400,
                        height: 200,
                        title: 'Title',
                        maxLines: 8,
                      );
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
