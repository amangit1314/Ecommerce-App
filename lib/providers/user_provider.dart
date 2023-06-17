import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/providers/auth_provider.dart';

import '../models/address.dart';

class UserProvider with ChangeNotifier {
  models.User _currentUser = models.User(email: '', uid: '');
  late String _username;
  late String _email;
  late String _profileImage;
  bool _loading = false;
  String? _error;

  models.User get currentUser => _currentUser;
  String get uid => _currentUser.uid;
  String get username => _username;
  String get email => _email;
  String get profileImage => _profileImage;
  bool get loading => _loading;
  String? get error => _error;

  void setCurrentUser(models.User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> getCurrentUserDetails() async {
    try {
      _loading = true;

      await Future.delayed(Duration.zero); // Add this line

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot<Map<String, dynamic>> snap =
          await firestore.collection('users').doc(uid).get();
      _currentUser = models.User.fromMap(snap);

      _username = _currentUser.username!;
      _email = _currentUser.email;
      _profileImage = _currentUser.profImage!;

      _loading = false;
    } catch (e) {
      _loading = false;
      _error = e.toString();
    }
  }

  Future<void> updateProfileImage({required String profileImage}) async {
    _profileImage = profileImage;

    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .doc(uid)
          .update({'profImage': profileImage});
    } catch (err) {
      throw Exception(err);
    }

    notifyListeners();
  }

  final AuthProvider _authDataProvider = AuthProvider();

  models.User get user => _authDataProvider.user;

  Future<void> refreshUser() async {
    await _authDataProvider.refreshUser();
    notifyListeners();
  }

  Future<void> updateAllFields(models.User updatedUser) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).update(updatedUser.toMap());
    } catch (err) {
      throw Exception(err);
    }

    notifyListeners();
  }

  Future<String> authenticateUser({
    required String email,
    required String password,
  }) async {
    final AuthProvider authDataProvider = AuthProvider();
    final String uid = await authDataProvider.authenticateUser(
      email: email,
      password: password,
    );

    await getCurrentUserDetails();
    notifyListeners();
    return uid;
  }

  Future<String> authenticateWithGoogle() async {
    final AuthProvider authDataProvider = AuthProvider();
    final result = await authDataProvider.authenticateWithGoogle();
    await getCurrentUserDetails();
    notifyListeners();
    return result;
  }

  Future<void> signOut() async {
    final AuthProvider authDataProvider = AuthProvider();
    await authDataProvider.signOut();
    notifyListeners();
  }

  Future<void> addAddress(
    String uid,
    Address address,
  ) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final userDoc = userCollection.doc(uid);

      await userDoc.update({
        'addresses': FieldValue.arrayUnion([address]),
      });

      notifyListeners();
    } catch (error) {
      throw Exception('Failed to add address: $error');
    }
  }

  Future<List<String>> getAddresses(String uid) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final userDoc = userCollection.doc(uid);

      final userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final addresses = userData['addresses'] as List<dynamic>?;

        if (addresses != null) {
          return addresses.cast<String>();
        }
      }

      return [];
    } catch (error) {
      throw Exception('Failed to get addresses: $error');
    }
  }
}
