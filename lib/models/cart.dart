import 'dart:convert';

import 'package:soni_store_app/models/product.dart';
import 'package:soni_store_app/models/user.dart';

class Cart {
  final int id;
  final User user;
  final Product products;
  final int numOfItems;

  Cart({
    required this.id,
    required this.user,
    required this.products,
    required this.numOfItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'products': products.toMap(),
      // List<dynamic>.from(products.map((product) => product.toMap())),
      'numOfItems': numOfItems,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      user: User.fromMap(map['user']),
      products: Product.fromMap(
          map['products'].map((product) => Product.fromMap(product))),
      numOfItems: map['numOfItems']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
