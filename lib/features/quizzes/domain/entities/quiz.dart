import 'package:flutter/material.dart';
import 'question.dart';

class Quiz{
  final String image;
  final String title;
  final String category;
  final String description;
  List<Question> questions = [];

  Quiz({
    required this.image,
    required this.title,
    required this.category,
    required this.description,
  });
}