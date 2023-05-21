import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List get cartItems => _cartItems;

  String _name = '';
  final String _price = '';
  final String _description = '';
  final String _category = '';
  final String _image = '';
  bool _isInCart = false;

  String get name => _name;
  String get price => _price;
  String get description => _description;
  String get category => _category;
  String get image => _image;
  int get length => cartItems.length;
  bool get isInCart => _isInCart;

  changeName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void addToCart(Product product) {
    int index = cartItems.indexWhere(
      (item) => item.product.title == product.title,
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
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }

  int getProductQuantity(String productName) {
    int index =
        cartItems.indexWhere((item) => item.product.name == productName);

    if (index != -1) {
      return cartItems[index].quantity;
    } else {
      return 0;
    }
  }

  int updateAddProductQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity = cartItems[index].quantity + 1;

      notifyListeners();
    }
    return cartItems[index].quantity;
  }

  int updateSubtractProductQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity >= 1) {
        cartItems[index].quantity = cartItems[index].quantity - 1;
      }
      cartItems[index].quantity = cartItems[index].quantity;
      notifyListeners();
    }
    return cartItems[index].quantity;
  }

  changeIsInCart(bool newIsInCart) {
    _isInCart = newIsInCart;
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var element in _cartItems) {
      total += element.price;
    }
    return total;
  }

  addItemCart(Product cart) {
    _cartItems.add(cart);
    notifyListeners();
  }

  void updateItemQuantity(Product product, {int quantity = 1}) {
    final int index = _cartItems.indexOf(product);
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
  }
}
