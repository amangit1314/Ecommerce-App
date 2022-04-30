import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  // final String photoUrl;
  final String username;
  final String bio;
  // final List followers;
  // final List following;

  const User({
    required this.email,
    required this.uid,
    // required this.photoUrl,
    required this.username,
    required this.bio,
    // required this.followers,
    // required this.following,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        // 'photoUrl': photoUrl,
        'username': username,
        'bio': bio,
        // 'followers': followers,
        // 'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'] as String,
      uid: snapshot['uid'] as String,
      // photoUrl: snapshot['photoUrl'] as String,
      username: snapshot['username'] as String,
      bio: snapshot['bio'] as String,
      // followers: snapshot['followers'] as List,
      // following: snapshot['following'] as List,
    );
  }
}
