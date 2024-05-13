import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';
import 'package:octo_image/octo_image.dart';

class SummaryCard extends StatefulWidget {
  final Summary summary;
  const SummaryCard({
    super.key,
    required this.summary,
  });

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
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
                  width: 8.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(
                      colors: getGradientColors(widget.summary.category),
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                midSizedBoxWidth,
                widget.summary.photoUrl.isNotEmpty
                    ? SizedBox(
                        width: 80,
                        height: 110,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: OctoImage(
                            image: NetworkImage(widget.summary.photoUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox(),
                smallSizedBoxWidth,
                smallSizedBoxWidth,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.summary.name,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      smallSizedBoxWidth,
                      Text(
                        widget.summary.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
