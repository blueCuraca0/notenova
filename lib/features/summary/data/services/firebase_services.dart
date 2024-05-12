import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/features/summary/domain/entities/summary.dart';

class SummaryFirestoreService {
  final CollectionReference _summaryCollection =
      FirebaseFirestore.instance.collection('summary');
  String get currentUserId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'default';

  Stream<List<Summary>> getSummary() {
    return _summaryCollection
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Summary(
          id: doc.id ?? '',
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          category: data['category'] ?? '',
          photoUrl: data['photoUrl'] ?? '',
        );
      }).toList();
    });
  }

  Future<void> addSummary(Summary summary) {
    return _summaryCollection.add({
      'userId': currentUserId,
      'name': summary.name,
      'description': summary.description,
      'category': summary.category,
      'photoUrl': summary.photoUrl,
    });
  }

  Future<void> updateSummary(Summary summary) {
    return _summaryCollection.doc(summary.id).update({
      'userId': currentUserId,
      'name': summary.name,
      'description': summary.description,
      'category': summary.category,
      'photoUrl': summary.photoUrl,
    });
  }

  Future<void> deleteSummary(Summary summary) {
    return _summaryCollection.doc(summary.id).delete();
  }
}
