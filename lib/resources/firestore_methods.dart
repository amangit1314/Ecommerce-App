import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soni_store_app/models/cart_item.dart';
import 'package:soni_store_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

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
      _firestore.collection('user').doc(productId).set(cartItem.toJson());
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
  Future<List<CartItem>> getCartItems(String uid) async {
    List<CartItem> cartItems = [];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('cart_items')
          .where('uid', isEqualTo: uid)
          .get();
      for (var doc in snapshot.docs) {
        cartItems.add(CartItem.fromSnap(doc));
      }
    } catch (err) {
      Get.snackbar(
        'Error Message',
        err.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return cartItems;
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
