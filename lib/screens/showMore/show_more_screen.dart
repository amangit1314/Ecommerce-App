import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/details/detail_screen.dart';

import '../../../models/models.dart';
import '../../../utils/constants.dart';
import '../../utils/size_config.dart';

class ShowMore extends StatefulWidget {
  final String keyword;

  const ShowMore({Key? key, required this.keyword}) : super(key: key);

  @override
  State<ShowMore> createState() => _ShowMoreState();
}

class _ShowMoreState extends State<ShowMore> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore(String category) async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts
        // .where(
        //   'categories',
        //   arrayContains: category,
        // )
        .get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  //   Future<List<Product>> fetchProductsFromFirestore() async {
  //   final List<Product> products = [];
  //   final QuerySnapshot snapshot = await _refProducts.get();

  //   for (var element in snapshot.docs) {
  //     final productData = element.data() as Map<String, dynamic>;
  //     final productCategories = List<String>.from(productData['categories']);

  //     if (productCategories.contains('Fashion')) {
  //       products.add(Product.fromMap(productData));
  //     }
  //   }

  //   return products;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Products",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(
                MediaQuery.of(context).size.height * .85),
            child: FutureBuilder<List<Product>>(
              future: fetchProductsFromFirestore(widget.keyword),
              builder: (context, snapshot) {
                final List<Product> products = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                return GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductGridTileItem(
                      product: products[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGridTileItem extends StatelessWidget {
  final Product product;

  const ProductGridTileItem({
    Key? key,
    required this.product,
  }) : super(key: key);

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
        width: 150,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kPrimaryColor.withOpacity(.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    product.images.isNotEmpty
                        ? product.images.first
                        : 'https://picsum.photos/250?image=9',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
