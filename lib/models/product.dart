import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soni_store_app/models/review.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final int price;
  final double rating;
  bool isFavourite, isPopular;
  final List<String> categories;
  final List<Review> reviews;

  Product({
    required this.categories,
    required this.id,
    required this.images,
    this.colors = const [Colors.white],
    this.reviews = const [],
    this.rating = 0,
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
      // colors: productData['colors'],
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
      // 'colors': colors.map((x) => x.value).toList(),
      'price': price,
      'isPopular': isPopular,
      'categories': categories,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      categories: List<String>.from(map['categories'] ?? []),
      id: map['id'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      images: List<String>.from(map['images'] ?? []),
      price: map['price'] ?? 0,
      rating: map['rating'] ?? 0,
      isFavourite: map['isFavourite'] as bool? ?? false,
      isPopular: map['isPopular'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
