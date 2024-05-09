import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/features/cards/presentation/pages/create_card_stack_page.dart';
import 'package:notenova/features/cards/presentation/widgets/card_stack_list.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

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
    double height = MediaQuery.of(context).size.height - bottomNavBarHeight;

    return Material(
      child: Scaffold(
        backgroundColor: CColors.accent,
        resizeToAvoidBottomInset: false,
        body: Column(
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
            LightRoundedBG(
              height: height / 5 * 4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 30,
                    ),
                    child: Column(
                      children: [
                        CustomSearchBar(baseColor: Theme.of(context).cardColor),
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
            )
          ],
        ),
      ),
    );
  }
}
