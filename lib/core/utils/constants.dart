import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';

// text size
const mediumTextSize = 18.0;
const smallTextSize = 14.0;
const largeTextSize = 24.0;

// text style
TextStyle titleTextStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: CColors.text
);
TextStyle subtitleTextStyle = const TextStyle(
    fontSize: mediumTextSize,
    color: CColors.text
);

// sized box
const smallSizedBoxWidth = SizedBox(width: 5.0);
const smallSizedBoxHeight = SizedBox(height: 5.0);
const midSizedBoxHeight = SizedBox(height: 10.0);
const midSizedBoxWidth = SizedBox(width: 10.0);
const bigSizedBoxWidth = SizedBox(width: 30.0);
const bigSizedBoxHeight = SizedBox(height: 30.0);

// padding
const smallerPadding = EdgeInsets.all(3.0);
const smallPadding = EdgeInsets.all(8.0);
const mediumPadding = EdgeInsets.all(15.0);
const lPadding = EdgeInsets.all(20.0);
const largePadding = EdgeInsets.all(30.0);
const smallButtonPadding = EdgeInsets.symmetric(horizontal: 30, vertical: 7);
const buttonPadding = EdgeInsets.symmetric(horizontal: 30, vertical: 15);

// spacer
const spacer = Spacer();

// Divider
const divider = Divider(
  thickness: 1,
  height: 3,
);

// shadow
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
List<BoxShadow> neumorphismShadowSmallCard = const [
  BoxShadow(
    color: Colors.black26,
    blurRadius: 6,
    spreadRadius: -2,
    offset: Offset(3, 2),
  ),
  BoxShadow(
    color: Colors.white,
    blurRadius: 7,
    spreadRadius: -2,
    offset: Offset(-2, -2),
  ),
];
List<BoxShadow> neumorphismShadowLargeCardLeftLight = [
  const BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    spreadRadius: 5,
    offset: Offset(10, 10),
  ),
  const BoxShadow(
    color: Colors.white,
    blurRadius: 10,
    spreadRadius: -3,
    offset: Offset(-5, -5),
  ),
  const BoxShadow(
    color: CColors.shadow,
    blurRadius: 10,
    spreadRadius: -10,
    offset: Offset(-12, -12),
  ),
];
List<BoxShadow> neumorphismShadowLargeCardRightLight = [
  const BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    spreadRadius: 5,
    offset: Offset(-10, 10),
  ),
  const BoxShadow(
    color: Colors.white,
    blurRadius: 10,
    spreadRadius: -3,
    offset: Offset(5, -5),
  ),
  const BoxShadow(
    color: CColors.shadow,
    blurRadius: 10,
    spreadRadius: -10,
    offset: Offset(12, -12),
  ),
];

// border radius
BorderRadius backgroundTile = const BorderRadius.only(
    topLeft: Radius.circular(45),
    topRight: Radius.circular(45)
);