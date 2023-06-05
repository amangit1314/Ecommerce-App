import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';

import '../../../components/icon_btn_with_counter.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../cart/cart_screen.dart';
import '../../notification/notification_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SnapCart",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconBtnWithCounter(
                    svgSrc: "assets/icons/Bell.svg",
                    numOfitem: 0,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(8)),
                  IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    numOfitem: cartProvider.cartItems.length,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
