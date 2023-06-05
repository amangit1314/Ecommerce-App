import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/models.dart' as models;

class CartProvider with ChangeNotifier {
  final List<models.Product> _cartItems = [];
  List<models.Product> get cartItems => _cartItems;

  Future<void> addToCart(models.Product product, String uid) async {
    try {
      final productsData = product.toMap();
      if (productsData.isEmpty) {
        throw Exception('Product data is null');
      }

      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');

      // Check if the product already exists in the cart
      final existingProductIndex =
          _cartItems.indexWhere((item) => item.id == product.id);

      if (existingProductIndex != -1) {
        // If the product already exists, delete the existing document
        final existingProduct = _cartItems[existingProductIndex];
        await cartItemsCollection.doc(existingProduct.id).delete();
        _cartItems.removeAt(existingProductIndex);
      }

      // Generate a new unique document ID for the cartItem
      final newProductDoc = cartItemsCollection.doc();

      await newProductDoc.set({
        'id': product.id,
        ...productsData,
      });

      _cartItems.add(product);

      notifyListeners();
    } catch (error) {
      log('Failed to add item to cart: $error');
    }
  }

  Future<void> removeFromCart(models.Product product, String uid) async {
    try {
      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');

      await cartItemsCollection.doc(product.id).delete();

      _cartItems.remove(product);

      notifyListeners();
    } catch (error) {
      log('Failed to delete item from cart: $error');
    }
  }

  Future<List<models.Product>> getCartItems(String uid) async {
    try {
      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');

      final cartItemsSnapshot = await cartItemsCollection.get();

      _cartItems.clear();

      for (final doc in cartItemsSnapshot.docs) {
        final cartItemData = doc.data();
        _cartItems.add(models.Product.fromMap(cartItemData));
      }

      return _cartItems;
    } catch (error) {
      log('Failed to fetch cart items: $error');
      return [];
    }
  }

  int get totalCartItemQuantity {
    int quantity = 0;
    for (var item in _cartItems) {
      quantity += item.quantity;
    }
    return quantity;
  }

  double get totalPrice {
    double total = 0;
    for (var element in _cartItems) {
      total += element.price * element.quantity;
    }
    return total;
  }
}
