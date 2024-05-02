import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notenova/data/models/card_stack_model.dart';

import '../../domain/entities/card.dart';

class Datasource {
  static final CollectionReference card_stacks =
  FirebaseFirestore.instance.collection('card_stacks');

  static Future<void> addCardStack(CardStack cardStack) {
    List<Map<String, String>> cardsToList = [];

    for(Card card in cardStack.cardsList) {
      cardsToList.add({'term': card.term, 'definition': card.definition});
    }

    return card_stacks.add({
      'name': cardStack.name,
      'cards': cardsToList,
      // 'timestamp': Timestamp.now()
    });
  }

  // static Stream<QuerySnapshot> getHabitsStream() {
  //   return card_stacks.orderBy('timestamp', descending: false).snapshots();
  // }
  //
  // static Future<void> updateHabit(String docID, CardModel cardModel) {
  //   return card_stacks.doc(docID).update({
  //     'term': cardModel.term,
  //     'definition': cardModel.definition,
  //     // 'timestamp': Timestamp.now()
  //   });
  // }
}