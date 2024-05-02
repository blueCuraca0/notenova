import 'package:flutter/material.dart';
import 'quiz_page.dart';

import '../../../../core/style/c_colors.dart';
import 'card_learning_page.dart';

class StudyMaterialsPage extends StatelessWidget {
  const StudyMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // C A R D S
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CardPage();
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
                    return const QuizPage();
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
    );
  }
}
