import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/features/tips/domain/tips.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/tips/presentation/pages/tip_page.dart';
import 'package:notenova/features/profile/presentation/state_management/fav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsBox extends StatelessWidget {
  final Tip tip;

  const TipsBox({super.key, required this.tip});

  bool checkFav(BuildContext context) {
    return context.read<FavCubit>().inFavs(tip);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TipPage(tip: tip, text: checkFav(context)? 'Liked' : 'Like'); //TODO: hardcoded string
                }));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
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
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    midSizedBoxHeight,
                    FittedBox(
                      child: Text(
                        tip.subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    spacer,
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}