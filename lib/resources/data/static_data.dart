import 'package:flutter/material.dart';

import '../../models/cart.dart';
import '../../models/product.dart';
import '../../models/user.dart';

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    categories: [],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    categories: [],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    categories: [],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    categories: [],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

List<Cart> demoCarts = [
  Cart(
    id: 1,
    products: demoProducts[2],
    user: const User(
      [],
      username: 'John Doe',
      email: '',
    ), // Provide a User object here    products: demoProducts[0],
    numOfItems: 2,
  ),
  Cart(
    id: 2,
    user: const User(
      [],
      username: 'John Doe',
      email: '',
    ),
    products: demoProducts[2],
    numOfItems: 1,
  ),
  Cart(
    id: 3,
    user: const User(
      [],
      username: 'John Doe',
      email: '',
    ), // Provide a User object here
    products: demoProducts[1],
    numOfItems: 1,
  ),
  Cart(
    id: 4,
    user: const User(
      [],
      username: 'John Doe',
      email: '',
    ), // Provide a User object here
    products: demoProducts[3],
    numOfItems: 1,
  ),
];
