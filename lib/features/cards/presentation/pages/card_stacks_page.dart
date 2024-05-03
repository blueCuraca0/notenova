import 'package:flutter/material.dart';

import '../../../../core/style/c_colors.dart';

class CardStacksPage extends StatelessWidget {
  const CardStacksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: CColors.primary,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 50,),
                Text("Cards"),
                Text("Let's study!"),
                Expanded(child: const SizedBox()),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    color: CColors.accentSoft,
                    height: 600,
                  ),
                )
              ],
            )

            // TODO: appbar, navbar etc.
          ],
        ),
      ),
    );
  }
}
