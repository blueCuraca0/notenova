import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/features/cards/presentation/pages/create_card_stack_page.dart';
import 'package:notenova/features/cards/presentation/widgets/card_stack_list.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';
import '../../../../core/utils/languages/generated/locale_keys.g.dart';

class CardStacksPage extends StatefulWidget {
  const CardStacksPage({super.key});

  @override
  State<CardStacksPage> createState() => _CardStacksPageState();
}

class _CardStacksPageState extends State<CardStacksPage> {
  String _searchInput = '';

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: height,
        child: Column(
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
                      LocaleKeys.cards.tr(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30),
                    ),
                    Text(
                      LocaleKeys.lets_study.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
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
                        CustomSearchBar(
                          baseColor: Theme.of(context).cardColor,
                          onChanged: (value) {
                            setState(() {
                              _searchInput = value;
                            });
                          },
                        ),
                        bigSizedBoxHeight,
                        CustomButton(
                          text: LocaleKeys.create_card_stack.tr(),
                          onPressed: () {
                            Navigator.of(context).push(
                                _createRoute(const CreateCardStackPage()));
                          }
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CardStackList(searchInput: _searchInput),
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
