import 'dart:convert';

class CartItem {
  final String price;
  final String uid;
  final String productUrl;
  final String productName;
  final bool isInCart;

  const CartItem({
    this.isInCart = false,
    required this.price,
    required this.uid,
    required this.productUrl,
    required this.productName,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'productUrl': productUrl,
        'productName': productName,
        'isInCart': isInCart,
        'price': price,
      };

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      isInCart: map['isInCart'] as bool,
      productName: map['productName'] as String,
      uid: map['uid'] as String,
      productUrl: map['productUrl'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static CartItem fromJson(String source) => fromMap(json.decode(source));
}
