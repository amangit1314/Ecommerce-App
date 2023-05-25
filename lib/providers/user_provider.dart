import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/resources/auth_methods.dart';

import '../resources/user_details_methods.dart';

class UserProvider with ChangeNotifier {
  models.User _user = models.User(email: 'default@gmail.com', uid: '');
  final AuthMethods _authMethods = AuthMethods();
  final UserDetailsMethods _userDetailsMethods = UserDetailsMethods();

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

  Future<void> updateAllFields(models.User updatedUser) async {
    await _userDetailsMethods.updateUserDetailsFromProvider(updatedUser);
    _user = updatedUser;
    notifyListeners();
  }

  Future<void> updateProfileImage({required String profileImage}) async {
    _user = _user.copyWith(profImage: profileImage);
    await _userDetailsMethods.updateUserDetailsFromProvider(_user);
    notifyListeners();
  }
}
