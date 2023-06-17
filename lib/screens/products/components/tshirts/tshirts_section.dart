import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/products/components/products_search_screen_item_card.dart';

import '../../../../components/section_tile.dart';
import '../../../../models/product.dart';
import '../../../../utils/size_config.dart';
import '../../../details/detail_screen.dart';
import '../../../loading/shimmer_box.dart';
import '../../../showMore/show_more_screen.dart';

class TshirtsSection extends StatefulWidget {
  const TshirtsSection({
    super.key,
  });

  @override
  State<TshirtsSection> createState() => _TshirtsSectionState();
}

class _TshirtsSectionState extends State<TshirtsSection> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();

    for (var element in snapshot.docs) {
      final productData = element.data() as Map<String, dynamic>;
      final productCategories = List<String>.from(productData['categories']);

      if (productCategories.contains('tshirts')) {
        products.add(Product.fromMap(productData));
      }
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Tshirt\'s',
          press: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ShowMore(
                  keyword: 'tshirts',
                ),
              ),
            );
          },
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        SizedBox(
          height: 190,
          child: FutureBuilder<List<Product>>(
            future: fetchProductsFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              final List<Product> products = snapshot.data ?? [];

              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailsScreenFirebase(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: ProductSearchScreenItemCard(
                      category: 'tshirts',
                      width: 150,
                      productName: products[index].title,
                      productImage: products[index].images.isNotEmpty
                          ? products[index].images[0]
                          : '',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreenFirebase(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      // productDesc: '\$${products[index].price}',
                      price: '₹ ${products[index].price}',
                      product: products[index],
                    ),
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
