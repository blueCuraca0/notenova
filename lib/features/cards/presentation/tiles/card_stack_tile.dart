import 'package:flutter/material.dart';
import 'package:notenova/features/cards/presentation/widgets/learning_mode_dialod.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/flashcard_stack.dart';

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
              barrierDismissible: true);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            boxShadow: getShadowCard(context),
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).cardColor,
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
