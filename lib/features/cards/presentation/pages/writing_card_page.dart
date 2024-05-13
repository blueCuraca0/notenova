import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';
import '../../../../core/widgets/congratulations_dialog.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../autorization/data/firebase_service.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/flashcard_stack.dart';
import '../tiles/writing_card_tile.dart';
import '../tiles/writing_input_tile.dart';

class WritingCardPage extends StatefulWidget {
  final CardStack _cardStack;
  final void Function(BuildContext context) _goBack;

  const WritingCardPage(this._cardStack, this._goBack, {super.key});

  @override
  State<WritingCardPage> createState() => _WritingCardPageState();
}

class _WritingCardPageState extends State<WritingCardPage> {
  List<Flashcard> _flashcardList = [];
  int _currentFlashcard = 0;

  int _wellLearnedCards = 0;
  int _needRepeatCards = 0;

  @override
  void initState() {
    super.initState();
    _flashcardList = widget._cardStack.cardsList;
  }

  void nextFlashCard() {
    if (_currentFlashcard < _flashcardList.length - 1) {
      setState(() {
        _currentFlashcard++;
      });
    } else {
      FirebaseServiceAuth.updateUserXP(_wellLearnedCards);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => CongratulationsDialog(
              title: LocaleKeys.congratulations.tr(),
              content: '${LocaleKeys.this_stack_is_finished.tr()}\n'
                  '${LocaleKeys.your_results_are.tr()}'
                  '$_wellLearnedCards/${_flashcardList.length}',
              actionText: LocaleKeys.back_to_card_stacks.tr(),
              goBack: (dialogContext) {
                Navigator.of(dialogContext).pop();
                widget._goBack(context);
              }
          )
      );
    }
  }

  void plusOneWellLearnedCard() {
    setState(() {
      _wellLearnedCards++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: height / 15 * 2,
              child: CustomAppBar(
                screenHeight: height,
                title: widget._cardStack.name,
                onPressedBack: () {
                  widget._goBack(context);
                },
              ),
            ),
            Container(
              // color: Colors.cyanAccent.withOpacity(0.1),
              height: height / 15,
              alignment: Alignment.center,
              child: Text(
                "${_wellLearnedCards + _needRepeatCards}/${_flashcardList.length}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              height: height / 15 * 12,
              width: width,
              alignment: Alignment.center,
              child: Column(
                children: [
                  WritingCardTile(
                      widget._cardStack.cardsList[_currentFlashcard]
                  ),
                  WritingInputTile(
                      widget._cardStack.cardsList[_currentFlashcard].term,
                      nextFlashCard,
                      plusOneWellLearnedCard
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).primaryColorDark,
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
