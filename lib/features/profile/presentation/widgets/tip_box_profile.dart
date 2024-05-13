import 'package:flutter/material.dart';
import 'package:notenova/features/tips/domain/tips.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_cubit.dart';
import 'package:notenova/features/profile/presentation/pages/tip_page_profile.dart';

class TipsBoxProfile extends StatelessWidget {
  final Tip tip;

  const TipsBoxProfile({super.key, required this.tip});

  void deleteFav(BuildContext context) {
    context.read<FavCubit>().deleteFav(tip);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TipPageProfile(tip: tip);
        }));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 10,
              offset: const Offset(10, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            midSizedBoxWidth,
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                tip.imageUrl,
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.26,
                fit: BoxFit.cover,
              ),
            ),
            bigSizedBoxWidth,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  spacer,
                  Text(
                    tip.date,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  midSizedBoxHeight,
                  Text(
                    tip.title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  spacer,
                ],
              ),
            ),
            smallSizedBoxWidth,
            Column(
              children: [
                const Spacer(flex: 1),
                IconButton(
                  onPressed: () {
                    deleteFav(context);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
