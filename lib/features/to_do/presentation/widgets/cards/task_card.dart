import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/autorization/data/firebase_service.dart';
import '../../../../../core/style/c_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/task_model.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Function(bool) onCheckboxChanged;
  const TaskCard(
      {super.key, required this.task, required this.onCheckboxChanged});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = context.locale;
    String monthFormat =
        locale.languageCode == 'uk' ? 'dd-MMMM, HH:mm' : 'dd-MMMM, HH:mm';
    DateFormat formatter = DateFormat(monthFormat, locale.languageCode);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
      child: SizedBox(
        height: 170,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor,
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
              BoxShadow(
                color: Theme.of(context).primaryColor,
                spreadRadius: -2,
                blurRadius: 7,
                offset: Offset(0, -3),
              ),
            ],
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      smallSizedBoxWidth,
                      Text(
                        widget.task.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      spacer,
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range_outlined,
                            color: CColors.text,
                          ),
                          smallSizedBoxWidth,
                          Text(formatter.format(widget.task.finalDate),
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      )
                    ],
                  ),
                ),
                _checkBoxButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _checkBoxButton() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Checkbox(
          visualDensity: VisualDensity.compact,
          activeColor: Theme.of(context).primaryColorDark,
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
              FirebaseServiceAuth.updateUserXP(
                  (value ?? false) ? standardXP : (-standardXP));
            });
            widget.onCheckboxChanged(_isChecked);
          },
          shape: const CircleBorder(),
        );
      },
    );
  }
}
