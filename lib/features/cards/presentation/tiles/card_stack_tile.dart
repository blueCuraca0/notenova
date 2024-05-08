import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/cards/presentation/pages/flashcard_page.dart';
import 'package:notenova/features/cards/presentation/widgets/learning_mode_dialod.dart';

import '../../../../core/style/c_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/flashcard_stack_model.dart';

class CardStackTile extends StatelessWidget {
  final CardStack _cardStack;

  const CardStackTile(this._cardStack, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => LearningModeDialog(_cardStack),
            barrierDismissible: true
          );
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            boxShadow: shadowCard,
            borderRadius: BorderRadius.circular(25),
            color: CColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _cardStack.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                _cardStack.cardsList.length == 1
                    ? "1 card"
                    : "${_cardStack.cardsList.length} cards",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
