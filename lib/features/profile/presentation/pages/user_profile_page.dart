import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  void _logOut() {
    print("logging out");
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: const Text(
                "User Profile Page",
                style: TextStyle(fontSize: 25),
              ),
            ),
            bigSizedBoxHeight,
            CustomButton(
              text: "Log out",
              onPressed: () {
                _logOut();
              }
            )
          ],
        ),
      ),
    );
  }
}
