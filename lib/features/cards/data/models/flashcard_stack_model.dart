import '../../domain/entities/flashcard.dart';
import '../../domain/entities/flashcard_stack.dart';

class CardStackModel {

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