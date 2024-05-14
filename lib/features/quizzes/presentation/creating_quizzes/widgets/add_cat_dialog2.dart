import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';

class AddCatDialog2 extends StatefulWidget {
  final String title;
  final Function(String) onCategoryAdded;


  const AddCatDialog2({super.key, required this.title, required this.onCategoryAdded});

  @override
  State<AddCatDialog2> createState() => _AddCatDialog2State();
}

class _AddCatDialog2State extends State<AddCatDialog2> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).cardColor;

    return AlertDialog(
      title: Text(widget.title),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      alignment: Alignment.center,
      backgroundColor: color,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions:[
        MyCustomTextField(
          baseColor: Theme.of(context).cardColor,
          maxLength: 10,
          height: 80,
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        midSizedBoxHeight,
        CustomButton(text: LocaleKeys.add.tr(), onPressed: (){
          widget.onCategoryAdded(name);
          Navigator.pop(context);
        })
      ],
    );
  }
}