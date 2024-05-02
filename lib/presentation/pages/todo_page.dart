import 'package:flutter/material.dart';


class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(70),
            alignment: Alignment.center,
            child: const Text(
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
