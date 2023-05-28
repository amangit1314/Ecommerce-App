import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreenFirebase extends StatelessWidget {
  final Product product;
  const DetailsScreenFirebase({Key? key, required this.product})
      : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
          rating: product.rating,
        ),
      ),
      backgroundColor: Colors.transparent,
      body: DetailFirebaseBody(product: product),
    );
  }
}
