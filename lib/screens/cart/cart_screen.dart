import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/cart_provider.dart';
import 'package:soni_store_app/screens/cart/components/body.dart';
import 'package:soni_store_app/screens/cart/components/check_out_cart.dart';

import '../../utils/constants.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(left: 20, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: kPrimaryColor,
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your Cart",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${cartProvider.cartItems.length}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: kPrimaryColor.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    " items",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: kTextColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
