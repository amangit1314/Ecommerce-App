import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(currentUser!.uid).get();
    return model.User.fromMap(snap);
  }

  Future<String> registerUser({
    BuildContext? context,
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.User user = model.User(
          email: email,
          username: username,
          uid: cred.user!.uid,
          password: password,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toMap());

        res = 'success';
      } else {
        res = '❗Please enter all required information';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = '❗The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = '❗Password should be at least 6 characters long';
      }
    } catch (err) {
      res = err.toString();
      Get.snackbar(
        'Error Message',
        err.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return res;
  }

  Future<String> loginUser({
    BuildContext? context,
    required String email,
    required String password,
  }) async {
    String res = "❓Error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = '❗Please enter both email and password';
      }
    } catch (err) {
      res = err.toString();
      Get.snackbar(
        'Error Message',
        err.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return res;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> addProfileImage({required String photoURL}) async {
    User? currentUser = _auth.currentUser;
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
    User? currentUser = _auth.currentUser;
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
}

class UserDetailsMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProfileImage({required String photoURL}) async {
    User? currentUser = _auth.currentUser;
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
    User? currentUser = _auth.currentUser;
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
    User? currentUser = _auth.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(currentUser!.uid).get();
    return model.User.fromMap(snap);
  }
}
