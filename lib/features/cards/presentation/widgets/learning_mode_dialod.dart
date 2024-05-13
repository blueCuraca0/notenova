import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/presentation/pages/flashcard_page.dart';
import 'package:notenova/features/cards/presentation/pages/writing_card_page.dart';
import '../../../../core/utils/languages/generated/locale_keys.g.dart';
import '../../domain/entities/flashcard_stack.dart';

class LearningModeDialog extends StatelessWidget {
  final CardStack _cardStack;
  const LearningModeDialog(this._cardStack, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return AlertDialog(
      title: Text(LocaleKeys.learning_mode.tr()),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      content: Text(LocaleKeys.learning_mode_description.tr()),
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      alignment: Alignment.center,
      backgroundColor: color,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        DialogButton(
            LocaleKeys.flashcards.tr(),
            FlashcardPage(
              _cardStack,
              (context) {
                Navigator.of(context).pop();
              }
            ),
            color),
        DialogButton(
            LocaleKeys.writing.tr(),
            WritingCardPage(
              _cardStack,
              (context) {
                Navigator.of(context).pop();
              }
            ),
            color
        ),
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

