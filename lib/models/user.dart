import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String? uid;
  final String? username;
  final String? password;

  const User({
    required this.email,
    this.uid,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'username': username,
        'password': password,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'] as String,
      uid: snapshot['uid'] as String,
      username: snapshot['username'] as String,
      password: snapshot['password'] as String,
    );
  }
}
