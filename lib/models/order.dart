import 'dart:convert';

import 'package:soni_store_app/utils/constants.dart';

class Order {
  final String orderId;
  final String? uid;
  final String productId;
  final String productImage;
  final String orderedDate;
  final int quantity;
  final double amount;
  final String number;
  final String color;
  final String address;
  final String orderStatus;
  final String size;
  // final Payment? paymentInfo;

  Order(
    this.number, {
    required this.orderId,
    this.uid,
    required this.productId,
    required this.productImage,
    required this.orderedDate,
    required this.quantity,
    required this.amount,
    required this.address,
    required this.orderStatus,
    required this.color,
    required this.size,
    // this.paymentInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'orderId': orderId,
      'uid': uid,
      'productId': productId,
      'productImage': productImage,
      'orderedDate': orderedDate,
      'quantity': quantity,
      'amount': amount,
      'address': address,
      'orderStatus': orderStatus,
      // 'paymentInfo': paymentInfo!.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      map['number'] ?? '+91 1234567890',
      size: map['size'] ?? 'XL',
      color: map['color'] ??
          kPrimaryColor.value.toRadixString(16).padLeft(8, '0').toString(),
      address: map['address'] ?? '',
      orderId: map['orderId'] ?? '',
      uid: map['uid'] ?? '',
      productId: map['productId'] ?? '',
      productImage: map['productImage'] ?? '',
      orderedDate: map['orderedDate'] ?? DateTime.now().toString(),
      quantity: map['quantity']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      orderStatus: map['orderStatus'] ?? '',
      // paymentInfo: Payment.fromMap(
      //   map['paymentInfo'],
      //   FirebaseAuth.instance.currentUser!,
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
