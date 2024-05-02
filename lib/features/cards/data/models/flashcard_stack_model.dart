import '../../domain/entities/flashcard.dart';

class CardStack {
  String name;
  List<Flashcard> cardsList;

  CardStack(this.name, this.cardsList);
}