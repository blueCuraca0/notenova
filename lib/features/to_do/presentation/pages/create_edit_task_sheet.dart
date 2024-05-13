import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/to_do/data/services/notify_service.dart';
import 'package:notenova/features/to_do/domain/entities/task_model.dart';
import 'package:notenova/features/to_do/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:notenova/features/to_do/presentation/widgets/date_picker_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  final bool isEdit;
  final Task? task;
  final TaskCubit taskCubit;
  const CreateTaskBottomSheet({
    super.key,
    this.task,
    required this.taskCubit,
    required this.isEdit,
  });

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  DateTime _selectedDateTime = DateTime.now();
  bool _notificationEnabled = false;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _nameController.text = widget.task!.name;
      _descriptionController.text = widget.task!.description;
      _selectedDateTime = widget.task!.finalDate;
      _selectedCategory = widget.task!.category;
      _notificationEnabled = widget.task!.finalDate.isAfter(DateTime.now());
    }
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
              widget.isEdit
                  ? LocaleKeys.update_task.tr()
                  : LocaleKeys.create_task.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          midSizedBoxHeight,
          MyCustomTextField(
            controller: _nameController,
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 50,
            maxLines: 1,
            title: LocaleKeys.title.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          smallSizedBoxHeight,
          MyCustomTextField(
            controller: _descriptionController,
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 70,
            maxLines: 2,
            title: LocaleKeys.description.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          midSizedBoxHeight,
          _selectTimeAndNotifyButtons(),
          midSizedBoxHeight,
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: _buttonsCategory()),
          midSizedBoxHeight,
          midSizedBoxHeight,
          CustomButton(
            onPressed: () {
              if (widget.isEdit) {
                _updateTask(context);
              } else {
                addTask(context);
              }
            },
            text: widget.isEdit
                ? LocaleKeys.update_task.tr()
                : LocaleKeys.create_task.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ],
      ),
    );
  }

  Widget _selectTimeAndNotifyButtons() {
    return Row(
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
                  : LocaleKeys.select_time_date.tr(),
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
                  debugPrint('Notification Scheduled for $_selectedDateTime');
                  NotificationService().scheduleNotification(
                    title: _nameController.text,
                    body: 'Time for ${_descriptionController.text}',
                    scheduledNotificationDateTime: _selectedDateTime,
                  );
                }
              } else {}
            }),
      ],
    );
  }

  Widget _buttonsCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CustomButton(
          onPressed: () {
            setState(() {
              _selectedCategory = LocaleKeys.study.tr();
            });
          },
          text: LocaleKeys.study.tr(),
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          gradient: LinearGradient(
            colors: _selectedCategory == LocaleKeys.study.tr()
                ? [CColors.text, CColors.text]
                : CColors.pinkGradientColor,
          ),
        ),
        smallSizedBoxWidth,
        CustomButton(
          onPressed: () {
            setState(() {
              _selectedCategory = LocaleKeys.productive.tr();
            });
          },
          text: LocaleKeys.productive.tr(),
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          gradient: LinearGradient(
            colors: _selectedCategory == LocaleKeys.productive.tr()
                ? [CColors.text, CColors.text]
                : CColors.blueGradientColor,
          ),
        ),
        smallSizedBoxWidth,
        CustomButton(
          onPressed: () {
            setState(() {
              _selectedCategory = LocaleKeys.life.tr();
            });
          },
          text: LocaleKeys.life.tr(),
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          gradient: LinearGradient(
            colors: _selectedCategory == LocaleKeys.life.tr()
                ? [CColors.text, CColors.text]
                : CColors.greenGradientColor,
          ),
        ),
      ],
    );
  }

  void addTask(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      final task = Task(
        id: DateTime.now().toString(),
        name: _nameController.text,
        isCompleted: false,
        finalDate: _selectedDateTime,
        description: _descriptionController.text,
        category: _selectedCategory ?? '',
      );
      widget.taskCubit.addTask(task);
      Navigator.pop(context);
    }
  }

  void _selectDateTime(BuildContext context) {
    DateTimePicker.pickDateTime(context, _selectedDateTime,
        (DateTime pickedDateTime) {
      _selectedDateTime = pickedDateTime;
    });
  }

  void _updateTask(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      final task = Task(
        name: _nameController.text,
        isCompleted: false,
        finalDate: _selectedDateTime,
        description: _descriptionController.text,
        category: _selectedCategory ?? '',
        id: widget.task!.id,
      );
      widget.taskCubit.updateTask(task);
      Navigator.pop(context);
    }
  }
}
