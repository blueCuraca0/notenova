import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notenova/features/tips/domain/tips.dart';

class FirebaseServiceTips {
  static final CollectionReference tips =
  FirebaseFirestore.instance.collection('tips');

  Stream<List<Tip>> getTips() {
    return tips.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Tip(
         date: data['date'] ?? 'dd/mm/yyyy',
          title: data['title'] ?? 'Untitled',
          description: data['description'] ?? '',
          subtitle: data['subtitle'] ?? 'No subtitle',
          imageUrl: data['url'] ?? '',
        );
      }).toList();
    });
  }

}