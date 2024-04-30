import 'package:flutter/material.dart';

import 'cards/card_learning_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // temporary solution, so you can just change current page
    List<Widget> temporaryPages = [
      const CardLearningPage(),
      // your pages
    ];
    int currentPageIndex = 0;

    return temporaryPages[currentPageIndex];
  }
}
