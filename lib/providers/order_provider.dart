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
          .get();

      _orders = querySnapshot.docs
          .map((doc) => models.Order.fromMap(doc.data()))
          .toList();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch orders: $error');
    }
  }

  Future<void> addOrder(models.Order order, models.User user) async {
    try {
      final orderData = order.toMap();

      final documentRef =
          await FirebaseFirestore.instance.collection('orders').add(orderData);

      final documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        final addedOrder = models.Order.fromMap(documentSnapshot.data()!);
        _orders.add(addedOrder);
        notifyListeners();

        // Update user's orders field
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userData = {
          'orders': FieldValue.arrayUnion([addedOrder.toMap()])
        };
        await userRef.update(userData);
      } else {
        throw Exception('Failed to add order: Document does not exist');
      }
    } catch (error) {
      throw Exception('Failed to add order: $error');
    }
  }
}
