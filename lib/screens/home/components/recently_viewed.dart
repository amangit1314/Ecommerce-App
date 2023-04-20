import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/home/components/section_tile.dart';

import '../../../components/product_card.dart';
import '../../../resources/data/static_data.dart';
import '../../../utils/size_config.dart';
import '../../details/detail_screen.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Recently Viewed", press: () {}),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(
                                product: demoProducts[index],
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          color: demoProducts[index].colors[1],
                          productImage: demoProducts[index].images[0],
                        ),
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
