import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soni_store_app/models/models.dart' as models;

class AuthProvider with ChangeNotifier {
  models.User _user = models.User(uid: '', email: '');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  models.User get user => _user;

  Future<void> refreshUser() async {
    try {
      models.User user = await getUserDetails();
      _user = user;
    } catch (error) {
      const GetSnackBar(
        title: 'User LogedOut',
        message: 'User is currently loged out',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
    notifyListeners();
  }

  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    String? phone,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User signedInUser = credential.user!;
        String uid = signedInUser.uid;

        models.User user = models.User(
          email: email,
          username: username,
          uid: uid,
        );

        await _firestore
            .collection('users')
            .doc(uid)
            .set(user.toMap(), SetOptions(merge: true));
        _user = user;
        notifyListeners();
        return uid;
      } else {
        return 'Please enter all required information';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        return 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        return 'Password should be at least 6 characters long';
      }
    } catch (err) {
      return err.toString();
    }

    return 'Some error occurred';
  }

  Future<String> authenticateUser({
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
        _user = await getUserDetails();
        notifyListeners();
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

  Future<UserCredential> authenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      _user = await getUserDetails();
      notifyListeners();
      return userCredential;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<models.User> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(currentUser!.uid).get();
    return models.User.fromMap(snap);
  }
}
