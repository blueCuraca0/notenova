import 'package:flutter/material.dart';


class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(70),
            alignment: Alignment.center,
            child: const Text(
              "User Profile Page",
              style: TextStyle(
                  fontSize: 25
              ),
            ),
          )
        ],
      ),
    );
  }
}
