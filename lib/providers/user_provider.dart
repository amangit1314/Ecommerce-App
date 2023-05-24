import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/resources/auth_methods.dart';

import '../models/order.dart';

class UserProvider with ChangeNotifier {
  models.User _user = models.User(
    email: 'default@gmail.com',
    uid: '',
  );
  final AuthMethods _authMethods = AuthMethods();

  models.User get getUser => _user;
  List<Order>? get orders => _user.orders;

  // ? <------------------ Authentication Methods ------------------->
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

  Future signOut() async {
    return await _authMethods.signOut();
  }
  // ? <--------------------------------------------------------------->

  // ! <----------------------- User Details ------------------------>
  Future<void> updateAllFields({
    String? username,
    String? password,
    String? email,
    String? mobile,
    String? profImage,
    String? number,
    String? gender,
    List<String?>? addresses,
    List<models.Order>? orders,
    List<models.Payment>? payments,
    List<models.Product>? cartItems,
  }) async {
    final updatedUser = models.User(
      uid: _user.uid,
      email: email ?? _user.email,
      username: username ?? _user.username,
      password: password ?? _user.password,
      number: number ?? _user.number,
      profImage: profImage ?? _user.profImage,
      gender: gender ?? _user.gender,
      addresses: addresses ?? _user.addresses,
      orders: orders ?? _user.orders,
      payments: payments ?? _user.payments,
      cartItems: cartItems ?? _user.cartItems,
    );

    // Call a method to update the user details in the backend
    await _authMethods.updateUserDetailsFromProvider(updatedUser);

    _user = updatedUser;
    notifyListeners();
  }
  // ! <------------------------------------------------------------->

  // * <----------------------- Payments ---------------------->
  Future<void> addPayment(models.Payment payment) async {
    _user.payments!.add(payment);
    notifyListeners();
  }
  // * <------------------------------------------------------->
}
