import '../../domain/entities/card.dart';

class CardModel extends Card {
  CardModel(super.term, super.definition);

  CardModel getCardModel(Map<String, dynamic> json) {
    // TODO: implement json parsing logic
    return CardModel("term?", "def?");
  }
}