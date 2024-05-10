import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/summary/presentation/cubits/recognation_cubits/recognition_cubit.dart';
import 'package:notenova/features/summary/presentation/cubits/recognation_cubits/recognition_state.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';

class TextRecognitionPage extends StatelessWidget {
  const TextRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10),
          child: Row(
            children: [
              CustomArrowBackButton(
                  height: 40,
                  width: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              midSizedBoxWidth,
              Text(
                LocaleKeys.recognition_text.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              midSizedBoxHeight,
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          child: Container(
            constraints:
                const BoxConstraints(minHeight: 400.0, maxHeight: 400.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TextRecognitionCubit(),
        child: const TextRecognition(),
      ),
    );
  }
}

class TextRecognition extends StatelessWidget {
  const TextRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: smallPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            midSizedBoxHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  width: 170,
                  color: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    context
                        .read<TextRecognitionCubit>()
                        .getImageAndRecognize(ImageSource.gallery);
                  },
                  text: LocaleKeys.select_image_from_gallery.tr(),
                ),
                midSizedBoxHeight,
                CustomButton(
                  width: 170,
                  color: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    context
                        .read<TextRecognitionCubit>()
                        .getImageAndRecognize(ImageSource.camera);
                  },
                  text: LocaleKeys.select_image_from_photo.tr(),
                ),
              ],
            ),
            midSizedBoxHeight,
            BlocBuilder<TextRecognitionCubit, TextRecognitionState>(
              builder: (context, state) {
                if (state is TextRecognitionInitial) {
                  return const Text('Select an image to recognize text');
                } else if (state is TextRecognitionLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TextRecognitionLoaded) {
                  return Column(
                    children: [
                      if (state.selectedImage != null) midSizedBoxHeight,
                      Padding(
                          padding: smallPadding,
                          child: Image.file(state.selectedImage!)),
                      Text(
                        LocaleKeys.recognition_text.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      midSizedBoxHeight,
                      SingleChildScrollView(
                        child: Text(
                          state.detectedText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      bigSizedBoxHeight,
                      bigSizedBoxHeight,
                      CustomButton(
                        color: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          Navigator.pop(context, state.detectedText);
                        },
                        text: LocaleKeys.add.tr(),
                      ),
                    ],
                  );
                } else if (state is TextRecognitionError) {
                  return const Text('Error occurred! Please, try again.');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
