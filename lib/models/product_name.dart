import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
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

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'images': images,
  //       'colors': colors,
  //       'title': title,
  //       'price': price,
  //       'description': description,
  //       'rating': rating,
  //       'isFavourite': isFavourite,
  //       'isPopular': isPopular,
  //     };

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
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
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

// Our demo Products