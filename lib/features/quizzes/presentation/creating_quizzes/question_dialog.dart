import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

class QuestionDialog extends StatelessWidget {
  final String title;
  final String button1;
  final String button2;
  final Function button1Action;
  final Function button2Action;

  const QuestionDialog(
      {super.key,
      required this.title,
      required this.button1,
      required this.button2,
      required this.button1Action,
      required this.button2Action});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).cardColor;
    final Color colorButton = Theme.of(context).primaryColor;

    return AlertDialog(
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      alignment: Alignment.center,
      backgroundColor: color,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        DialogButton(button1, colorButton, button1Action),
        DialogButton(button2, colorButton, button2Action),
      ],
    );
  }
}

class DialogButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function buttonAction;

  const DialogButton(this._text, this._color, this.buttonAction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        boxShadow: neumorphismShadowSmallCard,
        borderRadius: BorderRadius.circular(15),
      ),
      child: OutlinedButton(
        onPressed: () {
          buttonAction();
          Navigator.of(context).pop(); // to close the dialog
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: _color,
          side: const BorderSide(style: BorderStyle.none),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          _text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
