import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String uid, String name, String avatarUrl) {
    return users.doc(uid).set({
      'name': name,
      'avatar': avatarUrl,
      'xp_points': 0
    });
  }

  static Future<void> updateHabit(String uid, String name, String avatarUrl, int xp) {
    return users.doc(uid).update({
      'name': name,
      'avatar': avatarUrl,
      'xp_points': xp
    });
  }
}
