import 'package:flutter/material.dart';

class Category{
  final String name;
  final List<Color> gradient;
  final List<Color>? darkGradient;
  bool isSelected = false;
  final String id;

  Category({required this.name, required this.gradient, this.darkGradient, this.isSelected = false, required this.id});
}