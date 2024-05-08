import 'package:flutter/material.dart';
import 'package:notenova/features/cards/presentation/pages/card_stacks_page.dart';
import 'package:notenova/features/cards/presentation/pages/create_card_stack_page.dart';

import 'core/utils/c_routes.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'features/profile/presentation/pages/user_profile_page.dart';
import 'features/quiz_and_card/presentation/pages/study_materials_page.dart';
import 'features/tips/presentation/pages/homepage.dart';
import 'features/to_do/presentation/pages/todo_page.dart';

class MainPage extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  MainPage({super.key});

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
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // page itself
          Navigator(
            key: _navigatorKey,
            initialRoute: CRoutes.routeHomepage,
            onGenerateRoute: _onGenerateRoute,
          ),

          //  const ToDoPage(),
          
          // template with a custom bottom navigation bar
          Column(
            children: [
              const Expanded(child: SizedBox()),
              CustomBottomNavBar(_navigatorKey),
            ],
          )
        ],
      ),
    );
  }
}
