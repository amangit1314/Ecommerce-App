import 'package:flutter/material.dart';

import '../../models/product_name.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    // final MaterialPageRoute agrs = MaterialPageRoute(builder: (context) {
    //   // return PassArgumentsScreen(
    //   //   title: args.title,
    //   //   message: args.message,
    //   // );
    // });
    return const Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      // appBar: CustomAppBar(rating: agrs.product.rating),
      // body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
