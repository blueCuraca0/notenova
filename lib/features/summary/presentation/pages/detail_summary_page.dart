import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/summary/domain/entities/summary_model.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';

class DetailSummaryPage extends StatelessWidget {
  final Summary summary;
  const DetailSummaryPage({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            expandedHeight: 300.0,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              child: Stack(
                children: [
                  summary.photoUrl.isNotEmpty
                      ? Image.network(
                          summary.photoUrl,
                          height: 350,
                          fit: BoxFit.cover,
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
                  bigSizedBoxHeight,
                  Text(
                      textAlign: TextAlign.center,
                      summary.name,
                      style: Theme.of(context).textTheme.bodyLarge),
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
