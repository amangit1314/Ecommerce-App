import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soni_store_app/models/order.dart' as order;
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
  final List<order.Order> orders; // Updated field: List of orders
  final List<Payment>? payments;
  final List<Product> cartItems;

  User({
    required this.email,
    required this.uid,
    this.username = 'Default User',
    this.password = '',
    this.cartItems = const [],
    this.number = '+91 1234567891',
    this.profImage = '',
    this.gender = 'Not Defined',
    this.addresses = const [],
    this.orders = const [], // Initialize orders with an empty list
    this.payments = const [],
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'uid': uid,
        'username': username,
        'password': password,
        'cartItems': cartItems.map((e) => e.toMap()).toList(),
        'number': number,
        'profImage': profImage,
        'orders': orders.map((order) => order.toMap()).toList(),
        'payments': payments,
        'addresses': addresses,
        'gender': gender,
      };

  factory User.fromMap(DocumentSnapshot snap) {
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
      orders: (snapshot['orders'] as List<dynamic>?)
              ?.map((item) => order.Order.fromMap(item))
              .toList() ??
          [],
      payments: snapshot['payments'],
      password: snapshot['password'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
        json.decode(source) as DocumentSnapshot<Object?>,
      );

  // create fromIdEmail
  factory User.fromIdEmail(String id, String email) {
    return User(
      uid: id,
      email: email,
      username: '',
      password: '',
      cartItems: [],
    );
  }
}

extension UserExtension on User {
  User copyWith({
    String? uid,
    String? email,
    String? username,
    String? profImage,
    String? number,
    List<Order>? orders,
    List<Payment>? payments,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profImage: profImage ?? this.profImage,
      number: number ?? this.number,
      payments: payments ?? this.payments,
    );
  }
}
