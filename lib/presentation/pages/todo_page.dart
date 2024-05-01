import 'package:flutter/material.dart';

import 'subpages/card_learning_page.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(70),
            alignment: Alignment.center,
            child: Text(
              "To-Do Page",
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
