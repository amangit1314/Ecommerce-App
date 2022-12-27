import 'package:flutter/material.dart';
import 'package:tokoto_ecommerce_app/screens/home/components/section_tile.dart';

import '../../../components/product_card.dart';
import '../../../models/product_name.dart';
import '../../../utils/size_config.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: Row(
              children: [
                ...List.generate(
                  demoProducts.length,
                  (index) {
                    if (demoProducts[index].isPopular) {
                      return ProductCard(
                        productImage: demoProducts[index].images[0],
                      );
                    }
                    // here by default width and height is 0
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
