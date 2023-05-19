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

  void addToCart(Product product) {
    // Find the index of the product in the cartItems list
    int index = cartItems.indexWhere(
      (item) => item.product.title == product.title,
    );

    if (index != -1) {
      // If the product is already in the cart, increment its quantity
      cartItems[index].quantity++;
    } else {
      // Otherwise, add a new cart item to the list
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
    // Find the index of the product in the cartItems list
    int index =
        cartItems.indexWhere((item) => item.product.name == productName);

    if (index != -1) {
      // If the product is found, return its quantity
      return cartItems[index].quantity;
    } else {
      // If the product is not found, return 0
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

  void updateItemQuantity(Product product, {int quantity = 1}) {
    final int index = _cartItems.indexOf(product);
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
  }
}
