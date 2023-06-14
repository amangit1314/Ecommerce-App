import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;

class OrderProvider with ChangeNotifier {
  List<models.Order> _orders = [];
  List<models.Order> get orders => _orders;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool _hasError = false;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchOrders(String uid) async {
    try {
      _isLoading = true;
      _hasError = false;
      notifyListeners();

      final ordersCollection = _firestore.collection('orders');
      final userOrderDoc = ordersCollection.doc(uid);

      final userOrderSnapshot = await userOrderDoc.get();
      if (!userOrderSnapshot.exists) {
        _orders = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      final userOrderData = userOrderSnapshot.data();
      if (userOrderData == null) {
        _orders = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      final userOrder = models.Order.fromMap(userOrderData);
      _orders.add(userOrder);

      final orderDocs = await ordersCollection.get();
      for (final orderDoc in orderDocs.docs) {
        final orderData = orderDoc.data();
        if (orderData == {}) {
          continue;
        }

        final order = models.Order.fromMap(orderData);
        _orders.add(order);
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
      throw Exception('Failed to fetch orders: $error');
    }
  }

  Future addOrder({
    // required models.Order order,
    required Map<String, dynamic> orderData,
    required String uid,
  }) async {
    try {
      // final orderData = order.toMap();
      if (orderData.isEmpty) {
        throw Exception('Order data is null');
      }

      final ordersCollection = FirebaseFirestore.instance.collection('orders');
      final orderDoc = ordersCollection.doc();

      final orderSnapshot = await orderDoc.get();
      if (!orderSnapshot.exists) {
        final userOrderDoc = ordersCollection.doc();
        await userOrderDoc.set(orderData);
        log('Order added successfully ✨🎉🥳');
        notifyListeners();
        return orderDoc.id;
      } else {
        await orderDoc.set(orderData);
        log('Existing order document updated');
        notifyListeners();
        return orderDoc.id;
      }
    } catch (error) {
      log('Failed to add order: $error');
      throw Exception('Failed to add order: $error');
    }
  }

  // change orderCategory to Delivered
  Future<void> changeOrderStatus({
    required String uid,
    required String oid,
    required String orderStatus,
  }) async {
    try {
      final ordersCollection = FirebaseFirestore.instance.collection('orders');
      final orderDoc = ordersCollection.doc(oid);

      final orderSnapshot = await orderDoc.get();
      if (!orderSnapshot.exists) {
        throw Exception('Order document does not exist');
      }

      await orderDoc.update({'orderStatus': orderStatus});
      log('Order status updated successfully ✨🎉🥳');
      notifyListeners();
    } catch (error) {
      log('Failed to update order status: $error');
      throw Exception('Failed to update order status: $error');
    }
  }

  Future<String?> getProductName(String productId) async {
    try {
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      final productData = productDoc.data();

      if (productData != null) {
        return productData['title'] as String?;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return null;
  }
}
