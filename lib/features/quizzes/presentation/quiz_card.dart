import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';

class QuizCard extends StatelessWidget {
  String image;
  String title;
  String category;

  QuizCard(
      {super.key,
        required this.image,
        required this.title,
        required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Column(
        children: [
          midSizedBoxHeight,
          GestureDetector(
            child: Container(
              padding: smallPadding,
              decoration: BoxDecoration(
                color: CColors.white,
                boxShadow: const [
                  BoxShadow(
                    color: CColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  midSizedBoxWidth,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      image,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  midSizedBoxWidth,
                  Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: mediumTextSize,
                          color: Color(0xff334669),
                        ),
                      ),
                      Text(
                        category,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
