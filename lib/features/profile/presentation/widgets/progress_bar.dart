import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/autorization/data/firebase_service.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';

class ProgressBar extends StatefulWidget {
  double _availableWidth = 0;

  ProgressBar(double availableWidth, {super.key}) {
    _availableWidth = availableWidth - 60; // horizontal padding 30
  }

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  int _xp = 0;
  int _lvl = 1;
  int _progressToNextLvl = 0;

  late final AnimationController _controller;
  late final Animation<double> _curve;
  Animation? _sizeAnimation;

  double _width = 0;

  Future<void> updateXP() async {
    try {
      Map<String, dynamic> userInfo = await FirebaseServiceAuth.getUserInfo();
      setState(() {
        _xp = userInfo['xp_points'];
      });
    } catch (e) {
      _xp = 0;
    }
  }

  Future<void> startAnimation() async {
    _xp = (await FirebaseServiceAuth.getUserInfo())['xp_points'];
    _sizeAnimation = Tween<double>(begin: 0, end: _width).animate(_curve);
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => _controller.forward());
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2300), vsync: this);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    updateXP().then((value) {
      // calculating width of the filled bar's part
      _lvl = 1 + (_xp / 100).floor();
      _progressToNextLvl = _xp % 100;
      _width = widget._availableWidth / 100 * _progressToNextLvl;
      startAnimation();
    });
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 40,
            width: widget._availableWidth,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Container(
                        width: _sizeAnimation?.value ?? 0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(10),
                        ));
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${LocaleKeys.level.tr()} $_lvl",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}
