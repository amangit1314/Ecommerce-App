import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;

class OrderProvider with ChangeNotifier {
  final List<models.Order> _orders = [];
  List<models.Order> get orders => _orders;

  Future<List<models.Order>> fetchOrders(
      String userId, String orderStaus) async {
    try {
      final querySnapshotCollection = FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .where('orderStatus', isEqualTo: orderStaus);

      final ordersSnapshot = await querySnapshotCollection.get();

      _orders.clear();

      for (final doc in ordersSnapshot.docs) {
        final orderItemData = doc.data();
        _orders.add(models.Order.fromMap(orderItemData));
      }

      notifyListeners();
      return _orders;
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
}
