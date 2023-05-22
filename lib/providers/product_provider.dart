import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:soni_store_app/models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  List<Product> get products => _products;

  final String _title = '';
  final int _price = 0;
  final String _description = '';
  final List<String> _categories = const [];
  final List<String> _images = const [];
  final bool _isFavourite = false;
  final bool _isPopular = false;
  final int _quantity = 1;
  int _totalPrice = 0;

  String get title => _title;
  int get price => _price;
  String get description => _description;
  List<String> get categories => _categories;
  List<String> get images => _images;
  bool get isFavourite => _isFavourite;
  bool get isPopular => _isPopular;
  int get quantity => _quantity;
  int get totalPrice => _totalPrice;

  Future<List<Product>> fetchProductsFromFirestore(
      CollectionReference productsRef) async {
    final QuerySnapshot snapshot = await productsRef.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  int inceaseQuantity(int quantity) {
    if (quantity == 1) {
      quantity = quantity + 1;
      notifyListeners();
    }

    return quantity;
  }

  int decreaseQuantity(int quantity) {
    if (quantity > 1) {
      quantity = quantity - 1;
      notifyListeners();
    }

    return quantity;
  }

  int updateTotalPrice(int price, int quantity) {
    if (price > 0) {
      _totalPrice = price * quantity;
      notifyListeners();
    }

    return _totalPrice;
  }
}
