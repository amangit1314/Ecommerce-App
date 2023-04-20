import 'package:flutter/material.dart';

import '../../models/product_name.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    // final MaterialPageRoute agrs = MaterialPageRoute(builder: (context) {
    //   // return PassArgumentsScreen(
    //   //   title: args.title,
    //   //   message: args.message,
    //   // );
    // });
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      // appBar: CustomAppBar(rating: agrs.product.rating),
      body: Body(product: product),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
