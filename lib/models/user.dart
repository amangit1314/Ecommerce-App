import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soni_store_app/models/product.dart';

import 'address.dart';

class User {
  final String email;
  final String uid;
  final String? username;
  final String? password;
  final String? number;
  final String? profImage;
  final String? gender;
  final List<Address?>? addresses;
  final List<Product>? cartItems;

  User({
    required this.email,
    required this.uid,
    this.username,
    this.password,
    this.cartItems,
    this.number,
    this.profImage,
    this.gender,
    this.addresses,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'password': password,
      'cartItems': cartItems?.map((e) => e.toMap()).toList(),
      'number': number,
      'profImage': profImage,
      'addresses': addresses,
      'gender': gender,
    };
  }

  factory User.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return User(
      email: data['email'] as String? ?? '',
      uid: data['uid'] as String? ?? '',
      username: data['username'] as String?,
      password: data['password'] as String?,
      number: data['number'] as String?,
      profImage: data['profImage'] as String?,
      gender: data['gender'] as String?,
      addresses: data['addresses'] as List<Address?>?,
      cartItems: (data['cartItems'] as List<Product>?)
          ?.map((item) => Product.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
      json.decode(source) as DocumentSnapshot<Map<String, dynamic>>);

  // factory User.fromJson(String source) =>
  // User.fromMap(json.decode(source) as DocumentSnapshot<Object?>);
}
