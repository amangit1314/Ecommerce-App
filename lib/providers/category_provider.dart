import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  String _name = '';
  String _image = '';

  String get name => _name;
  String get image => _image;

  changeName(String newName) {
    _name = newName;
    notifyListeners();
  }

  changeImage(String newImage) {
    _image = newImage;
    notifyListeners();
  }
}
