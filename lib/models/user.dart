import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soni_store_app/models/payment.dart';
import 'package:soni_store_app/models/product.dart';

class User {
  final String email;
  final String uid;
  final String? username;
  final String? password;
  final String? number;
  final String? profImage;
  final String? gender;
  final List<String?>? addresses;
  final List<Order>? orders;
  final List<Payment>? payments;
  final List<Product> cartItems;

  const User({
    required this.email,
    required this.uid,
    this.username,
    this.password,
    this.cartItems = const [],
    this.number,
    this.profImage,
    this.gender,
    this.addresses,
    this.orders,
    this.payments,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'uid': uid,
        'username': username,
        'password': password,
        'cartItems': cartItems.map((e) => e.toMap()).toList(),
        'number': number,
        'profImage': profImage,
        'orders': orders,
        'payments': payments,
        'addresses': addresses,
        'gender': gender,
      };

  static User fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      number: snapshot['number'] as String?,
      gender: snapshot['gender'] as String?,
      addresses: snapshot['addresses']?.cast<String>(),
      cartItems: (snapshot['cartItems'] as List<dynamic>?)
              ?.map((item) => Product.fromMap(item))
              .toList() ??
          [],
      uid: snapshot['uid'] as String? ?? '',
      email: snapshot['email'] as String? ?? '',
      username: snapshot['username'] as String? ?? '',
      profImage: snapshot['profImage'] as String? ?? '',
      orders: snapshot['orders']?.cast<Order>(),
      payments: snapshot['payments'],
      password: snapshot['password'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
