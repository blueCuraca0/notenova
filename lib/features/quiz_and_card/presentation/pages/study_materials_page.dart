import 'package:flutter/material.dart';
import 'package:notenova/features/quizzes/presentation/main_page/quiz_page.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../main.dart';
import '../../../cards/presentation/pages/card_stacks_page.dart';

import '../../../cards/presentation/pages/card_stacks_page.dart';

import '../../../../core/style/c_colors.dart';

class StudyMaterialsPage extends StatelessWidget {
  const StudyMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(70),
                alignment: Alignment.center,
                child: const Text(
                  "Study Materials Page",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // C A R D S
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const CardStacksPage();
                      }));
                    },
                    child: Container(
                      color: CColors.accent,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: const Text("Cards"),
                    ),
                  ),

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
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: height,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavBar(MyApp.navigatorKey)
            ),
          )
        ],
      ),
    );
  }
}
