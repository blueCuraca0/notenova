import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/tips/domain/tips.dart';
import 'package:notenova/features/quizzes/presentation/button_back.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_cubit.dart';
import 'package:notenova/features/profile/data/firebase_service_fav.dart';
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_states.dart';

class TipPage extends StatefulWidget {
  final Tip tip;
  String text;

  TipPage({super.key, required this.tip, required this.text});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  void addToFavs(BuildContext context) {
    context.read<FavCubit>().addFav(widget.tip);
  }

  bool checkFav(BuildContext context) {
    return context.read<FavCubit>().inFavs(widget.tip);
  }

  void deletefromFavs(BuildContext context) {
    context.read<FavCubit>().deleteFav(widget.tip);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 80,
            leading: const ButtonBack(),
            expandedHeight: MediaQuery.of(context).size.height * 0.1,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: ColoredBox(color: Theme.of(context).primaryColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: height,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                  child: Column(
                children: [
                  midSizedBoxHeight,
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.tip.imageUrl,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      bigSizedBoxWidth,
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.tip.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            bigSizedBoxHeight,
                            CustomButton(
                              color: Theme.of(context).primaryColor,
                              text: widget.text, //TODO: hardcoded string
                              onPressed: () {
                                setState(() {
                                  if (widget.text == 'Like') {
                                    widget.text = 'Liked';
                                    addToFavs(context);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bigSizedBoxHeight,
                  Text(
                    widget.tip.subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  bigSizedBoxHeight,
                  Text(
                    widget.tip.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
