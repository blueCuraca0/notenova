import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../domain/entities/flashcard.dart';

class WritingCardTile extends StatelessWidget {
  final Flashcard _flashcard;

  const WritingCardTile(this._flashcard, {super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChannels.textInput.invokeMethod("TextInput.show");

    return Padding(
      padding: const EdgeInsets.all(50),
      child: Container(
        height: 200,
        width: 300,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: neumorphismShadowLargeCardLeftLight,
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).cardColor,
          // color: CColors.darkGreen,
        ),
        child: Text(
          _flashcard.definition,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
