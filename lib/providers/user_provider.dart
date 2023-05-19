import 'package:flutter/material.dart';
import 'package:soni_store_app/models/user.dart' as model;
import 'package:soni_store_app/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();

  model.User? get getUser => _user;

  Future<void> refreshUser() async {
    model.User? user = await _authMethods.getUserDetails();
    _user = model.User(
      uid: user.uid,
      email: user.email,
      username: user.username,
      profImage: user.profImage,
      number: user.number,
    );
    notifyListeners();
  }

  Future registerUser({
    required String email,
    required String password,
    String? mobile,
  }) async {
    return await _authMethods.registerUser(
      email: email,
      password: password,
      username: email.substring(5),
    );
  }

  Future authenticateUser({
    required String email,
    required String password,
  }) async {
    return await _authMethods.loginUser(email: email, password: password);
  }

  Future updateUserDetails({required String displayName}) async {
    return await _authMethods.updateUserDetails(displayName: displayName);
  }

  Future updateUserEmail({required String email}) async {
    if (email.isNotEmpty) {
      return await _authMethods.updateEmail(email: email);
    } else {
      throw Exception("Invalid email");
    }
  }

  Future updateUserPassword({required String password}) async {
    return await _authMethods.updatePassword(password: password);
  }

  Future<void> updateUserProfileImage({required String profileImage}) async {
    await _authMethods.updateUserPic(photoURL: profileImage);
    final userData = await _authMethods.getUserDetails();
    _user = model.User(
      uid: userData.uid,
      email: userData.email,
      username: userData.username,
      profImage: userData.profImage,
      number: userData.number,
    );
    notifyListeners();
  }

  Future resetPassword({required String email}) async {
    return await _authMethods.resetPassword(email: email);
  }

  Future signOut() async {
    return await _authMethods.signOut();
  }
}
