import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/profile/presentation/cubits/user_cubit/user_cubit.dart';

class EditUserInformationWidget extends StatefulWidget {
  final UserDataCubit userDataCubit;
  const EditUserInformationWidget({
    super.key,
    required this.userDataCubit,
  });

  @override
  EditUserInformationWidgetState createState() =>
      EditUserInformationWidgetState();
}

class EditUserInformationWidgetState extends State<EditUserInformationWidget> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
          bigSizedBoxHeight,
          _selectPhoto(),
          bigSizedBoxHeight,
          CustomButton(
            onPressed: () async {
              var user = FirebaseAuth.instance.currentUser;
              DateTime.now().millisecondsSinceEpoch.toString();
              var userPhotoUrl = '';
              if (_image != null) {
                var storageRef = FirebaseStorage.instance
                    .ref()
                    .child('users/${user!.uid}/profilePicture.jpg');
                var uploadTask = storageRef.putFile(_image!);
                var downloadUrl = await (await uploadTask).ref.getDownloadURL();
                userPhotoUrl = downloadUrl.toString();
              }
              widget.userDataCubit.updateUserProfile(user!, userPhotoUrl);
              Navigator.pop(context);
            },
            text: 'Update profile photo',
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          midSizedBoxHeight,
        ],
      ),
    );
  }

  Widget _selectPhoto() {
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
