import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getDataFromUrl() async {
    final ref = FirebaseStorage.instance.refFromURL(
      'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/products%2Fshoes%2F3.jpg?alt=media&token=d1c08000-a39d-4fd8-89c3-8545437936df',
    );
    final data = await ref.getData();
    Image.memory(data!);
  }

  // edit address to firebase firestore
  Future<void> editAddress({
    required String address,
    required String city,
    required String state,
    required String pincode,
  }) async {
    await _storage
        .ref()
        .child('users')
        .child(_auth.currentUser!.uid)
        .child('address')
        .child('address')
        .putString(address);
    await _storage
        .ref()
        .child('users')
        .child(_auth.currentUser!.uid)
        .child('address')
        .child('city')
        .putString(city);
    await _storage
        .ref()
        .child('users')
        .child(_auth.currentUser!.uid)
        .child('address')
        .child('state')
        .putString(state);
    await _storage
        .ref()
        .child('users')
        .child(_auth.currentUser!.uid)
        .child('address')
        .child('pincode')
        .putString(pincode);
  }

  // Edit number to firebase storage
  Future<void> editNumber(String number) async {
    await _storage
        .ref()
        .child('users')
        .child(_auth.currentUser!.uid)
        .child('number')
        .putString(number);
  }

  // adding file to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
