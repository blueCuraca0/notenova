import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/profile/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:notenova/features/profile/presentation/cubits/user_cubit/user_state.dart';
import 'package:notenova/features/profile/presentation/widgets/edit_name_user_sheet.dart';
import 'package:notenova/features/profile/presentation/widgets/edit_photo_user_sheet.dart';

class UserInformationWidget extends StatefulWidget {
  const UserInformationWidget({super.key});

  @override
  State<UserInformationWidget> createState() => _UserInformationWidgetState();
}

class _UserInformationWidgetState extends State<UserInformationWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDataCubit>(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final UserDataCubit userCubit = BlocProvider.of<UserDataCubit>(context);
    return BlocBuilder<UserDataCubit, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const CircularProgressIndicator();
        } else if (state is UserLoaded) {
          final userData = state.userData;
          final userAvatar = userData['avatar'] ?? '';
          final userName = userData['name'];
          return ListTile(
            title: Row(
              children: [
                bigSizedBoxHeight,
                Expanded(
                  child: GestureDetector(
                    onLongPress: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return EditUserNameWidget(
                              userDataCubit: userCubit, userName: userName);
                        }),
                    child: Text(
                        overflow: TextOverflow.fade,
                        '${LocaleKeys.hello_user.tr()} \n$userName',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 20)),
                  ),
                ),
              ],
            ),
            trailing: userAvatar.isNotEmpty && userAvatar != null
                ? Stack(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipOval(
                          child: Image.network(
                            userAvatar,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 35,
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return EditUserInformationWidget(
                                      userDataCubit: userCubit);
                                });
                          },
                          icon: const Icon(Icons.edit,
                              color: CColors.text, size: 20),
                        ),
                      )
                    ],
                  )
                : Stack(
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/cat.jpg'),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 35,
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return EditUserInformationWidget(
                                      userDataCubit: userCubit);
                                });
                          },
                          icon: const Icon(Icons.add_a_photo_rounded,
                              color: CColors.text, size: 16),
                        ),
                      )
                    ],
                  ),
          );
        } else if (state is UserError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return Container();
        }
      },
    );
  }
}
