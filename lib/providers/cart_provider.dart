import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  // list of getter cartItems responsible for all cart items
  List<Cart> cartItems = [];

  String _name = '';
  String _price = '';
  String _description = '';
  String _category = '';
  String _image = '';

  String get name => _name;
  String get price => _price;
  String get description => _description;
  String get category => _category;
  String get image => _image;
  int get length => cartItems.length;

  changeName(String newName) {
    _name = newName;
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

  // add cart to cartItems
  void addCart(Cart cart) {
    cartItems.add(cart);
    notifyListeners();
  }
}
