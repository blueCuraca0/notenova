import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/autorization/presentation/pages/authoriazation_page.dart';
import 'package:notenova/features/profile/presentation/pages/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/profile/presentation/state_management/fav_cubit.dart';
import 'package:notenova/features/profile/data/firebase_service_fav.dart';
import 'package:notenova/features/profile/presentation/state_management/fav_states.dart';
import 'package:notenova/features/profile/presentation/pages/widgets/tip_box_profile.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  void _logOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.read<FavCubit>().loadFavs();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                      top: constraints.maxHeight>MediaQuery.of(context).size.height*0.2? constraints.maxHeight - MediaQuery.of(context).size.height*0.2: 0, bottom: constraints.maxHeight>110? 20: 0),
                  title: Column(
                    children: [
                      spacer,
                      Row(
                        children: [
                          spacer,
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SettingPage()),
                            );
                          },
                              child: Text(LocaleKeys.settings.tr(), style: Theme.of(context).textTheme.bodySmall)),
                        ],
                      ),
                      Row(
                        children: [
                          midSizedBoxWidth,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              midSizedBoxHeight,
                              Text('Username', //TODO: add username
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text('user_email@gmail.com', //TODO: add email
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12)),
                              midSizedBoxHeight,
                            ],
                          ),
                          spacer,
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://secure.gravatar.com/avatar/7381b9e7e146bf03b5ef62ce417b53a2.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0024-192.png'),
                          ),
                          midSizedBoxWidth,
                        ],
                      ),
                    ],
                  ),
                  background:
                  ColoredBox(color: Theme.of(context).primaryColor),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.favorite_tips_of_the_day.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          BlocBuilder<FavCubit,FavState>(
            builder: (context, state) {
              if (state is FavLoading) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                    color: Theme
                        .of(context)
                        .primaryColorLight,
                    child: Center(
                      child: CircularProgressIndicator(color: Theme
                          .of(context)
                          .primaryColorDark,),
                    ),
                  ),
                );
              }
              else if (state is FavError){
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                    color: Theme
                        .of(context)
                        .primaryColorLight,
                    child: Center(
                      child: Text(state.message),
                    ),
                  ),
                );
              }
              else if (state is FavLoaded){
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                    color: Theme
                        .of(context)
                        .primaryColorLight,
                         child: ListView.builder(
                            itemCount: state.favtips.length+1,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: lPadding,
                                color: Theme
                                    .of(context)
                                    .primaryColorLight,
                                child: index<state.favtips.length ? TipsBoxProfile(
                                  tip: state.favtips[index],
                                ): SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                              );
                            },
                          ),

                  ),
                );
              }
              else {
                return SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                    color: Theme
                        .of(context)
                        .primaryColorLight,
                    child: Center(
                      child: CircularProgressIndicator(color: Theme
                          .of(context)
                          .primaryColorDark,),
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


/*Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 100),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: const Text(
                "User Profile Page",
                style: TextStyle(fontSize: 25),
              ),
            ),
            bigSizedBoxHeight,
            CustomButton(
              text: "Log out",
              onPressed: () {
                _logOut(context);
              }
            ),
          ],
        ),
      ),
    );*/