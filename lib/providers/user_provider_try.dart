import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import '../models/address.dart';
import '../models/models.dart';

class UserProviderTry with ChangeNotifier {
  User? _user;
  User? get user => _user;

  String _uid = '';
  String get uid => _uid;

  String _email = '';
  String get email => _email;

  String _username = '';
  String get username => _username;

  String _profileImage =
      'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000';
  String get profileImage => _profileImage;

  List<Address>? addresses = [];
  List<Address>? get address => addresses;

  Address? _selectedAddress;
  Address? get selectedAddress => _selectedAddress;

  void setUser(User user) {
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

  void setAddress(Address address, String uid) async {
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

  void setSelectedAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }
}
