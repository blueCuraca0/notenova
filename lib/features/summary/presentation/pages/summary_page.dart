import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:notenova/features/summary/domain/entities/summary_model.dart';
import 'package:notenova/features/summary/presentation/widgets/cards/summary_card.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String selectedCategory = 'Exams';

  @override
  Widget build(BuildContext context) {
    List<Summary> filteredSummary = summaries
        .where((summary) => summary.category == selectedCategory)
        .toList();
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
        padding: smallPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              bigSizedBoxHeight,
              CustomSearchBar(
                baseColor: Theme.of(context).cardColor,
              ),
              midSizedBoxHeight,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('Exams'),
                    _buildCategoryButton('Lectures'),
                    _buildCategoryButton('Workshops'),
                    _buildCategoryButton('Seminars'),
                    _buildCategoryButton('Practices'),
                    _buildCategoryButton('Lab works'),
                  ],
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredSummary.length,
                  itemBuilder: (context, index) {
                    final summary = filteredSummary[index];
                    return GestureDetector(
                      onTap: () => {},
                      child: SummaryCard(summary: summary),
                    );
                  }),
              bigSizedBoxHeight,
              bigSizedBoxHeight,
              midSizedBoxHeight,
              midSizedBoxHeight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 10),
        child: Text(category,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: selectedCategory == category
                      ? FontWeight.bold
                      : FontWeight.normal,
                )),
      ),
    );
  }
}
