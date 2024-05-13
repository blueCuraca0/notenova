import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';

class QuizSortState {
  final Category category;
  final String search;
  final List<Quiz> quizzesSort;

  QuizSortState({required this.category, required this.search, this.quizzesSort = const []});
}

class QuizSortInitialState extends QuizSortState {
  QuizSortInitialState() : super(category: Category(name: 'All', id: '0', gradient: CColors.greenGradientColor, darkGradient: CColors.darkGreenGradientColor), search: '');
}

class QuizSortByCategory extends QuizSortState {
  QuizSortByCategory({required super.category, required super.quizzesSort}): super(search: '');
}

class QuizSortBySearch extends QuizSortState {
  QuizSortBySearch({required super.search, required super.quizzesSort}): super(category: Category(name: 'All', id: '0', gradient: CColors.greenGradientColor, darkGradient: CColors.darkGreenGradientColor));
}