import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../products/searched_item_screen_view.dart';

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
    Query query = _refProducts;

    if (category == "Popular Products") {
      query = query.where('isPopular', isEqualTo: true);
    } else {
      query = query.where('categories', arrayContains: widget.keyword);
    }

    final QuerySnapshot snapshot = await query.get();

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
          "${widget.keyword} Products",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
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
              future: fetchProductsFromFirestore(
                  widget.keyword == "Popular Products"
                      ? "Popular Products"
                      : widget.keyword),
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
