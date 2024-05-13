import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';
import 'dart:math';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/features/quizzes/data/firebase_quizzes.dart';
import 'package:flutter/material.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizFirebaseService _quizFirebaseService;
  QuizCubit(this._quizFirebaseService) : super(QuizInitialState());

  List<Quiz> get quizzes => state.quizzes;

  Future<void> loadQuizzes(Quiz current) async{
    if (state.newQuiz != null && state is QuizChanged){
      return;
    }
    emit (QuizzesLoading());
    try {
      final categories = await _quizFirebaseService.getCategories().first;
      final quizzes = await _quizFirebaseService.getQuizzes().first;
      for (var quiz in quizzes){
        bool categoryExist = false;
        for (var cat in categories){
          if (cat.name == quiz.category!.name){
            quiz.category = cat;
            categoryExist = true;
          }
        }
        if (!categoryExist){
          quiz.category = Category(name: 'Unknown', gradient: CColors.greenGradientColor, id: '0');
        }
      }
      emit(QuizzesLoaded(quizzes: quizzes, categories: categories));
    } catch (e) {
      emit(QuizzesLoaded(quizzes: [], categories: []));
    }
  }


  Future<void> addQuiz(Quiz quiz) async {
    await _quizFirebaseService.addQuiz(quiz);
    emit(QuizAdded(quizzes: state.quizzes, categories: state.categories));
  }

  void deleteQuiz(Quiz quiz) async {
    await _quizFirebaseService.deleteQuiz(quiz);
    emit(QuizDeleted(quizzes: state.quizzes, categories: state.categories));
  }

  void sortedQuizzes(){
    emit(QuizLoadedSorted(quizzes: state.quizzes, categories: state.categories));
  }

  void changeImage(String path){
    if (state is QuizChanged){
      state.newQuiz!.image = path;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void createQuiz(){
    emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
  }

  void changeTitle(String title){
    if (state is QuizChanged){
      state.newQuiz!.title = title;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void changeDescription(String descr){
    if (state is QuizChanged){
      state.newQuiz!.description = descr;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void changeCategory(Category cat){
    if (state is QuizChanged){
      state.newQuiz!.category = cat;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void singleQuestionCreate(){
    if (state is QuizChanged){
      state.newQuiz!.questions.add(OneChoiceQuestion.empty(options: ['']));
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void multipleQuestionCreate(){
    if (state is QuizChanged){
      state.newQuiz!.questions.add(MultipleChoiceQuestion.empty(options: [''], correctAnswers: []));
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void updateQuestion(int index, String value) {
    if (state is! QuizChanged){
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
    else{
    final updatedQuiz = state.newQuiz!.copyWith();
    updatedQuiz.questions[index].question = value;
    emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: updatedQuiz));}
  }

  void addOption(int index){
    if (state is QuizChanged){
      state.newQuiz!.questions[index].options.add('');
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void deleteOption(int questionIndex, int optionIndex){
    if (state is QuizChanged){
      state.newQuiz!.questions[questionIndex].options.removeAt(optionIndex);
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  void selectOption(int questionIndex, int optionIndex){
    if (state is QuizChanged){
      if (state.newQuiz!.questions[questionIndex] is OneChoiceQuestion){
        (state.newQuiz!.questions[questionIndex] as OneChoiceQuestion).correctAnswer = optionIndex;
      }
      else{
        if ((state.newQuiz!.questions[questionIndex] as MultipleChoiceQuestion).correctAnswers.contains(optionIndex)){
          (state.newQuiz!.questions[questionIndex] as MultipleChoiceQuestion).correctAnswers.remove(optionIndex);
        }
        else{
          (state.newQuiz!.questions[questionIndex] as MultipleChoiceQuestion).correctAnswers.add(optionIndex);
        }
      }
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty(id: '${DateTime.now().millisecondsSinceEpoch}')));
    }
  }

  bool isSelected(int questionIndex, int optionIndex){
    if (state is QuizChanged){
      if (state.newQuiz!.questions[questionIndex] is OneChoiceQuestion){
        return (state.newQuiz!.questions[questionIndex] as OneChoiceQuestion).correctAnswer == optionIndex;
      }
      else{
        return (state.newQuiz!.questions[questionIndex] as MultipleChoiceQuestion).correctAnswers.contains(optionIndex);
      }
    }
    else{
      return false;
    }
  }


  //taking quizzes part
  void startQuiz(int indexQuiz){
    Map<int, List<bool>> answers = {};
    for (int i = 0; i < state.quizzes[indexQuiz].questions.length; i++){
      answers[i] = List.generate(state.quizzes[indexQuiz].questions[i].options.length, (index) => false);
    }
    emit(QuizTaken(quizzes: state.quizzes, categories: state.categories, answers: answers));
  }

  void selectQuestionOption(int questionIndex, int optionIndex, String type){
    if (type == 'single'){
      for (int i = 0; i < state.answers[questionIndex]!.length; i++){
        if (i == optionIndex){
          state.answers[questionIndex]![i] = true;
        }
        else{
        state.answers[questionIndex]![i] = false;
        }
      }
      emit(QuizTaken(quizzes: state.quizzes, categories: state.categories, answers: state.answers));
    }
    else{
        state.answers[questionIndex]![optionIndex] = !state.answers[questionIndex]![optionIndex];
      emit(QuizTaken(quizzes: state.quizzes, categories: state.categories, answers: state.answers));
    }
  }

  bool ifSelected(int questionIndex, int optionIndex){
      return state.answers[questionIndex]![optionIndex];
  }

  int quizIndex(Quiz quiz){
    return state.quizzes.indexOf(quiz);
  }

  Question getNextQuestion(int index){
    return state.quizzes[0].questions[index];
  }

  double getPercentage(int indexQuestion){
    return indexQuestion.toDouble() / state.quizzes[0].questions.length;
  }

  bool isLast(int indexQuestion){
    return indexQuestion == state.quizzes[0].questions.length - 1;
  }

  String checkBoxType(int quizIndex, int optionIndex, int questionIndex){
    if (state.quizzes[quizIndex].questions[questionIndex] is OneChoiceQuestion){
      if ((state.quizzes[quizIndex].questions[questionIndex] as OneChoiceQuestion).correctAnswer == optionIndex){
        return 'green';
      }
      else if (state.answers[questionIndex]![optionIndex]){
        return 'red';
      }
    }
    else
      {
        if ((state.quizzes[quizIndex].questions[questionIndex] as MultipleChoiceQuestion).correctAnswers.contains(optionIndex) && state.answers[questionIndex]![optionIndex]){
          return 'green';
        }
        else if ( state.answers[questionIndex]![optionIndex] || (state.quizzes[quizIndex].questions[questionIndex] as MultipleChoiceQuestion).correctAnswers.contains(optionIndex)){
          return 'red';
        }
      }
    return 'white';
  }

  Quiz currentQuiz(int index) => state.quizzes[index];

  int indexQuiz(Quiz quiz) => state.quizzes.indexOf(quiz);

  //working with categories
  List<Category> get categories => state.categories;

  void addCategory(String name) async{
    var randNum = Random().nextInt(3);
    List<Color> gradient = [];
    List<Color> darkGradient = [];
    switch (randNum){
      case 0:
        gradient = CColors.pinkGradientColor;
        darkGradient = CColors.darkPinkGradientColor;
        break;
      case 1:
        gradient = CColors.blueGradientColor;
        darkGradient = CColors.darkBlueGradientColor;
        break;
      case 2:
        gradient = CColors.greenGradientColor;
        darkGradient = CColors.darkGreenGradientColor;
        break;
    }
    await _quizFirebaseService.addCategory(name, gradient);
    loadCategories();
    //emit(QuizChanged(quizzes: state.quizzes, categories: categories, newQuiz: state.newQuiz));
  }

  void loadCategories() async{
    final cat = await _quizFirebaseService.getCategories().first;
    emit(QuizChanged(quizzes: state.quizzes, categories: cat, newQuiz: state.newQuiz));
  }
  void deleteCategory(Category category) async{
    /*final List<Category> categories = state.categories;
    categories.remove(category);
    emit(QuizChanged(quizzes: state.quizzes, categories: categories, newQuiz: state.newQuiz));*/
    await _quizFirebaseService.deleteCategory(category);
    loadCategories();
  }

  //quizzes filter
  List<Quiz> filterQuizzes(Category category){
    return state.quizzes.where((element) => element.category == category).toList();
  }
}