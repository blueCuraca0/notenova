import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/autorization/presentation/pages/authoriazation_page.dart';

import '../../../../core/utils/c_routes.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../main.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  void _logIn(BuildContext context) {
    // Navigator.pushNamed(context, CRoutes.routeAuthorizationPage);

    // Navigator.push(context,
    //   MaterialPageRoute(builder: (context) => const AuthorizationPage())
    // );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const AuthorizationPage()),
      (r) {
        print('');
        print('');
        print(r);
        print('');
        print('');
        return false;
      });
  }

  void _logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, CRoutes.routeAuthorizationPage);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
          SizedBox(
            height: height,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavBar(MyApp.navigatorKey)
            ),
          )
        ],
      ),
    );
  }
}
