import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/home/components/popular/popular_show_more.dart';

import '../../../../components/section_tile.dart';
import '../../../../models/product.dart';
import '../../../../utils/size_config.dart';
import '../../../loading/shimmer_box.dart';
import '../fashions_card.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    // filtering if isPopular
    final QuerySnapshot snapshot =
        await _refProducts.where('isPopular', isEqualTo: true).get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              // navigate to ShowMore
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PopularShowMore(
                    keyword: 'Popular',
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 20.0),
          child: FutureBuilder<List<Product>>(
            future: fetchProductsFromFirestore(),
            builder: (context, snapshot) {
              final List<Product> products = snapshot.data ?? [];

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 150,
                        width: getProportionateScreenWidth(170),
                        child: ShimmerBox(
                          child: SizedBox(
                            height: getProportionateScreenHeight(150),
                            width: getProportionateScreenWidth(170),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return FashionsCard(
                    image: products[index].images.isNotEmpty
                        ? products[index].images[0]
                        : '',
                    product: products[index],
                    category: products[index].categories.isNotEmpty
                        ? products[index].categories[0]
                        : '',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
