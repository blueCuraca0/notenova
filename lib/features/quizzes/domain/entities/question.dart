abstract class Question{
  final String question;
  final List<String> options;

  Question({required this.question, required this.options});
}

class OneChoiceQuestion extends Question{
  final int correctAnswer;

  OneChoiceQuestion({required question, required options, required this.correctAnswer}) : super(question: question, options: options);
}

class MultipleChoiceQuestion extends Question{
  final List<int> correctAnswers;

  MultipleChoiceQuestion({required question, required options, required this.correctAnswers}) : super(question: question, options: options);
}