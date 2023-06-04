import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../utils/constants.dart';
import '../details/detail_screen.dart';
import '../home/components/popular/popular_product.dart';

class ShowMore extends StatefulWidget {
  final String keyword;
  const ShowMore({Key? key, required this.keyword}) : super(key: key);

  @override
  State<ShowMore> createState() => _ShowMoreState();
}

class _ShowMoreState extends State<ShowMore> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore(String keyword) async {
    final List<Product> products = [];

    final QuerySnapshot snapshot =
        await _refProducts.where(keyword, isEqualTo: true).get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Products",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchProductsFromFirestore(widget.keyword),
              builder: (context, snapshot) {
                final List<Product> products = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return const LoadingShimmerSkelton();
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                    ),
                  );
                  // return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two columns
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 2,
                        // Aspect ratio for each grid item
                        mainAxisSpacing: 2,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: ProductGridTileItem(
                            image: products[index].images.isNotEmpty
                                ? products[index].images[0]
                                : '',
                            product: products[index],
                            category: products[index].categories.isNotEmpty
                                ? products[index].categories[0]
                                : '',
                          ),
                        );
                      },
                    ),
                  ),
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
  final String? image;
  final String? category;
  const ProductGridTileItem({
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
        width: 150,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
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
                  Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       category! == '' ? 'Fashion' : category!,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(
                  //         color: Colors.grey.shade700,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
