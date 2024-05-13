import 'package:flutter/material.dart';

class LightRoundedBG extends StatelessWidget {
  final double height;
  final Widget child;

  const LightRoundedBG({required this.height, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: Container(
        color: Theme.of(context).primaryColorLight,
        height: height,
        child: child,
      ),
    );
  }
}
