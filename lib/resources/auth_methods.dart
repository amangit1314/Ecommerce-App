import 'dart:typed_data';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tokoto_ecommerce_app/resources/storage_methods.dart';

import '../models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    final DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // to register the user
  Future<String> registerUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //  register user using firebase
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('postPics', file, false);

        model.User user = model.User(
          bio: bio,
          email: email,
          username: username,
          // photoUrl: photoUrl,
          uid: cred.user!.uid,
          // followers: [],
          // following: [],
        );

        //  add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = '❗The email is badly formated...';
      } else if (err.code == 'weak-password') {
        res = 'Password should be 6 characters long...';
      }
    } catch (err) {
      res = res.toString();
    }
    return res;
  }

  // to login the user
  Future<String> loginUser({required email, required password}) async {
    String res = "❓error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = '❗Please enter both email and password';
      }
    } catch (err) {
      res = res.toString();
    }
    return res;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
