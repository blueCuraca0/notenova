import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  late final double screenHeight;
  late final String? title;

  CustomAppBar({required this.screenHeight, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = screenHeight / 7;
    Widget buttonBack = Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: neumorphismShadowSmallCard,
          shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new, size: 24,),
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
    );

    return Container(
      height: appBarHeight,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: title == null
          ? buttonBack
          : Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: buttonBack
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(title!, style: Theme.of(context).textTheme.bodyLarge,)
                )
              ],
            )
    );
  }
}
