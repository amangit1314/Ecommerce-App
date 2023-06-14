import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../components/section_tile.dart';
import '../../../models/product.dart';
import '../../../utils/size_config.dart';
import '../../home/components/fashion/fashions.dart';
import '../../loading/shimmer_box.dart';
import '../../showMore/show_more_screen.dart';
import '../components/body.dart';

class SimilarProducts extends StatefulWidget {
  const SimilarProducts({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailFirebaseBody widget;

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts
        .where(
          'categories',
          arrayContains: widget.widget.product.categories.first,
        )
        .get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: 'Similar Products',
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowMore(
                    keyword: 'Similar Products',
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
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
                itemCount: products.length < 5 ? products.length : 5,
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
