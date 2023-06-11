import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../models/models.dart' as models;
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../loading/shimmer_box.dart';
import 'order_item_detail_screen.dart';
import 'order_widget.dart';

class OrdersListOfSelectedCategoryScreen extends StatefulWidget {
  final String statusName;
  final String? productImage;

  const OrdersListOfSelectedCategoryScreen({
    Key? key,
    required this.statusName,
    this.productImage,
  }) : super(key: key);

  @override
  State<OrdersListOfSelectedCategoryScreen> createState() =>
      _OrdersListOfSelectedCategoryScreenState();
}

class _OrdersListOfSelectedCategoryScreenState
    extends State<OrdersListOfSelectedCategoryScreen> {
  List<models.Product> products = []; // List to store fetched products

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          '${widget.statusName} Orders',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('uid', isEqualTo: authProvider.user.uid)
                    .where('orderStatus', isEqualTo: widget.statusName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width * .9,
                        child: ShimmerBox(
                          child: SizedBox(
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenWidth(100),
                          ),
                        ),
                      ),
                    );
                  }

                  List<DocumentSnapshot> orderDocuments = snapshot.data!.docs;
                  int orderCount = orderDocuments.length;

                  return Expanded(
                    child: ListView.separated(
                      itemCount: orderCount,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (context, index) {
                        DocumentSnapshot orderSnapshot = orderDocuments[index];
                        Map<String, dynamic> orderData =
                            orderSnapshot.data() as Map<String, dynamic>;
                        final Future<String?> productName =
                            getProductName(orderData['productId']);
                        return FutureBuilder<String?>(
                          future: productName,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: ShimmerBox(
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(100),
                                      width: getProportionateScreenWidth(100),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            final String? productName = snapshot.data;
                            return GestureDetector(
                              // on tap naviagtor.push
                              onTap: () {
                                Navigator.push(
                                  context,
                                  // material page route
                                  MaterialPageRoute(
                                    builder: (_) => OrderItemDetailScreen(
                                      order: models.Order(
                                        // orderData['number'],
                                        authProvider.user.number ??
                                            "+91 7023953453",
                                        orderId: orderData['orderId'],
                                        productId: orderData['productId'],
                                        productImage: orderData['productImage'],
                                        orderedDate: orderData['orderedDate'],
                                        quantity: orderData['quantity'],
                                        amount: orderData['amount'],
                                        address: orderData['address'],
                                        orderStatus: orderData['orderStatus'],
                                        // color: convertStringToColor(
                                        //     orderData['color']),
                                        color: Colors.black,
                                        // size: orderData['size'],
                                        size: "XL",
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Dismissible(
                                key: Key(orderData['orderId']),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) async {},
                                background: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFB1EFD1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                                child: OrderWidget(
                                  productImage: orderData['productImage'] ??
                                      'https://www.getillustrations.com/packs/gradient-marker-vector-illustrations/scenes/_1x/e-commerce%20_%20online,%20shopping,%20buy,%20purchase,%20empty,%20cart,%20order_md.png',
                                  orderId: orderData['orderId'],
                                  // productName: 'Cart Order',
                                  productName: productName ?? 'Cart Order',
                                  quantity: orderData['quantity'],
                                  orderPrice: orderData['amount'].toString(),
                                  orderDate: orderData['orderedDate'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getProductName(String productId) async {
    try {
      var productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      var productData = productDoc.data();
      if (productData != null) {
        return productData['title'] as String?;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return null; // Return null if the product is not found or if an error occurs.
  }
}
