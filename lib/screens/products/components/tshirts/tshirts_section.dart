// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:soni_store_app/screens/details/detail_screen.dart';

// import '../../../../components/section_tile.dart';
// import '../../../../providers/providers.dart';
// import '../../../../utils/size_config.dart';
// import '../products_search_screen_item_card.dart';

// class TshirtsSection extends StatefulWidget {
//   const TshirtsSection({super.key, s});

//   @override
//   State<TshirtsSection> createState() => _TshirtsSectionState();
// }

// class _TshirtsSectionState extends State<TshirtsSection> {
//   final CollectionReference _refProducts =
//       FirebaseFirestore.instance.collection('products');
//   late Stream<QuerySnapshot> _streamProducts;

//   @override
//   void initState() {
//     super.initState();
//     _streamProducts = _refProducts.snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SectionTitle(title: 'Tshirt\'s', press: () {}),
//         SizedBox(height: getProportionateScreenHeight(10)),
//         SizedBox(
//           height: 190,
//           child: StreamBuilder<QuerySnapshot>(
//             stream: _streamProducts,
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(
//                   child: Text('Something went wrong'),
//                 );
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }

//               return Consumer<ProductProvider>(
//                   builder: (context, productProvider, _) {
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 1,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => DetailsScreenFirebase(
//                               product: productProvider.products[index],
//                             ),
//                           ),
//                         );
//                       },
//                       child: ProductSearchScreenItemCard(
//                         width: 170,
//                         productName: productProvider.products[index].title,
//                         productImage:
//                             productProvider.products[index].images.isNotEmpty
//                                 ? productProvider.products[index].images[index]
//                                 : '',
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) => DetailsScreenFirebase(
//                                 product: productProvider.products[index],
//                               ),
//                             ),
//                           );
//                         },
//                         price: '\$${productProvider.products[index].price}',
//                         product: productProvider.products[index],
//                       ),
//                     );
//                   },
//                 );
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/products/components/products_search_screen_item_card.dart';

import '../../../../components/section_tile.dart';
import '../../../../models/product.dart';
import '../../../../utils/size_config.dart';
import '../../../details/detail_screen.dart';

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
  late Stream<QuerySnapshot> _streamProducts;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: 'Tshirt\'s', press: () {}),
        SizedBox(height: getProportionateScreenHeight(10)),
        SizedBox(
          height: 190,
          child: FutureBuilder<List<Product>>(
            future: fetchProductsFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
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
                      width: 170,
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
