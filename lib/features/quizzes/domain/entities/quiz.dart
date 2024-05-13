import 'package:flutter/material.dart';
import 'question.dart';
import 'category.dart';

class Quiz{
  String id;
  String image;
  String title;
  Category? category;
  String description;
  List<Question> questions = [];

  Quiz({
    required this.image,
    required this.title,
    required this.category,
    required this.description,
    required this.questions,
    required this.id,
  });

  Quiz.empty({
    this.image='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZe88Zxjf5pQPODgsrRX44zcxVOCqulUWrXwOtkM-evQ&s',//TODO: I have here default image
    this.title= 'Unknown',
    this.category,
    this.description = 'Unknown',
    this.questions = const [],
    this.id = '',
  });
}