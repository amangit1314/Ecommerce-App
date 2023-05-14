import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/product.dart';

class CartProvider with ChangeNotifier {
  // list of getter cartItems responsible for all cart items
  final List<Product> _cartItems = [];
  // getter cartItemsCount responsible for count of cart items
  List get cartItems => _cartItems;

  String _name = '';
  String _price = '';
  String _description = '';
  String _category = '';
  String _image = '';
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

  // if in cart notify if not then add
  changeIsInCart(bool newIsInCart) {
    _isInCart = newIsInCart;
    notifyListeners();
  }

  changePrice(String newPrice) {
    _price = newPrice;
    notifyListeners();
  }

  changeDescription(String newDescription) {
    _description = newDescription;
    notifyListeners();
  }

  changeCategory(String newCategory) {
    _category = newCategory;
    notifyListeners();
  }

  changeImage(String newImage) {
    _image = newImage;
    notifyListeners();
  }

  // calculate total price and notify
  double get totalPrice {
    double total = 0;
    for (var element in _cartItems) {
      total += element.price;
    }
    return total;
  }

  // add cart to cartItems
  addItemCart(Product cart) {
    _cartItems.add(cart);
    notifyListeners();
  }
}
