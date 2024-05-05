import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/features/cards/presentation/pages/create_card_stack_page.dart';
import 'package:notenova/features/cards/presentation/widgets/card_stack_list.dart';

import '../../../../core/style/c_colors.dart';

class CardStacksPage extends StatelessWidget {
  const CardStacksPage({super.key});

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

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
                    // padding: largePadding,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Column(
                            children: [
                              CustomSearchBar(width - largePadding.left - largePadding.right),
                              bigSizedBoxHeight,
                              CustomButton(
                                  text: "Create card stack",
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        _createRoute(const CreateCardStackPage()
                                    ));
                                  }
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: CardStackList(),
                        )
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
