import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/summary/presentation/pages/summary_page.dart';
import 'package:notenova/features/quizzes/presentation/main_page/quiz_page.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../main.dart';
import '../../../cards/presentation/pages/card_stacks_page.dart';

import '../../../cards/presentation/pages/card_stacks_page.dart';

import '../../../../core/style/c_colors.dart';
import '../../../quizzes/presentation/main_page/quiz_page.dart';

class StudyMaterialsPage extends StatelessWidget {
  const StudyMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(70),
            alignment: Alignment.center,
            child: const Text(
              "Study Materials Page",
              style: TextStyle(fontSize: 25),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "Cards",
                      color: Theme.of(context).cardColor,
                      buttonPadding: buttonPadding,
                      width: width / 2 - 40,
                      height: bottomNavBarHeight * 3,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const CardStacksPage();
                        }));
                      },
                  //  Q I Z Z E S
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return QuizPage();
                      }));
                    },
                    child: Container(
                      color: CColors.accent,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: const Text("Quizzes"),
                    ),
                    CustomButton(
                      text: "Quizzes",
                      color: Theme.of(context).cardColor,
                      buttonPadding: buttonPadding,
                      width: width / 2 - 40,
                      height: bottomNavBarHeight * 3,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return QuizPage();
                        }));
                      },
                    ),
                  ],
                ),

                bigSizedBoxHeight,

                // S U M M A R Y
                CustomButton(
                  text: "Summaries",
                  color: Theme.of(context).cardColor,
                  buttonPadding: buttonPadding,
                  height: bottomNavBarHeight * 2,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const SummariesPage();
                    }));
                  },
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
