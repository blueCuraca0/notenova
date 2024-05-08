import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';

abstract class QuizState {
  List<Quiz> quizzes;
  List<Category> categories;
  Quiz? newQuiz;

  QuizState({required this.quizzes, required this.categories, this.newQuiz});
}

class QuizInitialState extends QuizState {
  QuizInitialState()
      : super(quizzes: [], categories: [
          Category(name: 'Work', gradient: CColors.pinkGradientColor),
          Category(name: 'Study', gradient: CColors.blueGradientColor),
          Category(name: 'Fun', gradient: CColors.greenGradientColor)
        ]);
}

class QuizChanged extends QuizState {
  QuizChanged({required super.quizzes, required super.categories, required super.newQuiz});
}

class QuizAdded extends QuizState {
  QuizAdded({required super.quizzes, required super.categories});
}
