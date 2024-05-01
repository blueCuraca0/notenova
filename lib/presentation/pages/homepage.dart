import 'package:flutter/material.dart';

import 'subpages/card_learning_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(70),
            alignment: Alignment.center,
            child: Text(
              "Homepage",
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
