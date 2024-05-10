

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';

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
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void changeDescription(String descr){
    if (state is QuizChanged){
      state.newQuiz!.description = descr;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void changeCategory(Category cat){
    if (state is QuizChanged){
      state.newQuiz!.category = cat;
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void singleQuestionCreate(){
    if (state is QuizChanged){
      state.newQuiz!.questions.add(OneChoiceQuestion.empty(options: ['']));
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void multipleQuestionCreate(){
    if (state is QuizChanged){
      state.newQuiz!.questions.add(MultipleChoiceQuestion.empty(options: [''], correctAnswers: []));
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void addOption(int index){
    if (state is QuizChanged){
      state.newQuiz!.questions[index].options.add('');
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
    }
  }

  void deleteOption(int questionIndex, int optionIndex){
    if (state is QuizChanged){
      state.newQuiz!.questions[questionIndex].options.removeAt(optionIndex);
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: state.newQuiz!));
    }
    else{
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
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
      emit(QuizChanged(quizzes: state.quizzes, categories: state.categories, newQuiz: Quiz.empty()));
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
          print('I am doing smth');
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
      for (int i = 0; i < state.answers[questionIndex]!.length; i++){
        print(state.answers[questionIndex]![i]);
      }
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

  List<Category> get categories => state.categories;
}