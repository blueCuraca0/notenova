import 'package:flutter/material.dart';
import 'main_page.dart';
import 'features/autorization/presentation/pages/authoriazation_page.dart';
import 'core/utils/c_routes.dart';
import 'package:device_preview/device_preview.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
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
