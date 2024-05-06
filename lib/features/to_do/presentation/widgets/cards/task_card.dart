import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/style/c_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/task_model.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool? isSelected = false;

  List<Color> getGradientColors(String category) {
    switch (category) {
      case 'Study':
        return CColors.pinkGradientColor;
      case 'Productive':
        return CColors.blueGradientColor;
      case 'Life':
        return CColors.greenGradientColor;
      default:
        return [Colors.grey, Colors.grey];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
      child: SizedBox(
        height: 140,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: CColors.white,
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
                      colors: getGradientColors(widget.task.category),
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
                        widget.task.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      smallSizedBoxWidth,
                      Text(
                        widget.task.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range_outlined,
                            color: CColors.text,
                          ),
                          smallSizedBoxWidth,
                          Text(
                              DateFormat('dd-MMMM, HH:mm')
                                  .format(widget.task.finalDate),
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      )
                    ],
                  ),
                ),
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  activeColor: Theme.of(context).primaryColorDark,
                  value: widget.task.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      widget.task.isCompleted = value!;
                    });
                  },
                  shape: const CircleBorder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
