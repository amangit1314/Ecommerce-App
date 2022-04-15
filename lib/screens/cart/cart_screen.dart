import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/cart/components/body.dart';
import 'package:tokoto_ecommerce_app/screens/cart/components/check_out_cart.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            '',
            //"${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
