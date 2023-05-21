import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/payment.dart';

class PaymentProvider with ChangeNotifier {
  String _paymentMethod = "Cash on Delivery";

  String get getPaymentMethod => _paymentMethod;

  void setPaymentMethod(String paymentMethod) {
    _paymentMethod = paymentMethod;
    notifyListeners();
  }

  Future<void> addPaymentToFirestore(Payment payment) async {
    try {
      CollectionReference paymentsCollection =
          FirebaseFirestore.instance.collection('payments');

      await paymentsCollection.add(payment.toMap());
    } catch (error) {
      throw Exception('Failed to add payment to Firestore: $error');
    }
  }
}
