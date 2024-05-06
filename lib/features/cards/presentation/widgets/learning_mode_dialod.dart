import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/data/models/flashcard_stack_model.dart';
import 'package:notenova/features/cards/presentation/pages/flashcard_page.dart';
import 'package:notenova/features/cards/presentation/pages/writing_card_page.dart';

class LearningModeDialog extends StatelessWidget {
  final CardStack _cardStack;
  const LearningModeDialog(this._cardStack, {super.key});

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return AlertDialog(
      title: Text("Learning Mode"),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      content: Text("Choose a prefered learning mode for this study session:"),
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      alignment: Alignment.center,
      backgroundColor: color,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        DialogButton("Flashcards", FlashcardPage(_cardStack), color),
        DialogButton("Writing", WritingCardPage(), color),
      ],
    );
  }
}

class DialogButton extends StatelessWidget {
  final String _text;
  final Widget _page;
  final Color _color;

  const DialogButton(this._text, this._page, this._color, {super.key});

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
          Navigator.of(context).pop(); // to close the dialog
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => _page)
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: _color,
          side: const BorderSide(style: BorderStyle.none),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
        ),
        child: Text(
          _text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

