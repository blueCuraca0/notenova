import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/core/widgets/custom_textfield.dart';

import '../../../../core/style/c_colors.dart';

class CardStacksPage extends StatelessWidget {
  const CardStacksPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Scaffold(
        backgroundColor: CColors.accent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // header
                Container(
                  height: height / 5,
                  width: width,
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: largePadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cards",
                          style: titleTextStyle,
                        ),
                        Text(
                          "Let's study!",
                          style: subtitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),

                // lighter bg
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    color: CColors.accentSoft,
                    height: height / 5 * 4,
                    padding: largePadding,
                    child: Column(
                      children: [

                        // search bar
                        CustomSearchBar(width - largePadding.left - largePadding.right),
                        // CustomTextField(hintText: "some text"),

                        // create card stack button

                        // list of card stacks
                      ],
                    ),
                  ),
                )
              ],
            )

            // TODO: appbar, navbar etc.
          ],
        ),
      ),
    );
  }
}
