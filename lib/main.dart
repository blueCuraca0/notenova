import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/themes.dart';
import 'package:notenova/core/cubit/darkTheme_cubit/darkTheme_states.dart';
import 'package:notenova/features/profile/data/firebase_service_fav.dart';
import 'package:notenova/features/quizzes/data/firebase_quizzes.dart';
import 'package:notenova/features/to_do/data/services/notify_service.dart';
import 'core/utils/languages/generated/codegen_loader.g.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main_page.dart';
import 'features/autorization/presentation/pages/authoriazation_page.dart';
import 'core/utils/c_routes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/core/cubit/darkTheme_cubit/darkTheme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService().initNotification();
  tz.initializeTimeZones();

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
      ],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      child: BlocProvider<DarkCubit>(
          create: (context) => DarkCubit(), child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return BlocBuilder<DarkCubit, DarkState>(builder: (context, state) {
      return MaterialApp(
        title: 'NoteNova',
        theme: state.darkTheme ? darkTheme : lightTheme,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        initialRoute: CRoutes.routeMainPage,
        routes: {
          CRoutes.routeAuthorizationPage: (context) =>
              const AuthorizationPage(),
          CRoutes.routeMainPage: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<FavCubit>(
                    create: (_) => FavCubit(FavTipsFirebaseService()),
                  ),
                  BlocProvider<QuizCubit>(
                    create: (_) => QuizCubit(QuizFirebaseService()),
                  ),
                ],
                child: MainPage(),
              ),
        },
      );
    });
  }
}
