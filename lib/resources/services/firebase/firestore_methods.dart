import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/resources/services/firebase/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../../../models/product.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImageToStorage(
    String folderName,
    Uint8List file,
    bool isCart,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        folderName,
        file,
        isCart,
      );
      res = photoUrl;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addItemToCart(
    String description,
    Uint8List file,
    String uid,
    String itemName,
    String price,
    String profImage,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        'cart_items',
        file,
        true,
      );

      String productId = const Uuid().v1();
      Product cartItem = Product(
        id: productId,
        title: itemName,
        price: int.parse(price),
        images: [photoUrl],
      );
      _firestore.collection('user').doc(productId).set(cartItem.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
      Get.snackbar(
        'Error Message',
        res,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return res;
  }

  Future<String> deleteCartItem(String productId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('cart_items').doc(productId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Future<void> addTokenToFirestore(String token) async {
  //   try {
  //     final firestore = FirebaseFirestore.instance;
  //     final registrationDoc = firestore.collection('users').doc();
  //     await registrationDoc.update({'token': token});
  //     debugPrint('Token added to Firestore successfully!');
  //   } catch (err) {
  //     debugPrint('Error adding token to Firestore: $err');
  //   }
  // }

  Future<void> addUserToFirestore(
    String id,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(id).set({
        'email': email,
        'phone': phone,
        'password': password,
      });
    } catch (err) {
      Get.snackbar(
        'Error Message',
        err.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateProfile(
    String id,
    String email,
    String phone,
    String name,
    String profileImage,
  ) async {
    try {
      if (id.isEmpty) {
        throw Exception('Invalid user ID');
      }
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(id).update({
        'email': email,
        'phone': phone,
        'name': name,
        'profileImage': profileImage,
      });
    } catch (err) {
      debugPrint('Error updating profile: $err');
      Get.snackbar(
        'Error',
        'Failed to update profile: $err',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
