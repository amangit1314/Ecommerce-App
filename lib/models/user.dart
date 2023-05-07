import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class User {
  final String email;
  final String? uid;
  final String? username;
  final String? password;
  final List<CartItem>? cartItems;

  const User(
    this.cartItems, {
    required this.email,
    this.uid,
    this.username,
    this.password,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'uid': uid,
        'username': username,
        'password': password,
        'cartItems': cartItems?.map((e) => e.toMap()).toList(),
      };

  static User fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      snapshot['cartItems']?.map((e) => CartItem.fromMap(e)).toList(),
      email: snapshot['email'] as String,
      uid: snapshot['uid'] as String,
      username: snapshot['username'] as String,
      password: snapshot['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
