import 'dart:convert';

import 'package:soni_store_app/models/product.dart';

class Category {
  final int name;
  final List<Product> products;

  Category({required this.name, required this.products});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'products': products.map((x) => x.toJson()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name']?.toInt() ?? 0,
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromSnapshot(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
