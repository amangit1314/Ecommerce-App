import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart' as model;

class UserDetailsMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProfileImage({required String photoURL}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'photoURL': photoURL});
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> addPhoneNumber({required String phoneNumber}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'phoneNumber': phoneNumber});
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> updateUserDetailsFromProvider(model.User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update(user.toMap());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<model.User> getUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(currentUser!.uid).get();
    return model.User.fromMap(snap);
  }
}
