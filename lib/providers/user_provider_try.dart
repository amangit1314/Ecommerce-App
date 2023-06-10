import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import '../models/models.dart' as models;

class UserProviderTry with ChangeNotifier {
  models.User? _user;
  models.User? get user => _user;

  String _uid = '';
  String get uid => _uid;

  String _email = '';
  String get email => _email;

  String _username = '';
  String get username => _username;

  String _profileImage =
      'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000';
  String get profileImage => _profileImage;

  List<models.Address>? addresses = [];
  List<models.Address>? get address => addresses;

  models.Address? _selectedAddress;
  models.Address? get selectedAddress => _selectedAddress;

  void setUser(models.User user) {
    _user = user;
    notifyListeners();
  }

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setProfileImage(String profileImage) {
    _profileImage = profileImage;
    notifyListeners();
  }

  void setAddress(models.Address address, String uid) async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is Empty');
    }

    addresses!.add(address);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'addresses': addresses});

    notifyListeners();
  }

  void setSelectedAddress(models.Address address) {
    _selectedAddress = address;
    notifyListeners();
  }
}
