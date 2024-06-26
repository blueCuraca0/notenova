import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Gradient? gradient;
  final EdgeInsetsGeometry buttonPadding;
  final double? height;
  final double? width;
  final Color? color;

  const CustomButton({
    super.key,
    this.height,
    this.width,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.color,
    this.buttonPadding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: getShadowCard(context),
          color: color ?? Theme.of(context).primaryColorDark,
          gradient: gradient,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: buttonPadding,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: gradient != null
                  ? CColors.white
                  : Theme.of(context).textTheme.bodySmall!.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
