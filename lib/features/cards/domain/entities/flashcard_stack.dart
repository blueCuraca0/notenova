import '../../domain/entities/flashcard.dart';

class CardStack {
  String name;
  String description = '';
  String category = '';
  List<Flashcard> cardsList;

  CardStack(this.name, this.cardsList, {String? description, String? category}) {
    this.description = description ?? '';
    this.category = category ?? '';
  }

}