import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServiceAuth {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String uid, String name, String avatarUrl) {
    return users
        .doc(uid)
        .set({'name': name, 'avatar': avatarUrl, 'xp_points': 0});
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

  static Future<Map<String, dynamic>> getUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    DocumentReference<Map<String, dynamic>> doc =
        users.doc(uid) as DocumentReference<Map<String, dynamic>>;

    DocumentSnapshot<Map<String, dynamic>> document = await doc.get();
    Map<String, dynamic>? data = document.data();

    // if there is no userData with this id, then document.data() is null
    if (data == null) {
      return {'name': '', 'avatar': '', 'xp_points': -1};
    }

    Map<String, dynamic> userData = document.data() as Map<String, dynamic>;

    return {
      'name': userData['name'],
      'avatar': userData['avatar'],
      'xp_points': userData['xp_points']
    };
  }

  static Future<void> updateUserXP(int xp) async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    Map<String, dynamic> userData = await getUserInfo();

    return users.doc(uid).update({
      'name': userData['name'],
      'avatar': userData['avatar'],
      'xp_points': userData['xp_points'] + xp
    });
  }
}
