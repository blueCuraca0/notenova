import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';

// text size
const mediumTextSize = 18.0;
const smallTextSize = 12.0;

const smallSizedBoxWidth = SizedBox(width: 5.0);
const smallSizedBoxHeight = SizedBox(height: 5.0);
const midSizedBoxHeight = SizedBox(height: 10.0);
const midSizedBoxWidth = SizedBox(width: 10.0);
// padding
const smallerPadding = EdgeInsets.all(3.0);
const smallPadding = EdgeInsets.all(8.0);
const lPadding = EdgeInsets.all(20.0);
const largePadding = EdgeInsets.all(30.0);
// spacer
const spacer = Spacer();

// Divider
const divider = Divider(
  thickness: 1,
  height: 3,
);

List<BoxShadow> shadowCard = [
  BoxShadow(
    color: CColors.text.withOpacity(0.1),
    spreadRadius: 5,
    blurRadius: 7,
    offset: const Offset(0, 3),
  ),
  const BoxShadow(
    color: CColors.shadow,
    spreadRadius: -2,
    blurRadius: 7,
    offset: Offset(0, -3),
  ),
];
