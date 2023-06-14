import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/constants.dart';

import '../models/models.dart' as models;

class ProductProvider with ChangeNotifier {
  final List<models.Product> _products = [];
  List<models.Product> get products => _products;

  models.Product? _product;
  models.Product? get product => _product;

  String _id = '';
  String get id => _id;

  int _quantity = 1;
  int get quantity => _quantity;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  String _selectedSize = 'XL';
  String get selectedSize => _selectedSize;

  Color _selectedColor = kPrimaryColor;
  Color get selectedColor => _selectedColor;

  int get totalAmount => _product?.price ?? 0 * _quantity;

  void setProduct(models.Product product) {
    _product = product;
    _id = product.id;
    _quantity = 1;
    _totalPrice = _product?.price ?? 0;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    updateTotalPrice();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      updateTotalPrice();
    }
  }

  void updateTotalPrice() {
    if (_quantity > 0 && _product != null) {
      _totalPrice = _product!.price * _quantity;
    }
    notifyListeners();
  }

  updateSelectedSize(String uid, String selectedSize) async {
    _selectedSize = selectedSize;

    try {
      final ordersCollection = FirebaseFirestore.instance.collection('orders');
      final querySnapshot =
          await ordersCollection.where('uid', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        final orderDoc = querySnapshot.docs.first;
        final orderRef = ordersCollection.doc(orderDoc.id);

        if (orderDoc.data().containsKey('size')) {
          // If the 'size' field already exists, update the size using SetOption({merge: true})
          await orderRef.set({'size': selectedSize}, SetOptions(merge: true));
        } else {
          // If the 'size' field doesn't exist, create a new 'size' field in the order
          await orderRef.update({'size': selectedSize});
        }
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return _selectedSize;
  }

  updateSelectedColor(String uid, Color selectedColor) async {
    _selectedColor = selectedColor;

    try {
      final ordersCollection = FirebaseFirestore.instance.collection('orders');
      final querySnapshot =
          await ordersCollection.where('uid', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        final orderDoc = querySnapshot.docs.first;
        final orderRef = ordersCollection.doc(orderDoc.id);

        if (orderDoc.data().containsKey('color')) {
          // If the 'color' field already exists, update the color using SetOption({merge: true})
          await orderRef.set(
              {'color': selectedColor.toString()}, SetOptions(merge: true));
        } else {
          // If the 'color' field doesn't exist, create a new 'color' field in the order
          await orderRef.update({'color': selectedColor.toString()});
        }
      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
    return _selectedColor;
  }
}
