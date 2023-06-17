import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soni_store_app/models/models.dart' as models;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<models.User?> _userFromFirebase(auth.User? user) async {
    if (user == null) {
      return null;
    }

    try {
      final snapshot = await _firestore.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        final userData = snapshot.data();
        if (userData != null) {
          return models.User(
            uid: user.uid,
            email: user.email!,
            username: userData['username'],
            password: userData['password'],
            profImage: userData['profImage'],
            gender: userData['gender'],
            number: userData['number'],
            // cartItems: userData['cartItems'],
            // addresses: userData['addresses'],
          );
        }
      }
    } catch (e) {
      log('Error retrieving user data: $e');
    }

    return null;
  }

  Stream<models.User?> get user {
    return _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);
  }

  Future<models.User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final auth.UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;

        // Check if the user exists in Firestore
        final snapshot = await _firestore.collection('users').doc(uid).get();
        if (snapshot.exists) {
          final userData = snapshot.data();
          if (userData != null) {
            return models.User(
              uid: uid,
              email: email,
              username: userData['username'],
              password: userData['password'],
              profImage: userData['profImage'],
              gender: userData['gender'],
              number: userData['number'],
              // cartItems: userData['cartItems'],
              // addresses: userData['addresses'],
            );
          }
        }

        // If the user does not exist in Firestore, create a new user
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'password': password,
        });
      }
    } catch (e) {
      log('Error signing in with email and password: $e');
    }

    return null;
  }

  Future<models.User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final auth.UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        models.User user = models.User(
          uid: userCredential.user!.uid,
          email: email,
          username: email.split('@')[0],
          password: password,
          profImage:
              'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000',
          gender: 'Not Defined',
          number: 'Not Defined',
          // cartItems: [],
          // addresses: [],
        );

        await _firestore.collection('users').doc(user.uid).set(user.toMap());

        return user;
      }
    } catch (e) {
      log('Error creating user with email and password: $e');
    }

    return null;
  }

  Future<models.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;

        final auth.AuthCredential credential =
            auth.GoogleAuthProvider.credential(
          idToken: googleSignInAuth.idToken,
          accessToken: googleSignInAuth.accessToken,
        );

        final auth.UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        if (userCredential.user != null) {
          final uid = userCredential.user!.uid;
          final email = userCredential.user!.email;

          // Check if the user exists in Firestore
          final snapshot = await _firestore.collection('users').doc(uid).get();
          if (snapshot.exists) {
            final userData = snapshot.data();
            if (userData != null) {
              return models.User(
                uid: uid,
                email: email!,
                username: userData['username'],
                password: userData['password'],
                profImage: userData['profImage'],
                gender: userData['gender'],
                number: userData['number'],
                // cartItems: userData['cartItems'],
                // addresses: userData['addresses'],
              );
            }
          }

          // If the user does not exist in Firestore, create a new user
          models.User user = models.User(
            uid: uid,
            email: email!,
            username: email.split('@')[0],
            password: '',
            profImage:
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000',
            gender: 'Not Defined',
            number: 'Not Defined',
            // cartItems: [],
            // addresses: [],
          );

          await _firestore.collection('users').doc(uid).set(user.toMap());

          return user;
        }
      }
    } catch (e) {
      log('Error signing in with Google: $e');
    }

    return null;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      log('Error signing out: $e');
    }
  }
}
