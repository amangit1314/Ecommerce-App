import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/home/components/discount_banner.dart';
import 'package:tokoto_ecommerce_app/screens/home/components/home_header.dart';
import 'package:tokoto_ecommerce_app/screens/home/components/popular_product.dart';
import 'package:tokoto_ecommerce_app/screens/home/components/special_offers.dart';

import '../../../utils/size_config.dart';
import 'categories.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            const Categories(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
