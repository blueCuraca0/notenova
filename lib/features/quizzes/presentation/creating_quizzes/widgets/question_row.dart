import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'checkbox_single.dart';

class QuestionRow extends StatelessWidget{
  final int questionIndex;
  final int optionIndex;
  final Function deleteOption;
  final Function onChangedText;
  final String type;

  QuestionRow({super.key, required this.questionIndex, required this.optionIndex, required this.deleteOption, required this.onChangedText, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(questionIndex: questionIndex, optionIndex: optionIndex, type: type,),
        midSizedBoxWidth,
        Expanded(
          child: MyCustomTextField(
            baseColor: Theme.of(context).cardColor,
            hintText: LocaleKeys.option.tr(),
            onChanged: (value){
              onChangedText(value);
            },
          ),
        ),
        midSizedBoxWidth,
        GestureDetector(onTap: (){
          deleteOption();
        },
          child: const Icon(Icons.delete_outline),),
      ],
    );
  }
}