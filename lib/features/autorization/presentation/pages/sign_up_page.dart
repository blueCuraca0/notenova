import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/autorization/data/firebase_service.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

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

    late final String errorMessage;

    setState(() {
      _errorMessage = '';
    });

    if (_name.isEmpty) {
      errorMessage = "Field \"name\" is empty.";
    } else if (_email.isEmpty) {
      errorMessage = "Field \"email\" is empty.";
    } else if (_password.isEmpty || _confirmPassword.isEmpty) {
      errorMessage = "Field \"password\" is empty.";
    } else if (_password != _confirmPassword) {
      errorMessage = "Passwords are not the same.";
    } else {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        FirebaseServiceAuth.addUser(
            credential.user!.uid,
            _name,
            ''
        );
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "weak-password":
            errorMessage = "The password provided is too weak.";
            break;
          case "email-already-in-use":
            errorMessage = "The account already exists for that email.";
            break;
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
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
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Sign Up",
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
                          hintText: "Name",
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        bigSizedBoxHeight,

                        // Email TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: "Email",
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        bigSizedBoxHeight,

                        // Password TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: "Password",
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        bigSizedBoxHeight,

                        // Confirm Password TextField
                        MyCustomTextField(
                          baseColor: Theme.of(context).cardColor,
                          hintText: "Confirm password",
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                        ),
                        midSizedBoxHeight,

                        _getErrorText(),
                        bigSizedBoxHeight,

                        // Sign Up Button
                        CustomButton(
                            text: "Sign Up",
                            onPressed: () {
                              _signUp();
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
