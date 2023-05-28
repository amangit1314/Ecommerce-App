import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soni_store_app/models/models.dart' as models;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<models.User?> _userFromFirebase(auth.User? user) async {
    if (user == null) {
      return null;
    }

    try {
      final snapshot = await _firestore.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        final userData = snapshot.data();
        if (userData != null) {
          return models.User(
            uid: user.uid,
            email: user.email!,
            username: userData['username'],
            password: userData['password'],
            profImage: userData['profImage'],
            gender: userData['gender'],
            number: userData['number'],
            cartItems: userData['cartItems'],
            addresses: userData['addresses'],
          );
        }
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Stream<models.User?> get user {
    return _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);
  }

  Future<models.User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final auth.UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;

        // Check if the user exists in Firestore
        final snapshot = await _firestore.collection('users').doc(uid).get();
        if (snapshot.exists) {
          final userData = snapshot.data();
          if (userData != null) {
            return models.User(
              uid: uid,
              email: email,
              username: userData['username'],
              password: userData['password'],
              profImage: userData['profImage'],
              gender: userData['gender'],
              number: userData['number'],
              cartItems: userData['cartItems'],
              addresses: userData['addresses'],
            );
          }
        }

        // If the user does not exist in Firestore, create a new user
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'password': password,
        });
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  Future<models.User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final auth.UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        models.User user = models.User(
          uid: userCredential.user!.uid,
          email: email,
          username: email.split('@')[0],
          password: password,
          profImage:
              'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000',
          gender: 'Not Defined',
          number: 'Not Defined',
          cartItems: [],
          addresses: [],
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(user.toMap(), SetOptions(merge: true));
        return _userFromFirebase(userCredential.user);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<auth.UserCredential> authenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<models.User?> getUserDetails(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        final userData = snapshot.data();
        if (userData != null) {
          return models.User(
            uid: uid,
            email: userData['email'],
            username: userData['username'],
            password: userData['password'],
            profImage: userData['profImage'],
            gender: userData['gender'],
            number: userData['number'],
            cartItems: userData['cartItems'],
            addresses: userData['addresses'],
          );
        }
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<void> updateUserField(String uid, String field, dynamic value) async {
    try {
      await _firestore.collection('users').doc(uid).update({field: value});
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

//   Future<void> setAddress(Address address, String uid) async {
//     try {
//       final DocumentReference userRef = _firestore.collection('users').doc(uid);
//       final DocumentSnapshot<Object?> snapshot = await userRef.get();
//       if (snapshot.exists) {
//         final List<Address?>? addresses = snapshot.data()?['addresses'];
//         if (addresses != null) {
//           addresses.add(address);
//           await userRef.update({'addresses': addresses});
//         }
//       }
//     } catch (error) {
//       log(error.toString());
//       rethrow;
//     }
//   }

// void setSelectedAddress(Address address, String uid) async {
//     try {
//       final DocumentReference userRef = _firestore.collection('users').doc(uid);
//       final DocumentSnapshot<Map<String, dynamic>> snapshot =
//           await userRef.get();
//       if (snapshot.exists) {
//         final List<Address?>? addresses = snapshot.data()?['addresses'];
//         if (addresses != null) {
//           for (int i = 0; i < addresses.length; i++) {
//             if (addresses[i]?.id == address.id) {
//               addresses[i] = address;
//               break;
//             }
//           }
//           await userRef.update({'addresses': addresses});
//         }
//       }
//     } catch (error) {
//       log(error.toString());
//       rethrow;
//     }
//   }
}
