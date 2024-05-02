import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/pages/authoriazation_page.dart';
import 'presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

import 'data/datasource/c_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
