import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/profile/presentation/cubits/user_cubit/user_cubit.dart';

class EditUserNameWidget extends StatefulWidget {
  final UserDataCubit userDataCubit;
  final String userName;
  const EditUserNameWidget({
    super.key,
    required this.userDataCubit,
    required this.userName,
  });

  @override
  EditUserNameWidgetState createState() => EditUserNameWidgetState();
}

class EditUserNameWidgetState extends State<EditUserNameWidget> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
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
          MyCustomTextField(
            controller: _nameController,
            gradientColor: const Color(0xffCCD9E4),
            width: 400,
            height: 40,
            maxLines: 1,
            title: LocaleKeys.name.tr(),
            baseColor: Theme.of(context).cardColor,
          ),
          bigSizedBoxHeight,
          CustomButton(
            onPressed: () async {
              var user = FirebaseAuth.instance.currentUser;
              widget.userDataCubit.updateUserName(user!, _nameController.text);
              Navigator.pop(context);
            },
            text: LocaleKeys.update_name.tr(),
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          midSizedBoxHeight,
        ],
      ),
    );
  }
}
