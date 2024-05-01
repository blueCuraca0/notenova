import 'package:flutter/material.dart';

import '../../data/datasource/c_colors.dart';
import '../../data/datasource/c_routes.dart';

class CustomBottomNavBar extends StatelessWidget {

  final GlobalKey<NavigatorState> _navigator;

  CustomBottomNavBar(this._navigator, {super.key});

  static const double _bottomNavBarHeightPanel = 80;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _bottomNavBarHeightPanel,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              child: Container(
                color: CColors.white,
                padding: const EdgeInsets.only(top: 2,),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: CColors.primary,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: _bottomNavBarHeightPanel,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          _navigator.currentState?.pushReplacementNamed(CRoutes.routeHomepage);
                        },
                        // icon: Icon(Icons.home, color: theme.secondaryColor.withOpacity(0.75))
                        icon: Icon(Icons.home, color: CColors.textDark.withOpacity(0.8),)
                    ),
                    IconButton(
                        onPressed: () {
                          _navigator.currentState?.pushReplacementNamed(CRoutes.routeStudyMaterials);
                        },
                        icon: Icon(Icons.book, color: CColors.textDark.withOpacity(0.8),)
                    ),
                    const SizedBox(width: 40),
                    IconButton(
                        onPressed: () {
                          _navigator.currentState?.pushReplacementNamed(CRoutes.routeToDo);
                        },
                        icon: Icon(Icons.today, color: CColors.textDark.withOpacity(0.8),)
                    ),
                    IconButton(
                        onPressed: () {
                          _navigator.currentState?.pushReplacementNamed(CRoutes.routeUserProfile);
                        },
                        icon: Icon(Icons.person, color: CColors.textDark.withOpacity(0.8),)
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
