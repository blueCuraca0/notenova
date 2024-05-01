import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CColors.primary),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(15)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: CColors.text),
      ),
    );
  }
}
