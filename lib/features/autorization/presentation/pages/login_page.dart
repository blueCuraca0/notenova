import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/congratulations_dialog.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _login = '';
  String _password = '';
  String _errorMessage = '';

  void _signInWithEmail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _login,
          password: _password
      );
    } on FirebaseAuthException catch (e) {

      late final errorMessage;

      switch (e.code) {
        case "invalid-credential":
          errorMessage = "Your email address or password is wrong.";
          break;
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      setState(() {
        _errorMessage = errorMessage;
      });
    }
  }

  void _singInAnonymous() {

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
                    "NoteNova",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              LightRoundedBG(
                  height: height / 10 * 7,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: "Login",
                          onChanged: (value) {
                            _login = value;
                          },
                        ),
                        bigSizedBoxHeight,
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: "Password",
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        midSizedBoxHeight,
                        _errorMessage.isEmpty
                            ? const SizedBox()
                            : Text(
                                _errorMessage,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Theme.of(context).colorScheme.error),
                              ),
                        bigSizedBoxHeight,
                        CustomButton(
                          text: "Sign In",
                          onPressed: () {
                            _signInWithEmail();
                          }
                        ),
                        bigSizedBoxHeight,
                        CustomButton(
                          text: "Sign Up",
                          onPressed: () {
                            // _signIn();
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