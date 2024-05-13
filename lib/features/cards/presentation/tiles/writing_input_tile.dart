import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

import '../../../../core/style/c_colors.dart';

class WritingInputTile extends StatefulWidget {
  const WritingInputTile({super.key});

  @override
  State<WritingInputTile> createState() => _WritingInputTileState();
}

class _WritingInputTileState extends State<WritingInputTile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: Theme.of(context).cardColor,
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.navigate_next_outlined,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  )
                ),
                hintText: 'term...',
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
