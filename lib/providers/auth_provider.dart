import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soni_store_app/models/user.dart' as models;

import '../models/address.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  models.User _user = models.User(uid: '', email: '');
  models.User get user => _user;

  String _uid = '';
  String get uid => _uid;

  String _email = '';
  String get email => _email;

  String _username = '';
  String get username => _username;

  String _profileImage =
      'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000';
  String get profileImage => _profileImage;

  final List<Address?> _addresses = [];
  List<Address?>? get addresses => _addresses;

  Address? _selectedAddress;
  Address? get selectedAddress => _selectedAddress;

  Future<void> refreshUser() async {
    try {
      if (_auth.currentUser != null) {
        await getUserDetails(_auth.currentUser!);
        _user = user;
        _uid = user.uid;
        _email = user.email;
        _username = user.username ?? user.email.split('@')[0];
        _profileImage = user.profImage ??
            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000';
      }
    } catch (error) {
      Get.snackbar(
        'User Logged Out',
        'User is currently logged out',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
    notifyListeners();
  }

  Future<void> getUserDetails(User user) async {
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(user.uid).get();
    _user = models.User.fromMap(snap);
  }

  Future<void> updateUserField(String uid, String field, dynamic value) async {
    try {
      await _firestore
          .collection('users')
          .doc(_user.uid)
          .update({field: value});
      refreshUser();
    } catch (error) {
      log(error.toString());
      // rethrow;
    }
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
          password: password.hashCode.toString(),
          uid: uid,
        );

        await _firestore.collection('users').doc(uid).set(
              user.toMap(),
              SetOptions(merge: true),
            );

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
        if (_auth.currentUser != null) {
          await getUserDetails(_auth.currentUser!);
        }
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

  Future<String> authenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ) as GoogleAuthCredential;

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (_auth.currentUser != null && user != null) {
        final QuerySnapshot result = await _firestore
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        String uid = user.uid;
        String profImage = user.photoURL ?? '';

        if (documents.isEmpty) {
          models.User user = models.User(
            email: email,
            username: username,
            uid: uid,
            profImage: profImage != '' ? profImage : '',
          );

          _firestore.collection('users').doc(uid).set(user.toMap());
        }

        await getUserDetails(_auth.currentUser!);
        await getUserDetails(user);

        notifyListeners();
        return 'success';
      }
    } on FirebaseAuthException {
      return 'failure';
    }
    return 'failure';
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setAddress(Address address, String uid) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('User is Empty');
    }

    _addresses.add(address);

    await _firestore
        .collection('users')
        .doc(uid)
        .update({'addresses': _addresses});

    refreshUser();
  }

  void setSelectedAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }
}
