import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/profile/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:notenova/features/profile/presentation/widgets/settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_cubit.dart';
import 'package:notenova/features/profile/presentation/cubits/fav_cubit/fav_states.dart';
import 'package:notenova/features/profile/presentation/widgets/tip_box_profile.dart';
import 'package:notenova/features/profile/presentation/widgets/user_information.dart';

import '../widgets/progress_bar.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavCubit>().loadFavs();
    double availableWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBarWidget(),
          const SliverToBoxAdapter(
            child: smallSizedBoxHeight,
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressBar(availableWidth),
                const SettingsButton(),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: bigSizedBoxHeight,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.favorite_tips_of_the_day.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          BlocBuilder<FavCubit, FavState>(
            builder: (context, state) {
              if (state is FavLoading) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                );
              } else if (state is FavError) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: Text(state.message),
                    ),
                  ),
                );
              } else if (state is FavLoaded) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: Theme.of(context).primaryColorLight,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.favtips.length + 1,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: lPadding,
                          color: Theme.of(context).primaryColorLight,
                          child: index < state.favtips.length
                              ? TipsBoxProfile(
                                  tip: state.favtips[index],
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBarWidget extends StatefulWidget {
  const CustomSliverAppBarWidget({
    super.key,
  });

  @override
  CustomSliverAppBarWidgetState createState() =>
      CustomSliverAppBarWidgetState();
}

class CustomSliverAppBarWidgetState extends State<CustomSliverAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.17,
        pinned: false,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        surfaceTintColor: Theme.of(context).primaryColor,
        flexibleSpace: FlexibleSpaceBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: BlocProvider(
              create: (context) => UserDataCubit(
                  FirebaseFirestore.instance, FirebaseAuth.instance),
              child: const UserInformationWidget(),
            ),
          ),
          titlePadding: EdgeInsets.zero,
        ));
  }
}
