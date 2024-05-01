import 'package:flutter/material.dart';

import '../../data/datasource/c_routes.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, CRoutes.routeMainPage);
          },
          child: Container(
              color: Colors.blueGrey.withOpacity(0.3),
              padding: const EdgeInsets.all(10),
              width: 100,
              height: 50,
              alignment: Alignment.center,
              child: Text("Login")),
        ),
      ),
    );
  }
}
