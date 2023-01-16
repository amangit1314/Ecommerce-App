import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
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
}
