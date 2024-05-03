import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_textfield.dart';
import '../../../../core/widgets/custom_button.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  const CreateTaskBottomSheet({super.key});

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  DateTime _selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: CColors.accentSoft,
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
          const Text(
            'Create task',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          midSizedBoxHeight,
          TextField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              labelText: 'Title',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          smallSizedBoxHeight,
          const CustomTextField(
            maxLine: 2,
            hintText: 'Description',
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
                  DateFormat('dd-MMMM, HH:mm').format(_selectedDateTime),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CColors.text),
                ),
              ),
            ],
          ),
          midSizedBoxHeight,
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
