import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/summary/presentation/pages/summary_page.dart';
import 'package:notenova/features/quizzes/presentation/main_page/quiz_page.dart';
import '../../../../core/utils/languages/generated/locale_keys.g.dart';
import '../../../cards/presentation/pages/card_stacks_page.dart';

class StudyMaterialsPage extends StatelessWidget {
  const StudyMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.study_materials.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 28),
              ),
              Text(
                LocaleKeys.start_learning.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          child: Container(
            constraints:
                const BoxConstraints(minHeight: 400.0, maxHeight: 400.0),
            decoration: BoxDecoration(
              boxShadow: getShadowCard(context),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: largePadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StudyMaterialCard(
                  text: LocaleKeys.improve_your_know_with_quizzes.tr(),
                  color: Theme.of(context).cardColor,
                  width: (width / 2) - 35,
                  height: bottomNavBarHeight * 4,
                  imagePath: 'assets/images/cards_img.png',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return QuizPage();
                    }));
                  },
                ),

                //  Q U I Z Z E S
                StudyMaterialCard(
                  text: LocaleKeys.boost_your_brain_with_cards.tr(),
                  color: Theme.of(context).cardColor,
                  width: (width / 2) - 35,
                  height: bottomNavBarHeight * 4,
                  imagePath: 'assets/images/quizz_img.png',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CardStacksPage();
                    }));
                  },
                ),
              ],
            ),
            midSizedBoxHeight,
            // S U M M A R I E S
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SummaryPage();
                }));
              },
              child: Container(
                width: width - largePadding.horizontal,
                height: bottomNavBarHeight * 1.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: getShadowCard(context),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: buttonPadding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: smallPadding,
                        child: Image.asset(
                          'assets/images/summary.png',
                          width: 90,
                          height: 90,
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            '${LocaleKeys.summaries.tr()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ).tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyMaterialCard extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final String? imagePath;
  final VoidCallback onTap;

  const StudyMaterialCard({
    super.key,
    required this.text,
    required this.color,
    required this.width,
    required this.height,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          boxShadow: getShadowCard(context),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: buttonPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                Padding(
                  padding: smallPadding,
                  child: Image.asset(
                    imagePath!,
                    width: 90,
                    height: 90,
                  ),
                ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Center(
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ).tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
