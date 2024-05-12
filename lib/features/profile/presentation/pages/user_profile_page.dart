import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/profile/presentation/cubits/user_cubit.dart';
import 'package:notenova/features/profile/presentation/widgets/settings_buttons.dart';
import 'package:notenova/features/profile/presentation/widgets/settings_fields.dart';
import 'package:notenova/features/profile/presentation/widgets/user_information.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CColors.accent,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBarWidget(),
          SliverToBoxAdapter(
            child: smallSizedBoxHeight,
          ),
          SliverToBoxAdapter(
            child: SettingsButton(),
          ),
          SliverToBoxAdapter(
            child: bigSizedBoxHeight,
          ),
          // !! TO-DO: Add uses favorites
          SliverToBoxAdapter(
            child: SettingsFieldsWidget(),
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
      expandedHeight: MediaQuery.of(context).size.height * 0.15,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      surfaceTintColor: Theme.of(context).primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: BlocProvider(
          create: (context) =>
              UserDataCubit(FirebaseFirestore.instance, FirebaseAuth.instance),
          child: const UserInformationWidget(),
        ),
      ),
    );
  }
}
