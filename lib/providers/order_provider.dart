import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;

class OrderProvider with ChangeNotifier {
  List<models.Order> _orders = [];
  List<models.Order> get orders => _orders;

  Future<void> fetchOrders(String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('uid')
          .get();

      _orders = querySnapshot.docs
          .map((doc) => models.Order.fromMap(doc.data()))
          .toList();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch orders: $error');
    }
  }

  Future<void> addOrder({
    required models.Order order,
    required String uid,
    required String oid,
  }) async {
    try {
      final orderData = order.toMap();
      if (orderData.isEmpty) {
        throw Exception('Order data is null');
      }

      final ordersCollection = FirebaseFirestore.instance.collection('orders');
      final orderDoc = ordersCollection.doc(oid);

      final orderSnapshot = await orderDoc.get();
      if (!orderSnapshot.exists) {
        final userOrderDoc = ordersCollection.doc(uid);
        await userOrderDoc.set(orderData);
        log('New order document created for user');
      } else {
        await orderDoc.set(orderData);
        log('Existing order document updated');
      }

      log('Order added successfully ✨🎉🥳');
      notifyListeners();
    } catch (error) {
      log('Failed to add order: $error');
      throw Exception('Failed to add order: $error');
    }
  }
}
