// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/models/cart_item.dart';
import 'package:soni_store_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import '../models/user.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      CartItem cartItem = CartItem(
        uid: productId,
        productName: itemName,
        price: price,
        productUrl: photoUrl,
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

      List<CartItem> cartItems = cartItemsSnapshot.docs
          .map((doc) => CartItem.fromMap(doc as Map<String, dynamic>))
          .toList();

      for (CartItem cartItem in cartItems) {
        DocumentSnapshot<Map<String, dynamic>> productSnapshot =
            await FirebaseFirestore.instance.doc(cartItem.productUrl).get();

        Product product = Product.fromMap(productSnapshot.data()!);

        products.add(product);
      }
    } catch (e) {
      print('Error getting products from Firestore: $e');
    }

    return products;
  }

  // edit or addaddress to firebase firestore
  Future<void> editAddress({
    required String address,
    required String city,
    required String state,
    required String pincode,
  }) async {
    await _firestore
        .collection('users')
        .doc(_firestore.collection('users').doc().id)
        .set({
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
    });
  }

  // add number or edit number in firestore
  Future<void> editNumber(String number) async {
    await _firestore
        .collection('users')
        .doc(_firestore.collection('users').doc().id)
        .set({'number': number});
  }

  // flutter notifications
  Future<void> addTokenToFirestore(String token) async {
    await _firestore
        .collection('users')
        .doc(_firestore.collection('users').doc().id)
        .set({'token': token});
  }
}
