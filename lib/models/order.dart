import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:soni_store_app/models/payment.dart';

class Order {
  final String orderId;
  final String uid;
  final String productId;
  final String productImage;
  final DateTime orderedDate;
  final int quantity;
  final double amount;
  // final String address;
  final String orderStatus;
  final Payment? paymentInfo;

  Order({
    required this.orderId,
    required this.uid,
    required this.productId,
    required this.productImage,
    required this.orderedDate,
    required this.quantity,
    required this.amount,
    // required this.address,
    required this.orderStatus,
    this.paymentInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'uid': uid,
      'productId': productId,
      'productImage': productImage,
      'orderedDate': orderedDate.millisecondsSinceEpoch,
      'quantity': quantity,
      'amount': amount,
      // 'address': address,
      'orderStatus': orderStatus,
      'paymentInfo': paymentInfo!.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] ?? '',
      uid: map['uid'] ?? '',
      productId: map['productId'] ?? '',
      productImage: map['productImage'] ?? '',
      orderedDate: DateTime.fromMillisecondsSinceEpoch(map['orderedDate']),
      quantity: map['quantity']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      // address: map['address'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      paymentInfo: Payment.fromMap(
        map['paymentInfo'],
        FirebaseAuth.instance.currentUser!,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
