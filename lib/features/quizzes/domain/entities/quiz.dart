import 'question.dart';
import 'category.dart';

class Quiz {
  String id;
  String image;
  String title;
  Category? category;
  String description;
  List<Question> questions = [];

  Quiz({
    required this.image,
    required this.title,
    this.category,
    required this.description,
    required this.questions,
    required this.id,
  });

  Quiz.empty({
    this.image =
        'https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg',
    this.title = 'Unknown',
    this.category,
    this.description = 'Unknown',
    this.questions = const [],
    this.id = '',
  });

  Quiz copyWith() {
    return Quiz(
      id: id,
      image: image,
      title: title,
      category: category,
      description: description,
      questions: questions,
    );
  }
}
