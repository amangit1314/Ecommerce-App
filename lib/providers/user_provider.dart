import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = (await _authMethods.getUserDetails()) as User;
    _user = user;
    notifyListeners();
  }

  // register user with email and password with optional mobile
  Future registerUser(
      {required String email, required String password, String? mobile}) async {
    return await _authMethods.registerUser(
      username: email.substring(5),
      email: email,
      password: password,
    );
  }

  // authenticate with email and password
  Future authenticateUser(
      {required String email, required String password}) async {
    return await _authMethods.loginUser(email: email, password: password);
  }

  // update displayName
  Future updateUserDetails({required String displayName}) async {
    return await _authMethods.updateUserDetails(displayName: displayName);
  }

  // update email
  Future updateUserEmail({required String email}) async {
    return await _authMethods.updateUserEmail(email: email);
  }

  // update number
  Future updateUserNumber({required String number}) async {
    return await _authMethods.updateUserNumber(number: number);
  }

  // update password
  Future updateUserPassword({required String password}) async {
    return await _authMethods.updateUserPassword(password: password);
  }
}
