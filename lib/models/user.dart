import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String? username;
  final String? password;
  final String? number;
  final String? profImage;
  final String? gender;

  User({
    required this.email,
    required this.uid,
    this.username,
    this.password,
    this.number,
    this.profImage,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'password': password,
      'number': number,
      'profImage': profImage,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
      json.decode(source) as DocumentSnapshot<Map<String, dynamic>>);

  // factory User.fromJson(String source) =>
  // User.fromMap(json.decode(source) as DocumentSnapshot<Object?>);
}
