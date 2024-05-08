import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/to_do/data/services/notify_service.dart';
import 'package:notenova/features/to_do/presentation/widgets/date_picker_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  const CreateTaskBottomSheet({super.key});

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  DateTime _selectedDateTime = DateTime.now();
  String _taskTitle = '';
  String _taskDesc = '';
  bool _notificationEnabled = false;

  void _selectDateTime(BuildContext context) {
    DateTimePicker.pickDateTime(context, _selectedDateTime,
        (DateTime pickedDateTime) {
      _selectedDateTime = pickedDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        boxShadow: shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              LocaleKeys.create_task.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          midSizedBoxHeight,
          MyCustomTextField(
            onChanged: (value) {
              setState(() {
                _taskDesc = value;
              });
            },
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 50,
            maxLines: 1,
            title: LocaleKeys.title.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          smallSizedBoxHeight,
          MyCustomTextField(
            onChanged: (value) {
              setState(() {
                _taskTitle = value;
              });
            },
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 70,
            maxLines: 2,
            title: LocaleKeys.description.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          midSizedBoxHeight,
          Row(
            children: <Widget>[
              const Icon(
                Icons.notifications_active,
                size: 20,
                color: CColors.text,
              ),
              smallSizedBoxWidth,
              GestureDetector(
                onTap: () => _selectDateTime(context),
                child: Text(
                    _selectedDateTime.isAfter(DateTime.now())
                        ? DateFormat('dd-MMMM, HH:mm').format(_selectedDateTime)
                        : 'Select date & time',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              spacer,
              Switch(
                  inactiveTrackColor: Theme.of(context).primaryColor,
                  activeTrackColor: Theme.of(context).cardColor,
                  inactiveThumbColor: Theme.of(context).primaryColorLight,
                  activeColor: Theme.of(context).primaryColorDark,
                  value: _notificationEnabled,
                  onChanged: (value) {
                    if (_selectedDateTime.isAfter(DateTime.now())) {
                      setState(() {
                        _notificationEnabled = value;
                      });
                      if (_notificationEnabled) {
                        debugPrint(
                            'Notification Scheduled for $_selectedDateTime');
                        NotificationService().scheduleNotification(
                          title: _taskTitle,
                          body: 'Time for $_taskDesc',
                          scheduledNotificationDateTime: _selectedDateTime,
                        );
                      }
                    } else {}
                  }),
            ],
          ),
          midSizedBoxHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButton(
                onPressed: () {},
                text: 'Study',
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                gradient: LinearGradient(
                  colors: CColors.pinkGradientColor,
                ),
              ),
              CustomButton(
                onPressed: () {},
                text: 'Productive',
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                gradient: LinearGradient(
                  colors: CColors.blueGradientColor,
                ),
              ),
              CustomButton(
                onPressed: () {},
                text: 'Life',
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                gradient: LinearGradient(
                  colors: CColors.greenGradientColor,
                ),
              ),
            ],
          ),
          midSizedBoxHeight,
          midSizedBoxHeight,
          CustomButton(
            onPressed: () {},
            text: 'Create task',
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ],
      ),
    );
  }
}
