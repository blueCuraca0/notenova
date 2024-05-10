import 'package:flutter/material.dart';

import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  "Homepage",
                  style: TextStyle(fontSize: 25),
                ),
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
