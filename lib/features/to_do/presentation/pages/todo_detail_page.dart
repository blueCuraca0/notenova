import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';

class TaskDialog extends StatelessWidget {
  final Task task;

  const TaskDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Theme.of(context).shadowColor,
      actions: [
        Container(
          padding: smallPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              midSizedBoxHeight,
              Text(task.name, style: Theme.of(context).textTheme.bodyLarge),
              midSizedBoxHeight,
              Text(task.description,
                  style: Theme.of(context).textTheme.bodyMedium),
              midSizedBoxHeight,
              midSizedBoxHeight,
              Row(
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: CColors.text,
                  ),
                  smallSizedBoxWidth,
                  Text(DateFormat('dd-MMMM, HH:mm').format(task.finalDate),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              midSizedBoxHeight,
              midSizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomButton(task.category),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      LocaleKeys.ok.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCustomButton(String category) {
    switch (category) {
      case 'Study':
        return CustomButton(
            onPressed: () {},
            text: 'Study',
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.pinkGradientColor,
            ));
      case 'Productive':
        return CustomButton(
            onPressed: () {},
            text: 'Productive',
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.blueGradientColor,
            ));
      case 'Life':
        return CustomButton(
            onPressed: () {},
            text: 'Life',
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
            gradient: LinearGradient(
              colors: CColors.greenGradientColor,
            ));
      default:
        return Container(color: Colors.grey);
    }
  }
}
