import '../../domain/entities/flashcard.dart';

class CardStack {
  String name;
  List<Flashcard> cardsList;

  CardStack(this.name, this.cardsList);

  static CardStack cardStackFromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> listOfCardMaps = [...json['cards']];
    List<Flashcard> cards = [];

    for (var cardMap in listOfCardMaps) {
      cards.add(Flashcard(cardMap['term'], cardMap['definition']));
    }

    return CardStack(
      json['name'],
      cards
    );
  }

}