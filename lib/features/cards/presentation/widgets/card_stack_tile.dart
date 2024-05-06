import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/cards/presentation/pages/card_page.dart';
import 'package:notenova/features/cards/presentation/widgets/learning_mode_dialod.dart';

import '../../../../core/style/c_colors.dart';
import '../../../../core/utils/constants.dart';

class CardStackTile extends StatelessWidget {
  final String cardStackName;
  final int numCards;

  const CardStackTile(this.cardStackName, this.numCards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => const LearningModeDialog(),
            barrierDismissible: true
          );
        },
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: shadowCard,),

          // TODO: Row with a card stack's cover (an image?)

          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: shadowCard,
                color: CColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cardStackName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    numCards == 1 ? "1 card" : "$numCards cards",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
