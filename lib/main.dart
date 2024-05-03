import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/utils/languages/generated/codegen_loader.g.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main_page.dart';
import 'features/autorization/presentation/pages/authoriazation_page.dart';
import 'core/utils/c_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ua'),
      ],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteNova',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      initialRoute: CRoutes.routeAuthorizationPage,
      routes: {
        CRoutes.routeAuthorizationPage: (context) => const AuthorizationPage(),
        CRoutes.routeMainPage: (context) => MainPage(),
      },
    );
  }
}
