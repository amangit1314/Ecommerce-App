import 'package:flutter/material.dart';

import '../../models/cart.dart';
import '../../models/product.dart';
import '../../models/user.dart';

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

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
    price: 64,
    description: description,
    rating: 4,
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
    price: 50,
    description: description,
    rating: 4,
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
    price: 365,
    description: description,
    rating: 4,
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
    price: 200,
    description: description,
    rating: 4,
    isFavourite: true,
  ),
];

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

List generes = [
  'assets/images/tshirt.png',
  'assets/images/tshirt.png',
  'assets/images/tshirt.png',
  'assets/images/tshirt.png',
];

List tshirts = [
  'assets/images/tshirt_w.jpg',
  'assets/images/black.jpg',
  'assets/images/lav.jpg',
  'assets/images/tshirt.png',
];

List tshirtName = ['Sports Amber', 'Polo White', 'Olive Green', 'Yellow V'];

List pants = [
  'assets/images/download.jpg',
  'assets/images/images.jpg',
  'assets/images/images-_1_.jpg',
  'assets/images/images-_2_.jpg',
];

List shoes = [
  'assets/images/sneak_pink.jpg',
  'assets/images/sneakers.jpg',
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
];
