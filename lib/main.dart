import 'package:flutter/material.dart';
import 'package:notenova_app/presentation/pages/authoriazation_page.dart';
import 'package:notenova_app/presentation/pages/main_page.dart';

import 'presentation/pages/homepage.dart';
import 'data/datasource/c_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteNova',
      initialRoute: CRoutes.routeAuthorizationPage,
      routes: {
        CRoutes.routeAuthorizationPage: (context) => const AuthorizationPage(),
        CRoutes.routeMainPage: (context) => MainPage(),
      },
    );
  }
}