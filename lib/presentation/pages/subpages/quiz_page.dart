import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(70),
            alignment: Alignment.center,
            child: Text(
              "Quiz Page",
              style: TextStyle(
                  fontSize: 25
              ),
            ),
          )
        ],
      ),
    );
  }
}
