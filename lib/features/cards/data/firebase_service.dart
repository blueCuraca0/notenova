import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/entities/flashcard.dart';
import '../domain/entities/flashcard_stack.dart';

class FirebaseService {
  static final CollectionReference cardStacks =
      FirebaseFirestore.instance.collection('card_stacks');

  static Future<void> addCardStack(CardStack cardStack) {
    List<Map<String, String>> cardsToList = [];

    for (Flashcard card in cardStack.cardsList) {
      cardsToList.add({'term': card.term, 'definition': card.definition});
    }

    return cardStacks.add({
      'name': cardStack.name,
      'cards': cardsToList,
      'uid': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  static Stream<QuerySnapshot> getCardStackStream() {
    // return card_stacks.orderBy('timestamp', descending: false).snapshots();
    return cardStacks.snapshots();
  }

// static Future<void> updateHabit(String docID, CardModel cardModel) {
//   return card_stacks.doc(docID).update({
//     'term': cardModel.term,
//     'definition': cardModel.definition,
//     // 'timestamp': Timestamp.now()
//   });
// }
}
