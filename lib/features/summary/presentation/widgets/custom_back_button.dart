import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';

class CustomArrowBackButton extends StatelessWidget {
  final Function onPressed;
  final double? height;
  final double? width;
  const CustomArrowBackButton({
    super.key,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: shadowCard,
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: IconButton(
        onPressed: () => onPressed(),
        icon: const Icon(
          size: 20,
          Icons.arrow_back_ios_new,
          color: CColors.textDark,
        ),
      ),
    );
  }
}
