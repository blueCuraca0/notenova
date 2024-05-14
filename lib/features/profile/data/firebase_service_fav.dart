import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notenova/features/tips/domain/tips.dart';

class FavTipsFirebaseService {
  final CollectionReference _favsCollection =
  FirebaseFirestore.instance.collection('fav_tips');

  String get currentUserId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'default';

  Stream<List<Tip>> getFavs() {
    return _favsCollection.where('userId', isEqualTo: currentUserId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Tip(
          id: doc.id,
          title: data['title'] ?? 'Untitled',
          description: data['description'] ?? 'No description',
          subtitle: data['subtitles'] ?? 'No subtitle',
          imageUrl: data['url'] ?? '',
          date: data['date'] ?? '',
        );
      }).toList();
    });
  }

  Future<void> addFavTip(Tip tip) {
    return _favsCollection.add({
      'date': tip.date,
      'title': tip.title,
      'description': tip.description,
      'subtitles': tip.subtitle,
      'url': tip.imageUrl,
      'userId': FirebaseAuth.instance.currentUser == null ? '': FirebaseAuth.instance.currentUser!.uid,
    });
  }


  Future<void> deleteTip(Tip tip) {
    return _favsCollection.doc(tip.id).delete();
  }
}