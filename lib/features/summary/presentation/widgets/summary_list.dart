import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_cubit.dart';
import 'package:notenova/features/summary/presentation/pages/create_edit_summary_sheet.dart';
import 'package:notenova/features/summary/presentation/pages/detail_summary_page.dart';
import 'package:notenova/features/summary/presentation/widgets/cards/summary_card.dart';

class SummaryList extends StatefulWidget {
  const SummaryList({
    super.key,
    required this.filteredSummary,
    required this.summaryCubit,
  });

  final List<Summary> filteredSummary;
  final SummaryCubit summaryCubit;

  @override
  State<SummaryList> createState() => _SummaryListState();
}

class _SummaryListState extends State<SummaryList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        curve: Curves.easeOut,
        parent: _controller,
      )),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            widget.filteredSummary.isEmpty ? 1 : widget.filteredSummary.length,
        itemBuilder: (context, index) {
          if (widget.filteredSummary.isEmpty) {
            return Center(
                child: Text(
              LocaleKeys.no_summary.tr(),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ));
          } else {
            final summary = widget.filteredSummary[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                widget.summaryCubit.deleteSummary(summary);
              },
              background: Container(
                height: 80,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).cardColor,
                ),
              ),
              child: GestureDetector(
                onTap: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DetailSummaryPage(summary: summary);
                    },
                  ),
                },
                child: GestureDetector(
                    onLongPress: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return EditAndCreateSummaryPage(
                              isEdit: true,
                              summary: summary,
                              summaryCubit: widget.summaryCubit,
                            );
                          },
                        ),
                    child: SummaryCard(summary: summary)),
              ),
            );
          }
        },
      ),
    );
  }
}
