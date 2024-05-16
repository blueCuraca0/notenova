import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      backgroundColor: Theme.of(context).primaryColorLight,
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
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 25),
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
              color: Theme.of(context).primaryColor,
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
    return ListView(
      children: [
        Padding(
          padding: smallPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              midSizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: CustomButton(
                      buttonPadding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      color: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        context
                            .read<TextRecognitionCubit>()
                            .getImageAndRecognize(ImageSource.gallery);
                      },
                      text: LocaleKeys.select_image_from_gallery.tr(),
                    ),
                  ),
                  midSizedBoxWidth,
                  Flexible(
                    child: CustomButton(
                      buttonPadding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      color: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        context
                            .read<TextRecognitionCubit>()
                            .getImageAndRecognize(ImageSource.camera);
                      },
                      text: LocaleKeys.select_image_from_photo.tr(),
                    ),
                  ),
                ],
              ),
              midSizedBoxHeight,
              BlocBuilder<TextRecognitionCubit, TextRecognitionState>(
                builder: (context, state) {
                  if (state is TextRecognitionInitial) {
                    return Center(
                        child: Text(
                      LocaleKeys.select_an_image_to_recognize.tr(),
                      textAlign: TextAlign.center,
                    ));
                  } else if (state is TextRecognitionLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 250.0),
                      child: Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 10.0,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    );
                  } else if (state is TextRecognitionLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          midSizedBoxHeight,
                          CustomButton(
                            color: Theme.of(context).primaryColorDark,
                            onPressed: () {
                              Navigator.pop(context, state.detectedText);
                            },
                            text: LocaleKeys.add_description.tr(),
                          ),
                          midSizedBoxHeight,
                          if (state.selectedImage != null)
                            Padding(
                                padding: mediumPadding,
                                child: Image.file(state.selectedImage!)),
                          Text(
                            LocaleKeys.recognized_text.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          midSizedBoxHeight,
                          Text(
                            state.detectedText,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: 500,
                          ),
                          if (state.selectedImage == null) Container(),
                        ],
                      ),
                    );
                  } else if (state is TextRecognitionError) {
                    return Text(LocaleKeys.error_occured.tr());
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
