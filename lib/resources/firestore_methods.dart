import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';

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

  Future<void> addTokenToFirestore(String token) async {
    await _firestore
        .collection('users')
        .doc(_firestore.collection('users').doc().id)
        .set({'token': token});
  }
}
