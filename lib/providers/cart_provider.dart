import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;

class CartProvider with ChangeNotifier {
  List<models.Product> _cartItems = [];
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
          .collection("cartItems");

      // Check if the product already exists in the cart
      final existingProduct = _cartItems.firstWhere(
        (item) => item.id == product.id,
        orElse: () => product,
      );

      if (existingProduct != null) {
        // Increment the quantity of the existing product
        existingProduct.quantity += 1;
        log('Product quantity incremented: $existingProduct');

        // Update the quantity in Firestore
        final existingProductDoc = cartItemsCollection.doc(product.id);
        await existingProductDoc.set(
          {'quantity': existingProduct.quantity},
          SetOptions(merge: true),
        );
      } else {
        // Add the product to the cart
        _cartItems.add(product);
        log('Product added to cart: $product');

        // Generate a new unique document ID for the product
        final newProductDoc = cartItemsCollection.doc(product.id);

        await newProductDoc.set({
          ...productsData,
          'userId': uid,
          'quantity': 1, // Set initial quantity to 1
        });
      }

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
          .collection("cartItems");

      await cartItemsCollection.doc(product.id).delete();

      _cartItems.remove(product);

      notifyListeners();
    } catch (error) {
      log('Failed to delete item from cart: $error');
    }
  }

  Future<List<models.Product>> getCartItems(String uid) async {
    try {
      var cartItemsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("cartItems")
          .get();

      _cartItems = cartItemsSnapshot.docs.map((doc) {
        var productData = doc.data();
        return models.Product(
          id: doc.id,
          title: productData['title'],
          price: productData['price'].toDouble(),
          images: [productData['image']],
          quantity: productData['quantity'],
        );
      }).toList();

      return _cartItems;
    } catch (error) {
      log('Failed to fetch cart items: $error');
      return [];
    }
  }

  double get totalPrice {
    double total = 0;
    for (var element in _cartItems) {
      total += element.price * element.quantity;
    }
    return total;
  }
}
