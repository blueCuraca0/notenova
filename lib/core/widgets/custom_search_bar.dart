import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            height: 60,
            child: Row(
              children: [
                Icon(Icons.search),
                TextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
