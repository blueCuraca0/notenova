import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/profile/presentation/widgets/custom_appbar.dart';
import 'package:notenova/features/profile/presentation/widgets/settings_buttons.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.accent,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBarWidget(
            title: LocaleKeys.settings.tr(),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 60,
          )),
          const SliverToBoxAdapter(
            child: SettingsFieldsWidget(),
          ),
        ],
      ),
    );
  }
}

// class CustomSliverAppBarWidget extends StatefulWidget {
//   const CustomSliverAppBarWidget({
//     super.key,
//   });

//   @override
//   State<CustomSliverAppBarWidget> createState() =>
//       _CustomSliverAppBarWidgetState();
// }

// class _CustomSliverAppBarWidgetState extends State<CustomSliverAppBarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       expandedHeight: MediaQuery.of(context).size.height * 0.1,
//       floating: true,
//       pinned: false,
//       automaticallyImplyLeading: false,
//       backgroundColor: Theme.of(context).primaryColor,
//       surfaceTintColor: Theme.of(context).primaryColor,
//       flexibleSpace: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return FlexibleSpaceBar(
//             titlePadding: EdgeInsets.only(
//               left: 20,
//               top: constraints.maxHeight - 70,
//             ),
//             title: Padding(
//               padding: smallPadding,
//               child: Row(
//                 children: [
//                   CustomArrowBackButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     iconHeight: 10,
//                     height: 27,
//                     width: 27,
//                   ),
//                   midSizedBoxWidth,
//                   Text(LocaleKeys.settings.tr(),
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyLarge
//                           ?.copyWith(fontSize: 20)),
//                 ],
//               ),
//             ),
//             background: ColoredBox(color: Theme.of(context).primaryColor),
//           );
//         },
//       ),
//     );
//   }
// }
