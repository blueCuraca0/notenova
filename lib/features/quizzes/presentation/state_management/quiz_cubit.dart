

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitialState());

  List<Quiz> get quizzes => state.quizzes;

  void addQuiz(Quiz quiz) {
    final List<Quiz> quizzes = state.quizzes;
    quizzes.add(quiz);
    emit(QuizAdded(quizzes: quizzes, categories: state.categories));
  }

  void createQuiz(){
    emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
  }

  void changeTitle(String title){
    if (state is QuizChanged){
      state.newQuiz!.title = title;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz));
      print('Changed');
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void changeDescription(String descr){
    if (state is QuizChanged){
      state.newQuiz!.description = descr;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void changeCategory(Category cat){
    if (state is QuizChanged){
      state.newQuiz!.category = cat;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  List<Category> get categories => state.categories;
}