import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/resources/auth_methods.dart';

class AuthProvider with ChangeNotifier {
  models.User _user = models.User(email: 'default@gmail.com', uid: '');
  final AuthMethods _authMethods = AuthMethods();

  models.User get user => _user;

  Future<void> refreshUser() async {
    models.User user = await _authMethods.getUserDetails();
    _user = models.User(
      uid: user.uid,
      email: user.email,
      username: user.username,
      profImage: user.profImage,
      number: user.number,
    );
    notifyListeners();
  }

  Future<String> registerUser(
      {required String email, required String password, String? mobile}) async {
    String uid = await _authMethods.registerUser(
      email: email,
      password: password,
      username: email.substring(5),
      phone: mobile,
    );
    notifyListeners();
    return uid;
  }

  Future<String> authenticateUser({
    required String email,
    required String password,
  }) async {
    notifyListeners();
    return await _authMethods.loginUser(email: email, password: password);
  }

  Future<UserCredential> authenticateWithGoogle() async {
    notifyListeners();
    return await _authMethods.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authMethods.signOut();
    _user = models.User(email: 'default@gmail.com', uid: '');
    notifyListeners();
  }
}
