import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/body.dart';

class DetailsScreenFirebase extends StatelessWidget {
  final Product product;
  const DetailsScreenFirebase({Key? key, required this.product})
      : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailFirebaseBody(product: product),
    );
  }
}
