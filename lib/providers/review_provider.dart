import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/models.dart' as models;

class ReviewProvider with ChangeNotifier {
  Future<List<models.Review>> getReviewsForProduct(String productId) async {
    try {
      final reviewsSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('reviews')
          .get();

      final reviews = reviewsSnapshot.docs.map((doc) {
        final reviewData = doc.data();
        return models.Review.fromMap(reviewData);
      }).toList();

      return reviews;
    } catch (error) {
      log('Failed to fetch reviews for product: $error');
      return [];
    }
  }

  Future<void> addReviewToProduct(
      models.Review review, String productId) async {
    try {
      final reviewData = review.toMap();

      if (reviewData.isEmpty) {
        throw Exception('Review data is null');
      }

      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('reviews')
          .add(reviewData);

      notifyListeners();
    } catch (error) {
      log('Failed to add review to product: $error');
    }
  }
}
