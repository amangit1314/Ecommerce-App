// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:soni_store_app/models/product.dart';

// class CartProvider with ChangeNotifier {
//   final String userId;
//   final CollectionReference _usersCollection;

//   CartProvider(this.userId)
//       : _usersCollection = FirebaseFirestore.instance.collection('users');

//   List<Product> _cartItems = [];
//   List<Product> get cartItems => _cartItems;

//   int get length => cartItems.length;

//   int _cartItemQuantity = 0;
//   int get cartItemQuantity => _cartItemQuantity;

//   String _name = '';
//   String get name => _name;

//   final String _price = '';
//   String get price => _price;

//   final String _category = '';
//   String get category => _category;

//   final String _image = '';
//   String get image => _image;

//   final bool _isInCart = false;
//   bool get isInCart => _isInCart;

//   final String _description = '';
//   String get description => _description;

//   final Map<String, Product> _items = {};

//   changeName(String newName) {
//     _name = newName;
//     notifyListeners();
//   }

//   Future<void> addToCart(Product product) async {
//     try {
//       var cartItemsMap =
//           await _usersCollection.doc(userId).collection("cartItems").get();

//       for (var doc in cartItemsMap.docs) {
//         var cartItem = Product.fromJson(doc.id);
//         _items[doc.id] = cartItem;
//       }

//       int index = cartItems.indexWhere((item) => item.id == product.id);

//       if (index != -1) {
//         cartItems[index].quantity += 1;
//       } else {
//         cartItems.add(
//           Product(
//             id: product.id,
//             title: product.title,
//             quantity: 1,
//             price: product.price,
//             images: product.images,
//           ),
//         );
//       }

//       _cartItemQuantity = _calculateCartItemQuantity();

//       await _updateCartItems(
//         cartItems,
//         _usersCollection.doc(userId),
//       );

//       notifyListeners();
//     } catch (error) {
//       log('Failed to add item to cart: $error');
//     }
//   }

//   Future<void> deleteFromCart(Product product) async {
//     try {
//       var cartItemsMap =
//           await _usersCollection.doc(userId).collection("cartItems").get();

//       for (var doc in cartItemsMap.docs) {
//         var cartItem = Product.fromJson(doc.id);
//         _items[doc.id] = cartItem;
//       }

//       int index = cartItems.indexWhere((item) => item.id == product.id);

//       if (index != -1) {
//         if (cartItems[index].quantity > 1) {
//           cartItems[index].quantity -= 1;
//         } else {
//           cartItems.removeAt(index);
//         }

//         await _updateCartItems(
//           cartItems,
//           _usersCollection.doc(userId),
//         );
//       }
//     } catch (error) {
//       log('Failed to delete item from cart: $error');
//     }
//   }

//   Future<void> getCartItems() async {
//     try {
//       var cartItemsSnapshot =
//           await _usersCollection.doc(userId).collection("cartItems").get();

//       _cartItems = cartItemsSnapshot.docs.map((doc) {
//         var productData = doc.data();
//         return Product(
//           id: doc.id,
//           title: productData['title'],
//           price: productData['price'],
//           images: [productData['image']],
//         );
//       }).toList();

//       _cartItemQuantity = _calculateCartItemQuantity();

//       notifyListeners();
//     } catch (error) {
//       log('Failed to fetch cart items: $error');
//       _cartItems = [];
//       _cartItemQuantity = 0;
//     }
//   }

//   Future<void> _updateCartItems(
//       List<dynamic> cartItems, DocumentReference userDocRef) async {
//     try {
//       _cartItems = cartItems
//           .map((item) => Product(
//                 id: item['id'],
//                 title: item['title'],
//                 price: item['price'],
//                 images: [item['image']],
//               ))
//           .toList();

//       _cartItemQuantity = _calculateCartItemQuantity();

//       notifyListeners();
//     } catch (error) {
//       log('Failed to update cart items: $error');
//     }
//   }

//   int _calculateCartItemQuantity() {
//     int quantity = 0;
//     for (var item in _cartItems) {
//       quantity += item.quantity;
//     }
//     return quantity;
//   }

//   double get totalPrice {
//     double total = 0;
//     for (var element in _cartItems) {
//       total += element.price;
//     }
//     return total;
//   }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/product.dart';

class CartProvider with ChangeNotifier {
  final String userId;
  final CollectionReference _usersCollection;

  CartProvider(this.userId)
      : _usersCollection = FirebaseFirestore.instance.collection('users');

  List<Product> _cartItems = [];
  List<Product> get cartItems => _cartItems;

  int get length => cartItems.length;

  int _cartItemQuantity = 0;
  int get cartItemQuantity => _cartItemQuantity;

  String _name = '';
  String get name => _name;

  final String _price = '';
  String get price => _price;

  final String _category = '';
  String get category => _category;

  final String _image = '';
  String get image => _image;

  final bool _isInCart = false;
  bool get isInCart => _isInCart;

  final String _description = '';
  String get description => _description;

  final Map<String, Product> _items = {};

  changeName(String newName) {
    _name = newName;
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    try {
      var cartItemsSnapshot =
          await _usersCollection.doc(userId).collection("cartItems").get();

      for (var doc in cartItemsSnapshot.docs) {
        var cartItem = Product.fromJson(doc.id);
        _items[doc.id] = cartItem;
      }

      int index = cartItems.indexWhere((item) => item.id == product.id);

      if (index != -1) {
        cartItems[index].quantity += 1;
      } else {
        cartItems.add(
          Product(
            id: product.id,
            title: product.title,
            quantity: 1,
            price: product.price,
            images: product.images,
          ),
        );
      }

      _cartItemQuantity = _calculateCartItemQuantity();

      await _updateCartItems(
        cartItems,
        _usersCollection.doc(userId),
      );

      notifyListeners();
    } catch (error) {
      log('Failed to add item to cart: $error');
    }
  }

  Future<void> removeFromCart(Product product) async {
    try {
      var cartItemsSnapshot =
          await _usersCollection.doc(userId).collection("cartItems").get();

      for (var doc in cartItemsSnapshot.docs) {
        var cartItem = Product.fromJson(doc.id);
        _items[doc.id] = cartItem;
      }

      int index = cartItems.indexWhere((item) => item.id == product.id);

      if (index != -1) {
        if (cartItems[index].quantity > 1) {
          cartItems[index].quantity -= 1;
        } else {
          cartItems.removeAt(index);
        }

        await _updateCartItems(
          cartItems,
          _usersCollection.doc(userId),
        );
      }
    } catch (error) {
      log('Failed to delete item from cart: $error');
    }
  }

  Future<void> getCartItems() async {
    try {
      var cartItemsSnapshot =
          await _usersCollection.doc(userId).collection("cartItems").get();

      _cartItems = cartItemsSnapshot.docs.map((doc) {
        var productData = doc.data();
        return Product(
          id: doc.id,
          title: productData['title'],
          price: productData['price'].toDouble(),
          images: [productData['image']],
        );
      }).toList();

      _cartItemQuantity = _calculateCartItemQuantity();

      notifyListeners();
    } catch (error) {
      log('Failed to fetch cart items: $error');
      _cartItems = [];
      _cartItemQuantity = 0;
    }
  }

  Future<void> _updateCartItems(
      List<Product> cartItems, DocumentReference userDocRef) async {
    try {
      var cartItemsData = cartItems.map((item) => item.toMap()).toList();

      await userDocRef.update({'cartItems': cartItemsData});

      _cartItems = cartItems;
      _cartItemQuantity = _calculateCartItemQuantity();

      notifyListeners();
    } catch (error) {
      log('Failed to update cart items: $error');
    }
  }

  int _calculateCartItemQuantity() {
    int quantity = 0;
    for (var item in _cartItems) {
      quantity += item.quantity;
    }
    return quantity;
  }

  double get totalPrice {
    double total = 0;
    for (var element in _cartItems) {
      total += element.price * element.quantity;
    }
    return total;
  }
}
