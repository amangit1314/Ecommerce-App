import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokoto_ecommerce_app/models/cart_item.dart';
import 'package:tokoto_ecommerce_app/resources/storage_methods.dart';
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
        productDescription: description,
        uid: productId,
        productName: itemName,
        price: price,
        // datePublished: DateTime.now(),
        productUrl: photoUrl,
      );
      _firestore.collection('cart_items').doc(productId).set(cartItem.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
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
}
