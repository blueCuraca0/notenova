import 'package:firebase_auth/firebase_auth.dart';

class AuthorizationInfo {
  static User? user = FirebaseAuth.instance.currentUser;
}