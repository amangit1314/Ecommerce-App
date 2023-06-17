import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/screens/orders/order_item_detail_screen.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../providers/providers.dart';
import '../../../../utils/constants.dart';
import '../../../loading/shimmer_box.dart';
import '../../order_widget.dart';

class ListOfDeliveredOrdersScreen extends StatefulWidget {
  final String statusName;
  final String? productImage;

  const ListOfDeliveredOrdersScreen({
    Key? key,
    required this.statusName,
    this.productImage,
  }) : super(key: key);

  @override
  State<ListOfDeliveredOrdersScreen> createState() =>
      _ListOfDeliveredOrdersScreenState();
}

class _ListOfDeliveredOrdersScreenState
    extends State<ListOfDeliveredOrdersScreen> {
  late AuthProvider authProvider;
  late Stream<QuerySnapshot> orderStream;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: authProvider.user.uid)
        .where('orderStatus', isEqualTo: 'Delivered')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.all(getProportionateScreenHeight(15)),
          child: StreamBuilder<QuerySnapshot>(
            stream: orderStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: getProportionateScreenHeight(120),
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

              final orderDocuments = snapshot.data!.docs;
              final orderCount = orderDocuments.length;

              return SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: orderCount,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: getProportionateScreenHeight(8),
                    );
                  },
                  itemBuilder: (context, index) {
                    final orderSnapshot = orderDocuments[index];
                    final orderData =
                        orderSnapshot.data() as Map<String, dynamic>;
                    return FutureBuilder<String?>(
                      future: getProductName(orderData['productId']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              height: getProportionateScreenHeight(120),
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
                        final productName = snapshot.data;
                        log('-------------');
                        log(orderData.toString());
                        log('-------------');
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderItemDetailScreen(
                                  order: models.Order.fromMap(orderData),
                                ),
                              ),
                            );
                          },
                          child: OrderWidget(
                            productImage: orderData['productImage'] ??
                                'https://www.getillustrations.com/packs/gradient-marker-vector-illustrations/scenes/_1x/e-commerce%20_%20online,%20shopping,%20buy,%20purchase,%20empty,%20cart,%20order_md.png',
                            orderId: orderData['orderId'],
                            productName: productName ?? 'Cart Order',
                            quantity: orderData['quantity'],
                            orderPrice: orderData['amount'].toString(),
                            orderDate: orderData['orderedDate'],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<String?> getProductName(String productId) async {
    try {
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      final productData = productDoc.data();
      if (productData != null) {
        return productData['title'] as String?;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return null;
  }
}
