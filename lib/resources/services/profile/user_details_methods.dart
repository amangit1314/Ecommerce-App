import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user.dart' as model;

class UserDetailsMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProfileImage(
      {required String uid, required String photoURL}) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .update({'photoURL': photoURL});
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> addPhoneNumber(
      {required String uid, required String phoneNumber}) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .update({'phoneNumber': phoneNumber});
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> updateUserDetailsFromProvider(
      String uid, model.User user) async {
    try {
      await _firestore.collection('users').doc(uid).update(user.toMap());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<model.User> getUserDetails(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(uid).get();
    return model.User.fromMap(snap);
  }
}
