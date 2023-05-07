import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soni_store_app/models/user.dart';

class Payment {
  final String id;
  final User user;
  final double amount;
  final DateTime date;

  const Payment({
    required this.id,
    required this.user,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': user.uid,
      'amount': amount,
      'date': date,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map, User user) {
    return Payment(
      id: map['id'] as String,
      user: user,
      amount: map['amount'] as double,
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  String toJson() => throw UnimplementedError();

  factory Payment.fromJson(String source) => throw UnimplementedError();
}
