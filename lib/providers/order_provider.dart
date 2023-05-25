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

  Future<void> addOrder(models.Order order) async {
    final orderData = order.toMap();

    final CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');
    ordersCollection
        .add(orderData)
        .then((value) => debugPrint('Order added successfully ✨🎉🥳'))
        .catchError((e) =>
            throw Exception('Failed to add order: Document does not exist'));
    notifyListeners();
  }
}
