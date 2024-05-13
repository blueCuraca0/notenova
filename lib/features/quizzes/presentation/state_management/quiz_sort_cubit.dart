import 'package:bloc/bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_sort_states.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';

class QuizSortCubit extends Cubit<QuizSortState> {
  QuizSortCubit() : super(QuizSortInitialState());

  void sortByCategory(Category category, List<Quiz> quizzes){
    List<Quiz> newQuizzes = [];
    if (category.id == '0'){
      newQuizzes = quizzes;
    }
    else{
      for (var quiz in quizzes){
        if (quiz.category!.id == category.id){
          newQuizzes.add(quiz);
        }
      }
    }
    emit(QuizSortByCategory(category: category, quizzesSort: newQuizzes));
  }

  void sortBySearch(String search, List<Quiz> quizzes){
    List<Quiz> newQuizzes = [];
    for (var quiz in quizzes){
      if (quiz.title.toLowerCase().contains(search.toLowerCase())){
        newQuizzes.add(quiz);
      }
    }
    emit(QuizSortBySearch(search: search, quizzesSort: newQuizzes));
  }
}