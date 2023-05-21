import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Payment {
  final String id;
  final String uid;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String paymentStatus;
  final bool isSuccess;

  const Payment({
    required this.id,
    required this.uid,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    this.paymentStatus = 'Processing',
    this.isSuccess = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'isSuccess': isSuccess,
      'id': id,
      'uid': uid,
      'amount': amount,
      'date': date,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map, User user) {
    return Payment(
      paymentMethod: map['paymentMethod'] as String,
      paymentStatus: map['paymentStatus'] as String,
      isSuccess: map['isSuccess'] as bool,
      id: map['id'] as String,
      uid: map['uid'] as String,
      amount: map['amount'] as double,
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  factory Payment.fromJson(String source) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Payment.fromMap(
        Map<String, dynamic>.from(json.decode(source)), currentUser);
  }

  String toJson() => json.encode(toMap());

  Future<void> addPaymentToFirestore() async {
    try {
      CollectionReference paymentsCollection =
          FirebaseFirestore.instance.collection('payments');

      await paymentsCollection.add(toMap());
    } catch (error) {
      throw Exception('Failed to add payment to Firestore: $error');
    }
  }
}
