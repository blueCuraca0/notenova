import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';
import 'package:octo_image/octo_image.dart';

class DetailSummaryPage extends StatelessWidget {
  final Summary summary;
  const DetailSummaryPage({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            expandedHeight: 270.0,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              child: Stack(
                children: [
                  summary.photoUrl.isNotEmpty
                      ? FractionallySizedBox(
                          widthFactor: 1.0,
                          child: OctoImage(
                            image: NetworkImage(summary.photoUrl),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center,
                          ),
                        )
                      : Container(
                          height: 350,
                          color: Theme.of(context).primaryColorDark,
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    child: CustomArrowBackButton(
                        height: 40,
                        width: 40,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: smallPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      textAlign: TextAlign.center,
                      summary.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 30)),
                  bigSizedBoxHeight,
                  getCustomButton(summary.category),
                  bigSizedBoxHeight,
                  Text(
                    summary.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCustomButton(String category) {
    switch (category) {
      case 'Workshops':
        return CustomButton(
            width: 150,
            onPressed: () {},
            text: LocaleKeys.workshops.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.pinkGradientColor,
            ));
      case 'Lectures':
        return CustomButton(
            width: 150,
            onPressed: () {},
            text: LocaleKeys.lectures.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.pinkGradientColor,
            ));
      case 'Seminars':
        return CustomButton(
            width: 150,
            onPressed: () {},
            text: LocaleKeys.seminars.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.blueGradientColor,
            ));
      case 'Practices':
        return CustomButton(
            width: 150,
            onPressed: () {},
            text: LocaleKeys.practices.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.blueGradientColor,
            ));
      case 'Lab works':
        return CustomButton(
            width: 150,
            onPressed: () {},
            text: LocaleKeys.lab_works.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.greenGradientColor,
            ));
      case 'Exams':
        return CustomButton(
            width: 150,
            onPressed: () {},
            text: LocaleKeys.exams.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.greenGradientColor,
            ));
      default:
        return Container(color: Colors.grey);
    }
  }
}
