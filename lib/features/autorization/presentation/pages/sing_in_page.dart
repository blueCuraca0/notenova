import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/autorization/presentation/pages/sign_up_page.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email = '';
  String _password = '';
  String _errorMessage = '';

  void _signInWithEmail() async {

    setState(() {
      _errorMessage = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e) {

      late final String errorMessage;

      if (_email.isEmpty) {
        errorMessage = LocaleKeys.field_email_is_empty.tr();
      } else if (_password.isEmpty) {
        errorMessage = LocaleKeys.field_password_is_empty.tr();
      } else {
        switch (e.code) {
          case "invalid-credential":
            errorMessage = LocaleKeys.invalid_credential.tr();
            break;
          case "invalid-email":
            errorMessage = LocaleKeys.invalid_email.tr();
            break;
          case "wrong-password":
            errorMessage = LocaleKeys.wrong_password.tr();
            break;
          case "user-not-found":
            errorMessage = LocaleKeys.user_not_found.tr();
            break;
          case "user-disabled":
            errorMessage = LocaleKeys.user_disabled.tr();
            break;
          default:
            errorMessage = LocaleKeys.undefined_error.tr();
        }
      }

      setState(() {
        _errorMessage = errorMessage;
      });
    }
  }

  Widget _getErrorText() {
    return _errorMessage.isEmpty
        ? const SizedBox()
        : Text(
      _errorMessage,
      style: Theme.of(context).textTheme.bodySmall
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
              Container(
                alignment: Alignment.center,
                height: height / 5 * 2,
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Image.asset(
                    'assets/images/logo_text.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              LightRoundedBG(
                  height: height / 5 * 3,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        midSizedBoxHeight,

                        _getErrorText(),
                        bigSizedBoxHeight,

                        // Sign In Button
                        CustomButton(
                          text: LocaleKeys.sign_in.tr(),
                          onPressed: () {
                            _signInWithEmail();
                          }
                        ),
                        bigSizedBoxHeight,

                        // Sign Up Button
                        CustomButton(
                          text: LocaleKeys.sign_up.tr(),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const SignUpPage())
                            );
                          }
                        ),
                        bigSizedBoxHeight,
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
