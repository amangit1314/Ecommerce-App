import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:soni_store_app/models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  final bool _isLoading = false;

  late Product _product;
  Product get product => _product;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  int getProductQuantity(String productName) {
    // Find the index of the product in the cartItems list
    int index = products.indexWhere((item) => item.title == productName);

    if (index != -1) {
      // If the product is found, return its quantity
      return products[index].quantity;
    } else {
      // If the product is not found, return 0
      return 0;
    }
  }

  int updateAddProductQuantity(int index) {
    if (index >= 0 && index < products.length) {
      products[index].quantity = products[index].quantity + 1;

      notifyListeners();
    }
    return products[index].quantity;
  }

  int updateSubtractProductQuantity(int index) {
    if (index >= 0 && index < products.length) {
      if (products[index].quantity >= 1) {
        products[index].quantity = products[index].quantity - 1;
      }
      products[index].quantity = products[index].quantity;
      notifyListeners();
    }
    return products[index].quantity;
  }
}
