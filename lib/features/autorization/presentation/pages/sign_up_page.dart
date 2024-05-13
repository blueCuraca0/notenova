import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/autorization/data/firebase_service.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _errorMessage = '';

  void _signUp() async {
    String errorMessage = '';

    setState(() {
      _errorMessage = '';
    });

    if (_name.isEmpty) {
      errorMessage = LocaleKeys.field_name_is_empty.tr();
    } else if (_email.isEmpty) {
      errorMessage = LocaleKeys.field_email_is_empty.tr();
    } else if (_password.isEmpty || _confirmPassword.isEmpty) {
      errorMessage = LocaleKeys.field_password_is_empty.tr();
    } else if (_password != _confirmPassword) {
      errorMessage = LocaleKeys.passwords_are_not_same.tr();
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        FirebaseServiceAuth.addUser(credential.user!.uid, _name, '');
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "weak-password":
            errorMessage = LocaleKeys.weak_password.tr();
            break;
          case "email-already-in-use":
            errorMessage = LocaleKeys.email_already_in_use.tr();
            break;
          case "invalid-email":
            errorMessage = LocaleKeys.invalid_email.tr();
            break;
          default:
            errorMessage = LocaleKeys.undefined_error.tr();
        }
      }
    }

    setState(() {
      _errorMessage = errorMessage;
    });
  }

  Widget _getErrorText() {
    return _errorMessage.isEmpty
        ? const SizedBox()
        : Text(
            _errorMessage,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    LocaleKeys.sign_up.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              LightRoundedBG(
                  height: height / 10 * 8,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Name TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: LocaleKeys.name.tr(),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        bigSizedBoxHeight,

                        // Email TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: LocaleKeys.email.tr(),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        bigSizedBoxHeight,

                        // Password TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: LocaleKeys.password.tr(),
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        bigSizedBoxHeight,

                        // Confirm Password TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: LocaleKeys.confirm_password.tr(),
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                        ),
                        midSizedBoxHeight,

                        _getErrorText(),
                        bigSizedBoxHeight,

                        // Sign Up Button
                        CustomButton(
                            text: LocaleKeys.sign_up.tr(),
                            onPressed: () {
                              _signUp();
                            }),
                        bigSizedBoxHeight,
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
