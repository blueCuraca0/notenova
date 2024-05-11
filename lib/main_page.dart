import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/presentation/pages/card_stacks_page.dart';
import 'package:notenova/features/summary/presentation/pages/summary_page.dart';

import 'core/utils/c_routes.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'features/profile/presentation/pages/user_profile_page.dart';
import 'features/quiz_and_card/presentation/pages/study_materials_page.dart';
import 'features/tips/presentation/pages/homepage.dart';
import 'features/to_do/presentation/pages/todo_page.dart';
import 'main.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case CRoutes.routeHomepage:
        page = const HomePage();
      case CRoutes.routeStudyMaterials:
        page = const StudyMaterialsPage();
      case CRoutes.routeToDo:
        page = const ToDoPage();
      case CRoutes.routeUserProfile:
        page = const UserProfilePage();
      default:
        page = const Placeholder();
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Navigator(
            key: MyApp.navigatorKey,
            initialRoute: CRoutes.routeHomepage,
            onGenerateRoute: _onGenerateRoute,
      ),
    ),
      ),
    );
  }
}
