import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/style/c_colors.dart';

class CustomCategory extends StatelessWidget {
  final String category;

  CustomCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: smallPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: CColors.pinkGradientColor,
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        category,
        style: const TextStyle(color: CColors.white),
      ),
    );
  }
}
