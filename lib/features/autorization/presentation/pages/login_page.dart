import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

import '../../../../core/utils/c_routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginController.text,
        password: _passwordController.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(
                hintText: "login",
                border: OutlineInputBorder()
              ),
            ),
            bigSizedBoxHeight,
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "password",
                border: OutlineInputBorder()
              ),
            ),
            TextButton(
              onPressed: () {
                _signIn();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 100,
                height: 50,
                alignment: Alignment.center,
                child: Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
