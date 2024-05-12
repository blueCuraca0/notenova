import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

class ButtonBack extends StatelessWidget{

  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: neumorphismShadowSmallCard,
          shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 24,
        ),
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
    );
  }
}