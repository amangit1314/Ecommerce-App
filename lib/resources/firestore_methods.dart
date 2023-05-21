// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import '../models/user.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload image
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
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        'cart_items',
        file,
        true,
      );
      // creates unique id based on time
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

  // Delete CartItem
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

  // get product from firestore from users collection and cart_items sub collection
  Future<List<Product>> getProductsFromFirestore(String userId) async {
    List<Product> products = [];

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      User user = User.fromMap(userSnapshot);

      QuerySnapshot cartItemsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart_items')
          .get();

      List cartItems = cartItemsSnapshot.docs
          .map((doc) => Product.fromMap(doc as Map<String, dynamic>))
          .toList();

      for (Product cartItem in cartItems) {
        DocumentSnapshot<Map<String, dynamic>> productSnapshot =
            // ! -----------
            await FirebaseFirestore.instance
                .doc(cartItem.images[cartItem.id])
                .get();

        Product product = Product.fromMap(productSnapshot.data()!);

        products.add(product);
      }
    } catch (e) {
      print('Error getting products from Firestore: $e');
    }

    return products;
  }

  // flutter notifications
  Future<void> addTokenToFirestore(String token) async {
    await _firestore
        .collection('users')
        .doc(_firestore.collection('users').doc().id)
        .set({'token': token});
  }
}
