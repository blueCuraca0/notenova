import 'package:flutter/material.dart';

class Category{
  final String name;
  final List<Color> gradient;
  final List<Color>? darkGradient;
  bool isSelected = false;

  Category({required this.name, required this.gradient, this.darkGradient, this.isSelected = false});
}