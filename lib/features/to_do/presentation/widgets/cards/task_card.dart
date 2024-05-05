import 'package:flutter/material.dart';
import '../../../../../core/style/c_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

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
                      colors: CColors.pinkGradientColor,
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
                        task.name,
                        style: const TextStyle(fontSize: 17),
                      ),
                      smallSizedBoxWidth,
                      Text(
                        task.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      const Row(
                        children: [
                          Icon(
                            Icons.date_range_outlined,
                          ),
                          smallSizedBoxWidth,
                          Text('12:00'),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.check_circle, color: CColors.textDark),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
