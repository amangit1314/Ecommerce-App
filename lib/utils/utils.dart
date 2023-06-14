import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

String apiKey = '';
String apiEndPoint = 'https://amazon-products1.p.rapidapi.com/product';

Future<void> getProducts() async {
  final response = await http.get(
    Uri.parse(apiEndPoint),
    headers: <String, String>{
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': 'amazon-products1.p.rapidapi.com',
    },
  );
  if (response.statusCode == 200) {
    log(response.body);
  } else {
    log(response.statusCode.toString());
  }
}

String generateOrderId() {
  const uuid = Uuid();
  return uuid.v4(); // Generate a random UUID
}

Color convertStringToColor(String hexColor) {
  // String hexColor = "#567890";
  Color color =
      Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
  return color;
}
