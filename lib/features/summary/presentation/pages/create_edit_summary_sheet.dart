import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';
import 'package:notenova/features/summary/presentation/cubits/summary_cubits/summary_cubit.dart';
import 'package:notenova/features/summary/presentation/pages/text_recognition.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';

import '../../../autorization/data/firebase_service.dart';

class EditAndCreateSummaryPage extends StatefulWidget {
  final bool isEdit;
  final SummaryCubit summaryCubit;
  final Summary? summary;
  const EditAndCreateSummaryPage(
      {super.key,
      required this.isEdit,
      required this.summaryCubit,
      this.summary});

  @override
  State<EditAndCreateSummaryPage> createState() =>
      _EditAndCreateSummaryPageState();
}

class _EditAndCreateSummaryPageState extends State<EditAndCreateSummaryPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  File? _image;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.summary?.name ?? '';
    _descriptionController.text = widget.summary?.description ?? '';
    _selectedCategory = widget.summary?.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 770,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
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
            child: Row(
              children: [
                CustomArrowBackButton(
                    height: 40,
                    width: 40,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                bigSizedBoxWidth,
                Text(
                  widget.isEdit
                      ? LocaleKeys.update_summary.tr()
                      : LocaleKeys.create_summary.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          midSizedBoxHeight,
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
            height: 220,
            title: LocaleKeys.description.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          TextButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TextRecognitionPage()),
              );

              if (result != null) {
                _descriptionController.text = result as String;
              }
            },
            child: Text(
              LocaleKeys.select_image_from_photo.tr(),
            ),
          ),
          widget.isEdit ? const Text('') : selectPhotoForSummary(),
          midSizedBoxHeight,
          buttonCategorySummary(),
          midSizedBoxHeight,
          CustomButton(
            onPressed: () {
              if (widget.isEdit) {
                _updateSummary(context);
                Navigator.pop(context);
              } else {
                addSummary(context);
                FirebaseServiceAuth.updateUserXP(standardXP);
                Navigator.pop(context);
              }
            },
            text: widget.isEdit
                ? LocaleKeys.update_summary.tr()
                : LocaleKeys.create_summary.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          midSizedBoxHeight,
        ],
      ),
    );
  }

  void addSummary(BuildContext context) async {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      var imageName = DateTime.now().millisecondsSinceEpoch.toString();
      var summaryPhotoUrl = '';
      if (_image != null) {
        var storageRef =
            FirebaseStorage.instance.ref().child('summary/$imageName.jpg');
        var uploadTask = storageRef.putFile(_image!);
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();
        summaryPhotoUrl = downloadUrl.toString();
      }

      final summary = Summary(
        id: DateTime.now().toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        category: _selectedCategory ?? '',
        photoUrl: summaryPhotoUrl,
      );

      widget.summaryCubit.addSummary(summary);
    }
  }

  void _updateSummary(BuildContext context) async {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _image.toString().isNotEmpty) {
      final summary = Summary(
        id: widget.summary!.id,
        name: _nameController.text,
        description: _descriptionController.text,
        category: _selectedCategory ?? '',
        photoUrl: widget.summary!.photoUrl,
      );
      widget.summaryCubit.updateSummary(summary);
    }
  }

  Widget buttonCategorySummary() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Lectures';
                  });
                },
                text: LocaleKeys.lectures.tr(),
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                gradient: LinearGradient(
                  colors: _selectedCategory == 'Lectures'
                      ? [CColors.text, CColors.text]
                      : CColors.pinkGradientColor,
                ),
              ),
              CustomButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Seminars';
                  });
                },
                text: LocaleKeys.seminars.tr(),
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                gradient: LinearGradient(
                  colors: _selectedCategory == 'Seminars'
                      ? [CColors.text, CColors.text]
                      : CColors.blueGradientColor,
                ),
              ),
              CustomButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Lab works';
                  });
                },
                text: LocaleKeys.lab_works.tr(),
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                gradient: LinearGradient(
                  colors: _selectedCategory == 'Lab works'
                      ? [CColors.text, CColors.text]
                      : CColors.greenGradientColor,
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
                    _selectedCategory = 'Workshops';
                  });
                },
                text: LocaleKeys.workshops.tr(),
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                gradient: LinearGradient(
                  colors: _selectedCategory == 'Workshops'
                      ? [CColors.text, CColors.text]
                      : CColors.pinkGradientColor,
                ),
              ),
              CustomButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Practices';
                  });
                },
                text: LocaleKeys.practices.tr(),
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                gradient: LinearGradient(
                  colors: _selectedCategory == 'Practices'
                      ? [CColors.text, CColors.text]
                      : CColors.blueGradientColor,
                ),
              ),
              CustomButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'Exams';
                  });
                },
                text: LocaleKeys.exams.tr(),
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                gradient: LinearGradient(
                  colors: _selectedCategory == 'Exams'
                      ? [CColors.text, CColors.text]
                      : CColors.greenGradientColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectPhotoForSummary() {
    return Padding(
      padding: smallPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              boxShadow: shadowCard,
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: IconButton(
              onPressed: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              icon: const Icon(
                size: 25,
                Icons.add_outlined,
                color: CColors.textDark,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _image == null
                  ? Text(LocaleKeys.no_image_selected.tr())
                  : SizedBox(height: 50, child: Image.file(_image!)),
            ),
          ),
        ],
      ),
    );
  }
}
