import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitialState());

  void addQuiz(Quiz quiz) {
    final List<Quiz> quizzes = state.quizzes;
    quizzes.add(quiz);
    emit(QuizChanged(quizzes: quizzes, categories: state.categories));
  }

  List<Category> get categories => state.categories;
}
