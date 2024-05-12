abstract class Question{
  String question;
  List<String> options;

  Question({required this.question, required this.options});
}

class OneChoiceQuestion extends Question{
  int correctAnswer;

  OneChoiceQuestion({required super.question, required super.options, required this.correctAnswer});
  OneChoiceQuestion.empty({super.question= '', super.options=const [], this.correctAnswer = -1});
}

class MultipleChoiceQuestion extends Question{
  List<int> correctAnswers;

  MultipleChoiceQuestion({required super.question, required super.options, required this.correctAnswers});
  MultipleChoiceQuestion.empty({super.question = '', super.options = const [], this.correctAnswers= const []});
}
