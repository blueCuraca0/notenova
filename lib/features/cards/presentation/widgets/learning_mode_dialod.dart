import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/cards/presentation/pages/card_page.dart';

class LearningModeDialog extends StatelessWidget {
  const LearningModeDialog({super.key});

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
    return AlertDialog(
      title: Text("Learning Mode"),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,

      content: Text("Choose a prefered learning mode for this study session:"),
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      // contentTextStyle: Theme.of(context).textTheme.bodySmall,

      alignment: Alignment.center,
      backgroundColor: Theme.of(context).primaryColorDark,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(); // to close the dialog
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CardPage())
            );
          },
          child: Text(
            "Flashcards",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(); // to close the dialog
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CardPage())
            );
          },
          child: Text(
            "Writing",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              )
          ),
        ),
      ],
    );
  }
}
