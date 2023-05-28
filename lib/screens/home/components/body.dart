import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/home/components/discount/discount_banner.dart';
import 'package:soni_store_app/screens/home/components/home_header.dart';
import 'package:soni_store_app/screens/home/components/popular/popular_product.dart';
import 'package:soni_store_app/screens/home/components/recent/recently_viewed.dart';
import 'package:soni_store_app/screens/home/components/sports/sports.dart';

import '../../../utils/size_config.dart';
import 'categories/categories.dart';
import 'commercials/commercials.dart';
import 'fashion/fashion.dart';
import 'fashion/fashions.dart';
import 'groceries/grocery_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const DiscountBanner(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const Categories(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const PopularProducts(),
            SizedBox(height: getProportionateScreenHeight(20)),
            const Fashionable(),
            SizedBox(height: getProportionateScreenHeight(20)),
            const Sports(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Grocery(),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20, left: 20),
              child: Fashion(),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            const RecentlyViewd(),
            SizedBox(height: getProportionateScreenHeight(10)),
            const Commercials(),
          ],
        ),
      ),
    );
  }
}
