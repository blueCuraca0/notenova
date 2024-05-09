import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/summary/domain/entities/summary_model.dart';
import 'package:notenova/features/summary/presentation/pages/text_recognition.dart';

class EditAndCreateSummaryPage extends StatefulWidget {
  const EditAndCreateSummaryPage({super.key});

  @override
  State<EditAndCreateSummaryPage> createState() =>
      _EditAndCreateSummaryPageState();
}

class _EditAndCreateSummaryPageState extends State<EditAndCreateSummaryPage> {
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
  Widget build(BuildContext context) {
    var buttonsCategory = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = LocaleKeys.lectures.tr();
                });
              },
              text: LocaleKeys.lectures.tr(),
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              gradient: LinearGradient(
                colors: CColors.pinkGradientColor,
              ),
            ),
            CustomButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = LocaleKeys.seminars.tr();
                });
              },
              text: LocaleKeys.seminars.tr(),
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              gradient: LinearGradient(
                colors: CColors.blueGradientColor,
              ),
            ),
            CustomButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = LocaleKeys.lab_works.tr();
                });
              },
              text: LocaleKeys.lab_works.tr(),
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              gradient: LinearGradient(
                colors: CColors.greenGradientColor,
              ),
            ),
          ],
        ),
        smallSizedBoxHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = LocaleKeys.workshops.tr();
                });
              },
              text: LocaleKeys.workshops.tr(),
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              gradient: LinearGradient(
                colors: CColors.pinkGradientColor,
              ),
            ),
            CustomButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = LocaleKeys.practices.tr();
                });
              },
              text: LocaleKeys.practices.tr(),
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              gradient: LinearGradient(
                colors: CColors.blueGradientColor,
              ),
            ),
            CustomButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = LocaleKeys.exams.tr();
                });
              },
              text: LocaleKeys.exams.tr(),
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              gradient: LinearGradient(
                colors: CColors.greenGradientColor,
              ),
            ),
          ],
        ),
      ],
    );
    return Container(
      height: 800,
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
              LocaleKeys.create_summary.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          MyCustomTextField(
            controller: _nameController,
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 40,
            maxLines: 1,
            title: LocaleKeys.title.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          smallSizedBoxHeight,
          MyCustomTextField(
            controller: _descriptionController,
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 350,
            title: LocaleKeys.description.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          TextButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextRecognitionPage()),
              );

              if (result != null) {
                _descriptionController.text = result as String;
              }
            },
            child: const Text('Select text from photo...'),
          ),
          midSizedBoxHeight,
          buttonsCategory,
          bigSizedBoxHeight,
          midSizedBoxHeight,
          CustomButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty) {
                final task = Summary(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  description: _descriptionController.text,
                  category: _selectedCategory ?? '',
                  photoUrl: '',
                );
                // widget.taskCubit.addTask(task);
                Navigator.pop(context);
              }
            },
            text: LocaleKeys.create_task.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          bigSizedBoxHeight,
        ],
      ),
    );
  }
}
