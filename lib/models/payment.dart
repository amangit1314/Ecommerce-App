import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Payment {
  final String paymentId;
  final String uid;
  final String oid;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String paymentStatus;
  final bool isSuccess;
  final String signature;

  const Payment(
    this.oid,
    this.signature, {
    required this.paymentId,
    required this.uid,
    required this.amount,
    required this.date,
    required this.paymentMethod,
    required this.paymentStatus,
    this.isSuccess = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'isSuccess': isSuccess,
      'paymentId': paymentId,
      'uid': uid,
      'amount': amount,
      'date': date,
      'signature': signature,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map, User user) {
    return Payment(
      map['oid'] as String,
      map['signature'] as String,
      paymentMethod: map['paymentMethod'] as String,
      paymentStatus: map['paymentStatus'] as String,
      isSuccess: map['isSuccess'] as bool,
      paymentId: map['paymentId'] as String,
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
