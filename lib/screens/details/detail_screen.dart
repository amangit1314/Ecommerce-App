import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/details/components/body.dart';
import 'package:tokoto_ecommerce_app/screens/details/components/custom_app_bar.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      // appBar: CustomAppBar(rating: agrs.product.rating),
      // body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
