import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:flutter/material.dart';

class QuizFirebaseService {
  final CollectionReference _quizCollection =
  FirebaseFirestore.instance.collection('quizzes');

  final CollectionReference _categoryCollection =
  FirebaseFirestore.instance.collection('quizzes_categories');

  String get currentUserId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'default';

  Stream<List<Category>> getCategories() {
    return _categoryCollection
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<Color> gradient = [];
        List<Color> darkgradient = [];
        if (data['gradient']== 'pink'){
          gradient = CColors.pinkGradientColor;
          darkgradient = CColors.darkPinkGradientColor;
        }
        else if (data['gradient']== 'green'){
          gradient = CColors.greenGradientColor;
          darkgradient = CColors.darkGreenGradientColor;
        }
        else{
          gradient = CColors.blueGradientColor;
          darkgradient = CColors.darkBlueGradientColor;
        }
        return Category(
          id: doc.id,
          name: data['name']?? 'Unknown',
          gradient: gradient,
          darkGradient: darkgradient,
        );
      }).toList();
    });
  }

  Stream<List<Quiz>> getQuizzes(){
    return _quizCollection.where('userId', isEqualTo: currentUserId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<Question> questions = [];
        List<dynamic> questionData = data['questions'] as List<dynamic>;
        for (var question in questionData){
          if (question['type']== 'single'){
            List<String> answers = [];
            for (var answer in question['answers']){
              answers.add(answer);
            }
            questions.add(OneChoiceQuestion(
              question: question['question'],
              correctAnswer: question['correctAnswer'],
              options: answers,
            ));
          }
          else{
            List<int> correctAnswers = [];
            for (var answer in question['correctAnswers']){
              correctAnswers.add(answer);
            }
            List<String> answers = [];
            for (var answer in question['answers']){
              answers.add(answer);
            }
            questions.add(MultipleChoiceQuestion(
              question: question['question'],
              options: answers,
              correctAnswers: correctAnswers,
            ));
          }
        }
        List<Color> gradient = [];
        List<Color> darkgradient = [];
        if (data['category'] != null){
          if (data['categoryGradient']== 'pink'){
            gradient = CColors.pinkGradientColor;
            darkgradient = CColors.darkPinkGradientColor;
          }
          else if (data['categoryGradient']== 'green'){
            gradient = CColors.greenGradientColor;
            darkgradient = CColors.darkGreenGradientColor;
          }
          else{
            gradient = CColors.blueGradientColor;
            darkgradient = CColors.darkBlueGradientColor;
          }
        }
        return Quiz(
          id: doc.id,
          title: data['title'] ?? 'Untitled',
          description: data['description'] ?? 'No description',
          image: data['url'] ?? '',
          category: Category(
            id: '0',
            name: data['category'] ?? 'No category',
            gradient: gradient,
            darkGradient: darkgradient,
          ),
          questions: questions,
        );
      }).toList();
    });
  }

  Future<void> addQuiz(Quiz quiz) {
    return _quizCollection.add({
      'userId': currentUserId,
      'title': quiz.title,
      'description': quiz.description,
      'url': quiz.image,
      'category': quiz.category==null? '': quiz.category!.name,
      'questions': quiz.questions.map((question) {
        if (question is OneChoiceQuestion){
          return {
            'type': 'single',
            'question': question.question,
            'answers': question.options,
            'correctAnswer': question.correctAnswer,
          };
        }
        else if (question is MultipleChoiceQuestion){
          return {
            'type': 'multiple',
            'question': question.question,
            'answers': question.options,
            'correctAnswers': question.correctAnswers,
          };
        }
      }).toList(),
    });
  }

  Future<void> addCategory(String name, List<Color> gradient) {
    String color = '';
    if (gradient == CColors.pinkGradientColor){
      color = 'pink';
    }
    else if (gradient == CColors.greenGradientColor){
      color = 'green';
    }
    else{
      color = 'blue';
    }
    return _categoryCollection.add({
      'userId': currentUserId,
      'name': name,
      'gradient': color,
    });
  }

  Future<void> deleteCategory(Category category) {
    return _categoryCollection.doc(category.id).delete();
  }

  Future<void> deleteQuiz(Quiz quiz) {
    return _quizCollection.doc(quiz.id).delete();
  }
}
