import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/themes.dart';

double searchBarHeight = 60;

class CustomSearchBar extends StatelessWidget {
  final double width;

  const CustomSearchBar(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    double availableWidth = width;

    return Container(
      decoration: BoxDecoration(boxShadow: shadowCard),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Align(
          child: Container(
            width: availableWidth,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            height: searchBarHeight,
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              // decoration: InputDecoration.collapsed(hintText: "searching for..."),
              decoration: const InputDecoration(
                isCollapsed: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
              ),
            ),
          ),
        ),
      ),
    );
  }
}
