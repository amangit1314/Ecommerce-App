import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../components/section_tile.dart';
import '../../../../models/product.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../details/detail_screen.dart';
import '../../../loading/shimmer_box.dart';
import '../../../showMore/show_more_screen.dart';

class Fashionable extends StatefulWidget {
  const Fashionable({super.key});

  @override
  State<Fashionable> createState() => _FashionableState();
}

class _FashionableState extends State<Fashionable> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  @override
  void initState() {
    super.initState();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();

    for (var element in snapshot.docs) {
      final productData = element.data() as Map<String, dynamic>;
      final productCategories = List<String>.from(productData['categories']);

      if (productCategories.contains('Fashion')) {
        products.add(Product.fromMap(productData));
      }
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
            title: "Fashion Collection",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ShowMore(
                    keyword: 'Fashion',
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

class FashionsCard extends StatelessWidget {
  final Product product;
  final String? image;
  final String? category;
  const FashionsCard({
    super.key,
    required this.product,
    this.image,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsScreenFirebase(
              product: product,
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    image! == '' ? 'https://picsum.photos/250?image=9' : image!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
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
                        category! == '' ? 'Fashion' : category!,
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
                    children: [
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
              child: Text(
                '₹ ${product.price}',
                style: const TextStyle(
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
  }
}
