import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/resources/auth_methods.dart';

import '../models/order.dart';
import '../resources/user_details_methods.dart';

class UserProvider with ChangeNotifier {
  models.User _user = models.User(email: 'default@gmail.com', uid: '');
  final AuthMethods _authMethods = AuthMethods();
  final UserDetailsMethods _userDetailsMethods = UserDetailsMethods();

  models.User get user => _user;
  List<Order>? get orders => _user.orders;

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

  Future<String> registerUser({
    required String email,
    required String password,
    String? mobile,
  }) async {
    return await _authMethods.registerUser(
      email: email,
      password: password,
      username: email.substring(5),
      phone: mobile,
    );
  }

  Future<String> authenticateUser({
    required String email,
    required String password,
  }) async {
    return await _authMethods.loginUser(email: email, password: password);
  }

  Future<void> signOut() async {
    await _authMethods.signOut();
    _user = models.User(email: 'default@gmail.com', uid: '');
    notifyListeners();
  }

  Future<void> updateAllFields(models.User updatedUser) async {
    await _userDetailsMethods.updateUserDetailsFromProvider(updatedUser);
    _user = updatedUser;
    notifyListeners();
  }

  Future<void> addPayment(models.Payment payment) async {
    _user.payments!.add(payment);
    notifyListeners();
  }

  Future<void> addOrder(Order order) async {
    _user.orders;
    _user.orders.add(order);
    await _userDetailsMethods.updateUserDetailsFromProvider(_user);
    notifyListeners();
  }

  Future<void> updateProfileImage({required String profileImage}) async {
    _user = _user.copyWith(profImage: profileImage);
    await _userDetailsMethods.updateUserDetailsFromProvider(_user);
    notifyListeners();
  }
}
