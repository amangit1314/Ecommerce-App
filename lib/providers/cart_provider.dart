import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/models.dart' as models;

class CartProvider with ChangeNotifier {
  final List<models.Product> _cartItems = [];
  List<models.Product> get cartItems => _cartItems;

  models.Product? _cartItem;
  models.Product? get product => _cartItem;

  int _quantity = 1;
  int get quantity => _quantity;

  final double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  void increaseQuantity(models.Product product, String uid) async {
    _quantity++;

    final cartItemsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cartItems');

    final cartItemSnapshot = await cartItemsCollection
        .where('id', isEqualTo: product.id)
        .limit(1)
        .get();

    if (cartItemSnapshot.docs.isNotEmpty) {
      final cartItemId = cartItemSnapshot.docs.first.id;

      // Update the quantity of the cart item
      await cartItemsCollection.doc(cartItemId).update({'quantity': _quantity});
    } // Update the total price after increasing the quantity
  }

  void decreaseQuantity(models.Product product, String uid) async {
    if (_quantity > 1) {
      _quantity--;

      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');

      final cartItemSnapshot = await cartItemsCollection
          .where('id', isEqualTo: product.id)
          .limit(1)
          .get();

      if (cartItemSnapshot.docs.isNotEmpty) {
        final cartItemId = cartItemSnapshot.docs.first.id;

        // Update the quantity of the cart item
        await cartItemsCollection
            .doc(cartItemId)
            .update({'quantity': _quantity});
      }
// Update the total price after decreasing the quantity
    }
  }

  Future<int> cartItemQuantity(models.Product product, String uid) async {
    final cartItemsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cartItems');

    final cartItemSnapshot = await cartItemsCollection
        .where('id', isEqualTo: product.id)
        .limit(1)
        .get();

    if (cartItemSnapshot.docs.isNotEmpty) {
      final cartItemId = cartItemSnapshot.docs.first.id;

      // Update the quantity of the cart item
      await cartItemsCollection.doc(cartItemId).get();

      await cartItemsCollection.doc(cartItemId).get().then((doc) => {
            if (doc.exists)
              {
                _quantity = doc.data()!['quantity'],
                log("Quantity: $quantity"),
                // You can use the quantity variable here or perform any other operations
              }
            else
              {log("Document does not exist")}
          });
      return _quantity;
    }
    return _quantity;
  }

  void clearCartItems(String uid) {
    try {
      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');

      // Delete all cart items from the cartItems collection
      cartItemsCollection.get().then((snapshot) {
        for (final doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      _cartItems.clear();
      notifyListeners();
    } catch (error) {
      log('Failed to clear cart items: $error');
    }
  }

  Future<void> addToCart(
      models.Product product, String uid, int quantity) async {
    try {
      final productsData = product.toMap();

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
        'quantity': _quantity,
      });

      _cartItems.add(product);
    } catch (error) {
      log('Failed to add item to cart: $error');
    }
    notifyListeners();
  }

  Future<void> addToCartFromDetails(dynamic productsData, String uid) async {
    try {
      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');
      final cartItemDoc = cartItemsCollection.doc();
      final cartSnapshot = await cartItemDoc.get();

      final existingProductIndex =
          _cartItems.indexWhere((item) => item.id == cartSnapshot.id);

      if (existingProductIndex != -1) {
        final existingProduct = _cartItems[existingProductIndex];
        await cartItemsCollection.doc(existingProduct.id).delete();
        _cartItems.removeAt(existingProductIndex);
      }

      final newProductDoc = cartItemsCollection.doc();

      await newProductDoc.set({
        'id': productsData['id'],
        ...productsData,
        'quantity': _quantity,
      });
      _cartItems.add(models.Product.fromMap(productsData));
    } catch (error) {
      log('Failed to add item to cart: $error');
    }
    notifyListeners();
  }

  Future<void> removeFromCart(models.Product product, String uid) async {
    try {
      final cartItemsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cartItems');

      // Find the document ID of the product in Firestore
      final cartItemSnapshot = await cartItemsCollection
          .where('id', isEqualTo: product.id)
          .limit(1)
          .get();

      if (cartItemSnapshot.docs.isNotEmpty) {
        final cartItemId = cartItemSnapshot.docs.first.id;

        // Delete the product document from the cartItems collection
        await cartItemsCollection.doc(cartItemId).delete();
      }

      // Remove the product from the _cartItems list
      _cartItems.removeWhere((item) => item.id == product.id);
    } catch (error) {
      log('Failed to delete item from cart: $error');
    }
    notifyListeners();
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

  bool isItemInCart(models.Product product) {
    return _cartItems.any((item) => item.id == product.id);
  }

  Future<double> totalPriceFunc(String uid) async {
    double total = 0;
    late int quantity;
    for (var element in _cartItems) {
      quantity = await cartItemQuantity(element, uid);
      total += (element.price * quantity);
    }
    return total;
  }
}
