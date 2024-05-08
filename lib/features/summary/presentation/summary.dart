import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/bottom_nav_bar.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/features/summary/domain/entities/summary_model.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  boxShadow: shadowCard,
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              midSizedBoxWidth,
              Text(
                LocaleKeys.my_summary.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              midSizedBoxHeight,
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
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
            ),
            height: 200,
          ),
        ),
      ),
      body: Padding(
        padding: smallerPadding,
        child: Column(
          children: [
            bigSizedBoxHeight,
            CustomSearchBar(
              baseColor: Theme.of(context).cardColor,
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: summaries.length,
                itemBuilder: (context, index) {
                  final summary = summaries[index];
                  return GestureDetector(
                    onTap: () => {},
                    child: SummaryCard(summary: summary),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  Summary summary;
  SummaryCard({super.key, required this.summary});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
      child: SizedBox(
        height: 140,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Theme.of(context).cardColor,
            boxShadow: shadowCard,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
            child: Row(
              children: [
                smallSizedBoxWidth,
                smallSizedBoxWidth,
                smallSizedBoxWidth,
                Container(
                  width: 11.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(
                      colors: getGradientColors(summary.category),
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                smallSizedBoxWidth,
                smallSizedBoxWidth,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        summary.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      smallSizedBoxWidth,
                      Text(
                        summary.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      spacer,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> getGradientColors(String category) {
    switch (category) {
      case 'Lectures':
        return CColors.pinkGradientColor;
      case 'Workshops':
        return CColors.pinkGradientColor;
      case 'Seminars':
        return CColors.blueGradientColor;
      case 'Practices':
        return CColors.blueGradientColor;
      case 'Exams':
        return CColors.greenGradientColor;
      case 'Lab works':
        return CColors.greenGradientColor;
      default:
        return [Colors.grey, Colors.grey];
    }
  }
}
