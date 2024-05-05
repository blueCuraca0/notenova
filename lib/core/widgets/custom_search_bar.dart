import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/utils/constants.dart';

double searchBarHeight = 60;

class CustomSearchBar extends StatelessWidget {
  final double width;

  const CustomSearchBar(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    double availableWidth = width - buttonPadding.right - buttonPadding.left;

    return Container(
      decoration: BoxDecoration(
        boxShadow: shadowCard
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Align(
          child: Container(
            color: Colors.white,
            padding: buttonPadding,
            alignment: Alignment.center,
            height: searchBarHeight,
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey,),
                midSizedBoxWidth,
                Expanded(
                  child: TextField()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
