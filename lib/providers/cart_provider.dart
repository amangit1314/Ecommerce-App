import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];
  List<Product> get cartItems => _cartItems;

  String _name = '';
  final String _price = '';
  final String _description = '';
  final String _category = '';
  final String _image = '';
  final bool _isInCart = false;

  String get name => _name;
  String get price => _price;
  String get image => _image;
  bool get isInCart => _isInCart;
  String get category => _category;
  int get length => cartItems.length;
  String get description => _description;

  changeName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void addToCart(Product product) {
    int index = cartItems.indexWhere(
      (item) => item.title == product.title,
    );

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(
        Product(
          categories: [],
          description: product.description,
          id: product.id,
          images: product.images,
          title: product.title,
          quantity: product.quantity,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }

  int updateItemQuantity(Product product, {int quantity = 1}) {
    final int index = _cartItems.indexOf(product);
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
    return _cartItems[index].quantity;
  }

  double get totalPrice {
    double total = 0;
    for (var element in _cartItems) {
      total += element.price;
    }
    return total;
  }
}
