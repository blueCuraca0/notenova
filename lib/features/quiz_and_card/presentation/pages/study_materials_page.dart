import 'package:flutter/material.dart';
import '../../../cards/presentation/subpages/quiz_page.dart';

import '../../../../core/style/c_colors.dart';
import '../../../cards/presentation/subpages/card_learning_page.dart';

class StudyMaterialsPage extends StatelessWidget {
  const StudyMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(70),
            alignment: Alignment.center,
            child: Text(
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
                    return CardPage();
                  }));
                },
                child: Container(
                  color: CColors.accent,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: Text("Cards"),
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
                  child: Text("Quizzes"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
