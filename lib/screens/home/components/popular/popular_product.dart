import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../components/section_tile.dart';
import '../../../../resources/data/static_data.dart';
import '../../../../utils/constatns.dart';
import '../../../details/detail_screen.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: 'Popular Products',
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
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
                child: Container(
                  width: 170,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 148,
                        width: 170,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://picsum.photos/250?image=9',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Category',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Macbook Air',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                // const SizedBox(width: 6),
                                // const Spacer(),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(20),
                                //   child: GestureDetector(
                                //     onTap:
                                //         //onTap ??
                                //         () {
                                //       // add to cart with provider
                                //     },
                                //     child: Container(
                                //       height: 40,
                                //       width: 40,
                                //       color: kPrimaryColor.withOpacity(0.1),
                                //       child: const Icon(
                                //         // Icons.shopping_bag_outlined,
                                //         // addedToCart!
                                //         //     ? Icons.shopping_bag
                                //         //     :
                                //         Icons.shopping_bag_outlined,
                                //         size: 14,
                                //         color: kPrimaryColor,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
                        child: Text(
                          '\$ 1000',
                          style: TextStyle(
                            fontSize: 12,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
