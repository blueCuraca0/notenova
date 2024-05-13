import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/summary/presentation/widgets/custom_back_button.dart';

class CustomSliverAppBarWidget extends StatefulWidget {
  final String title;

  const CustomSliverAppBarWidget({
    super.key,
    required this.title,
  });

  @override
  CustomSliverAppBarWidgetState createState() =>
      CustomSliverAppBarWidgetState();
}

class CustomSliverAppBarWidgetState extends State<CustomSliverAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.1,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      surfaceTintColor: Theme.of(context).primaryColor,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: 20,
              top: constraints.maxHeight - 70,
            ),
            title: Padding(
              padding: smallPadding,
              child: Row(
                children: [
                  CustomArrowBackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconHeight: 10,
                    height: 27,
                    width: 27,
                  ),
                  midSizedBoxWidth,
                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            background: ColoredBox(color: Theme.of(context).primaryColor),
          );
        },
      ),
    );
  }
}
