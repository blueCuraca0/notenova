import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/profile/presentation/cubits/user_state.dart';

class UserDataCubit extends Cubit<UserState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserDataCubit(this._firestore, this._auth) : super(UserLoading());

  void getUserData() async {
    try {
      final user = _auth.currentUser;
      final snapshot =
          await _firestore.collection('users').doc(user?.uid).get();
      if (snapshot.exists) {
        final userData = snapshot.data();
        emit(UserLoaded(userData!));
      } else {
        emit(UserError('User data not found'));
      }
    } catch (e) {
      emit(UserError('Error occurred: $e'));
    }
  }

  Future updateUserProfile(
    User user,
    String avatar,
  ) async {
    await _firestore.collection('users').doc(user.uid).update({
      'avatar': avatar,
    });
  }

  Future updateUserName(
    User user,
    String name,
  ) async {
    await _firestore.collection('users').doc(user.uid).update({
      'name': name,
    });
    getUserData();
  }
}
