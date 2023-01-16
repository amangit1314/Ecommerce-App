import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soni_store_app/screens/sign_in/sign_in_screen.dart';

import '../models/user.dart' as model;
import '../screens/login_success/login_success_screen.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    final DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> registerUser({
    BuildContext? context,
    required String email,
    required String password,
    required String username,
  }) async {
    //final navigator = Navigator.of(context!);
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
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
            .set(user.toJson());
        res = 'success';

        Navigator.of(context!).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const SignInScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = '❗The email is badly formated...';
      } else if (err.code == 'weak-password') {
        res = 'Password should be 6 characters long...';
      }
    } catch (err) {
      res = res.toString();
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

  Future<String> loginUser(
      {required BuildContext context,
      required email,
      required password}) async {
    String res = "❓error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid)
              .get()
              .then((value) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const LoginSuccessScreen(),
              ),
            );
          });
        });
        res = 'success';
      } else {
        res = '❗Please enter both email and password';
      }
    } catch (err) {
      res = res.toString();
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
}
