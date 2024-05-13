import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_app_bar.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

import '../../../../core/style/c_colors.dart';
import '../../domain/entities/flashcard_stack.dart';
import 'create_cards_page.dart';

class CreateCardStackPage extends StatefulWidget {
  const CreateCardStackPage({super.key});

  @override
  State<CreateCardStackPage> createState() => _CreateCardStackPageState();
}

class _CreateCardStackPageState extends State<CreateCardStackPage> {
  String title = "";
  String description = "";
  String category = "";
  int categoryIndex = -1;

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

  goToCreateCardsPage() {
    Navigator.of(context).push(
        _createRoute(CreateCardsPage(
            CardStack(
              title,
              [],
              description: description,
              category: category
            )
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - bottomNavBarHeight;

    return Scaffold(
      backgroundColor: CColors.accent,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height / 20 * 3,
            child: CustomAppBar(
              screenHeight: height,
              title: "New Card Stack",
              onPressedBack: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          midSizedBoxHeight,
          LightRoundedBG(
            height: height / 20 * 17 - (midSizedBoxHeight.height ?? 0) + bottomNavBarHeight,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // TITLE
                  Text(
                    "Title",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  midSizedBoxHeight,
                  MyCustomTextField(
                    baseColor: Theme.of(context).cardColor,
                    maxLines: 1,
                    onChanged: (value) {
                      title = value;
                    },
                  ),

                  bigSizedBoxHeight,

                  // DESCRIPTION
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  midSizedBoxHeight,
                  MyCustomTextField(
                    baseColor: Theme.of(context).cardColor,
                    height: 100,
                    onChanged: (value) {
                      description = value;
                    },
                  ),

                  bigSizedBoxHeight,

                  // CATEGORY
                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  midSizedBoxHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        text: "Code",
                        onPressed: () {
                          category = "Code";
                          setState(() {
                            if (categoryIndex == 0) {
                              categoryIndex = -1;
                            } else {
                              categoryIndex = 0;
                            }
                          });
                        },
                        buttonPadding: EdgeInsets.symmetric(
                          vertical: categoryIndex == 0 ? 10 : 7,
                          horizontal: categoryIndex == 0 ? 30 : 25,
                        ),
                        gradient: LinearGradient(colors: CColors.blueGradientColor),
                      ),
                      CustomButton(
                        text: "Work",
                        onPressed: () {
                          category = "Work";
                          setState(() {
                            if (categoryIndex == 1) {
                              categoryIndex = -1;
                            } else {
                              categoryIndex = 1;
                            }
                          });
                        },
                        buttonPadding: EdgeInsets.symmetric(
                          vertical: categoryIndex == 1 ? 10 : 7,
                          horizontal: categoryIndex == 1 ? 35 : 25,
                        ),
                        gradient: LinearGradient(colors: CColors.pinkGradientColor),
                      ),
                      CustomButton(
                        text: "English",
                        onPressed: () {
                          category = "English";
                          setState(() {
                            if (categoryIndex == 2) {
                              categoryIndex = -1;
                            } else {
                              categoryIndex = 2;
                            }
                          });
                        },
                        buttonPadding: EdgeInsets.symmetric(
                          vertical: categoryIndex == 2 ? 10 : 7,
                          horizontal: categoryIndex == 2 ? 35 : 25,
                        ),
                        gradient: LinearGradient(colors: CColors.greenGradientColor),
                      ),
                    ],
                  ),
                  midSizedBoxHeight,
                  Text(
                    "+ Add category",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  // CREATE STACK BUTTON
                  const Expanded(child: SizedBox()),
                  CustomButton(
                    text: "Create new card stack",
                    onPressed: () async {
                      goToCreateCardsPage();
                    },
                    buttonPadding: buttonPadding,
                  ),

                  const SizedBox(height: bottomNavBarHeight,)
                ],
              ),
            )

          ),
        ],
      ),
    );
  }
}
