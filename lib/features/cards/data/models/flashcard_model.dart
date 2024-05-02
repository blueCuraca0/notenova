import '../../domain/entities/flashcard.dart';

class FlashcardModel extends Flashcard {
  FlashcardModel(super.term, super.definition);

  FlashcardModel getCardModel(Map<String, dynamic> json) {
    // TODO: implement json parsing logic
    return FlashcardModel("term?", "def?");
  }
}