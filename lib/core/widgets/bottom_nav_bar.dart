import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../features/autorization/presentation/pages/authoriazation_page.dart';
import '../utils/c_routes.dart';
import '../utils/constants.dart';
import '../utils/languages/generated/locale_keys.g.dart';

class CustomBottomNavBar extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator;

  const CustomBottomNavBar(this._navigator, {super.key});

  void onPressedButton(BuildContext context, String route) {
    if (FirebaseAuth.instance.currentUser == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) {
            return AlertDialog(
              title: Text(LocaleKeys.sorry.tr()) ,
              content: Text(LocaleKeys.no_access_log_in.tr()),
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              contentTextStyle: Theme.of(context).textTheme.bodyMedium,
              actionsAlignment: MainAxisAlignment.center,
              backgroundColor: Theme.of(context).cardColor,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.white,
              elevation: 30,
              actions: [
                OutlinedButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const AuthorizationPage()),
                          (r) => false
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                  child: Text(
                    LocaleKeys.log_in.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          });
    } else {
      _navigator.currentState?.pushReplacementNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: bottomNavBarHeight,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.only(
                  top: 2,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: bottomNavBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          _navigator.currentState
                              ?.pushReplacementNamed(CRoutes.routeHomepage);
                        },
                        icon: Icon(
                          Icons.home,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        )),
                    IconButton(
                        onPressed: () {
                          onPressedButton(context, CRoutes.routeStudyMaterials);
                        },
                        icon: Icon(
                          Icons.book,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        )),
                    IconButton(
                        onPressed: () {
                          onPressedButton(context, CRoutes.routeToDo);
                        },
                        icon: Icon(
                          Icons.today,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        )),
                    IconButton(
                        onPressed: () {
                          onPressedButton(context, CRoutes.routeUserProfile);
                        },
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
