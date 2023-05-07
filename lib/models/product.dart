import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soni_store_app/models/category.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;
  final List<Category> categories;

  Product({
    required this.categories,
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  static Product fromSnapshot(productData) {
    return Product(
      id: productData.id,
      images: productData['images'],
      colors: productData['colors'],
      title: productData['title'],
      price: productData['price'],
      description: productData['description'],
      rating: productData['rating'],
      isFavourite: productData['isFavourite'],
      isPopular: productData['isPopular'],
      categories: productData['categories'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'images': images,
      'colors': colors.map((x) => x.value).toList(),
      'price': price,
      'isPopular': isPopular,
      'categories': categories,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      categories: map['categories']?.map((x) => Category.fromMap(x)).toList(),
      id: map['id']?.toInt() ?? 0,
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      images: List<String>.from(map['images']),
      colors: List<Color>.from(map['colors']?.map((x) => Color(x))),
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
