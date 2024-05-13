import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/domain/entities/flashcard.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';

class CardEditingTile extends StatelessWidget {
  final List<Flashcard> _cardList;
  final int _id;

  const CardEditingTile(this._cardList, this._id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: neumorphismShadowSmallCard
        ),
        child: Column(
          children: [
            SimpleTextField(55, LocaleKeys.term.tr(), (value) {
              _cardList[_id].term = value;
            }),

            midSizedBoxHeight,

            SimpleTextField(100, LocaleKeys.definition.tr(), (value) {
              _cardList[_id].definition = value;
            }),
          ],
        ),
      ),
    );
  }
}

class SimpleTextField extends StatelessWidget {
  final double height;
  final String hintText;
  final void Function(String) onChanged;

  const SimpleTextField(this.height, this.hintText, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: neumorphismShadowSmallCard
      ),
      child: TextField(
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          // border: OutlineInputBorder(),
          // isCollapsed: true,
        ),
      ),
    );
  }
}

