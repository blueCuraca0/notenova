import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(
      String uid, String name, String avatarUrl, String email) {
    return users.doc(uid).set(
        {'name': name, 'email': email, 'avatar': avatarUrl, 'xp_points': 0});
  }

  static Future<void> updateUser(
    String uid,
    String name,
    String avatar,
    int xp,
    String email,
  ) {
    return users.doc(uid).update(
        {'name': name, 'email': email, 'avatar': avatar, 'xp_points': xp});
  }
}
