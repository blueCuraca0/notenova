import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';

class WritingInputTile extends StatefulWidget {
  final String _term;
  final Function _nextFlashcard;
  final Function _plusOneLearned;

  const WritingInputTile(this._term, this._nextFlashcard, this._plusOneLearned, {super.key});

  @override
  State<WritingInputTile> createState() => _WritingInputTileState();
}

class _WritingInputTileState extends State<WritingInputTile> {
  late TextStyle? answerStyle;
  late Widget? suffixButton;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  void checkAnswer() {
    if (_controller.text == widget._term) {
      widget._plusOneLearned();
      widget._nextFlashcard();
      _controller.clear();
    } else {
      _controller.text = widget._term;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    answerStyle = Theme.of(context).textTheme.bodyMedium;
    suffixButton = IconButton(
        color: Theme.of(context).cardColor,
        onPressed: () {
          checkAnswer();
        },
        icon: Icon(
          Icons.navigate_next_outlined,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        )
    );

    return Container(
      height: bottomNavBarHeight,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Theme.of(context).primaryColorDark,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style: answerStyle,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.add,
                  color: Colors.transparent,
                ),
                suffixIcon: suffixButton,
                hintText: "${LocaleKeys.term.tr()}...",
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                border: InputBorder.none
              ),
            ),
          ),
        ],
      ),
    );
  }
}
