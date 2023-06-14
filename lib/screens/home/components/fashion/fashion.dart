import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../components/section_tile.dart';
import '../../../../models/product.dart';
import '../../../details/detail_screen.dart';
import '../../../loading/shimmer_box.dart';
import '../../../showMore/show_more_screen.dart';

class Fashion extends StatefulWidget {
  const Fashion({Key? key}) : super(key: key);

  @override
  State<Fashion> createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  late Stream<List<Product>> _streamProducts;

  @override
  void initState() {
    super.initState();
    _streamProducts = fetchFashionProducts();
  }

  Stream<List<Product>> fetchFashionProducts() {
    final CollectionReference productsRef =
        FirebaseFirestore.instance.collection('products');

    return productsRef
        .where('categories', arrayContains: 'Fashion')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: SectionTitle(
            title: 'Fashion',
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
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            image: DecorationImage(
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/features%2FImage%20Banner%203.png?alt=media&token=efa74f88-8091-445b-847c-639b5a0b2fc2'),
              fit: BoxFit.cover,
            ),
          ),
          height: 230,
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          height: 180,
          child: StreamBuilder<List<Product>>(
            stream: _streamProducts,
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

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    products.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreenFirebase(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 180,
                        width: 153,
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(.3),
                          borderRadius: index != products.length - 1
                              ? (index == 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(5),
                                    )
                                  : BorderRadius.circular(5))
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(15),
                                ),
                          image: DecorationImage(
                            image: NetworkImage(
                              products[index].images.isNotEmpty
                                  ? products[index].images[0]
                                  : '',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
