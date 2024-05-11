import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/autorization/presentation/pages/authoriazation_page.dart';
import 'package:notenova/features/profile/presentation/pages/settings_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  void _logIn(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthorizationPage()),
        (r) {
      return false;
    });
  }

  void _logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => const AuthorizationPage()),
    //         (r) {
    //       return false;
    //     }
    // );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 100),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: const Text(
                "User Profile Page",
                style: TextStyle(fontSize: 25),
              ),
            ),
            bigSizedBoxHeight,
            FirebaseAuth.instance.currentUser == null
                ? CustomButton(
                    text: "Log in",
                    onPressed: () {
                      _logIn(context);
                    })
                : CustomButton(
                    text: "Log out",
                    onPressed: () {
                      _logOut(context);
                    }),
          ],
        ),
      ),
    );
  }
}
