import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/models.dart' as models;

import 'auth_provider.dart';

class CartProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Map<String, models.Product> _items = {};

  List<models.Product> _cartItems = [];
  List<models.Product> get cartItems => _cartItems;
  int get length => cartItems.length;

  models.User _user = models.User(uid: '', email: '');
  models.User get user => _user;

  final String _userId = AuthProvider().user.email;
  String get userId => _userId;

  String _name = '';
  String get name => _name;

  final String _image = '';
  String get image => _image;

  final String _price = '';
  String get price => _price;

  final bool _isInCart = false;
  bool get isInCart => _isInCart;

  int _cartItemQuantity = 0;
  int get cartItemQuantity => _cartItemQuantity;

  changeName(String newName) {
    _name = newName;
    notifyListeners();
  }

  Future<void> getUserDetails() async {
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(userId).get();
    _user = models.User.fromMap(snap);
  }

  Future<void> addToCart(models.Product product) async {
    try {
      var cartItemsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection("cartItems")
          .get();

      for (var doc in cartItemsSnapshot.docs) {
        var cartItem = models.Product.fromJson(doc.id);
        _items[doc.id] = cartItem;
      }

      int index = cartItems.indexWhere((item) => item.id == product.id);

      if (index != -1) {
        cartItems[index].quantity += 1;
      } else {
        cartItems.add(
          models.Product(
            id: product.id,
            title: product.title,
            quantity: 1,
            price: product.price,
            images: product.images,
          ),
        );
      }

      _cartItemQuantity = _calculateCartItemQuantity();

      await _updateCartItems(
        cartItems,
        FirebaseFirestore.instance.collection('users').doc(_user.uid),
      );

      notifyListeners();
    } catch (error) {
      log('-----------------------------------------');
      log('Failed to add item to cart: $error');
      log('-----------------------------------------');
      log('id: ${product.id}');
      log('title: ${product.title}');
      log('-----------------------------------------');
      log('userId: ${_user.uid}');
      log('-----------------------------------------');
      log('quantity: ${product.quantity}');
      log('price: ${product.price}');
      log('images: ${product.images}');
      log('-----------------------------------------');
    }
  }

  Future<void> removeFromCart(models.Product product) async {
    try {
      var cartItemsSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("cartItems")
          .get();

      for (var doc in cartItemsSnapshot.docs) {
        var cartItem = models.Product.fromJson(doc.id);
        _items[doc.id] = cartItem;
      }

      int index = cartItems.indexWhere((item) => item.id == product.id);

      if (index != -1) {
        if (cartItems[index].quantity > 1) {
          cartItems[index].quantity -= 1;
        } else {
          cartItems.removeAt(index);
        }

        await _updateCartItems(
          cartItems,
          FirebaseFirestore.instance.collection("users").doc(_user.uid),
        );
      }
    } catch (error) {
      log('Failed to delete item from cart: $error');
    }
  }

  Future<void> getCartItems(String userId) async {
    try {
      var cartItemsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
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

      _cartItemQuantity = _calculateCartItemQuantity();

      notifyListeners();
    } catch (error) {
      log('Failed to fetch cart items: $error');
      _cartItems = [];
      _cartItemQuantity = 0;
    }
  }

  Future<void> _updateCartItems(
    List<models.Product> cartItems,
    DocumentReference userDocRef,
  ) async {
    try {
      var cartItemsData = cartItems.map((item) => item.toMap()).toList();

      await userDocRef.update({'cartItems': cartItemsData});

      _cartItems = cartItems;
      _cartItemQuantity = _calculateCartItemQuantity();

      notifyListeners();
    } catch (error) {
      log('Failed to update cart items: $error');
    }
  }

  int _calculateCartItemQuantity() {
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
