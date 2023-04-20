import 'dart:convert';

import 'package:soni_store_app/models/product_name.dart';

class Cart {
  final Product product;
  final int numOfItem;

  const Cart({required this.product, required this.numOfItem});

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'numOfItem': numOfItem,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      product: Product.fromMap(map['product']),
      numOfItem: map['numOfItem']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}

// Demo data for our cart


